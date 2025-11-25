package com.mybookstore.bookstore.dao;

import com.mybookstore.bookstore.model.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

public class ReportDAO {

    // Helper: Tạo điều kiện WHERE từ filter
    private String buildWhereClause(ReportFilter filter, List<Object> params) {
        StringBuilder sql = new StringBuilder(" WHERE 1=1 ");
        if (filter.getFromDate() != null) {
            sql.append(" AND orderDate >= ? ");
            params.add(new java.sql.Timestamp(filter.getFromDate().getTime()));
        }
        if (filter.getToDate() != null) {
            sql.append(" AND orderDate <= ? ");
            // Set time to end of day
            Calendar c = Calendar.getInstance();
            c.setTime(filter.getToDate());
            c.set(Calendar.HOUR_OF_DAY, 23); c.set(Calendar.MINUTE, 59); c.set(Calendar.SECOND, 59);
            params.add(new java.sql.Timestamp(c.getTimeInMillis()));
        }
        if (filter.getOrderStatus() != null && !filter.getOrderStatus().isEmpty()) {
            sql.append(" AND status = ? ");
            params.add(filter.getOrderStatus());
        }
        return sql.toString();
    }

    public double getTotalRevenue(ReportFilter filter) {
        List<Object> params = new ArrayList<>();
        String sql = "SELECT SUM(totalAmount) FROM orders " + buildWhereClause(filter, params);
        // Nếu không lọc status thì mặc định chỉ lấy đơn hoàn thành
        if (filter.getOrderStatus() == null) { 
            sql += " AND status = 'Completed' "; 
        }
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public int getTotalOrders(ReportFilter filter) {
        List<Object> params = new ArrayList<>();
        String sql = "SELECT COUNT(*) FROM orders " + buildWhereClause(filter, params);
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public int getTotalBooksSold(ReportFilter filter) {
        // Cần join với order_details để đếm số lượng sách
        List<Object> params = new ArrayList<>();
        String where = buildWhereClause(filter, params);
        String sql = "SELECT SUM(od.quantity) FROM order_details od JOIN orders o ON od.orderId = o.id " + where;
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public int getNewCustomers(ReportFilter filter) {
        // Đếm user đăng ký trong khoảng thời gian lọc
        List<Object> params = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM users WHERE isAdmin=0 ");
        if (filter.getFromDate() != null) {
            sql.append(" AND createdAt >= ? ");
            params.add(new java.sql.Timestamp(filter.getFromDate().getTime()));
        }
        if (filter.getToDate() != null) {
            sql.append(" AND createdAt <= ? ");
            params.add(new java.sql.Timestamp(filter.getToDate().getTime()));
        }
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    // Lấy Top Bestseller
    public String getTopSellingBook(ReportFilter filter) {
        List<Object> params = new ArrayList<>();
        String where = buildWhereClause(filter, params);
        String sql = "SELECT b.title FROM books b " +
                     "JOIN order_details od ON b.id = od.bookId " +
                     "JOIN orders o ON od.orderId = o.id " +
                     where +
                     " GROUP BY b.id ORDER BY SUM(od.quantity) DESC LIMIT 1";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getString(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return "Chưa có dữ liệu";
    }

 // ===========================================================
    // THÊM METHOD NÀY ĐỂ SỬA LỖI UNDEFINED
    // ===========================================================
    
    /**
     * Lấy số lượng đơn hàng theo ngày để vẽ biểu đồ
     */
    public Map<String, Integer> getOrdersByDate(ReportFilter filter) {
        Map<String, Integer> map = new LinkedHashMap<>();
        List<Object> params = new ArrayList<>();
        String where = buildWhereClause(filter, params);
        
        // Query: Group by ngày (DATE) và đếm số dòng
        String sql = "SELECT DATE(orderDate) as day, COUNT(*) as count FROM orders " + 
                     where + " GROUP BY DATE(orderDate) ORDER BY day";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            // Set tham số cho dấu ?
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                // Lấy ngày dưới dạng String (YYYY-MM-DD) làm Key
                map.put(rs.getString("day"), rs.getInt("count"));
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return map;
    }

    // Dữ liệu biểu đồ Đơn hàng theo tháng (hoặc ngày)
    public Map<String, Integer> getOrdersByMonth(ReportFilter filter) {
        Map<String, Integer> map = new LinkedHashMap<>();
        List<Object> params = new ArrayList<>();
        String where = buildWhereClause(filter, params);
        
        // Group by date cho chi tiết
        String sql = "SELECT DATE(orderDate) as day, COUNT(*) as count FROM orders " + 
                     where + " GROUP BY DATE(orderDate) ORDER BY day";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                map.put(rs.getString("day"), rs.getInt("count"));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return map;
    }

    // Top 5 danh mục
    public List<CategoryRevenue> getCategoryRevenue(ReportFilter filter) {
        List<CategoryRevenue> list = new ArrayList<>();
        // Query phức tạp: join categories -> books -> order_details -> orders
        String sql = "SELECT c.name, SUM(od.quantity * od.pricePerUnit) as total " +
                     "FROM categories c " +
                     "JOIN books b ON c.id = b.categoryId " +
                     "JOIN order_details od ON b.id = od.bookId " +
                     "JOIN orders o ON od.orderId = o.id " +
                     "WHERE o.status = 'Completed' " +
                     "GROUP BY c.id ORDER BY total DESC LIMIT 5";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while(rs.next()) {
                list.add(new CategoryRevenue(rs.getString(1), rs.getDouble(2)));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // Bảng báo cáo chi tiết
    public List<DailyReport> getDailyReports(ReportFilter filter) {
        List<DailyReport> list = new ArrayList<>();
        // Lấy list ngày có đơn
        Map<String, Double> revenueMap = getRevenueByDate(filter);
        
        for (String dateStr : revenueMap.keySet()) {
            DailyReport r = new DailyReport();
            try {
                r.setDate(java.sql.Date.valueOf(dateStr));
                r.setRevenue(revenueMap.get(dateStr));
                // Các số liệu khác có thể query thêm hoặc fake tạm để demo table
                r.setOrderCount(1); // Demo
                r.setTopBook("Sách A"); // Demo
                r.setNewCustomers(0);
                r.setConversionRate(100.0);
                list.add(r);
            } catch(Exception e) {}
        }
        return list;
    }
    // ===========================================================
    // THÊM METHOD NÀY ĐỂ SỬA LỖI getRevenueByDate
    // ===========================================================
    
    /**
     * Lấy doanh thu theo ngày (Map<Ngày, Tiền>)
     */
    public Map<String, Double> getRevenueByDate(ReportFilter filter) {
        Map<String, Double> map = new LinkedHashMap<>();
        List<Object> params = new ArrayList<>();
        String where = buildWhereClause(filter, params);
        
        String sql = "SELECT DATE(orderDate) as day, SUM(totalAmount) as revenue FROM orders " + 
                     where + " GROUP BY DATE(orderDate) ORDER BY day";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            // Set tham số
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                map.put(rs.getString("day"), rs.getDouble("revenue"));
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return map;
    }
}