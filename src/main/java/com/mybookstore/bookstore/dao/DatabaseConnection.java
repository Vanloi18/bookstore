package com.mybookstore.bookstore.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    // THAY ĐỔI CÁC THÔNG SỐ NÀY CHO PHÙ HỢP VỚI CSDL CỦA BẠN
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/bookstore_db?useSSL=false&serverTimezone=UTC";
    private static final String JDBC_USERNAME = "root"; // <-- ĐIỀN USERNAME CỦA BẠN
    private static final String JDBC_PASSWORD = "root"; // <-- ĐIỀN MẬT KHẨU CỦA BẠN

    public static Connection getConnection() {
        Connection connection = null;
        try {
            // Nạp driver MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Mở kết nối
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
        } catch (SQLException e) {
            System.out.println("Lỗi kết nối CSDL!");
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            System.out.println("Không tìm thấy MySQL JDBC Driver!");
            e.printStackTrace();
        }
        return connection;
    }
}