<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh Toán Đơn Hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>
    <jsp:include page="header.jsp" />

    <div class="checkout-container">
        <h1>🛍️ Xác Nhận Đơn Hàng & Thanh Toán</h1>
        <hr>

        <c:set var="cart" value="${sessionScope.cart}" />
        <c:set var="loggedInUser" value="${sessionScope.loggedInUser}" />

        <c:choose>
            <c:when test="${empty loggedInUser}">
                <p>Vui lòng <a href="login.jsp" class="link">đăng nhập</a> để thanh toán.</p>
            </c:when>

            <c:when test="${empty cart}">
                <p>Giỏ hàng của bạn đang trống. <a href="home" class="link">Quay lại mua sắm</a>.</p>
            </c:when>

            <c:otherwise>
                <h3>🧾 Thông tin đơn hàng</h3>
                <table class="checkout-table">
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
                            <td><fmt:formatNumber type="number" value="${entry.value.subtotal}" /> VNĐ</td>
                        </tr>
                        <c:set var="totalAmount" value="${totalAmount + entry.value.subtotal}" />
                    </c:forEach>

                    <tr class="total-row">
                        <td colspan="2" style="text-align:right;">Tổng cộng:</td>
                        <td><fmt:formatNumber type="number" value="${totalAmount}" /> VNĐ</td>
                    </tr>
                </table>

                <div class="shipping-info">
                    <h3>🚚 Thông tin giao hàng</h3>
                    <form action="place-order" method="post">
                        <p>👤 Họ và tên người nhận: <strong>${loggedInUser.fullname}</strong></p>
                        <p>📧 Email: <strong>${loggedInUser.email}</strong></p>
                        <label for="shippingAddress">🏠 Địa chỉ giao hàng:</label><br>
                        <textarea name="shippingAddress" id="shippingAddress" rows="4" required>${loggedInUser.address}</textarea>
                        <br><br>
                        <button type="submit" class="btn-submit">✅ Đặt Hàng Ngay</button>
                    </form>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>
