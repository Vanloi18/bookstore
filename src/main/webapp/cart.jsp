<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Giỏ Hàng của bạn</title>
<style>
    table { width: 100%; border-collapse: collapse; }
    th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
    th { background-color: #f2f2f2; }
    .quantity-input { width: 50px; text-align: center; }
</style>
</head>
<body>
<%-- Phần header chứa thông tin đăng nhập/đăng xuất được tách ra file riêng --%>
	<jsp:include page="header.jsp" />
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
                        <td>${item.book.price} VNĐ</td>
                        <td>
                            <%-- Form nhỏ để cập nhật số lượng cho từng sản phẩm --%>
                            <form action="update-cart" method="post" style="display:inline;">
                                <input type="hidden" name="bookId" value="${item.book.id}">
                                <input type="number" name="quantity" class="quantity-input" value="${item.quantity}" min="0">
                                <button type="submit">Cập nhật</button>
                            </form>
                        </td>
                        <td>${item.subtotal} VNĐ</td>
                        <td><a href="remove-from-cart?id=${item.book.id}">Xóa</a></td>
                    </tr>
                    <c:set var="totalAmount" value="${totalAmount + item.subtotal}" />
                </c:forEach>
                
                <tr>
                    <td colspan="3" style="text-align:right;"><strong>Tổng cộng:</strong></td>
                    <td colspan="2"><strong>${totalAmount} VNĐ</strong></td>
                </tr>
            </table>
        </form>
        <br>
        <a href="home">Tiếp tục mua sắm</a> | <a href="checkout.jsp">Thanh toán</a>
    </c:if>
</body>
</html>