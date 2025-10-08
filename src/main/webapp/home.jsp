<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mybookstore.bookstore.model.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang Chủ</title>
</head>
<body>
    <h1>Chào mừng đến với Nhà Sách Online</h1>
    
    <%
        // Lấy thông tin user từ session
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser != null) {
            // Nếu đã đăng nhập
    %>
        <h3>Xin chào, <%= loggedInUser.getFullname() %>!</h3>
        <a href="logout">Đăng xuất</a>
    <%
        } else {
            // Nếu chưa đăng nhập
    %>
        <p>
            <a href="login.jsp">Đăng nhập</a> | 
            <a href="register.jsp">Đăng ký</a>
        </p>
    <%
        }
    %>

    <%-- Phần hiển thị danh sách sách sẽ được thêm vào đây sau --%>
</body>
</html>