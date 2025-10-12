<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa Tên Thể Loại</title>
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
