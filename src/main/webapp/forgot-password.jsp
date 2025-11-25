<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu | Nhà Sách Online</title>
    
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
                <i class="fa-solid fa-key"></i>
            </div>
            
            <h2>Quên mật khẩu?</h2>
            <p class="form-subtitle">Nhập email đăng ký để nhận liên kết đặt lại mật khẩu.</p>
            
            <% if(request.getAttribute("message") != null) { %>
                <div class="success-message">
                    <%= request.getAttribute("message") %>
                </div>
            <% } %>

            <% if(request.getAttribute("error") != null) { %>
                <div class="error-message">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                <div class="form-group">
                    <label for="email">Email đăng ký</label>
                    <input 
                        type="email" 
                        id="email" 
                        name="email" 
                        placeholder="name@example.com" 
                        required
                    >
                </div>

                <button type="submit">Gửi liên kết</button>
            </form>
            
            <div class="forgot-password">
                <a href="login.jsp"><i class="fa-solid fa-arrow-left"></i> Quay lại Đăng nhập</a>
            </div>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>