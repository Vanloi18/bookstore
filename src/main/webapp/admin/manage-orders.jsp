<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản Lý Đơn Hàng</title>
<style>
/* (CSS styles...) */
table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: left;
}

th {
	background-color: #f2f2f2;
}
</style>
</head>
<body>
	<h1>Trang Quản Trị - Quản lý Đơn Hàng</h1>
	<p>
		<a href="${pageContext.request.contextPath}/admin/manage-books">Quản
			lý sách</a>
	</p>
	<hr>

	<table>
		<tr>
			<th>ID Đơn hàng</th>
			<th>ID Khách hàng</th>
			<th>Ngày đặt</th>
			<th>Tổng tiền</th>
			<th>Địa chỉ giao</th>
			<th>Trạng thái</th>
			<th>Hành động</th>
		</tr>
		<c:forEach items="${orderList}" var="order">
			<tr>
				<td>${order.id}</td>
				<td>${order.userId}</td>
				<td><fmt:formatDate value="${order.orderDate}"
						pattern="dd-MM-yyyy HH:mm:ss" /></td>
				<td><fmt:formatNumber type="number"
						value="${order.totalAmount}" /> VNĐ</td>
				<td>${order.shippingAddress}</td>
				<td>
					<%-- FORM CẬP NHẬT TRẠNG THÁI --%>
					<form
						action="${pageContext.request.contextPath}/admin/update-order-status"
						method="post" style="display: inline;">
						<input type="hidden" name="orderId" value="${order.id}"> <select
							name="status">
							<option value="Pending"
								${order.status == 'Pending' ? 'selected' : ''}>Pending</option>
							<option value="Shipping"
								${order.status == 'Shipping' ? 'selected' : ''}>Shipping</option>
							<option value="Completed"
								${order.status == 'Completed' ? 'selected' : ''}>Completed</option>
							<option value="Cancelled"
								${order.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
						</select>
						<button type="submit">Cập nhật</button>
					</form>
				</td>
				<td><a
					href="${pageContext.request.contextPath}/admin/view-order-detail?id=${order.id}">Xem
						chi tiết</a></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>