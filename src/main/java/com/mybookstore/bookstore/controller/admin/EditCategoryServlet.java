package com.mybookstore.bookstore.controller.admin;

import com.mybookstore.bookstore.dao.CategoryDAO;
import com.mybookstore.bookstore.model.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/edit-category")
public class EditCategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CategoryDAO categoryDAO;

    public void init() {
        categoryDAO = new CategoryDAO();
    }

    // Hiển thị form để sửa
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Category existingCategory = categoryDAO.getCategoryById(id);
            if (existingCategory != null) {
                request.setAttribute("category", existingCategory);
                request.getRequestDispatcher("/admin/edit-category.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/manage-categories");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/manage-categories");
        }
    }

    // Xử lý cập nhật
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");

        if (name != null && !name.trim().isEmpty()) {
            Category category = new Category(id, name.trim());
            categoryDAO.updateCategory(category);
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/manage-categories");
    }
}