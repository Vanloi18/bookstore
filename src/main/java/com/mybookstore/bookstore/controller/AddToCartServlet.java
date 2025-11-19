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

        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            Book book = bookDAO.getBookById(bookId);

            if (book != null && quantity > 0) {
                CartItem cartItem = cart.get(bookId);

                if (cartItem != null) {
                    cartItem.setQuantity(cartItem.getQuantity() + quantity);
                } else {
                    cart.put(bookId, new CartItem(book, quantity));
                }
            }

            session.setAttribute("cart", cart);

            // Trả về tổng số lượng item trong giỏ
            int totalItems = 0;
            for (CartItem item : cart.values()) {
                totalItems += item.getQuantity();
            }

            response.setContentType("text/plain");
            response.getWriter().write(String.valueOf(totalItems));

        } catch (Exception e) {
            response.setContentType("text/plain");
            response.getWriter().write("0");
        }
    }
}
