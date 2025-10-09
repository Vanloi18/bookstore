package com.mybookstore.bookstore.controller.admin;

import com.mybookstore.bookstore.dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/update-order-status")
public class UpdateOrderStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO;

    public void init() {
        orderDAO = new OrderDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String newStatus = request.getParameter("status");
            
            if (newStatus != null && !newStatus.isEmpty()) {
                orderDAO.updateOrderStatus(orderId, newStatus);
            }
        } catch (NumberFormatException e) {
            // Xử lý nếu ID không hợp lệ
            e.printStackTrace();
        }
        
        // Luôn chuyển hướng về trang quản lý đơn hàng
        response.sendRedirect(request.getContextPath() + "/admin/manage-orders");
    }
}