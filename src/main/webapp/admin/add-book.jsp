<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thêm Sách Mới</title>
</head>
<body>
    <h1>Thêm Sách Mới</h1>
    <p><a href="${pageContext.request.contextPath}/admin/manage-books">Quay lại danh sách</a></p>
    <hr>
    
    <form action="${pageContext.request.contextPath}/admin/add-book" method="post">
        <table>
            <tr>
                <td>Tiêu đề:</td>
                <td><input type="text" name="title" size="50" required></td>
            </tr>
            <tr>
                <td>Tác giả:</td>
                <td><input type="text" name="author" size="50"></td>
            </tr>
            <tr>
                <td>Giá:</td>
                <td><input type="number" name="price" step="0.01" required></td>
            </tr>
            <tr>
                <td>Tồn kho:</td>
                <td><input type="number" name="stock" value="0"></td>
            </tr>
            <tr>
                <td>Năm xuất bản:</td>
                <td><input type="number" name="publicationYear"></td>
            </tr>
            <tr>
                <td>Thể loại:</td>
                <td>
                    <select name="categoryId" required>
                        <option value="">-- Chọn thể loại --</option>
                        <c:forEach items="${categoryList}" var="category">
                            <option value="${category.id}">${category.name}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Link ảnh bìa:</td>
                <td><input type="text" name="coverImage" size="50" placeholder="images/ten_sach.jpg"></td>
            </tr>
            <tr>
                <td>Mô tả:</td>
                <td><textarea name="description" rows="5" cols="50"></textarea></td>
            </tr>
            <tr>
                <td colspan="2"><button type="submit">Thêm Sách</button></td>
            </tr>
        </table>
    </form>
</body>
</html>