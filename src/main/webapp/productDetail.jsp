<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${book.title}</title>
<style>
    .container { display: flex; gap: 30px; }
    .book-image { flex: 1; }
    .book-details { flex: 2; }
</style>
</head>
<body>
    <%-- Include file header chung (nếu có) --%>
    <jsp:include page="header.jsp" /> 

    <h1>Chi tiết sản phẩm</h1>
    <hr>
    
    <c:if test="${not empty book}">
        <div class="container">
            <div class="book-image">
                <img src="${book.coverImage}" alt="${book.title}" style="max-width: 100%;">
            </div>
            <div class="book-details">
                <h2>${book.title}</h2>
                <p><strong>Tác giả:</strong> ${book.author}</p>
                <p><strong>Năm xuất bản:</strong> ${book.publicationYear}</p>
                <h3>Giá: ${book.price} VNĐ</h3>
                <p><strong>Số lượng trong kho:</strong> ${book.stock}</p>
                <h4>Mô tả:</h4>
                <p>${book.description}</p>
                
                <hr>
                
                <%-- Form để thêm vào giỏ hàng (sẽ làm ở bước sau) --%>
                <form action="add-to-cart" method="post">
                    <input type="hidden" name="bookId" value="${book.id}">
                    Số lượng: <input type="number" name="quantity" value="1" min="1" max="${book.stock}">
                    <button type="submit">Thêm vào giỏ hàng</button>
                </form>
            </div>
        </div>
    </c:if>
    
    <c:if test="${empty book}">
        <p>Không tìm thấy thông tin sách.</p>
    </c:if>

    <br>
    <a href="home">Quay lại trang chủ</a>

</body>
</html>