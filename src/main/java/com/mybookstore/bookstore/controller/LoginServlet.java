package com.mybookstore.bookstore.controller;

import com.mybookstore.bookstore.dao.UserDAO;
import com.mybookstore.bookstore.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String pass = request.getParameter("password");

        User user = userDAO.checkLogin(username, pass);

        if (user != null) {
            // Đăng nhập thành công, lưu user vào session
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);
            
            // Chuyển hướng đến trang chủ
            response.sendRedirect("home");
        } else {
            // Đăng nhập thất bại, gửi lỗi về trang login.jsp
            request.setAttribute("errorMessage", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}