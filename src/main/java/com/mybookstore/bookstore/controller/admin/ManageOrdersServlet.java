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

    public void init() {
        orderDAO = new OrderDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Order> orderList = orderDAO.getAllOrders();
        request.setAttribute("orderList", orderList);
        request.getRequestDispatcher("/admin/manage-orders.jsp").forward(request, response);
    }
}