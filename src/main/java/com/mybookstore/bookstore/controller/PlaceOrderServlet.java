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
        
        // Cần khởi tạo BookDAO để gọi hàm trừ kho
        com.mybookstore.bookstore.dao.BookDAO bookDAO = new com.mybookstore.bookstore.dao.BookDAO();
        
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        if (loggedInUser == null || cart == null || cart.isEmpty()) {
            response.sendRedirect("login.jsp");
            return;
        }

        String shippingAddress = request.getParameter("shippingAddress");

        // 1. Tính tổng tiền
        double totalAmount = 0;
        for (CartItem item : cart.values()) {
            totalAmount += item.getSubtotal();
        }
 
        // 2. Lưu Order
        Order order = new Order();
        order.setUserId(loggedInUser.getId());
        order.setTotalAmount(totalAmount);
        order.setShippingAddress(shippingAddress);
        order.setStatus("Pending"); 

        int generatedOrderId = orderDAO.addOrder(order);

        // 3. Lưu OrderDetail VÀ Trừ tồn kho
        if (generatedOrderId != -1) {
            for (CartItem item : cart.values()) {
                OrderDetail detail = new OrderDetail();
                detail.setOrderId(generatedOrderId);
                detail.setBookId(item.getBook().getId());
                detail.setQuantity(item.getQuantity());
                detail.setPricePerUnit(item.getBook().getPrice());
                
                // Lưu chi tiết đơn hàng
                orderDetailDAO.addOrderDetail(detail);
                
                // === FIX: TRỪ TỒN KHO ===
                boolean updateSuccess = bookDAO.updateStock(item.getBook().getId(), item.getQuantity());
                if (!updateSuccess) {
                    // Nếu trừ kho thất bại (do hết hàng giữa chừng), log lại lỗi
                    System.out.println("Lỗi: Không thể trừ kho cho sách ID: " + item.getBook().getId());
                    // Trong thực tế, bạn có thể cần rollback transaction ở đây
                }
            }
        }

        // 4. Xóa giỏ hàng & Redirect
        session.removeAttribute("cart");
        response.sendRedirect("order-success.jsp");
    }
}