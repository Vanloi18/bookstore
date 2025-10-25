<%-- File: manage-orders.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Quản Lý Đơn Hàng</title>

<%-- ⚠️ SỬA LỖI FONT & ICON: Đồng bộ Font Open Sans và Font Awesome --%>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />

<%-- ⚠️ SỬA LỖI CSS: Nhúng các file CSS chuyên biệt --%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/layout/admin-layout.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/components/button.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/components/table.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/pages/orders.css">
<%-- CSS riêng cho trang orders --%>
</head>
<body class="admin-body">

	<jsp:include page="admin-sidebar.jsp">
		<jsp:param name="activePage" value="orders" />
	</jsp:include>

	<div class="admin-main-content">
		<jsp:include page="admin-header.jsp" />

		<div class="admin-page-content">
			<h2>
				<i class="fas fa-shopping-cart"></i> Quản lý Đơn Hàng
			</h2>

			<%-- KHU VỰC TÌM KIẾM VÀ LỌC --%>
			<div class="action-bar table-filter-bar">
    <form action="${pageContext.request.contextPath}/admin/manage-orders" method="get" class="search-filter">
    <input type="text" name="keyword" value="${keyword}" placeholder="Tìm kiếm theo ID, Khách hàng hoặc Địa chỉ..." class="input-search">
    <select name="status" class="form-input filter-status-select">
        <option value="">Tất cả trạng thái</option>
        <option value="Pending" ${status == 'Pending' ? 'selected' : ''}>Chờ xử lý</option>
        <option value="Shipping" ${status == 'Shipping' ? 'selected' : ''}>Đang giao</option>
        <option value="Completed" ${status == 'Completed' ? 'selected' : ''}>Hoàn thành</option>
        <option value="Cancelled" ${status == 'Cancelled' ? 'selected' : ''}>Đã hủy</option>
    </select>
    <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i></button>
</form>
</div>


			<div class="table-responsive">
				<c:if test="${empty orderList}">
					<p class="text-center-empty">Hiện tại không có đơn hàng nào.</p>
				</c:if>

				<c:if test="${not empty orderList}">
					<table class="data-table">
						<thead>
							<tr>
								<th style="width: 10%;">ID</th>
								<th style="width: 15%;">Khách hàng</th>
								<th style="width: 15%;">Ngày đặt</th>
								<th style="width: 15%;">Tổng tiền</th>
								<th>Địa chỉ giao</th>
								<th style="width: 15%;">Trạng thái</th>
								<th style="width: 10%;">Hành động</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${orderList}" var="order">
								<tr>
									<td>#${order.id}</td>
									<td class="text-secondary">${order.userId}</td>
									<td><fmt:formatDate value="${order.orderDate}"
											pattern="dd-MM-yyyy HH:mm" /></td>
									<td class="text-price"><fmt:formatNumber type="number"
											value="${order.totalAmount}" /> VNĐ</td>
									<td class="text-address">${fn:substring(order.shippingAddress, 0, 50)}...</td>
									<td class="status-cell">
										<form
											action="${pageContext.request.contextPath}/admin/update-order-status"
											method="post" class="status-update-form"
											id="form-${order.id}">
											<input type="hidden" name="orderId" value="${order.id}">

											<%-- ⚠️ CẬP NHẬT CLASS: Thêm class động status-Pending, status-Shipping,... --%>
											<select name="status"
												class="status-select status-${order.status}"
												onchange="document.getElementById('form-${order.id}').submit()">
												<option value="Pending"
													${order.status == 'Pending' ? 'selected' : ''}>Chờ
													xử lý</option>
												<option value="Shipping"
													${order.status == 'Shipping' ? 'selected' : ''}>Đang
													giao</option>
												<option value="Completed"
													${order.status == 'Completed' ? 'selected' : ''}>Hoàn
													thành</option>
												<option value="Cancelled"
													${order.status == 'Cancelled' ? 'selected' : ''}>Đã
													hủy</option>
											</select>
										</form>
									</td>
									<td class="action-cell"><a class="btn btn-sm btn-info"
										href="${pageContext.request.contextPath}/admin/view-order-detail?id=${order.id}"><i
											class="fas fa-eye"></i> Xem</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:if>
			</div>
		</div>

		<jsp:include page="admin-footer.jsp" />
	</div>

	<%-- Script để tự động gửi form khi thay đổi trạng thái (nếu muốn) --%>
	 <script>
        document.querySelectorAll('.status-select').forEach(select => {
            select.addEventListener('change', function() {
                this.closest('form').submit();
            });
        });
    </script> 
    
</body>
</html>