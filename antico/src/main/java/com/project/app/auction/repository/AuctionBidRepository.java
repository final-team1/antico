package com.project.app.auction.repository;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.project.app.auction.domain.AuctionBid;

public interface AuctionBidRepository extends MongoRepository<AuctionBid, String> {

	AuctionBid findFirstByRoomIdOrderByBidDesc(String auctionRoomId);
}
