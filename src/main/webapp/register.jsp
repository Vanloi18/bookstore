<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng Ký Tài Khoản</title>
</head>
<body>
    <h2>Tạo tài khoản mới</h2>
    
    <%-- Hiển thị thông báo lỗi nếu có --%>
    <% 
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) { 
    %>
        <p style="color:red;"><%= errorMessage %></p>
    <% 
        } 
    %>

    <form action="register" method="post">
        <table>
            <tr>
                <td>Tên đăng nhập:</td>
                <td><input type="text" name="username" required></td>
            </tr>
            <tr>
                <td>Mật khẩu:</td>
                <td><input type="password" name="password" required></td>
            </tr>
            <tr>
                <td>Họ và tên:</td>
                <td><input type="text" name="fullname"></td>
            </tr>
            <tr>
                <td>Email:</td>
                <td><input type="email" name="email" required></td>
            </tr>
            <tr>
                <td>Địa chỉ:</td>
                <td><input type="text" name="address"></td>
            </tr>
            <tr>
                <td>Số điện thoại:</td>
                <td><input type="text" name="phone"></td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="Đăng Ký"></td>
            </tr>
        </table>
    </form>
    <p>Đã có tài khoản? <a href="login.jsp">Đăng nhập ngay</a></p>
</body>
</html>