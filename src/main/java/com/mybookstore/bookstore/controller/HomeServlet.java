package com.mybookstore.bookstore.controller;

import com.mybookstore.bookstore.dao.BookDAO;
import com.mybookstore.bookstore.model.Book;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/home") // Mapping cho trang chủ
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;

    @Override
    public void init() {
        bookDAO = new BookDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Lấy 8 cuốn sách mới nhất (sắp xếp theo ID giảm dần trong DAO)
        List<Book> featuredBooks = bookDAO.getBooksPaginated(0, null, 1, 8);

        // Gửi danh sách sách nổi bật tới home.jsp
        request.setAttribute("featuredBookList", featuredBooks);

        // Chuyển tiếp tới trang home.jsp (landing page)
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}
