<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Đơn Hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    
</head>
<body>
	<div class="container admin-container">
        <jsp:include page="header.jsp">
    <jsp:param name="currentPage" value="orders"/>
</jsp:include>

		<main>
			<h2>Danh sách Đơn Hàng</h2>
			   <%-- CẢI TIẾN 2: Kiểm tra nếu danh sách đơn hàng rỗng --%>
            <c:if test="${empty orderList}">
                <p class="empty-message">Hiện tại không có đơn hàng nào.</p>
            </c:if>

            <c:if test="${not empty orderList}">
                <table>
                    <thead>
                        <tr>
                            <th>ID Đơn hàng</th>
                            <th>ID Khách hàng</th>
                            <th>Ngày đặt</th>
                            <th>Tổng tiền</th>
                            <th>Địa chỉ giao</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${orderList}" var="order">
                            <tr>
                                <td>#${order.id}</td>
                                <td>${order.userId}</td>
                                <td><fmt:formatDate value="${order.orderDate}" pattern="dd-MM-yyyy HH:mm:ss" /></td>
                                <td><fmt:formatNumber type="number" value="${order.totalAmount}" /> VNĐ</td>
                                <td>${order.shippingAddress}</td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/admin/update-order-status" method="post" class="status-form">
                                        <input type="hidden" name="orderId" value="${order.id}"> 
                                        <%-- Thêm class động để dễ dàng CSS theo trạng thái --%>
                                        <select name="status" class="status-select status-${order.status.toLowerCase()}">
                                            <option value="Pending" ${order.status == 'Pending' ? 'selected' : ''}>Chờ xử lý</option>
                                            <option value="Shipping" ${order.status == 'Shipping' ? 'selected' : ''}>Đang giao</option>
                                            <option value="Completed" ${order.status == 'Completed' ? 'selected' : ''}>Hoàn thành</option>
                                            <option value="Cancelled" ${order.status == 'Cancelled' ? 'selected' : ''}>Đã hủy</option>
                                        </select>
                                        <button type="submit">Cập nhật</button>
                                    </form>
                                </td>
                                <td>
                                    <a class="action-link" href="${pageContext.request.contextPath}/admin/view-order-detail?id=${order.id}">Xem chi tiết</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
		</main>
	</div>
</body>
</html>
