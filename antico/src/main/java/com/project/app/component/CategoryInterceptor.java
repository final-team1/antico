package com.project.app.component;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.project.app.product.domain.CategoryDetailVO;
import com.project.app.product.domain.CategoryVO;
import com.project.app.product.model.ProductDAO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/*
 * header 페이지 카테고리 관리
 */
@Component
public class CategoryInterceptor implements HandlerInterceptor {

    @Autowired
    private ProductDAO productDAO;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        // 카테고리 데이터 가져오기
        List<CategoryVO> category_list = productDAO.getCategory();
        List<CategoryDetailVO> category_detail_list = productDAO.getCategoryDetail();
        
        // request에 저장 (모든 JSP에서 접근 가능)
        request.setAttribute("category_list", category_list);
        request.setAttribute("category_detail_list", category_detail_list);
        
        return true; // 요청 계속 진행
    }
}
