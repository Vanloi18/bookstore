<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa Tên Thể Loại</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container admin-container">
        <header class="admin-header">
            <h1>Trang Quản Trị</h1>
            <nav class="admin-nav">
                <a href="${pageContext.request.contextPath}/admin/manage-books">Quản lý sách</a>
                <a href="${pageContext.request.contextPath}/admin/manage-categories" class="active">Quản lý thể loại</a>
                <a href="${pageContext.request.contextPath}/admin/manage-orders">Quản lý đơn hàng</a>
                <a href="${pageContext.request.contextPath}/home">Về trang chủ</a>
            </nav>
        </header>

        <main>
            <div class="add-form-container">
                <h3>Sửa Tên Thể Loại</h3>
                <c:if test="${not empty category}">
                    <form action="${pageContext.request.contextPath}/admin/edit-category" method="post" class="add-form">
                        <input type="hidden" name="id" value="${category.id}">
                        <input type="text" name="name" value="${category.name}" required>
                        <button type="submit">Lưu Thay Đổi</button>
                    </form>
                </c:if>
                <c:if test="${empty category}">
                    <p>Không tìm thấy thể loại.</p>
                </c:if>
            </div>
            <p><a href="${pageContext.request.contextPath}/admin/manage-categories">Quay lại danh sách</a></p>
        </main>
    </div>
</body>
</html>
