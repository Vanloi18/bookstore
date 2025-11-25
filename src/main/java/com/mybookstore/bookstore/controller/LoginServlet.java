package com.mybookstore.bookstore.controller;

import com.mybookstore.bookstore.dao.UserDAO;
import com.mybookstore.bookstore.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Xử lý encoding tiếng Việt nếu cần
        request.setCharacterEncoding("UTF-8");
        
        String usernameOrEmail = request.getParameter("username");
        String pass = request.getParameter("password");
        String remember = request.getParameter("remember"); // Lấy giá trị checkbox từ login.jsp

        User user = userDAO.checkLogin(usernameOrEmail, pass);

        if (user != null) {
            // 1. Đăng nhập thành công, lưu vào Session (bắt buộc để duy trì trạng thái đăng nhập)
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);
            
            // 2. Xử lý Cookie "Ghi nhớ đăng nhập"
            // Tạo cookie lưu tên đăng nhập
            Cookie userCookie = new Cookie("c_user", usernameOrEmail);
            
            if (remember != null && remember.equals("on")) {
                // Nếu người dùng tick chọn: Lưu cookie trong 3 ngày (3 * 24 * 60 * 60 giây)
                userCookie.setMaxAge(3 * 24 * 60 * 60); 
            } else {
                // Nếu KHÔNG chọn: Xóa cookie cũ ngay lập tức (set thời gian sống = 0)
                userCookie.setMaxAge(0);
            }
            
            // Đặt đường dẫn để cookie có hiệu lực trên toàn bộ website
            userCookie.setPath("/"); 
            
            // Gửi cookie về trình duyệt của người dùng
            response.addCookie(userCookie);

            // Chuyển hướng về trang chủ
            response.sendRedirect("home");
        } else {
            // Đăng nhập thất bại
            request.setAttribute("errorMessage", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}