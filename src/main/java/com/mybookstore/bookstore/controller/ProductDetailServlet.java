package com.mybookstore.bookstore.controller;

import com.mybookstore.bookstore.dao.BookDAO;
import com.mybookstore.bookstore.model.Book;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/product-detail")
public class ProductDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;

    public void init() {
        bookDAO = new BookDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Lấy id của sách từ parameter trên URL
            int bookId = Integer.parseInt(request.getParameter("id"));
            
            // Gọi DAO để lấy thông tin chi tiết sách
            Book book = bookDAO.getBookById(bookId);
            
            if (book != null) {
                // Nếu tìm thấy sách, gửi thông tin sách đến trang jsp
                request.setAttribute("book", book);
                request.getRequestDispatcher("productDetail.jsp").forward(request, response);
            } else {
                // Nếu không tìm thấy sách, chuyển hướng về trang chủ
                response.sendRedirect("home");
            }
        } catch (NumberFormatException e) {
            // Nếu id không phải là số, chuyển hướng về trang chủ
            response.sendRedirect("home");
        }
    }
}