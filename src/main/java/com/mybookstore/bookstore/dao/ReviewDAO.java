package com.mybookstore.bookstore.dao;

import com.mybookstore.bookstore.model.Review;
import com.mybookstore.bookstore.model.User; // Cần import User

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {

    /**
     * Thêm một đánh giá mới vào cơ sở dữ liệu.
     * @param review Đối tượng Review chứa thông tin đánh giá.
     */
    public void addReview(Review review) {
        String sql = "INSERT INTO reviews (bookId, userId, rating, comment) VALUES (?, ?, ?, ?)";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, review.getBookId());
            ps.setInt(2, review.getUserId());
            ps.setInt(3, review.getRating());
            ps.setString(4, review.getComment());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Lấy tất cả đánh giá cho một cuốn sách cụ thể, kèm thông tin người dùng.
     * Sắp xếp đánh giá mới nhất lên đầu.
     * @param bookId ID của cuốn sách.
     * @return Danh sách các đối tượng Review.
     */
    public List<Review> getReviewsByBookId(int bookId) {
        List<Review> reviews = new ArrayList<>();
        // JOIN với bảng users để lấy tên người dùng
        String sql = "SELECT r.*, u.fullname " +
                     "FROM reviews r JOIN users u ON r.userId = u.id " +
                     "WHERE r.bookId = ? ORDER BY r.createdAt DESC";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, bookId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Review review = new Review();
                    review.setId(rs.getInt("id"));
                    review.setBookId(rs.getInt("bookId"));
                    review.setUserId(rs.getInt("userId"));
                    review.setRating(rs.getInt("rating"));
                    review.setComment(rs.getString("comment"));
                    review.setCreatedAt(rs.getTimestamp("createdAt"));

                    // Tạo đối tượng User tạm thời chỉ chứa fullname
                    User user = new User();
                    user.setId(rs.getInt("userId")); // Có thể cần ID nếu muốn link đến profile user
                    user.setFullname(rs.getString("fullname"));
                    review.setUser(user); // Gắn thông tin người dùng vào review

                    reviews.add(review);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }
}