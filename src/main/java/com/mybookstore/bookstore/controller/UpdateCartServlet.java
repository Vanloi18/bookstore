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

@WebServlet("/update-cart")
public class UpdateCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        if (cart != null) {
            try {
                int bookId = Integer.parseInt(request.getParameter("bookId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));

                CartItem item = cart.get(bookId);

                if (item != null) {
                    if (quantity > 0) {
                        // Cập nhật số lượng mới
                        item.setQuantity(quantity);
                    } else {
                        // Nếu số lượng là 0 hoặc âm, xóa sản phẩm khỏi giỏ
                        cart.remove(bookId);
                    }
                }
                
                session.setAttribute("cart", cart);
            } catch (NumberFormatException e) {
                // Bỏ qua nếu id hoặc quantity không hợp lệ
            }
        }
        
        response.sendRedirect("cart.jsp");
    }
}