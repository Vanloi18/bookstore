package com.mybookstore.bookstore.controller.admin;

import com.mybookstore.bookstore.dao.CategoryDAO;
import com.mybookstore.bookstore.model.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/add-category")
public class AddCategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CategoryDAO categoryDAO;

    public void init() {
        categoryDAO = new CategoryDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String categoryName = request.getParameter("categoryName");
        if (categoryName != null && !categoryName.trim().isEmpty()) {
            Category newCategory = new Category();
            newCategory.setName(categoryName.trim());
            categoryDAO.addCategory(newCategory);
        }
        response.sendRedirect(request.getContextPath() + "/admin/manage-categories");
    }
}