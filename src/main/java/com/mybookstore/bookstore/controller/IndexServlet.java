package com.mybookstore.bookstore.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet này hoạt động như một "cổng vào".
 * Nó được map với URL gốc của trang web ("").
 * Khi người dùng truy cập trang chủ, servlet này sẽ chuyển tiếp yêu cầu đến HomeServlet.
 */
@WebServlet("") // <-- Quan trọng: Map với URL gốc
public class IndexServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Chuyển tiếp yêu cầu đến HomeServlet để xử lý
        request.getRequestDispatcher("/home").forward(request, response);
    }
}