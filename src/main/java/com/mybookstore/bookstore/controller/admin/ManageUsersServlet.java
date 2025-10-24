package com.mybookstore.bookstore.controller.admin;

import com.mybookstore.bookstore.dao.UserDAO;
import com.mybookstore.bookstore.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/manage-users")
public class ManageUsersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> userList = userDAO.getAllNonAdminUsers();
        request.setAttribute("userList", userList);
        request.getRequestDispatcher("/admin/manage-users.jsp").forward(request, response);
    }
}
