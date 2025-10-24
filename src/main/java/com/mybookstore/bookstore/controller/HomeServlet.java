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
    private static final int BOOKS_PER_PAGE = 8; // Số sách hiển thị trên mỗi trang

    public void init() {
        bookDAO = new BookDAO();
        categoryDAO = new CategoryDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Luôn lấy danh sách thể loại
        List<Category> categoryList = categoryDAO.getAllCategories();
        request.setAttribute("categoryList", categoryList);

        // Lấy tham số lọc và tìm kiếm
        String searchKeyword = request.getParameter("search");
        String categoryIdStr = request.getParameter("categoryId");
        int categoryId = 0;
        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdStr);
            } catch (NumberFormatException e) {
                // Bỏ qua nếu categoryId không hợp lệ
            }
        }

        // Lấy số trang hiện tại từ request (mặc định là trang 1)
        String pageStr = request.getParameter("page");
        int currentPage = 1;
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageStr);
                if (currentPage < 1) {
                    currentPage = 1;
                }
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        // Đếm tổng số sách thỏa mãn điều kiện
        int totalBooks = bookDAO.countTotalBooks(categoryId, searchKeyword);

        // Tính tổng số trang
        int totalPages = (int) Math.ceil((double) totalBooks / BOOKS_PER_PAGE);

        // Đảm bảo currentPage không vượt quá totalPages
        if (currentPage > totalPages && totalPages > 0) {
             currentPage = totalPages;
        }

        // Lấy danh sách sách cho trang hiện tại
        List<Book> bookList = bookDAO.getBooksPaginated(categoryId, searchKeyword, currentPage, BOOKS_PER_PAGE);

        // Gửi các thuộc tính cần thiết tới JSP
        request.setAttribute("bookList", bookList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("categoryId", categoryId); // Để giữ lại category khi chuyển trang
        request.setAttribute("searchKeyword", searchKeyword); // Để giữ lại keyword khi chuyển trang

        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}
