<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng Nhập</title>
    <%-- Đảm bảo đường dẫn tới file CSS là chính xác --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <%-- BỌC FORM TRONG .main-content --%>
    <div class="main-content">
        <div class="form-container">
            <h2>Đăng Nhập</h2>
            
            <%-- Hiển thị thông báo lỗi bằng JSTL --%>
            <c:if test="${not empty errorMessage}">
                <p class="error-message">${errorMessage}</p>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label for="username">Tên đăng nhập:</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Mật khẩu:</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <button type="submit">Đăng Nhập</button>
            </form>
            <p style="margin-top: 20px;">Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register.jsp">Đăng ký tại đây</a></p>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>