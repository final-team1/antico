package com.project.app.chat.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class ChatRoomRespDTO {
	
	private ChatRoom chatRoom;
	
	private Chat latestChat;
	
	private ProductChatDTO productChatDTO;
	
	public void updateProductChatDTO( ProductChatDTO productChatDTO) {
		this.productChatDTO = productChatDTO;
	}

}
