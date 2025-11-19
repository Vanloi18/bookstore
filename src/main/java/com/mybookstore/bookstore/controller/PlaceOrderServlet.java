package com.mybookstore.bookstore.controller;

import com.mybookstore.bookstore.dao.OrderDAO;
import com.mybookstore.bookstore.dao.OrderDetailDAO;
import com.mybookstore.bookstore.model.CartItem;
import com.mybookstore.bookstore.model.Order;
import com.mybookstore.bookstore.model.OrderDetail;
import com.mybookstore.bookstore.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

@WebServlet("/place-order")
public class PlaceOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO;
    private OrderDetailDAO orderDetailDAO;

    public void init() {
        orderDAO = new OrderDAO();
        orderDetailDAO = new OrderDetailDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        // Kiểm tra điều kiện
        if (loggedInUser == null || cart == null || cart.isEmpty()) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Lấy thông tin từ form
        String shippingAddress = request.getParameter("shippingAddress");

        // 1. Tính tổng tiền
        double totalAmount = 0;
        for (CartItem item : cart.values()) {
            totalAmount += item.getSubtotal();
        }
 
        // 2. Tạo đối tượng Order và lưu vào CSDL
        Order order = new Order();
        order.setUserId(loggedInUser.getId());
        order.setTotalAmount(totalAmount);
        order.setShippingAddress(shippingAddress);
        order.setStatus("Pending"); // Trạng thái chờ xử lý

        int generatedOrderId = orderDAO.addOrder(order);

        // 3. Lưu chi tiết đơn hàng (từng sản phẩm) vào CSDL
        if (generatedOrderId != -1) {
            for (CartItem item : cart.values()) {
                OrderDetail detail = new OrderDetail();
                detail.setOrderId(generatedOrderId);
                detail.setBookId(item.getBook().getId());
                detail.setQuantity(item.getQuantity());
                detail.setPricePerUnit(item.getBook().getPrice());
                orderDetailDAO.addOrderDetail(detail);
                
                // (Nâng cao) Ở đây bạn có thể gọi BookDAO để trừ số lượng tồn kho
            }
        }

        // 4. Xóa giỏ hàng khỏi session
        session.removeAttribute("cart");

        // 5. Chuyển hướng đến trang cảm ơn
        response.sendRedirect("order-success.jsp");
    }
}