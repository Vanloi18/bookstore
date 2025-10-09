<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chi Tiết Đơn Hàng</title>
<style>
    table { width: 100%; border-collapse: collapse; }
    th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
    th { background-color: #f2f2f2; }
</style>
</head>
<body>
    <h1>Chi Tiết Đơn Hàng #${orderId}</h1>
    <p><a href="${pageContext.request.contextPath}/admin/manage-orders">Quay lại danh sách đơn hàng</a></p>
    <hr>
    
    <table>
        <tr>
            <th>ID Sách</th>
            <th>Tên Sách</th>
            <th>Số lượng</th>
            <th>Đơn giá</th>
            <th>Thành tiền</th>
        </tr>
        <c:set var="totalAmount" value="0" />
        <c:forEach items="${detailList}" var="detail">
            <tr>
                <td>${detail.book.id}</td>
                <td>${detail.book.title}</td>
                <td>${detail.quantity}</td>
                <td><fmt:formatNumber type="number" value="${detail.pricePerUnit}" /> VNĐ</td>
                <td><fmt:formatNumber type="number" value="${detail.quantity * detail.pricePerUnit}" /> VNĐ</td>
            </tr>
            <c:set var="totalAmount" value="${totalAmount + (detail.quantity * detail.pricePerUnit)}" />
        </c:forEach>
         <tr>
            <td colspan="4" style="text-align:right;"><strong>Tổng cộng:</strong></td>
            <td><strong><fmt:formatNumber type="number" value="${totalAmount}" /> VNĐ</strong></td>
        </tr>
    </table>
</body>
</html>