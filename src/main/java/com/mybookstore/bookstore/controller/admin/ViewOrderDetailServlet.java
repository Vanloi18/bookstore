package com.mybookstore.bookstore.controller.admin;

import com.mybookstore.bookstore.dao.BookDAO;
import com.mybookstore.bookstore.dao.OrderDetailDAO;
import com.mybookstore.bookstore.model.OrderDetail;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/view-order-detail")
public class ViewOrderDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDetailDAO orderDetailDAO;
    private BookDAO bookDAO;

    public void init() {
        orderDetailDAO = new OrderDetailDAO();
        bookDAO = new BookDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("id"));
            
            // Lấy danh sách các sản phẩm trong đơn hàng
            List<OrderDetail> detailList = orderDetailDAO.getOrderDetailsByOrderId(orderId);
            
            // Với mỗi sản phẩm, lấy thông tin chi tiết của sách (tên, ảnh...)
            for (OrderDetail detail : detailList) {
                detail.setBook(bookDAO.getBookById(detail.getBookId()));
            }
            
            request.setAttribute("detailList", detailList);
            request.setAttribute("orderId", orderId); // Gửi cả orderId để hiển thị
            request.getRequestDispatcher("/admin/view-order-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/manage-orders");
        }
    }
}