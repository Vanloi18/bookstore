<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Thể Loại</title>
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
                <h3>Thêm Thể loại mới</h3>
                <form action="${pageContext.request.contextPath}/admin/add-category" method="post" class="add-form">
                    <input type="text" name="categoryName" placeholder="Nhập tên thể loại..." required>
                    <button type="submit">Thêm</button>
                </form>
            </div>
            
            <h2>Danh sách Thể loại</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên Thể loại</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${categoryList}" var="cat">
                        <tr>
                            <td>${cat.id}</td>
                            <td>${cat.name}</td>
                            <td>
                                <a href="edit-category?id=${cat.id}" class="btn-action btn-edit">Sửa</a>
                                <a href="delete-category?id=${cat.id}" class="btn-action btn-delete" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </main>
    </div>
</body>
</html>
