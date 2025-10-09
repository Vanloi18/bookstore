<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Lịch Sử Đơn Hàng</title>
<style>
    table { width: 100%; border-collapse: collapse; }
    th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
    th { background-color: #f2f2f2; }
</style>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <h1>Lịch sử đơn hàng của bạn</h1>
    <hr>
    
    <c:if test="${empty orderList}">
        <p>Bạn chưa có đơn hàng nào.</p>
    </c:if>

    <c:if test="${not empty orderList}">
        <table>
            <tr>
                <th>ID Đơn hàng</th>
                <th>Ngày đặt</th>
                <th>Tổng tiền</th>
                <th>Địa chỉ giao</th>
                <th>Trạng thái</th>
            </tr>
            <c:forEach items="${orderList}" var="order">
                <tr>
                    <td>#${order.id}</td>
                    <td><fmt:formatDate value="${order.orderDate}" pattern="dd-MM-yyyy HH:mm"/></td>
                    <td><fmt:formatNumber type="number" value="${order.totalAmount}" /> VNĐ</td>
                    <td>${order.shippingAddress}</td>
                    <td>${order.status}</td>
                </tr>
            </c:forEach>
        </table>
    </c:if>

</body>
</html>