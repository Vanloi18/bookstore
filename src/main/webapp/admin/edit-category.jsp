<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sửa Tên Thể Loại</title>
</head>
<body>
    <h1>Sửa Tên Thể Loại</h1>
    <p><a href="${pageContext.request.contextPath}/admin/manage-categories">Quay lại danh sách</a></p>
    <hr>
    
    <c:if test="${not empty category}">
        <form action="${pageContext.request.contextPath}/admin/edit-category" method="post">
            <input type="hidden" name="id" value="${category.id}">
            Tên thể loại: 
            <input type="text" name="name" value="${category.name}" required>
            <button type="submit">Lưu Thay Đổi</button>
        </form>
    </c:if>
    <c:if test="${empty category}">
        <p>Không tìm thấy thể loại.</p>
    </c:if>
</body>
</html>