package com.mybookstore.bookstore.dao;

import com.mybookstore.bookstore.model.User;
import com.mybookstore.bookstore.util.PasswordUtil; // Thêm import
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList; // Thêm import
import java.util.List;    // Thêm import

public class UserDAO {

    /**
     * Kiểm tra thông tin đăng nhập bằng cách so sánh mật khẩu đã băm.
     * @param username Tên đăng nhập
     * @param plainPassword Mật khẩu dạng văn bản thuần người dùng nhập vào.
     * @return Đối tượng User nếu đăng nhập thành công, ngược lại trả về null.
     */
	public User checkLogin(String usernameOrEmail, String plainPassword) {
	    String sql = "SELECT * FROM users WHERE username = ? OR email = ?";
	    
	    try (Connection connection = DatabaseConnection.getConnection();
	         PreparedStatement ps = connection.prepareStatement(sql)) {

	        ps.setString(1, usernameOrEmail);
	        ps.setString(2, usernameOrEmail);

	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                String hashedPassword = rs.getString("password");

	                if (PasswordUtil.checkPassword(plainPassword, hashedPassword)) {
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
        	
            String hashedPassword = PasswordUtil.hashPassword(user.getPassword());

            ps.setString(1, user.getUsername());
            ps.setString(2, hashedPassword); 
            ps.setString(3, user.getFullname());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getPhone());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
 // Thêm vào UserDAO.java
    public int countNewUsersToday() {
        // CURDATE() là hàm của MySQL để lấy ngày hiện tại
        String sql = "SELECT COUNT(*) FROM users WHERE DATE(registrationDate) = CURDATE()"; 
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
     * Lấy danh sách tất cả người dùng (không bao gồm admin).
     * @return List các đối tượng User.
     */
    public List<User> getAllNonAdminUsers() {
        List<User> userList = new ArrayList<>();
        String sql = "SELECT id, username, fullname, email, address, phone, isAdmin, createdAt FROM users WHERE isAdmin = false ORDER BY createdAt DESC";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User user = mapResultSetToUser(rs);
                userList.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }

    /**
     * Cập nhật trạng thái admin cho một người dùng.
     * @param userId ID của người dùng.
     * @param isAdmin Trạng thái admin mới (true hoặc false).
     * @return true nếu cập nhật thành công, false nếu thất bại.
     */
    public boolean updateUserAdminStatus(int userId, boolean isAdmin) {
        String sql = "UPDATE users SET isAdmin = ? WHERE id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setBoolean(1, isAdmin);
            ps.setInt(2, userId);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Xóa một người dùng khỏi CSDL.
     * (Cẩn thận: Nên xem xét việc "vô hiệu hóa" thay vì xóa hẳn).
     * @param userId ID của người dùng cần xóa.
     * @return true nếu xóa thành công, false nếu thất bại.
     */
    public boolean deleteUser(int userId) {
        // Cần xóa các bản ghi liên quan trước (orders, reviews...) hoặc set ON DELETE CASCADE/SET NULL trong CSDL
        String sql = "DELETE FROM users WHERE id = ? AND isAdmin = false"; // Chỉ xóa user thường
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            // Log lỗi SQLIntegrityConstraintViolationException nếu không xóa được do khóa ngoại
            e.printStackTrace();
            return false;
        }
    }

    // Helper method để tránh lặp code
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setUsername(rs.getString("username"));
        user.setFullname(rs.getString("fullname"));
        user.setEmail(rs.getString("email"));
        user.setAddress(rs.getString("address"));
        user.setPhone(rs.getString("phone"));
        user.setAdmin(rs.getBoolean("isAdmin"));
        user.setCreatedAt(rs.getTimestamp("createdAt"));
        // Không lấy password
        return user;
    }

    /**
     * Đếm số lượng người dùng mới (không phải admin) đăng ký trong tháng hiện tại.
     */
    public int countNewUsersThisMonth() {
        // YEAR(createdAt) = YEAR(CURDATE()) AND MONTH(createdAt) = MONTH(CURDATE())
        String sql = "SELECT COUNT(*) FROM users WHERE isAdmin = false AND YEAR(createdAt) = YEAR(CURDATE()) AND MONTH(createdAt) = MONTH(CURDATE())";
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
 // Thêm các phương thức này vào cuối class UserDAO.java hiện tại

    /**
     * Tìm người dùng qua email để gửi link reset.
     */
    public User findByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs); // Sử dụng lại hàm helper có sẵn
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Lưu token reset password và thời gian hết hạn (15 phút).
     */
    public void updateResetToken(String email, String token) {
        String sql = "UPDATE users SET reset_token = ?, token_expiry = DATE_ADD(NOW(), INTERVAL 15 MINUTE) WHERE email = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, token);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Kiểm tra token có hợp lệ và còn hạn không.
     */
    public User getByResetToken(String token) {
        String sql = "SELECT * FROM users WHERE reset_token = ? AND token_expiry > NOW()";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, token);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Cập nhật mật khẩu mới (có mã hóa BCrypt) và xóa token.
     */
    public void updatePassword(String email, String newPassword) {
        String sql = "UPDATE users SET password = ?, reset_token = NULL, token_expiry = NULL WHERE email = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            
            // QUAN TRỌNG: Mã hóa mật khẩu trước khi lưu để đồng bộ với chức năng Login
            String hashedPassword = PasswordUtil.hashPassword(newPassword);
            
            ps.setString(1, hashedPassword);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

