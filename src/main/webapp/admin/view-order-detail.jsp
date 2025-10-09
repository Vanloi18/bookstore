<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Đơn Hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <h1>Chi Tiết Đơn Hàng #${orderId}</h1>
        <p><a href="${pageContext.request.contextPath}/admin/manage-orders">Quay lại danh sách đơn hàng</a></p>
        <hr>
        
        <table>
            <thead>
                <tr>
                    <th>ID Sách</th>
                    <th>Tên Sách</th>
                    <th>Số lượng</th>
                    <th>Đơn giá</th>
                    <th>Thành tiền</th>
                </tr>
            </thead>
            <tbody>
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
            </tbody>
            <tfoot>
                 <tr>
                    <td colspan="4" style="text-align:right; font-weight: bold;">Tổng cộng:</td>
                    <td style="font-weight: bold;"><fmt:formatNumber type="number" value="${totalAmount}" /> VNĐ</td>
                </tr>
            </tfoot>
        </table>
    </div>
</body>
</html>
