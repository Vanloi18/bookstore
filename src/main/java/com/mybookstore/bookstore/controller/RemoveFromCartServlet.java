package com.mybookstore.bookstore.controller;

import com.mybookstore.bookstore.model.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

@WebServlet("/remove-from-cart")
public class RemoveFromCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        if (cart != null) {
            try {
                // Lấy id của sách cần xóa
                int bookId = Integer.parseInt(request.getParameter("id"));
                
                // Xóa sản phẩm khỏi map
                cart.remove(bookId);
                
                // Cập nhật lại giỏ hàng trong session
                session.setAttribute("cart", cart);
            } catch (NumberFormatException e) {
                // Bỏ qua nếu id không hợp lệ
            }
        }
        
        // Chuyển hướng người dùng về lại trang giỏ hàng
        response.sendRedirect("cart.jsp");
    }
}