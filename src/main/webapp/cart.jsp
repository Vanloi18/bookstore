<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Giỏ Hàng của bạn</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/cart.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout/header.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <jsp:include page="header.jsp">
        <jsp:param name="currentPage" value="cart"/>
    </jsp:include>

    <div class="main-content">
        <div class="container">
            <h1><i class="fas fa-shopping-cart"></i> Giỏ Hàng</h1>
            <hr>
            
            <c:set var="cart" value="${sessionScope.cart}" />
            
            <c:choose>
                <c:when test="${empty cart or cart.size() == 0}">
                    <div style="text-align: center; padding: 50px;">
                        <p style="font-size: 1.2rem;">Giỏ hàng của bạn đang trống.</p>
                        <a href="${pageContext.request.contextPath}/books" class="cta-button" style="margin-top: 15px;">Đi mua sắm ngay</a>
                    </div>
                </c:when>

                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th>Sản phẩm</th>
                                <th>Đơn giá</th>
                                <th>Số lượng</th>
                                <th>Thành tiền</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="totalAmount" value="0" />
                            
                            <c:forEach items="${cart}" var="entry">
                                <c:set var="item" value="${entry.value}" />
                                <tr>
                                    <td>
                                        <strong>${item.book.title}</strong>
                                        <br>
                                        <%-- Hiển thị tồn kho để người dùng biết --%>
                                        <small style="color: #666;">(Trong kho còn: ${item.book.stock})</small>
                                    </td>
                                    
                                    <td><fmt:formatNumber type="number" value="${item.book.price}" /> VNĐ</td>
                                    
                                    <td>
                                        <%-- Form Cập nhật số lượng --%>
                                        <form action="update-cart" method="post" style="display:flex; align-items: center; gap: 5px;">
                                            <input type="hidden" name="bookId" value="${item.book.id}">
                                            
                                            <%-- THÊM attribute max="${item.book.stock}" để chặn nhập quá số lượng --%>
                                            <input type="number" name="quantity" class="quantity-input" 
                                                   value="${item.quantity}" min="1" max="${item.book.stock}" 
                                                   style="width: 60px; padding: 5px;" required>
                                                   
                                            <button type="submit" class="btn-update" style="padding: 5px 10px; cursor: pointer;">
                                                <i class="fas fa-sync-alt"></i>
                                            </button>
                                        </form>
                                    </td>
                                    
                                    <td style="color: #d32f2f; font-weight: bold;">
                                        <fmt:formatNumber type="number" value="${item.subtotal}" /> VNĐ
                                    </td>
                                    
                                    <td>
                                        <a href="remove-from-cart?id=${item.book.id}" class="btn-remove" onclick="return confirm('Bạn chắc chắn muốn xóa sách này?');" style="color: red;">
                                            <i class="fas fa-trash"></i> Xóa
                                        </a>
                                    </td>
                                </tr>
                                <c:set var="totalAmount" value="${totalAmount + item.subtotal}" />
                            </c:forEach>
                            
                            <tr class="total-row">
                                <td colspan="3" style="text-align:right;"><strong>Tổng cộng:</strong></td>
                                <td colspan="2" style="font-size: 1.2em; color: #d32f2f;">
                                    <strong><fmt:formatNumber type="number" value="${totalAmount}" /> VNĐ</strong>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <br>
                    <div class="cart-actions" style="display: flex; justify-content: space-between; align-items: center;">
                        <a href="${pageContext.request.contextPath}/books" class="btn-continue" style="text-decoration: none; color: #333;">
                            <i class="fas fa-arrow-left"></i> Tiếp tục mua sắm
                        </a>
                        <a href="checkout.jsp" class="cta-button" style="background-color: #27ae60;">
                            Tiến hành thanh toán <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <jsp:include page="footer.jsp" />
    
    <%-- Script kiểm tra logic khi người dùng nhập số tay --%>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const inputs = document.querySelectorAll(".quantity-input");
            inputs.forEach(input => {
                input.addEventListener("change", function() {
                    const max = parseInt(this.getAttribute("max"));
                    const val = parseInt(this.value);
                    if (val > max) {
                        alert("Số lượng bạn chọn vượt quá tồn kho (" + max + " cuốn).");
                        this.value = max; // Tự động reset về max
                    }
                    if (val < 1) {
                        this.value = 1;
                    }
                });
            });
        });
    </script>
</body>
</html>