<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sửa thông tin sách</title>
</head>
<body>
    <h1>Sửa thông tin sách: ${book.title}</h1>
    <p><a href="${pageContext.request.contextPath}/admin/manage-books">Quay lại danh sách</a></p>
    <hr>
    
    <form action="${pageContext.request.contextPath}/admin/edit-book" method="post">
        <%-- Thêm trường id ẩn để biết cần update sách nào --%>
        <input type="hidden" name="id" value="${book.id}">
        
        <table>
            <tr>
                <td>Tiêu đề:</td>
                <td><input type="text" name="title" size="50" required value="${book.title}"></td>
            </tr>
            <tr>
                <td>Tác giả:</td>
                <td><input type="text" name="author" size="50" value="${book.author}"></td>
            </tr>
            <tr>
                <td>Giá:</td>
                <td><input type="number" name="price" step="0.01" required value="${book.price}"></td>
            </tr>
            <tr>
                <td>Tồn kho:</td>
                <td><input type="number" name="stock" value="${book.stock}"></td>
            </tr>
            <tr>
                <td>Năm xuất bản:</td>
                <td><input type="number" name="publicationYear" value="${book.publicationYear}"></td>
            </tr>
            <tr>
                <td>Thể loại:</td>
                <td>
                    <select name="categoryId" required>
                        <c:forEach items="${categoryList}" var="category">
                            <%-- Dùng JSTL để tự động chọn đúng category cũ của sách --%>
                            <option value="${category.id}" ${category.id == book.categoryId ? 'selected' : ''}>
                                ${category.name}
                            </option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Link ảnh bìa:</td>
                <td><input type="text" name="coverImage" size="50" value="${book.coverImage}"></td>
            </tr>
            <tr>
                <td>Mô tả:</td>
                <td><textarea name="description" rows="5" cols="50">${book.description}</textarea></td>
            </tr>
            <tr>
                <td colspan="2"><button type="submit">Lưu Thay Đổi</button></td>
            </tr>
        </table>
    </form>
</body>
</html>