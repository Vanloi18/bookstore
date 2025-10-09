package com.mybookstore.bookstore.controller;

import com.mybookstore.bookstore.dao.OrderDAO;
import com.mybookstore.bookstore.model.Order;
import com.mybookstore.bookstore.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/order-history")
public class OrderHistoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO;

    public void init() {
        orderDAO = new OrderDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
        
        // Bắt buộc người dùng phải đăng nhập
        if (loggedInUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Lấy danh sách đơn hàng của người dùng đang đăng nhập
        List<Order> orderList = orderDAO.getOrdersByUserId(loggedInUser.getId());
        
        request.setAttribute("orderList", orderList);
        request.getRequestDispatcher("order-history.jsp").forward(request, response);
    }
}