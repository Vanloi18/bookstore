package com.mybookstore.bookstore.dao;

import com.mybookstore.bookstore.model.OrderDetail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class OrderDetailDAO {

    /**
     * Thêm chi tiết một đơn hàng vào CSDL.
     * @param detail Đối tượng OrderDetail chứa thông tin sản phẩm trong đơn hàng.
     */
    public void addOrderDetail(OrderDetail detail) {
        String sql = "INSERT INTO order_details (orderId, bookId, quantity, pricePerUnit) VALUES (?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, detail.getOrderId());
            ps.setInt(2, detail.getBookId());
            ps.setInt(3, detail.getQuantity());
            ps.setDouble(4, detail.getPricePerUnit());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}