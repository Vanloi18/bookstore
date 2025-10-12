<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Đơn Hàng | Bookstore Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
</head>

<body>
 <div class="container admin-container">
        <header class="main-header">
    <div class="logo-section">
        <a href="${pageContext.request.contextPath}/home" class="logo-text">
        <span class="b-part">Book</span><span class="s-part">Store</span>
            <img src="${pageContext.request.contextPath}/images/logo_icon.jpg" alt="icon" class="logo-icon">
        </a>
    </div>

    <nav class="nav-links">
    <a href="${pageContext.request.contextPath}/admin/dashboard">🧑‍💻TRANG ADMIN</a>
        <a href="${pageContext.request.contextPath}/admin/manage-books">📚 QUẢN LÝ SÁCH</a>
        <a href="${pageContext.request.contextPath}/admin/manage-categories">🏷️ QUẢN LÝ THỂ LOẠI</a>
        <a href="${pageContext.request.contextPath}/admin/manage-orders">🛒 QUẢN LÝ ĐƠN HÀNG</a>
        <a href="${pageContext.request.contextPath}/home">🏠Trang chủ</a>
        </nav>
    </header>

    <!-- Nội dung -->
    <main class="admin-container">
        <div class="admin-card">
            <h1 class="admin-title">Chi Tiết Đơn Hàng #${orderId}</h1>
            <p class="back-link">
                <a href="${pageContext.request.contextPath}/admin/manage-orders">← Quay lại danh sách đơn hàng</a>
            </p>
            <hr>

            <table class="admin-table">
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
                        <td colspan="4" style="text-align:right; font-weight:600;">Tổng cộng:</td>
                        <td style="font-weight:600; color:#0078d7;">
                            <fmt:formatNumber type="number" value="${totalAmount}" /> VNĐ
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>
    </main>

</body>
</html>
