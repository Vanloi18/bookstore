package com.mybookstore.bookstore.controller;

import com.mybookstore.bookstore.dao.UserDAO;
import com.mybookstore.bookstore.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("token");
        UserDAO dao = new UserDAO();
        User user = dao.getByResetToken(token);

        if (user != null) {
            request.setAttribute("token", token);
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Link không hợp lệ hoặc đã hết hạn!");
            request.getRequestDispatcher("forgot.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("token");
        String password = request.getParameter("password").trim();
        String confirmPassword = request.getParameter("confirmPassword").trim();

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.setAttribute("token", token);
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();
        User user = dao.getByResetToken(token); // Kiểm tra lại lần nữa để bảo mật

        if (user != null) {
            dao.updatePassword(user.getEmail(), password); // UserDAO sẽ tự hash password
            request.setAttribute("message", "Đổi mật khẩu thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Phiên làm việc hết hạn, vui lòng thử lại.");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
        }
    }
}