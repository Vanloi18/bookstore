	<%-- File: manage-users.jsp --%>
	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
	
	<!DOCTYPE html>
	<html lang="vi">
	<head>
	<meta charset="UTF-8">
	<title>Quản Lý Người Dùng</title>
	
	<%-- ⚠️ SỬA LỖI FONT & ICON: Đồng bộ Font Open Sans và Font Awesome --%>
	<link
		href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&display=swap"
		rel="stylesheet">
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
	
	<%-- ⚠️ SỬA LỖI CSS: Nhúng các file CSS component --%>
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/css/layout/admin-layout.css">
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/css/components/button.css">
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/css/components/table.css">
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/css/pages/users.css">
	</head>
	<body class="admin-body">
	
		<jsp:include page="admin-sidebar.jsp">
			<jsp:param name="activePage" value="users" />
		</jsp:include>
	
		<div class="admin-main-content">
			<jsp:include page="admin-header.jsp" />
	
			<div class="admin-page-content">
				<h2>
					<i class="fas fa-users"></i> Quản Lý Người Dùng
				</h2>
	
				<%-- ⚠️ THÊM ACTION BAR --%>
				<div class="action-bar table-filter-bar">
					<a href="${pageContext.request.contextPath}/admin/add-user"
						class="btn btn-primary"> <i class="fas fa-user-plus"></i> Thêm
						Người Dùng Mới
					</a>
					<div class="search-filter">
						<form action="${pageContext.request.contextPath}/admin/manage-users"
							method="get" class="search-form-inline">
							<input type="text" name="keyword"
								placeholder="Tìm kiếm theo tên, email..." class="input-search"
								value="${param.keyword}">
							<button type="submit" class="btn btn-search">
								<i class="fas fa-search"></i>
							</button>
						</form>
					</div>
				</div>
	
				<div class="table-responsive">
					<%-- ⚠️ THÊM CLASS data-table --%>
					<table class="data-table">
						<thead>
							<tr>
								<th style="width: 5%;">ID</th>
								<th style="width: 10%;">Username</th>
								<th style="width: 15%;">Họ tên</th>
								<th style="width: 15%;">Email</th>
								<th>Địa chỉ</th>
								<th style="width: 10%;">SĐT</th>
								<th style="width: 10%;">Ngày tạo</th>
								<th style="width: 10%;">Vai trò</th>
								<th style="width: 10%;">Hành động</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${userList}" var="user">
								<tr>
									<td>${user.id}</td>
									<td>${user.username}</td>
									<td>${user.fullname}</td>
									<td class="text-secondary">${user.email}</td>
									<td class="text-address">${user.address}</td>
									<td class="text-secondary">${user.phone}</td>
									<td><fmt:formatDate value="${order.orderDate}" pattern="dd-MM-yyyy HH:mm" timeZone="Asia/Ho_Chi_Minh"/></td>
									<td class="role-cell">
										<form
											action="${pageContext.request.contextPath}/admin/update-user-role"
											method="post" class="role-update-form"
											id="role-form-${user.id}">
											<input type="hidden" name="userId" value="${user.id}">
											<select name="isAdmin" class="role-select role-${user.isAdmin() ? 'admin' : 'user'}"
												onchange="document.getElementById('role-form-${user.id}').submit()">
												<option value="false" ${!user.isAdmin() ? 'selected' : ''}>User</option>
												<option value="true" ${user.isAdmin() ? 'selected' : ''}>Admin</option>
											</select>
										</form>
									</td>
									<td class="action-cell"><a
										href="${pageContext.request.contextPath}/admin/delete-user?id=${user.id}"
										class="btn btn-sm btn-danger"
										onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng ID ${user.id}?')">
											<i class="fas fa-trash-alt"></i> Xóa
									</a></td>
								</tr>
							</c:forEach>
							<c:if test="${empty userList}">
								<tr>
									<td colspan="9" class="text-center-empty">Không có người dùng
										nào trong hệ thống.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
	
			<jsp:include page="admin-footer.jsp" />
		</div>
	</body>
	</html>