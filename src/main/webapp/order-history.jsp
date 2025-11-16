<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lịch Sử Đơn Hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/user-profile.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout/header.css">
</head>
<body>
    <jsp:include page="header.jsp">
        <jsp:param name="currentPage" value="order-history"/>
    </jsp:include>

    <%-- Bọc chính trong main-content để footer luôn xuống dưới --%>
    <div class="main-content">
        <div class="container">
            <h1>Lịch sử đơn hàng của bạn</h1>
            <hr>

            <c:if test="${empty orderList}">
                <p class="no-orders-message">Bạn chưa có đơn hàng nào.</p>
                <a href="${pageContext.request.contextPath}/books" class="cta-button">Khám Phá Sách</a>
            </c:if>

            <c:if test="${not empty orderList}">
                <div class="order-table-wrapper">
                    <table class="order-table">
                        <thead>
                            <tr>
                                <th>ID Đơn hàng</th>
                                <th>Ngày đặt</th>
                                <th>Tổng tiền</th>
                                <th>Địa chỉ giao</th>
                                <th>Trạng thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${orderList}" var="order">
                                <tr>
                                    <td>#${order.id}</td>
                                    <td><fmt:formatDate value="${order.orderDate}" pattern="dd-MM-yyyy HH:mm" timeZone="Asia/Ho_Chi_Minh"/></td>
                                    <td><fmt:formatNumber type="number" value="${order.totalAmount}" /> VNĐ</td>
                                    <td>${order.shippingAddress}</td>
                                    <td class="order-status ${order.status.toLowerCase().replace(' ','-')}">${order.status}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>
