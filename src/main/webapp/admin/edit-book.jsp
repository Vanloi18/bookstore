<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa thông tin sách</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container admin-container">
        <header class="admin-header">
            <h1>Trang Quản Trị</h1>
            <nav class="admin-nav">
                <a href="${pageContext.request.contextPath}/admin/manage-books" class="active">Quản lý sách</a>
                <a href="${pageContext.request.contextPath}/admin/manage-categories">Quản lý thể loại</a>
                <a href="${pageContext.request.contextPath}/admin/manage-orders">Quản lý đơn hàng</a>
                <a href="${pageContext.request.contextPath}/home">Về trang chủ</a>
            </nav>
        </header>

        <main>
            <div class="form-container" style="max-width: 800px; text-align: left;">
                <h2>Sửa thông tin sách: ${book.title}</h2>
                <hr>
                
                <form action="${pageContext.request.contextPath}/admin/edit-book" method="post">
                    <input type="hidden" name="id" value="${book.id}">
                    
                    <div class="form-group">
                        <label for="title">Tiêu đề:</label>
                        <input type="text" id="title" name="title" required value="${book.title}">
                    </div>
                    
                    <div class="form-group">
                        <label for="author">Tác giả:</label>
                        <input type="text" id="author" name="author" value="${book.author}">
                    </div>

                    <div class="form-group">
                        <label for="price">Giá:</label>
                        <input type="number" id="price" name="price" step="0.01" required value="${book.price}">
                    </div>

                    <div class="form-group">
                        <label for="stock">Tồn kho:</label>
                        <input type="number" id="stock" name="stock" value="${book.stock}">
                    </div>

                    <div class="form-group">
                        <label for="publicationYear">Năm xuất bản:</label>
                        <input type="number" id="publicationYear" name="publicationYear" value="${book.publicationYear}">
                    </div>

                    <div class="form-group">
                        <label for="categoryId">Thể loại:</label>
                        <select name="categoryId" id="categoryId" required>
                            <c:forEach items="${categoryList}" var="category">
                                <option value="${category.id}" ${category.id == book.categoryId ? 'selected' : ''}>
                                    ${category.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="coverImage">Link ảnh bìa:</label>
                        <input type="text" id="coverImage" name="coverImage" value="${book.coverImage}">
                    </div>

                    <div class="form-group">
                        <label for="description">Mô tả:</label>
                        <textarea id="description" name="description" rows="5">${book.description}</textarea>
                    </div>
                    
                    <button type="submit">Lưu Thay Đổi</button>
                </form>
                <p style="margin-top: 20px;"><a href="${pageContext.request.contextPath}/admin/manage-books">Quay lại danh sách</a></p>
            </div>
        </main>
    </div>
</body>
</html>
