package com.mybookstore.bookstore.controller.admin;

import com.mybookstore.bookstore.dao.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/delete-category")
public class DeleteCategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CategoryDAO categoryDAO;

    public void init() {
        categoryDAO = new CategoryDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            // (Nâng cao) Cần kiểm tra xem có sách nào thuộc thể loại này không trước khi xóa
            categoryDAO.deleteCategory(id);
        } catch (NumberFormatException e) {
            // Bỏ qua nếu id không hợp lệ
        }
        response.sendRedirect(request.getContextPath() + "/admin/manage-categories");
    }
}