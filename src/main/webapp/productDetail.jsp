<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${book.title}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="header.jsp" /> 

    <div class="container">
        <h1>Chi tiết sản phẩm</h1>
        <hr>
        
        <c:if test="${not empty book}">
            <div class="product-detail-container">
                <div class="product-image">
                    <img src="${pageContext.request.contextPath}/${book.coverImage}" alt="${book.title}">
                </div>
                <div class="product-details">
                    <h2>${book.title}</h2>
                    <p><strong>Tác giả:</strong> ${book.author}</p>
                    <p><strong>Năm xuất bản:</strong> ${book.publicationYear}</p>
                    <h3><fmt:formatNumber type="number" value="${book.price}" /> VNĐ</h3>
                    <p><strong>Số lượng trong kho:</strong> ${book.stock}</p>
                    <h4>Mô tả:</h4>
                    <p>${book.description}</p>
                    
                    <form action="${pageContext.request.contextPath}/add-to-cart" method="post" class="add-to-cart-form">
                        <input type="hidden" name="bookId" value="${book.id}">
                        <label>Số lượng:</label> 
                        <input type="number" name="quantity" value="1" min="1" max="${book.stock}" class="quantity-input">
                        <button type="submit">Thêm vào giỏ hàng</button>
                    </form>
                </div>
            </div>
        </c:if>
        
        <c:if test="${empty book}">
            <p>Không tìm thấy thông tin sách.</p>
        </c:if>

        <br>
        <a href="${pageContext.request.contextPath}/home">Quay lại trang chủ</a>
    </div>
	<jsp:include page="footer.jsp" />
</body>
</html>

