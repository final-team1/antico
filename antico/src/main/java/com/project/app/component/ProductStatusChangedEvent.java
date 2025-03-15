package com.project.app.component;

public class ProductStatusChangedEvent {
	
    private final String productId;
    private final String newStatus;
    private String sellerNo;

    public ProductStatusChangedEvent(String productId, String newStatus) {
        this.productId = productId;
        this.newStatus = newStatus;
    }

    public ProductStatusChangedEvent(String productId, String newStatus, String sellerNo) {
        this.productId = productId;
        this.newStatus = newStatus;
        this.sellerNo = sellerNo;
    }

    public String getProductId() {
        return productId;
    }

    public String getNewStatus() {
        return newStatus;
    }

    public String getSellerNo() {return sellerNo;}
}
