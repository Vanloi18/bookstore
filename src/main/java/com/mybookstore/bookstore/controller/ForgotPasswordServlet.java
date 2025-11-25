package com.mybookstore.bookstore.controller;

import com.mybookstore.bookstore.dao.UserDAO;
import com.mybookstore.bookstore.model.User;
import com.mybookstore.bookstore.util.EmailUtility;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("forgot.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        UserDAO dao = new UserDAO();
        User user = dao.findByEmail(email);

        if (user != null) {
            String token = UUID.randomUUID().toString();
            dao.updateResetToken(email, token);
            
            // Xây dựng link reset (Lấy đúng domain hiện tại)
            String appUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
            String resetLink = appUrl + "/reset-password?token=" + token;
            
            String content = "<p>Xin chào " + user.getFullname() + ",</p>"
                    + "<p>Bạn đã yêu cầu đặt lại mật khẩu. Vui lòng click vào link bên dưới:</p>"
                    + "<p><a href=\"" + resetLink + "\" style='padding:10px 20px; background:#0071e3; color:white; text-decoration:none; border-radius:5px;'>ĐẶT LẠI MẬT KHẨU</a></p>"
                    + "<p>Link hết hạn sau 15 phút.</p>";

            try {
                EmailUtility.sendEmail(email, "Yêu cầu đặt lại mật khẩu", content);
                request.setAttribute("message", "Link đặt lại mật khẩu đã được gửi vào email của bạn!");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Lỗi gửi email: " + e.getMessage());
            }
        } else {
            // Bảo mật: Thông báo chung chung hoặc báo lỗi tùy ý
            request.setAttribute("error", "Email không tồn tại trong hệ thống.");
        }
        request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
    }
}