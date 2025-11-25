<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Đơn Hàng | Bookstore Admin</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-main.css">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>

<body class="admin-body">

    <div class="admin-main-content">
    
        <main class="admin-page-content">
            
            <div class="card">
                <h1><i class="fas fa-truck-moving"></i> Chi Tiết Đơn Hàng #${orderId}</h1>
                
                <p class="back-link mb-20"> <a href="${pageContext.request.contextPath}/admin/manage-orders" class="text-secondary">
                        ← Quay lại danh sách đơn hàng
                    </a>
                </p>
                <hr>

                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>ID Sách</th>
                                <th>Tên Sách</th>
                                <th class="text-center">Số lượng</th>
                                <th class="text-right">Đơn giá</th>
                                <th class="text-right">Thành tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="totalAmount" value="0" />
                            <c:forEach items="${detailList}" var="detail">
                                <tr>
                                    <td>${detail.book.id}</td>
                                    <td>${detail.book.title}</td>
                                    <td class="text-center">${detail.quantity}</td>
                                    <td class="text-right text-secondary">
                                        <fmt:formatNumber type="number" value="${detail.pricePerUnit}" /> VNĐ
                                    </td>
                                    <td class="text-right text-price"> <fmt:formatNumber type="number" value="${detail.quantity * detail.pricePerUnit}" /> VNĐ
                                    </td>
                                </tr>
                                <c:set var="totalAmount" value="${totalAmount + (detail.quantity * detail.pricePerUnit)}" />
                            </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="4" class="text-right">Tổng cộng:</td>
                                <td class="text-right text-price"> <fmt:formatNumber type="number" value="${totalAmount}" /> VNĐ
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </main>
        
        </div> </body>
</html>