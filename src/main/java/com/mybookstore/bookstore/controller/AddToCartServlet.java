package com.mybookstore.bookstore.controller;

import com.mybookstore.bookstore.dao.BookDAO;
import com.mybookstore.bookstore.model.Book;
import com.mybookstore.bookstore.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;

    public void init() {
        bookDAO = new BookDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }

        response.setContentType("text/plain");
        
        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            int quantityToAdd = Integer.parseInt(request.getParameter("quantity"));

            Book book = bookDAO.getBookById(bookId);

            if (book != null && quantityToAdd > 0) {
                // Lấy số lượng hiện có trong giỏ
                CartItem existingItem = cart.get(bookId);
                int currentInCart = (existingItem != null) ? existingItem.getQuantity() : 0;
                
                // === FIX: KIỂM TRA TỒN KHO ===
                if (currentInCart + quantityToAdd > book.getStock()) {
                    // Trả về -1 để báo lỗi hết hàng (Front-end cần xử lý số này nếu muốn hiển thị alert)
                    response.getWriter().write("-1"); 
                    return;
                }

                if (existingItem != null) {
                    existingItem.setQuantity(currentInCart + quantityToAdd);
                } else {
                    cart.put(bookId, new CartItem(book, quantityToAdd));
                }
            }

            session.setAttribute("cart", cart);

            // Trả về tổng số lượng item trong giỏ
            int totalItems = 0;
            for (CartItem item : cart.values()) {
                totalItems += item.getQuantity();
            }

            response.getWriter().write(String.valueOf(totalItems));

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("0");
        }
    }
}