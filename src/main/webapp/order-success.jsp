<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt Hàng Thành Công</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="container">
        <div class="order-success-container">
            <h1>Cảm ơn bạn đã đặt hàng!</h1>
            <p>Đơn hàng của bạn đã được ghi nhận và đang chờ xử lý. Chúng tôi sẽ liên hệ với bạn trong thời gian sớm nhất.</p>
            <a href="${pageContext.request.contextPath}/home" class="btn">Quay lại trang chủ</a>
        </div>
    </div>
    <jsp:include page="footer.jsp" />
</body>
</html>
