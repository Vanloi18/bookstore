<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Sách</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    
</head>
<body>
    <div class="container admin-container">
        <jsp:include page="header.jsp">
    <jsp:param name="currentPage" value="books"/>
</jsp:include>

        <main>
            <div class="add-form-container">
                 <a href="${pageContext.request.contextPath}/admin/add-book" class="btn-add-new">Thêm Sách Mới</a>
            </div>

            <h2>Danh sách Sách</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tiêu đề</th>
                        <th>Tác giả</th>
                        <th>Giá</th>
                        <th>Tồn kho</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${bookList}" var="book">
                        <tr>
                            <td>${book.id}</td>
                            <td>${book.title}</td>
                            <td>${book.author}</td>
                            <td><fmt:formatNumber type="number" value="${book.price}" /> VNĐ</td>
                            <td>${book.stock}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/edit-book?id=${book.id}" class="btn-action btn-edit">Sửa</a>
                                <a href="${pageContext.request.contextPath}/admin/delete-book?id=${book.id}" class="btn-action btn-delete" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </main>
    </div>
</body>
</html>
