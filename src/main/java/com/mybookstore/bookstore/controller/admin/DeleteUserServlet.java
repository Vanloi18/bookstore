package com.mybookstore.bookstore.controller.admin;

import com.mybookstore.bookstore.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/delete-user")
public class DeleteUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         try {
            int userId = Integer.parseInt(request.getParameter("id"));
            userDAO.deleteUser(userId);
        } catch (NumberFormatException e) {
             e.printStackTrace(); // Log lỗi
        }
        response.sendRedirect(request.getContextPath() + "/admin/manage-users");
    }
}
