<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản Lý Thể Loại</title>
<style>
    table { width: 50%; border-collapse: collapse; }
    th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
    th { background-color: #f2f2f2; }
</style>
</head>
<body>
    <h1>Trang Quản Trị - Quản lý Thể Loại</h1>
    <p>
        <a href="${pageContext.request.contextPath}/admin/manage-books">Quản lý sách</a> | 
        <a href="${pageContext.request.contextPath}/admin/manage-orders">Quản lý đơn hàng</a>
    </p>
    <hr>
    
    <h3>Thêm Thể loại mới</h3>
    <form action="${pageContext.request.contextPath}/admin/add-category" method="post">
        Tên thể loại: <input type="text" name="categoryName" required>
        <button type="submit">Thêm</button>
    </form>
    <br>

    <h3>Danh sách Thể loại</h3>
    <table>
        <tr>
            <th>ID</th>
            <th>Tên Thể loại</th>
            <th>Hành động</th>
        </tr>
        <c:forEach items="${categoryList}" var="cat">
            <tr>
                <td>${cat.id}</td>
                <td>${cat.name}</td>
                <td>
                    <a href="edit-category?id=${cat.id}">Sửa</a> |
                    <a href="delete-category?id=${cat.id}" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>