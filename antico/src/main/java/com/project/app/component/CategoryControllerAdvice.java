package com.project.app.component;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.project.app.product.domain.CategoryDetailVO;
import com.project.app.product.domain.CategoryVO;
import com.project.app.product.model.ProductDAO;

/*
 * header 페이지 카테고리 관리
 */
@ControllerAdvice
public class CategoryControllerAdvice {
	
	@Autowired
    private ProductDAO productDAO;

    
    // 상위 카테고리
    @ModelAttribute("category_list")
    public List<CategoryVO> getCategory() {
        return productDAO.getCategory();
    }
    
    // 하위 카테고리
    @ModelAttribute("category_detail_list")
    public List<CategoryDetailVO> getCategoryDetail() {
        return productDAO.getCategoryDetail();
    }
	
}
