package com.mybookstore.bookstore.test;

import com.mybookstore.bookstore.dao.DatabaseConnection;
import java.sql.Connection;

public class TestConnection {
    public static void main(String[] args) {
        Connection conn = DatabaseConnection.getConnection();
        if (conn != null) {
            System.out.println("✅ Kết nối thành công tới CSDL!");
        } else {
            System.out.println("❌ Kết nối thất bại!");
        }
    }
}
