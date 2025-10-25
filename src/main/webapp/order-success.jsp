<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt Hàng Thành Công</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/checkout.css">
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="main-content">
        <div class="container order-success-container">
            <h1>🎉 Cảm ơn bạn đã đặt hàng!</h1>
            <p class="success-message">Đơn hàng của bạn đã được ghi nhận và đang chờ xử lý.</p>
            <p class="success-message">Shipper đang trên đường giao hàng cho bạn 🚴‍♂️💨</p>

            <a href="${pageContext.request.contextPath}/home">🏠 Quay lại trang chủ</a>
        </div>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>
