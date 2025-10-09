package com.mybookstore.bookstore.dao;

import com.mybookstore.bookstore.model.Order;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class OrderDAO {

    /**
     * Thêm một đơn hàng mới vào CSDL.
     * @param order Đối tượng Order chứa thông tin đơn hàng.
     * @return ID của đơn hàng vừa được tạo, hoặc -1 nếu có lỗi.
     */
    public int addOrder(Order order) {
        String sql = "INSERT INTO orders (userId, totalAmount, shippingAddress, status) VALUES (?, ?, ?, ?)";
        int generatedOrderId = -1;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, order.getUserId());
            ps.setDouble(2, order.getTotalAmount());
            ps.setString(3, order.getShippingAddress());
            ps.setString(4, order.getStatus());

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        generatedOrderId = rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return generatedOrderId;
    }
    public List<Order> getAllOrders() {
        List<Order> orderList = new ArrayList<>();
        // Sắp xếp đơn hàng mới nhất lên đầu
        String sql = "SELECT * FROM orders ORDER BY orderDate DESC";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("userId"));
                order.setOrderDate(rs.getTimestamp("orderDate"));
                order.setTotalAmount(rs.getDouble("totalAmount"));
                order.setShippingAddress(rs.getString("shippingAddress"));
                order.setStatus(rs.getString("status"));
                orderList.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderList;
    }
}