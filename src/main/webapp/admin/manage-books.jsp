<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản Lý Sách</title>
<style>
/* (CSS tương tự như trang cart.jsp) */
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
	<h1>Trang Quản Trị - Quản lý Sách</h1>
	<p><a href="${pageContext.request.contextPath}/admin/manage-orders">Quản lý đơn hàng</a> | 
       <a href="${pageContext.request.contextPath}/admin/manage-categories">Quản lý thể loại</a>
    </p>
	<p>
		<a href="${pageContext.request.contextPath}/home">Quay lại trang chủ</a>
	</p>
	<hr>

	<a href="${pageContext.request.contextPath}/admin/add-book">Thêm
		Sách Mới</a>
	<br>
	<br>

	<table>
		<tr>
			<th>ID</th>
			<th>Tiêu đề</th>
			<th>Tác giả</th>
			<th>Giá</th>
			<th>Tồn kho</th>
			<th>Hành động</th>
		</tr>
		<c:forEach items="${bookList}" var="book">
			<tr>
				<td>${book.id}</td>
				<td>${book.title}</td>
				<td>${book.author}</td>
				<td>${book.price}</td>
				<td>${book.stock}</td>
				<td><a
					href="${pageContext.request.contextPath}/admin/edit-book?id=${book.id}">Sửa</a>
					| <a
					href="${pageContext.request.contextPath}/admin/delete-book?id=${book.id}"
					onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>