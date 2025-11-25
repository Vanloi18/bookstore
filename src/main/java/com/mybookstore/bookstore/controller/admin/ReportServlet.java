package com.mybookstore.bookstore.controller.admin;

import com.mybookstore.bookstore.dao.ReportDAO;
import com.mybookstore.bookstore.dao.CategoryDAO;
import com.mybookstore.bookstore.model.*;
import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/admin/report") // URL để vào xem báo cáo
public class ReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ReportDAO reportDAO;
    private CategoryDAO categoryDAO;
    private Gson gson;
    
    @Override
    public void init() {
        reportDAO = new ReportDAO();
        categoryDAO = new CategoryDAO();
        gson = new Gson();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // 1. LẤY FILTER
            ReportFilter filter = new ReportFilter();
            String fromDate = request.getParameter("fromDate");
            String toDate = request.getParameter("toDate");
            String categoryId = request.getParameter("categoryId");
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            
            // Mặc định lấy 30 ngày nếu không chọn
            if (fromDate != null && !fromDate.isEmpty()) {
                filter.setFromDate(sdf.parse(fromDate));
            } else {
                Calendar c = Calendar.getInstance();
                c.add(Calendar.DATE, -30);
                filter.setFromDate(c.getTime());
            }
            
            if (toDate != null && !toDate.isEmpty()) {
                filter.setToDate(sdf.parse(toDate));
            } else {
                filter.setToDate(new Date());
            }
            
            if (categoryId != null && !categoryId.isEmpty()) {
                filter.setCategoryId(Integer.parseInt(categoryId));
            }

            // 2. LẤY SỐ LIỆU KPI
            double totalRevenue = reportDAO.getTotalRevenue(filter);
            int totalOrders = reportDAO.getTotalOrders(filter);
            int totalBooksSold = reportDAO.getTotalBooksSold(filter);
            int newCustomers = reportDAO.getNewCustomers(filter);
            String topBook = reportDAO.getTopSellingBook(filter);
            
            // 3. TÍNH TOÁN TREND (So với kỳ trước)
            ReportFilter prevFilter = getPreviousFilter(filter);
            double prevRevenue = reportDAO.getTotalRevenue(prevFilter);
            int prevOrders = reportDAO.getTotalOrders(prevFilter);
            int prevCustomers = reportDAO.getNewCustomers(prevFilter);
            
            double revenueTrend = calculateTrend(totalRevenue, prevRevenue);
            double ordersTrend = calculateTrend(totalOrders, prevOrders);
            double customerTrend = calculateTrend(newCustomers, prevCustomers);

            // 4. DỮ LIỆU BIỂU ĐỒ (CHART) - JSON
            Map<String, Double> revMap = reportDAO.getRevenueByDate(filter);
            Map<String, Double> sortedRevMap = new TreeMap<>(revMap); // Sắp xếp theo ngày
            
            Map<String, Integer> ordMap = reportDAO.getOrdersByDate(filter);
            Map<String, Integer> sortedOrdMap = new TreeMap<>(ordMap);
            
            List<CategoryRevenue> catList = reportDAO.getCategoryRevenue(filter);

            // 5. DỮ LIỆU BẢNG CHI TIẾT
            List<DailyReport> dailyReports = reportDAO.getDailyReports(filter);

            // --- GỬI SANG JSP ---
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalBooksSold", totalBooksSold);
            request.setAttribute("newCustomers", newCustomers);
            request.setAttribute("topBook", topBook);
            
            request.setAttribute("revenueTrend", String.format("%.1f", revenueTrend));
            request.setAttribute("ordersTrend", String.format("%.1f", ordersTrend));
            request.setAttribute("customerTrend", String.format("%.1f", customerTrend));
            
            // Chart Data (Chuyển sang JSON string để JS đọc được)
            request.setAttribute("revenueLabels", gson.toJson(sortedRevMap.keySet()));
            request.setAttribute("revenueChartData", gson.toJson(sortedRevMap.values()));
            
            request.setAttribute("ordersLabels", gson.toJson(sortedOrdMap.keySet()));
            request.setAttribute("ordersChartData", gson.toJson(sortedOrdMap.values()));
            
            List<String> catLabels = catList.stream().map(CategoryRevenue::getCategoryName).collect(Collectors.toList());
            List<Double> catData = catList.stream().map(CategoryRevenue::getRevenue).collect(Collectors.toList());
            request.setAttribute("categoryLabels", gson.toJson(catLabels));
            request.setAttribute("categoryChartData", gson.toJson(catData));
            
            request.setAttribute("dailyReports", dailyReports);
            request.setAttribute("categories", categoryDAO.getAllCategories());
            
            // Chuyển hướng đến trang JSP hiển thị
            request.getRequestDispatcher("/admin/baocao.jsp").forward(request, response);
                   
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    private ReportFilter getPreviousFilter(ReportFilter current) {
        ReportFilter prev = new ReportFilter();
        long diff = current.getToDate().getTime() - current.getFromDate().getTime();
        long days = diff / (1000 * 60 * 60 * 24); // Số ngày chênh lệch
        if(days == 0) days = 1;

        Calendar c = Calendar.getInstance();
        c.setTime(current.getFromDate());
        c.add(Calendar.DATE, -(int)days);
        prev.setFromDate(c.getTime());
        
        c.setTime(current.getToDate());
        c.add(Calendar.DATE, -(int)days);
        prev.setToDate(c.getTime());
        
        prev.setCategoryId(current.getCategoryId());
        prev.setOrderStatus(current.getOrderStatus());
        return prev;
    }
    
    private double calculateTrend(double current, double previous) {
        if (previous == 0) return current > 0 ? 100.0 : 0.0;
        return ((current - previous) / previous) * 100.0;
    }
}