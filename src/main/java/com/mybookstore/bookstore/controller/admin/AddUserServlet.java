package com.mybookstore.bookstore.controller.admin;

import com.mybookstore.bookstore.dao.UserDAO;
import com.mybookstore.bookstore.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/add-user")
public class AddUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    // Hiển thị trang add-user.jsp
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/admin/add-user.jsp").forward(request, response);
    }

    // Xử lý việc thêm user
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        String username = request.getParameter("username");
        String pass = request.getParameter("password");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        // Lấy giá trị checkbox, nếu không check, nó sẽ là null
        boolean isAdmin = "true".equals(request.getParameter("isAdmin")); 

        if (userDAO.isUsernameExists(username)) {
            // Nếu đã tồn tại, gửi lỗi về
            request.setAttribute("errorMessage", "Tên đăng nhập đã tồn tại!");
            request.getRequestDispatcher("/admin/add-user.jsp").forward(request, response);
        } else {
            // Nếu chưa, tạo người dùng mới
            User newUser = new User();
            newUser.setUsername(username);
            newUser.setPassword(pass); // UserDAO sẽ tự động băm mật khẩu
            newUser.setFullname(fullname);
            newUser.setEmail(email);
            newUser.setAddress(address);
            newUser.setPhone(phone);
            newUser.setAdmin(isAdmin); // Đặt vai trò do admin chọn

            userDAO.addUser(newUser);
            
            session.setAttribute("userActionMsg", "Thêm người dùng mới thành công!");
            response.sendRedirect(request.getContextPath() + "/admin/manage-users");
        }
    }
}