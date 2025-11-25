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
        String sql = "SELECT o.*, u.fullname " +
                "FROM orders o " +
                "JOIN users u ON o.userId = u.id " + 
                "ORDER BY o.orderDate DESC";

        try (Connection conn = DatabaseConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

               while (rs.next()) {
                   Order order = new Order();
                   
                   // 1. Map dữ liệu từ bảng 'orders'
                   order.setId(rs.getInt("id"));
                   order.setUserId(rs.getInt("userId"));
                   order.setOrderDate(rs.getTimestamp("orderDate"));
                   order.setTotalAmount(rs.getDouble("totalAmount"));
                   order.setShippingAddress(rs.getString("shippingAddress"));
                   order.setStatus(rs.getString("status"));

                   // 2. Map dữ liệu từ bảng 'users' (Quan trọng)
                   // Lấy cột 'fullname' gán vào biến 'userName' của Model
                   order.setUserName(rs.getString("fullname"));

                   list.add(order);
               }
           } catch (Exception e) {
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

 // Tính tổng doanh thu toàn hệ thống (Chỉ tính đơn Completed)
    public double getTotalRevenue() {
        String sql = "SELECT SUM(totalAmount) FROM orders WHERE status = 'Completed'";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }
    
 // Đếm đơn hàng hoàn thành trong ngày hôm nay
    public int countCompletedOrdersToday() {
        String sql = "SELECT COUNT(*) FROM orders WHERE status = 'Completed' AND DATE(orderDate) = CURDATE()";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }
    
 // Lấy dữ liệu doanh thu theo 12 tháng của năm hiện tại (để vẽ biểu đồ)
    // Trả về List<Double> có 12 phần tử tương ứng tháng 1 -> 12
    public List<Double> getMonthlyRevenue(int year) {
        List<Double> monthlyRevenue = new ArrayList<>();
        // Khởi tạo 12 tháng bằng 0.0
        for (int i = 0; i < 12; i++) monthlyRevenue.add(0.0);

        String sql = "SELECT MONTH(orderDate) as month, SUM(totalAmount) as total " +
                     "FROM orders WHERE status = 'Completed' AND YEAR(orderDate) = ? " +
                     "GROUP BY MONTH(orderDate)";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, year);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int monthIndex = rs.getInt("month") - 1; // Tháng 1 là index 0
                    if (monthIndex >= 0 && monthIndex < 12) {
                        monthlyRevenue.set(monthIndex, rs.getDouble("total"));
                    }
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return monthlyRevenue;
    }

 // Lấy số lượng đơn hàng trong 7 ngày gần nhất (để vẽ biểu đồ)
    // Trả về Map<Ngày, Số lượng>
    public Map<String, Integer> getOrdersLast7Days() {
        Map<String, Integer> data = new LinkedHashMap<>(); // Dùng LinkedHashMap để giữ thứ tự
        String sql = "SELECT DATE(orderDate) as date, COUNT(*) as count " +
                     "FROM orders " +
                     "WHERE orderDate >= DATE(NOW()) - INTERVAL 6 DAY " +
                     "GROUP BY DATE(orderDate) ORDER BY date ASC";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                data.put(rs.getString("date"), rs.getInt("count"));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return data;
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
 // Trong OrderDAO.java (Bổ sung)

    /** Đếm số lượng đơn hàng theo từng trạng thái */
    public Map<String, Integer> getOrderStatusCounts() {
        Map<String, Integer> statusCounts = new HashMap<>();
        String sql = "SELECT status, COUNT(*) AS count FROM orders GROUP BY status";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                statusCounts.put(rs.getString("status"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return statusCounts;
    }

    /** Lấy N đơn hàng gần nhất (ID, userId, totalAmount, status) */
    public List<Order> getRecentOrders(int limit) {
        List<Order> list = new ArrayList<>();
        
        // ĐÃ SỬA: Thay u.name bằng u.fullname
        String sql = "SELECT o.*, u.fullname AS userName FROM orders o JOIN users u ON o.userId = u.id ORDER BY orderDate DESC LIMIT ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = extractOrderFromResultSet(rs);
                    list.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

 /**
  * Lấy danh sách Top N sách bán chạy nhất (dựa trên số lượng).
  * @param limit Số lượng sách muốn lấy (ví dụ: 5)
  * @return List các đối tượng chứa thông tin sách và số lượng bán.
  */
 public List<Map<String, Object>> getTopSellingBooks(int limit) {
     List<Map<String, Object>> topBooks = new ArrayList<>();
     
     // GIẢ ĐỊNH: Bảng 'order_details' có cột 'bookId' và 'quantity'
     // GIẢ ĐỊNH: Bảng 'books' có cột 'id
     String sql = "SELECT od.bookId, b.title, SUM(od.quantity) AS total_sold " +
                  "FROM order_details od " +
                  "JOIN books b ON od.bookId = b.id " +
                  // Chỉ tính các đơn hàng đã hoàn thành
                  "JOIN orders o ON od.orderId = o.id WHERE o.status = 'Completed' " +
                  "GROUP BY od.bookId, b.title " +
                  "ORDER BY total_sold DESC " +
                  "LIMIT ?";

     try (Connection connection = DatabaseConnection.getConnection();
          PreparedStatement ps = connection.prepareStatement(sql)) {

         ps.setInt(1, limit);
         try (ResultSet rs = ps.executeQuery()) {
             while (rs.next()) {
                 Map<String, Object> bookData = new HashMap<>();
                 bookData.put("id", rs.getInt("bookId"));
                 bookData.put("title", rs.getString("title"));
                 bookData.put("total_sold", rs.getLong("total_sold"));
                 topBooks.add(bookData);
             }
         }
     } catch (SQLException e) {
         e.printStackTrace();
     }
     return topBooks;
 }
 /** * Tính tổng doanh thu trong khoảng thời gian cụ thể (Dùng cho ReportService)
  * @param startDate Ngày bắt đầu
  * @param endDate Ngày kết thúc
  */
 public double getTotalRevenue(java.time.LocalDate startDate, java.time.LocalDate endDate) {
     String sql = "SELECT SUM(totalAmount) FROM orders WHERE status = 'Completed' AND orderDate BETWEEN ? AND ?";
     try (Connection connection = DatabaseConnection.getConnection();
          PreparedStatement ps = connection.prepareStatement(sql)) {

         // Chuyển đổi LocalDate sang Timestamp để query DB
         ps.setTimestamp(1, java.sql.Timestamp.valueOf(startDate.atStartOfDay()));
         ps.setTimestamp(2, java.sql.Timestamp.valueOf(endDate.atTime(23, 59, 59)));

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
  * Lấy doanh thu của từng ngày trong 7 ngày gần nhất.
  * @return Map<LocalDate, Double> (Key: Ngày, Value: Tổng tiền)
  */
 public java.util.Map<java.time.LocalDate, Double> getDailyRevenueLast7Days() {
     java.util.Map<java.time.LocalDate, Double> dailyRevenue = new java.util.HashMap<>();
     
     java.time.LocalDate today = java.time.LocalDate.now();
     java.time.LocalDate startDate = today.minusDays(6); // Lấy từ 6 ngày trước đến hôm nay (tổng 7 ngày)

     // SQL: Nhóm theo ngày (DATE(orderDate)) và tính tổng tiền
     String sql = "SELECT DATE(orderDate) AS order_day, SUM(totalAmount) AS daily_total " +
                  "FROM orders " +
                  "WHERE status = 'Completed' AND orderDate >= ? " +
                  "GROUP BY DATE(orderDate) " +
                  "ORDER BY order_day ASC";

     try (java.sql.Connection connection = DatabaseConnection.getConnection();
          java.sql.PreparedStatement ps = connection.prepareStatement(sql)) {

         // Chuyển LocalDate start về Timestamp 00:00:00
         ps.setTimestamp(1, java.sql.Timestamp.valueOf(startDate.atStartOfDay()));

         try (java.sql.ResultSet rs = ps.executeQuery()) {
             while (rs.next()) {
                 java.sql.Date dbDate = rs.getDate("order_day");
                 if (dbDate != null) {
                     // Put dữ liệu từ DB vào Map
                     dailyRevenue.put(dbDate.toLocalDate(), rs.getDouble("daily_total"));
                 }
             }
         }
     } catch (java.sql.SQLException e) {
         e.printStackTrace();
     }

     // QUAN TRỌNG: Lấp đầy những ngày không có đơn hàng bằng số 0
     // (Nếu không biểu đồ sẽ bị gãy hoặc thiếu ngày)
     for (int i = 0; i < 7; i++) {
         java.time.LocalDate date = startDate.plusDays(i);
         // Nếu ngày này chưa có trong Map (chưa bán được gì), thì set là 0.0
         dailyRevenue.putIfAbsent(date, 0.0);
     }

     return dailyRevenue;
 }
}
