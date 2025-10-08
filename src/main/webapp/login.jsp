<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng Nhập</title>
</head>
<body>
    <h2>Đăng Nhập</h2>
    
    <%-- Hiển thị thông báo lỗi nếu có --%>
    <% 
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) { 
    %>
        <p style="color:red;"><%= errorMessage %></p>
    <% 
        } 
    %>

    <form action="login" method="post">
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
                <td colspan="2"><input type="submit" value="Đăng Nhập"></td>
            </tr>
        </table>
    </form>
    <p>Chưa có tài khoản? <a href="register.jsp">Đăng ký tại đây</a></p>
</body>
</html>