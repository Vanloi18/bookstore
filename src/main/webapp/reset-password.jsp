<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lại mật khẩu | Nhà Sách Online</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/login.css">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="main-content">
        <div class="form-container">
            <div class="form-logo">
                <i class="fa-solid fa-lock-open"></i>
            </div>
            
            <h2>Mật khẩu mới</h2>
            <p class="form-subtitle">Vui lòng nhập mật khẩu mới cho tài khoản của bạn.</p>
            
            <% if(request.getAttribute("error") != null) { %>
                <div class="error-message">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/reset-password" method="post">
                <input type="hidden" name="token" value="<%= request.getAttribute("token") %>">
                
                <div class="form-group">
                    <label for="password">Mật khẩu mới</label>
                    <input type="password" id="password" name="password" placeholder="Nhập mật khẩu mới" required>
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">Xác nhận mật khẩu</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu" required>
                </div>

                <button type="submit">Đổi mật khẩu</button>
            </form>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>