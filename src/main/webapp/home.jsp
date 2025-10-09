<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang Chủ</title>
<style>
body {
	font-family: sans-serif;
}

.main-container {
	display: flex;
	gap: 20px;
}

.sidebar {
	width: 20%;
}

.content {
	width: 80%;
}

.book-list {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
}

.book-item {
	border: 1px solid #ccc;
	padding: 10px;
	width: 200px;
	text-align: center;
}

.book-item img {
	max-width: 100%;
	height: 200px; /* Đảm bảo các ảnh có cùng chiều cao */
	object-fit: cover; /* Giữ tỷ lệ ảnh */
}

.category-list, .category-list li {
	list-style: none;
	padding: 0;
	margin: 0;
}

.category-list a {
	text-decoration: none;
	color: #333;
	display: block;
	padding: 8px;
}

.category-list a:hover {
	background-color: #f0f0f0;
}
</style>
</head>
<body>
	<%-- Phần header chứa thông tin đăng nhập/đăng xuất được tách ra file riêng --%>
	<jsp:include page="header.jsp" />
	<h1>Chào mừng đến với Nhà Sách Online</h1>

	<hr>

	<div class="main-container">
		<%-- Sidebar hiển thị danh mục sản phẩm --%>
		<aside class="sidebar">
			<h3>Thể loại</h3>
			<ul class="category-list">
				<li><a href="${pageContext.request.contextPath}/home">Tất
						cả sách</a></li>
				<c:forEach items="${categoryList}" var="cat">
					<li><a
						href="${pageContext.request.contextPath}/home?categoryId=${cat.id}">${cat.name}</a>
					</li>
				</c:forEach>
			</ul>
		</aside>

		<%-- Nội dung chính hiển thị sách và thanh tìm kiếm --%>
		<main class="content">
			<%-- Form tìm kiếm --%>
			<form action="${pageContext.request.contextPath}/home" method="get">
				<input type="text" name="search" size="40"
					placeholder="Nhập tên sách cần tìm..." value="${searchKeyword}">
				<button type="submit">Tìm kiếm</button>
			</form>
			<br>

			<h2>Danh sách sách</h2>
			<div class="book-list">
				<c:forEach items="${bookList}" var="book">
					<div class="book-item">
						<img src="${pageContext.request.contextPath}/${book.coverImage}"
							alt="${book.title}">
						<h4>${book.title}</h4>
						<p>Tác giả: ${book.author}</p>
						<p>Giá: ${book.price} VNĐ</p>
						<a href="product-detail?id=${book.id}">Xem chi tiết</a>
					</div>
				</c:forEach>

				<%-- Hiển thị thông báo nếu không tìm thấy kết quả --%>
				<c:if test="${empty bookList}">
					<p>Không tìm thấy sản phẩm nào phù hợp.</p>
				</c:if>
			</div>
		</main>
	</div>
</body>
</html>