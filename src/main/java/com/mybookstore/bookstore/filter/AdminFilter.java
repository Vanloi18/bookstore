package com.mybookstore.bookstore.filter;

import com.mybookstore.bookstore.model.User;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/admin/*") // Áp dụng filter cho mọi URL bắt đầu bằng /admin/
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        boolean isLoggedIn = (session != null && session.getAttribute("loggedInUser") != null);
        boolean isAdmin = false;

        if (isLoggedIn) {
            User user = (User) session.getAttribute("loggedInUser");
            isAdmin = user.isAdmin();
        }

        if (isAdmin) {
            // Nếu là admin, cho phép truy cập
            chain.doFilter(request, response);
        } else {
            // Nếu không phải admin (chưa đăng nhập hoặc là user thường), đá về trang chủ
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/home");
        }
    }
}