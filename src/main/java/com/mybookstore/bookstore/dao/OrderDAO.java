package com.mybookstore.bookstore.dao;

import com.mybookstore.bookstore.model.Order;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

public class OrderDAO {

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
	
	public int countOrders() {
        String sql = "SELECT COUNT(*) FROM orders";
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
	
	public boolean updateOrderStatus(int orderId, String newStatus) {
		String sql = "UPDATE orders SET status = ? WHERE id = ?";
		try (Connection connection = DatabaseConnection.getConnection();
				PreparedStatement ps = connection.prepareStatement(sql)) {

			ps.setString(1, newStatus);
			ps.setInt(2, orderId);

			int affectedRows = ps.executeUpdate();
			return affectedRows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public List<Order> getOrdersByUserId(int userId) {
        List<Order> orderList = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE userId = ? ORDER BY orderDate DESC";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
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
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderList;
    }
	
	/**
     * Đếm số đơn hàng mới (trạng thái 'Pending').
     * @return Số lượng đơn hàng mới.
     */
    public int countNewOrders() {
        String sql = "SELECT COUNT(*) FROM orders WHERE status = 'Pending'";
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
     * Tính tổng doanh thu trong một khoảng thời gian.
     * @param startDate Ngày bắt đầu.
     * @param endDate Ngày kết thúc.
     * @return Tổng doanh thu.
     */
    public double getTotalRevenue(LocalDate startDate, LocalDate endDate) {
        // Chỉ tính doanh thu từ các đơn hàng đã hoàn thành ('Completed')
        String sql = "SELECT SUM(totalAmount) FROM orders WHERE status = 'Completed' AND orderDate BETWEEN ? AND ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            // Chuyển LocalDate sang Timestamp (thêm giờ phút giây)
            ps.setTimestamp(1, java.sql.Timestamp.valueOf(startDate.atStartOfDay()));
            ps.setTimestamp(2, java.sql.Timestamp.valueOf(endDate.atTime(23, 59, 59))); // Kết thúc ngày
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }
    
    /**
     * Lấy doanh thu theo từng ngày trong 7 ngày gần nhất.
     * @return Map với key là ngày (LocalDate) và value là doanh thu ngày đó.
     */
    public Map<LocalDate, Double> getDailyRevenueLast7Days() {
        Map<LocalDate, Double> dailyRevenue = new HashMap<>();
        LocalDate today = LocalDate.now();
        LocalDate startDate = today.minusDays(6); // 7 ngày tính cả hôm nay

        String sql = "SELECT DATE(orderDate) as order_day, SUM(totalAmount) as daily_total " +
                     "FROM orders " +
                     "WHERE status = 'Completed' AND orderDate >= ? " +
                     "GROUP BY DATE(orderDate) " +
                     "ORDER BY order_day ASC";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setTimestamp(1, java.sql.Timestamp.valueOf(startDate.atStartOfDay()));

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    LocalDate orderDay = rs.getDate("order_day").toLocalDate();
                    double revenue = rs.getDouble("daily_total");
                    dailyRevenue.put(orderDay, revenue);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Đảm bảo đủ 7 ngày, ngày nào không có doanh thu thì set là 0
        for (int i = 0; i < 7; i++) {
            LocalDate date = startDate.plusDays(i);
            dailyRevenue.putIfAbsent(date, 0.0);
        }

        return dailyRevenue;
    }
}