package com.mybookstore.bookstore.controller.admin;

import com.mybookstore.bookstore.dao.BookDAO;
import com.mybookstore.bookstore.dao.OrderDAO;
import com.mybookstore.bookstore.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;
    private OrderDAO orderDAO;
    private UserDAO userDAO;

    public void init() {
        bookDAO = new BookDAO();
        orderDAO = new OrderDAO();
        userDAO = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookCount = bookDAO.countBooks();
        int orderCount = orderDAO.countOrders();
        int userCount = userDAO.countUsers();

        request.setAttribute("bookCount", bookCount);
        request.setAttribute("orderCount", orderCount);
        request.setAttribute("userCount", userCount);

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}
