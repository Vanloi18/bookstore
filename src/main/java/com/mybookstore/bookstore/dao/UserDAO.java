package com.mybookstore.bookstore.dao;

import com.mybookstore.bookstore.model.User;
import com.mybookstore.bookstore.util.PasswordUtil; // Thêm import
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    /**
     * Kiểm tra thông tin đăng nhập bằng cách so sánh mật khẩu đã băm.
     * @param username Tên đăng nhập
     * @param plainPassword Mật khẩu dạng văn bản thuần người dùng nhập vào.
     * @return Đối tượng User nếu đăng nhập thành công, ngược lại trả về null.
     */
    public User checkLogin(String username, String plainPassword) {
        String sql = "SELECT * FROM users WHERE username = ?";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String hashedPasswordFromDB = rs.getString("password");
                    
                    // Sử dụng PasswordUtil để kiểm tra mật khẩu
                    if (PasswordUtil.checkPassword(plainPassword, hashedPasswordFromDB)) {
                        User user = new User();
                        user.setId(rs.getInt("id"));
                        user.setUsername(rs.getString("username"));
                        user.setFullname(rs.getString("fullname"));
                        user.setEmail(rs.getString("email"));
                        user.setAddress(rs.getString("address"));
                        user.setPhone(rs.getString("phone"));
                        user.setAdmin(rs.getBoolean("isAdmin"));
                        return user;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public int countUsers() {
        // Chỉ đếm người dùng thường, không đếm admin
        String sql = "SELECT COUNT(*) FROM users WHERE isAdmin = false";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    /**
     * Kiểm tra xem username đã tồn tại trong CSDL hay chưa.
     * @param username Tên đăng nhập cần kiểm tra
     * @return true nếu đã tồn tại, false nếu chưa.
     */
    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Thêm một người dùng mới vào CSDL (dùng cho chức năng đăng ký).
     * @param user Đối tượng User chứa thông tin người dùng mới.
     */
    public void addUser(User user) {
        String sql = "INSERT INTO users (username, password, fullname, email, address, phone) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            // Sử dụng PasswordUtil để băm mật khẩu trước khi lưu
            String hashedPassword = PasswordUtil.hashPassword(user.getPassword());

            ps.setString(1, user.getUsername());
            ps.setString(2, hashedPassword); // Lưu mật khẩu đã được mã hóa
            ps.setString(3, user.getFullname());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getPhone());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

