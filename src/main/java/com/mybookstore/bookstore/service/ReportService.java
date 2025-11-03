package com.mybookstore.bookstore.service;

// Thư viện cần thiết cho Jackson (giải quyết lỗi của bạn)
import com.fasterxml.jackson.databind.ObjectMapper; 

// Các imports khác
import com.mybookstore.bookstore.dao.OrderDAO;
import com.mybookstore.bookstore.dao.UserDAO; 
import com.mybookstore.bookstore.dao.BookDAO; 
import com.mybookstore.bookstore.model.Order;
import java.io.IOException; // Cần thiết khi dùng ObjectMapper.writeValueAsString()
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class ReportService {
    
    // Sử dụng ObjectMapper của Jackson
    private final ObjectMapper objectMapper = new ObjectMapper(); 
    
    private final OrderDAO orderDAO = new OrderDAO();
    private final UserDAO userDAO = new UserDAO();
    private final BookDAO bookDAO = new BookDAO(); 
    
    // Dùng cho việc format ngày tháng sang tiếng Việt
    private static final DateTimeFormatter DAY_FORMATTER = DateTimeFormatter.ofPattern("EEE", new Locale("vi", "VN")); 

    // Hàm tiện ích để chuyển đổi Object sang JSON String và xử lý lỗi
    private String writeValueAsJson(Object data) {
        try {
            return objectMapper.writeValueAsString(data);
        } catch (IOException e) {
            e.printStackTrace();
            // Trả về JSON rỗng hoặc thông báo lỗi nếu có lỗi chuyển đổi
            return "{\"error\": \"Lỗi chuyển đổi dữ liệu sang JSON.\"}"; 
        }
    }

    // --- 1. Lấy dữ liệu KPI (Action: 'kpis') ---
    public String getSalesKpiDataAsJson() {
        int totalOrders = orderDAO.countOrders();
        double totalRevenue = orderDAO.getTotalRevenue(LocalDate.now().minusDays(30), LocalDate.now());
        int booksSold = bookDAO.countTotalBooksSold(); 
        
        int totalUsers = userDAO.countUsers(); 
        double conversionRate = (totalUsers > 0) ? (double) totalOrders / totalUsers * 100.0 : 0.0; 

        Map<String, Object> kpiData = new HashMap<>();
        kpiData.put("totalOrders", totalOrders);
        kpiData.put("totalRevenue", String.format("%.2f", totalRevenue)); 
        kpiData.put("totalBooksSold", booksSold);
        kpiData.put("conversionRate", String.format("%.2f", conversionRate)); 

        return writeValueAsJson(kpiData);
    }

    // --- 2. Lấy dữ liệu Xu hướng Doanh thu (Action: 'trend') ---
    public String getRevenueTrendAsJson() {
        Map<LocalDate, Double> dailyRevenue = orderDAO.getDailyRevenueLast7Days();
        
        List<String> labels = new ArrayList<>();
        List<Double> values = new ArrayList<>();
        
        // Sắp xếp theo ngày và format label
        dailyRevenue.keySet().stream().sorted().forEach(date -> {
            labels.add(date.format(DAY_FORMATTER)); 
            values.add(dailyRevenue.get(date));
        });
        
        Map<String, Object> trendData = new HashMap<>();
        trendData.put("labels", labels);
        trendData.put("values", values); 
        
        return writeValueAsJson(trendData);
    }
    
    // --- 3. Lấy dữ liệu Phân bổ theo Thể loại (Action: 'distribution') ---
    public String getCategoryDistributionAsJson() {
        Map<String, Double> revenueByCategory = bookDAO.getRevenueByCategory();
        
        List<Map<String, Object>> list = new ArrayList<>();
        double totalRevenue = revenueByCategory.values().stream().mapToDouble(Double::doubleValue).sum();

        for (Map.Entry<String, Double> entry : revenueByCategory.entrySet()) {
            Map<String, Object> item = new HashMap<>();
            item.put("category", entry.getKey());
            item.put("revenue", entry.getValue());
            item.put("percentage", (totalRevenue > 0) ? (entry.getValue() / totalRevenue) * 100 : 0.0);
            list.add(item);
        }
        return writeValueAsJson(list);
    }

    // --- 4. Lấy dữ liệu Trạng thái Đơn hàng (Action: 'status') ---
    public String getOrderStatusStatsAsJson() {
        return writeValueAsJson(orderDAO.getOrderStatusCounts()); 
    }

    // --- 5. Lấy Đơn hàng gần đây (Action: 'recent') ---
    public String getRecentOrdersAsJson() {
        List<Order> recentOrders = orderDAO.getRecentOrders(5); 
        return writeValueAsJson(recentOrders);
    }
}