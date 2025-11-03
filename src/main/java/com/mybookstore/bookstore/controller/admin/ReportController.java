package com.mybookstore.bookstore.controller.admin;

import com.mybookstore.bookstore.service.ReportService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

// KHÔNG CẦN DÙNG import com.google.gson.Gson; nữa.

@WebServlet("/admin/baocao")
public class ReportController extends HttpServlet {
    private ReportService reportService = new ReportService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null || "main".equals(action)) {
            // Mặc định: Hiển thị trang JSP
            response.setContentType("text/html"); 
            request.getRequestDispatcher("/admin/baocao.jsp").forward(request, response);
            return;
        } 

        // Các Service trả về JSON String, nên Content Type là application/json
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String jsonData = "{}";
        
        try {
            switch (action) {
                case "kpis":
                    jsonData = reportService.getSalesKpiDataAsJson();
                    break;
                case "trend":
                    jsonData = reportService.getRevenueTrendAsJson();
                    break;
                case "distribution":
                    jsonData = reportService.getCategoryDistributionAsJson();
                    break;
                case "status":
                    jsonData = reportService.getOrderStatusStatsAsJson();
                    break;
                case "recent":
                    jsonData = reportService.getRecentOrdersAsJson();
                    break;
                default:
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    jsonData = "{\"error\": \"Invalid action\"}";
            }
        } catch (Exception e) {
            // Log lỗi và trả về lỗi 500
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            jsonData = "{\"error\": \"Internal Server Error: " + e.getMessage() + "\"}";
            e.printStackTrace();
        }

        response.getWriter().write(jsonData);
    }
    
    // Bạn có thể thêm doPost() tại đây để xử lý Export Excel/PDF
}