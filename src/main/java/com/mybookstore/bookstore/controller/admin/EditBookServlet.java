package com.mybookstore.bookstore.controller.admin;

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

@WebServlet("/admin/edit-book")
public class EditBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;
    private CategoryDAO categoryDAO;

    public void init() {
        bookDAO = new BookDAO();
        categoryDAO = new CategoryDAO();
    }

    // HIỂN THỊ FORM ĐỂ SỬA
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int bookId = Integer.parseInt(request.getParameter("id"));
            
            // Lấy thông tin sách cần sửa
            Book existingBook = bookDAO.getBookById(bookId);
            
            // Lấy danh sách thể loại để hiển thị trong dropdown
            List<Category> categoryList = categoryDAO.getAllCategories();
            
            // Gửi thông tin sách và danh sách thể loại tới trang jsp
            request.setAttribute("book", existingBook);
            request.setAttribute("categoryList", categoryList);
            
            request.getRequestDispatcher("/admin/edit-book.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/manage-books");
        }
    }

    // XỬ LÝ CẬP NHẬT
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Lấy thông tin từ form
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        int publicationYear = Integer.parseInt(request.getParameter("publicationYear"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String coverImage = request.getParameter("coverImage");
        String description = request.getParameter("description");
        
        // Tạo đối tượng Book để cập nhật
        Book book = new Book();
        book.setId(id);
        book.setTitle(title);
        book.setAuthor(author);
        book.setPrice(price);
        book.setStock(stock);
        book.setPublicationYear(publicationYear);
        book.setCategoryId(categoryId);
        book.setCoverImage(coverImage);
        book.setDescription(description);
        
        // Gọi DAO để cập nhật
        bookDAO.updateBook(book);
        
        // Chuyển hướng về lại trang quản lý sách
        response.sendRedirect(request.getContextPath() + "/admin/manage-books");
    }
}