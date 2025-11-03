package com.mybookstore.bookstore.controller.admin;

import com.mybookstore.bookstore.dao.BookDAO;
import com.mybookstore.bookstore.dao.OrderDAO;
import com.mybookstore.bookstore.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;
    private OrderDAO orderDAO;
    private UserDAO userDAO;
    
    private static final DateTimeFormatter CHART_LABEL_FORMATTER = DateTimeFormatter.ofPattern("dd/MM");

    public void init() {
        bookDAO = new BookDAO();
        orderDAO = new OrderDAO();
        userDAO = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // --- 1. Lấy dữ liệu KPI ---
        
        YearMonth currentYearMonth = YearMonth.now();
        LocalDate firstDayOfMonth = currentYearMonth.atDay(1);
        LocalDate lastDayOfMonth = currentYearMonth.atEndOfMonth();

        // 1.1. Đơn hàng mới (Pending)
        int newOrdersCount = orderDAO.countNewOrders(); 
        
        // 1.2. Doanh thu tháng này
        double monthlyRevenue = orderDAO.getTotalRevenue(firstDayOfMonth, lastDayOfMonth); 
        
        // 1.3. Khách hàng mới (tháng) - ĐÃ CẬP NHẬT TÊN PHƯƠNG THỨC GỌI
        int newUsersCount = userDAO.countNewUsersThisMonth(); 
        
        // 1.4. Tổng số sách
        int totalBooksCount = bookDAO.countBooks(); 


        // --- 2. Lấy dữ liệu Biểu đồ (Doanh thu 7 ngày gần nhất) ---
        
        Map<LocalDate, Double> dailyRevenueMap = orderDAO.getDailyRevenueLast7Days();
        
        // Sắp xếp Map theo thứ tự ngày tháng tăng dần (key)
        List<Map.Entry<LocalDate, Double>> sortedEntries = dailyRevenueMap.entrySet().stream()
            .sorted(Map.Entry.comparingByKey())
            .collect(Collectors.toList());
            
        // Chuẩn bị Labels và Data (dạng chuỗi JSON Array)
        String chartLabels = "[" + sortedEntries.stream()
            .map(e -> "\"" + e.getKey().format(CHART_LABEL_FORMATTER) + "\"")
            .collect(Collectors.joining(",")) + "]";
            
        String chartData = "[" + sortedEntries.stream()
            .map(e -> String.valueOf(e.getValue()))
            .collect(Collectors.joining(",")) + "]";


        // --- 3. Đặt dữ liệu vào Request Scope ---
        
        request.setAttribute("newOrdersCount", newOrdersCount);
        request.setAttribute("monthlyRevenue", monthlyRevenue);
        request.setAttribute("newUsersCount", newUsersCount);
        request.setAttribute("totalBooksCount", totalBooksCount);
        
        request.setAttribute("chartLabels", chartLabels);
        request.setAttribute("chartData", chartData);
     // ... (các bước lấy dữ liệu KPI và Biểu đồ)

     // Bổ sung: Lấy Top 5 Sách Bán Chạy
     List<Map<String, Object>> topSellingBooks = orderDAO.getTopSellingBooks(5);

     // Đặt dữ liệu vào Request Scope
     request.setAttribute("topSellingBooks", topSellingBooks);

  
        // --- 4. Forward đến trang JSP ---
		request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
	}
}