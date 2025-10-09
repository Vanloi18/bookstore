package com.mybookstore.bookstore.controller.admin;

import com.mybookstore.bookstore.dao.BookDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/delete-book")
public class DeleteBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;

    public void init() {
        bookDAO = new BookDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int bookId = Integer.parseInt(request.getParameter("id"));
            bookDAO.deleteBook(bookId);
        } catch (NumberFormatException e) {
            // Bỏ qua nếu id không hợp lệ
        }
        response.sendRedirect(request.getContextPath() + "/admin/manage-books");
    }
}