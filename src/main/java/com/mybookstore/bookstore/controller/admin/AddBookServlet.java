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

@WebServlet("/admin/add-book") // <-- URL DUY NHẤT
public class AddBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;
    private CategoryDAO categoryDAO;

    public void init() {
        bookDAO = new BookDAO();
        categoryDAO = new CategoryDAO();
    }

    /**
     * Xử lý yêu cầu GET: Hiển thị form thêm sách.
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy danh sách thể loại từ CSDL
        List<Category> categoryList = categoryDAO.getAllCategories();
        
        // Gửi danh sách này tới trang JSP
        request.setAttribute("categoryList", categoryList);
        
        // Chuyển tiếp đến form thêm sách
        request.getRequestDispatcher("/admin/add-book.jsp").forward(request, response);
    }

    /**
     * Xử lý yêu cầu POST: Thêm sách mới vào CSDL.
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Lấy thông tin từ form
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        int publicationYear = Integer.parseInt(request.getParameter("publicationYear"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String coverImage = request.getParameter("coverImage");
        String description = request.getParameter("description");
        
        // Tạo đối tượng Book mới
        Book newBook = new Book();
        newBook.setTitle(title);
        newBook.setAuthor(author);
        newBook.setPrice(price);
        newBook.setStock(stock);
        newBook.setPublicationYear(publicationYear);
        newBook.setCategoryId(categoryId);
        newBook.setCoverImage(coverImage);
        newBook.setDescription(description);
        
        // Gọi DAO để thêm vào CSDL
        bookDAO.addBook(newBook);
        
        // Chuyển hướng về lại trang quản lý sách
        response.sendRedirect(request.getContextPath() + "/admin/manage-books");
    }
}