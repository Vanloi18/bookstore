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

@WebServlet("/books")
public class BooksServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;
    private CategoryDAO categoryDAO;

    private static final int BOOKS_PER_PAGE = 8; // số sách mỗi trang

    public void init() {
        bookDAO = new BookDAO();
        categoryDAO = new CategoryDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy thể loại
        List<Category> categoryList = categoryDAO.getAllCategories();
        request.setAttribute("categoryList", categoryList);

        // Lấy tham số lọc
        String searchKeyword = request.getParameter("search");
        String categoryIdStr = request.getParameter("categoryId");
        int categoryId = 0;

        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdStr);
            } catch (NumberFormatException ignored) {}
        }

        // Lấy trang hiện tại
        String pageStr = request.getParameter("page");
        int currentPage = 1;

        try {
            if (pageStr != null) {
                currentPage = Integer.parseInt(pageStr);
            }
        } catch (NumberFormatException e) {
            currentPage = 1;
        }

        // Tổng số sách
        int totalBooks = bookDAO.countTotalBooks(categoryId, searchKeyword);
        int totalPages = (int) Math.ceil((double) totalBooks / BOOKS_PER_PAGE);

        if (totalPages < 1) totalPages = 1;
        if (currentPage > totalPages) currentPage = totalPages;
        if (currentPage < 1) currentPage = 1;

        // Lấy danh sách sách phân trang
        List<Book> bookList = bookDAO.getBooksPaginated(categoryId, searchKeyword, currentPage, BOOKS_PER_PAGE);

        // Set attribute
        request.setAttribute("bookList", bookList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("categoryId", categoryId);
        request.setAttribute("searchKeyword", searchKeyword);

        // Trả về JSP
        request.getRequestDispatcher("books.jsp").forward(request, response);
    }
}
