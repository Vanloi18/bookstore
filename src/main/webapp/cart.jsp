<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Giỏ Hàng của bạn</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page="header.jsp" />

<div class="container">
    <h1>Giỏ Hàng</h1>
    <hr>
    
    <c:set var="cart" value="${sessionScope.cart}" />
    
    <c:if test="${empty cart or cart.size() == 0}">
        <p>Giỏ hàng của bạn đang trống.</p>
    </c:if>

    <c:if test="${not empty cart and cart.size() > 0}">
        <form action="update-cart" method="post">
            <table>
                <tr>
                    <th>Sản phẩm</th>
                    <th>Đơn giá</th>
                    <th>Số lượng</th>
                    <th>Thành tiền</th>
                    <th>Hành động</th>
                </tr>
                
                <c:set var="totalAmount" value="0" />
                
                <c:forEach items="${cart}" var="entry">
                    <c:set var="item" value="${entry.value}" />
                    <tr>
                        <td>${item.book.title}</td>
                        <td><fmt:formatNumber type="number" value="${item.book.price}" /> VNĐ</td>
                        <td>
                            <form action="update-cart" method="post" style="display:flex; align-items: center; gap: 10px;">
                                <input type="hidden" name="bookId" value="${item.book.id}">
                                <input type="number" name="quantity" class="quantity-input" value="${item.quantity}" min="0">
                                <button type="submit">Cập nhật</button>
                            </form>
                        </td>
                        <td><fmt:formatNumber type="number" value="${item.subtotal}" /> VNĐ</td>
                        <td><a href="remove-from-cart?id=${item.book.id}">Xóa</a></td>
                    </tr>
                    <c:set var="totalAmount" value="${totalAmount + item.subtotal}" />
                </c:forEach>
                
                <tr>
                    <td colspan="3" style="text-align:right;"><strong>Tổng cộng:</strong></td>
                    <td colspan="2"><strong><fmt:formatNumber type="number" value="${totalAmount}" /> VNĐ</strong></td>
                </tr>
            </table>
        </form>
        <br>
        <div class="cart-actions">
    <a href="home" class="btn-continue">🛒 Tiếp tục mua sắm</a>
    <a href="checkout.jsp" class="btn-checkout">💳 Thanh toán</a>
</div>

    </c:if>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>