<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thanh Toán Đơn Hàng</title>
</head>
<body>
    <h1>Xác nhận đơn hàng và Thanh toán</h1>
    <hr>
    
    <c:set var="cart" value="${sessionScope.cart}" />
    <c:set var="loggedInUser" value="${sessionScope.loggedInUser}" />

    <%-- Kiểm tra xem người dùng đã đăng nhập và giỏ hàng có đồ chưa --%>
    <c:if test="${empty loggedInUser}">
        <p>Vui lòng <a href="login.jsp">đăng nhập</a> để thanh toán.</p>
    </c:if>
    <c:if test="${not empty loggedInUser and empty cart}">
        <p>Giỏ hàng của bạn đang trống. <a href="home">Quay lại mua sắm</a>.</p>
    </c:if>

    <c:if test="${not empty loggedInUser and not empty cart}">
        <h3>Thông tin đơn hàng</h3>
        <table border="1" style="width: 60%;">
            <tr>
                <th>Sản phẩm</th>
                <th>Số lượng</th>
                <th>Thành tiền</th>
            </tr>
            <c:set var="totalAmount" value="0" />
            <c:forEach items="${cart}" var="entry">
                <tr>
                    <td>${entry.value.book.title}</td>
                    <td>${entry.value.quantity}</td>
                    <td>${entry.value.subtotal} VNĐ</td>
                </tr>
                 <c:set var="totalAmount" value="${totalAmount + entry.value.subtotal}" />
            </c:forEach>
            <tr>
                <td colspan="2" style="text-align:right;"><strong>Tổng cộng:</strong></td>
                <td><strong>${totalAmount} VNĐ</strong></td>
            </tr>
        </table>

        <hr>
        <h3>Thông tin giao hàng</h3>
        <form action="place-order" method="post">
            <p>Họ và tên người nhận: <strong>${loggedInUser.fullname}</strong></p>
            <p>Email: <strong>${loggedInUser.email}</strong></p>
            <label for="shippingAddress">Địa chỉ giao hàng:</label><br>
            <textarea name="shippingAddress" id="shippingAddress" rows="4" cols="50" required>${loggedInUser.address}</textarea>
            <br><br>
            <button type="submit">Đặt Hàng</button>
        </form>
    </c:if>
    <jsp:include page="footer.jsp" />
</body>
</html>