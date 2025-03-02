package com.project.app.component;

public class ProductStatusChangedEvent {
	
    private final String productId;
    private final String newStatus;

    public ProductStatusChangedEvent(String productId, String newStatus) {
        this.productId = productId;
        this.newStatus = newStatus;
    }

    public String getProductId() {
        return productId;
    }

    public String getNewStatus() {
        return newStatus;
    }
}
