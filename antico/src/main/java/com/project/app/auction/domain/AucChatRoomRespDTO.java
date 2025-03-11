package com.project.app.auction.domain;

import com.project.app.chat.domain.ProductChatDTO;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class AucChatRoomRespDTO {

	private AuctionChatRoom auctionChatRoom;

	private AuctionChat latestChat;

	private ProductChatDTO productChatDTO;

	public void updateProductChatDTO( ProductChatDTO productChatDTO) {
		this.productChatDTO = productChatDTO;
	}

}
