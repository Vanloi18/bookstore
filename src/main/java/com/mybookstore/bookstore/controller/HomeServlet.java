package com.mybookstore.bookstore.controller;

import com.mybookstore.bookstore.dao.BookDAO;
import com.mybookstore.bookstore.dao.CategoryDAO;
import com.mybookstore.bookstore.model.Book;
import com.mybookstore.bookstore.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;
    private CategoryDAO categoryDAO;

    public void init() {
        bookDAO = new BookDAO();
        categoryDAO = new CategoryDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Luôn lấy danh sách thể loại để hiển thị
        List<Category> categoryList = categoryDAO.getAllCategories();
        request.setAttribute("categoryList", categoryList);
        
        List<Book> bookList;

        // Lấy tham số từ URL
        String searchKeyword = request.getParameter("search");
        String categoryIdStr = request.getParameter("categoryId");

        if (searchKeyword != null && !searchKeyword.isEmpty()) {
            // Trường hợp: Người dùng tìm kiếm
            bookList = bookDAO.searchBooksByTitle(searchKeyword);
            request.setAttribute("searchKeyword", searchKeyword); // Gửi lại từ khóa để hiển thị
        } else if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            // Trường hợp: Người dùng lọc theo thể loại
            int categoryId = Integer.parseInt(categoryIdStr);
            bookList = bookDAO.getBooksByCategoryId(categoryId);
        } else {
            // Trường hợp: Mặc định, hiển thị tất cả sách
            bookList = bookDAO.getAllBooks();
        }

        request.setAttribute("bookList", bookList);
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}