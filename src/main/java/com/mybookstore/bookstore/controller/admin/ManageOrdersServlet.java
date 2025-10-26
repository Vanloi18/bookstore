package com.mybookstore.bookstore.controller.admin;

import com.mybookstore.bookstore.dao.OrderDAO;
import com.mybookstore.bookstore.model.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/manage-orders")
public class ManageOrdersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy tham số từ URL
        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");

        List<Order> orderList;

        // ⚙️ Logic xử lý lọc & tìm kiếm
        if ((status != null && !status.isEmpty()) || (keyword != null && !keyword.trim().isEmpty())) {
            orderList = orderDAO.filterOrders(keyword, status);
        } else {
            orderList = orderDAO.getAllOrders();
        }

        // Gửi dữ liệu sang JSP
        request.setAttribute("orderList", orderList);
        request.setAttribute("keyword", keyword);
        request.setAttribute("status", status);

        // Chuyển hướng đến trang JSP
        request.getRequestDispatcher("/admin/manage-orders.jsp").forward(request, response);
    }
}
