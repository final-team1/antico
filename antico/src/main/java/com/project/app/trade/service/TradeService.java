package com.project.app.trade.service;

import java.util.Map;

public interface TradeService {

	Map<String, String> getProduct(String pk_product_no, String pk_member_no);

}
