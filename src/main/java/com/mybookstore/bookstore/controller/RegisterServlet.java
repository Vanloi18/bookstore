package com.mybookstore.bookstore.controller;

import com.mybookstore.bookstore.dao.UserDAO;
import com.mybookstore.bookstore.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); 
        
        String username = request.getParameter("username");
        String pass = request.getParameter("password");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        
        
        if (userDAO.isUsernameExists(username)) {
            
            request.setAttribute("errorMessage", "Tên đăng nhập đã tồn tại!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            
            User newUser = new User();
            newUser.setUsername(username);
            newUser.setPassword(pass); 
            newUser.setFullname(fullname);
            newUser.setEmail(email);
            newUser.setAddress(address);
            newUser.setPhone(phone);
            
            userDAO.addUser(newUser);
            
            response.sendRedirect("login.jsp");
        }
    }
}