<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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

		<main>
			<h2>Danh sách Đơn Hàng</h2>
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
							<td><fmt:formatDate value="${order.orderDate}"
									pattern="dd-MM-yyyy HH:mm:ss" /></td>
							<td><fmt:formatNumber type="number"
									value="${order.totalAmount}" /> VNĐ</td>
							<td>${order.shippingAddress}</td>
							<td>
								<form
									action="${pageContext.request.contextPath}/admin/update-order-status"
									method="post" class="status-form">
									<input type="hidden" name="orderId" value="${order.id}"> 
									<select name="status" class="status-select status-${order.status.toLowerCase()}">
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
				</tbody>
			</table>
		</main>
	</div>
</body>
</html>
