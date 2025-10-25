package com.mybookstore.bookstore.dao;

import com.mybookstore.bookstore.model.Order;
import java.sql.*;
import java.time.LocalDate;
import java.util.*;

/**
 * DAO quản lý các thao tác với bảng orders
 */
public class OrderDAO {

    /** Thêm đơn hàng mới và trả về ID được sinh ra */
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

    /** Đếm tổng số đơn hàng */
    public int countOrders() {
        String sql = "SELECT COUNT(*) FROM orders";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /** Lấy tất cả đơn hàng, mới nhất lên đầu */
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders ORDER BY orderDate DESC";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(extractOrderFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /** 🔍 Tìm kiếm đơn hàng theo ID, tên khách hàng, hoặc địa chỉ giao hàng */
    public List<Order> searchOrders(String keyword) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.*, u.name AS userName " +
                     "FROM orders o JOIN users u ON o.userId = u.id " +
                     "WHERE CAST(o.id AS CHAR) LIKE ? OR u.name LIKE ? OR o.shippingAddress LIKE ? " +
                     "ORDER BY o.orderDate DESC";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            String kw = "%" + keyword + "%";
            ps.setString(1, kw);
            ps.setString(2, kw);
            ps.setString(3, kw);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = extractOrderFromResultSet(rs);
                    // nếu muốn hiển thị tên người dùng, bạn có thể thêm vào model Order
                    list.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /** Lọc đơn hàng theo keyword và trạng thái */
    public List<Order> filterOrders(String keyword, String status) {
        List<Order> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM orders WHERE 1=1");

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (CAST(id AS CHAR) LIKE ? OR CAST(userId AS CHAR) LIKE ? OR shippingAddress LIKE ?)");
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
        }
        sql.append(" ORDER BY orderDate DESC");

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql.toString())) {

            int index = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                String pattern = "%" + keyword + "%";
                ps.setString(index++, pattern);
                ps.setString(index++, pattern);
                ps.setString(index++, pattern);
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(index++, status);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractOrderFromResultSet(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /** Cập nhật trạng thái đơn hàng */
    public boolean updateOrderStatus(int orderId, String newStatus) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, newStatus);
            ps.setInt(2, orderId);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /** Lấy đơn hàng theo ID người dùng */
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE userId = ? ORDER BY orderDate DESC";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractOrderFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /** Đếm số đơn hàng đang chờ xử lý */
    public int countNewOrders() {
        String sql = "SELECT COUNT(*) FROM orders WHERE status = 'Pending'";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /** Tính tổng doanh thu trong khoảng thời gian */
    public double getTotalRevenue(LocalDate startDate, LocalDate endDate) {
        String sql = "SELECT SUM(totalAmount) FROM orders WHERE status = 'Completed' AND orderDate BETWEEN ? AND ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setTimestamp(1, Timestamp.valueOf(startDate.atStartOfDay()));
            ps.setTimestamp(2, Timestamp.valueOf(endDate.atTime(23, 59, 59)));

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    /** Lấy doanh thu theo từng ngày trong 7 ngày gần nhất */
    public Map<LocalDate, Double> getDailyRevenueLast7Days() {
        Map<LocalDate, Double> dailyRevenue = new HashMap<>();
        LocalDate today = LocalDate.now();
        LocalDate startDate = today.minusDays(6);

        String sql = "SELECT DATE(orderDate) AS order_day, SUM(totalAmount) AS daily_total " +
                     "FROM orders WHERE status = 'Completed' AND orderDate >= ? " +
                     "GROUP BY DATE(orderDate) ORDER BY order_day ASC";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setTimestamp(1, Timestamp.valueOf(startDate.atStartOfDay()));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    LocalDate day = rs.getDate("order_day").toLocalDate();
                    double total = rs.getDouble("daily_total");
                    dailyRevenue.put(day, total);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        for (int i = 0; i < 7; i++) {
            LocalDate date = startDate.plusDays(i);
            dailyRevenue.putIfAbsent(date, 0.0);
        }

        return dailyRevenue;
    }

    /** Hàm tiện ích để chuyển ResultSet → Order object */
    private Order extractOrderFromResultSet(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setUserId(rs.getInt("userId"));
        order.setOrderDate(rs.getTimestamp("orderDate"));
        order.setTotalAmount(rs.getDouble("totalAmount"));
        order.setShippingAddress(rs.getString("shippingAddress"));
        order.setStatus(rs.getString("status"));
        return order;
    }
}
