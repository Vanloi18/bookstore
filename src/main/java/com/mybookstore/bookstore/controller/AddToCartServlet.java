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

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Lấy giỏ hàng từ session. Nếu chưa có, tạo mới.
        // Giỏ hàng sẽ là một Map<Integer, CartItem> với Key là ID của sách.
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }

        try {
            // Lấy thông tin từ form
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            // Lấy thông tin sách từ CSDL
            Book book = bookDAO.getBookById(bookId);

            if (book != null && quantity > 0) {
                CartItem cartItem = cart.get(bookId);
                if (cartItem != null) {
                    // Nếu sách đã có trong giỏ, cập nhật số lượng
                    cartItem.setQuantity(cartItem.getQuantity() + quantity);
                } else {
                    // Nếu sách chưa có trong giỏ, thêm mới
                    cart.put(bookId, new CartItem(book, quantity));
                }
            }

            // Lưu giỏ hàng đã cập nhật trở lại session
            session.setAttribute("cart", cart);

            // Chuyển hướng đến trang xem giỏ hàng
            response.sendRedirect("cart.jsp");

        } catch (NumberFormatException e) {
            // Xử lý nếu id hoặc quantity không phải là số
            response.sendRedirect("home");
        }
    }
}