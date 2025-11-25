package com.mybookstore.bookstore.controller.admin;

import com.mybookstore.bookstore.dao.*;
import com.mybookstore.bookstore.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.Year;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private BookDAO bookDAO;
    private UserDAO userDAO;
    private OrderDAO orderDAO;

    public void init() {
        bookDAO = new BookDAO();
        userDAO = new UserDAO();
        orderDAO = new OrderDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Kiểm tra quyền Admin (Bảo mật)
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || !user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 2. Lấy số liệu thống kê cơ bản (KPI Cards)
        int totalBooks = bookDAO.countBooks();
        int lowStockBooks = bookDAO.countLowStockBooks();
        int totalUsers = userDAO.countUsers();
        int totalOrders = orderDAO.countOrders();
        int pendingOrders = orderDAO.countNewOrders(); // Đơn Pending
        double totalRevenue = orderDAO.getTotalRevenue();
        int completedToday = orderDAO.countCompletedOrdersToday();

        // 3. Tính tỷ lệ chuyển đổi (Đơn hoàn thành / Tổng đơn) * 100
        double successRate = 0;
        if (totalOrders > 0) {
            // Lấy tổng đơn completed chia tổng đơn
            int totalCompleted = orderDAO.getOrderStatusCounts().getOrDefault("Completed", 0);
            successRate = ((double) totalCompleted / totalOrders) * 100;
        }

        // 4. Chuẩn bị dữ liệu cho BIỂU ĐỒ DOANH THU (12 tháng)
        int currentYear = Year.now().getValue();
        List<Double> monthlyRevenue = orderDAO.getMonthlyRevenue(currentYear);
        // Chuyển List thành chuỗi JSON đơn giản: [100.0, 200.0, ...]
        String revenueChartData = monthlyRevenue.toString(); 

        // 5. Chuẩn bị dữ liệu cho BIỂU ĐỒ ĐƠN HÀNG (7 ngày qua)
        Map<String, Integer> ordersLast7Days = orderDAO.getOrdersLast7Days();
        StringBuilder dateLabels = new StringBuilder("[");
        StringBuilder orderCounts = new StringBuilder("[");
        
        int i = 0;
        for (Map.Entry<String, Integer> entry : ordersLast7Days.entrySet()) {
            if (i > 0) { dateLabels.append(","); orderCounts.append(","); }
            dateLabels.append("'").append(entry.getKey()).append("'"); // '2023-10-01'
            orderCounts.append(entry.getValue());
            i++;
        }
        dateLabels.append("]");
        orderCounts.append("]");

        // 6. Gửi tất cả sang JSP
        request.setAttribute("totalBooks", totalBooks);
        request.setAttribute("lowStockBooks", lowStockBooks);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("pendingOrders", pendingOrders);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("completedToday", completedToday);
        request.setAttribute("successRate", String.format("%.1f", successRate)); // Format 1 số lẻ
        
        // Dữ liệu biểu đồ
        request.setAttribute("revenueChartData", revenueChartData);
        request.setAttribute("orderLabels", dateLabels.toString());
        request.setAttribute("orderData", orderCounts.toString());

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}