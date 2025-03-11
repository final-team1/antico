package com.project.app.auction.repository;

import java.util.Arrays;
import java.util.List;

import org.bson.types.ObjectId;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.aggregation.AggregationResults;
import org.springframework.data.mongodb.core.aggregation.ConvertOperators;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

import com.mongodb.client.result.UpdateResult;
import com.project.app.auction.domain.AucChatRoomRespDTO;
import com.project.app.auction.domain.AuctionChat;
import com.project.app.auction.domain.AuctionChatRoom;
import com.project.app.chat.domain.Chat;
import com.project.app.chat.domain.ChatRoom;
import com.project.app.chat.domain.ChatRoomRespDTO;
import com.project.app.chat.domain.Participant;
import com.project.app.exception.BusinessException;
import com.project.app.exception.ExceptionCode;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/*
 * 직접 쿼리를 제어하기 위한 사용자 정의 mongodb 레포지토리
 */
@Slf4j
@RequiredArgsConstructor
@Repository
public class CustomAuctionChatRoomRepository {
	
	private final MongoTemplate mongoTemplate;
	
	/*
	 * 특정 회원이 참여하는 채팅방, 최신 채팅 정보를 한번에 불러오기 위한 메소드
	 */
	public List<AucChatRoomRespDTO> findAllWithLatestChatByMemberNo(String memberNo) {
	    Aggregation aggregation = Aggregation.newAggregation(
	        
	        // 최신 채팅으로 정렬
	        Aggregation.sort(Sort.by(Sort.Direction.DESC, "sendDate")),

	        // 채팅 메시지를 roomId(String) 기준으로 그룹화하고, 최신 메시지 정보 추출
	        Aggregation.group("roomId")
	            .max("sendDate").as("sendDate")
	            .first("message").as("message")
	            .first("senderId").as("senderId")
	            .first("senderName").as("senderName")
				.first("chatType").as("chatType"),

	        // 채팅방 식별자와 join을 위한 타입 맞추기 ( object id )
	        Aggregation.addFields()
	            .addField("roomIdObj")
	            .withValue(
	                ConvertOperators.ToObjectId.toObjectId(
	                    ConvertOperators.ToString.toString("$_id")  // String 변환 후 ObjectId 변환 시도
	                )
	            )
	            .build(),

	        // 채팅방 컬렉션과 조인
	        Aggregation.lookup("auction_chat_room", "roomIdObj", "_id", "chatRoom"),

	        // 조인 결과 필터링 (채팅방 정보가 존재하는 경우만)
	        Aggregation.match(Criteria.where("chatRoom").ne(null)),

	        // `chatRoom` 필드는 배열이므로 단일 문서로 변환
	        Aggregation.unwind("chatRoom"),

	        // 사용자가 참여한 채팅방만 필터링
	        Aggregation.match(Criteria.where("chatRoom.participants").elemMatch(Criteria.where("memberNo").is(memberNo))),

	        // 필요한 필드만 유지하여 최종 반환 데이터 구조 정의
	        Aggregation.project()
	            .and("_id").as("roomId")  // roomId 매핑
	            .andInclude("message", "sendDate", "senderId", "senderName", "chatType")  // 최신 메시지 정보
	            .and("chatRoom").as("auctionChatRoom") // 채팅방 정보
	            .and("message").as("latestChat.message")
	            .and("sendDate").as("latestChat.sendDate")
	            .and("senderId").as("latestChat.senderId")
	            .and("senderName").as("latestChat.senderName")
				.and("chatType").as("latestChat.chatType")
	    );

	    // Aggregation 실행
	    AggregationResults<AucChatRoomRespDTO> result = mongoTemplate.aggregate(aggregation, "auction_chat_messages", AucChatRoomRespDTO.class);

	    return result.getMappedResults();
	}

	/*
	 * 사용자 채팅 읽음 처리 메소드
	 * 변경된 채팅 id, unReadCount 목록 반환
	 */
	public List<AuctionChat> updateUnReadCount(String chatId, String roomId, String memberNo) {

		log.info("roomId: {} memberNo: {}", roomId, memberNo);

		Query selectQuery = Query.query(Criteria.where("_id")
			.is(new ObjectId(roomId))
			.and("participants")
			.elemMatch(Criteria.where("memberNo").is(memberNo)));

		selectQuery.fields().include("participants.$");

		AuctionChatRoom chatRoom = mongoTemplate.findOne(selectQuery, AuctionChatRoom.class);

		if(chatRoom == null) {
			//TODO 예외처리
			log.error("chatRoom not found");
			return null;
		}

		if(chatRoom.getParticipants().isEmpty()) {
			// TODO 예외처리
			log.error("chatRoom participants not found");
			return null;
		}

		if(chatRoom.getParticipants().get(0) == null) {
			// TODO 예외처리
			log.error("chatRoom participants first not found");
			return null;
		}

		Participant participant = chatRoom.getParticipants().get(0);

		log.info("dfdfd " + participant.getStartDate());

		// 채팅방 id를 가진 채팅 메시지 중
		Query query = new Query(Criteria.where("roomId").is(roomId)
				.and("_id").lte(chatId)// 채팅 메시지 id가 가져온 chatId보다 작은 모든 채팅메시지에 대해
				.and("sendDate").gte(participant.getStartDate())
				.and("readMembers").ne(memberNo)); // memberNo(로그인사용자)가 읽지 않은 모든 메시지들에 대해
		
		Update update = new Update()
				.addToSet("readMembers", memberNo)
				.inc("unReadCount", -1);
		
		mongoTemplate.updateMulti(query, update, AuctionChat.class);
		
		// 조건 지정 쿼리 생성
		Query findUpdatedChats = new Query(Criteria.where("roomId").is(roomId)
				.and("_id").lte(chatId)
				.and("readMembers").in(memberNo));
		
		// 반환 지정
		findUpdatedChats.fields().include("_id").include("unReadCount");

		return mongoTemplate.find(findUpdatedChats, AuctionChat.class);
				
	}

	public AuctionChatRoom addParticipant(String roomId, Participant participant) {
		Query query = new Query(Criteria.where("roomId").is(roomId));
		Update update = new Update().addToSet("participants", participant);
		UpdateResult result = mongoTemplate.updateFirst(query, update, AuctionChatRoom.class);

		if(result.getMatchedCount() != 1) {
			log.error("[ERROR] : failed to update auction chat room participant with room id {}", roomId);
			throw new BusinessException(ExceptionCode.JOIN_CHATROOM_FAILD);
		}
		return mongoTemplate.findById(roomId, AuctionChatRoom.class);
	}
}
