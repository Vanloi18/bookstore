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
        <%-- ✅ DÒNG LỆNH NHÚNG HEADER VÀO --%>
         <jsp:include page="header.jsp">
    <jsp:param name="currentPage" value="categories"/>
</jsp:include>

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
