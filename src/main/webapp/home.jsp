<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ - Nhà Sách Online</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<br>
<br>
<body>
    <jsp:include page="header.jsp" />

    <div class="container">
 
        <div class="main-container">
            <aside class="sidebar">
                <h3>Thể loại</h3>
                <ul class="category-list">
                    <li><a href="${pageContext.request.contextPath}/home">Tất cả sách</a></li>
                    <c:forEach items="${categoryList}" var="cat">
                        <li><a href="${pageContext.request.contextPath}/home?categoryId=${cat.id}">${cat.name}</a></li>
                    </c:forEach>
                </ul>
            </aside>

            <main class="content">
                <form action="${pageContext.request.contextPath}/home" method="get" style="display: flex; gap: 10px; margin-bottom: 20px;">
                    <input type="text" name="search" style="flex-grow: 1;" placeholder="Nhập tên sách cần tìm..." value="${searchKeyword}">
                    <button type="submit">Tìm kiếm</button>
                </form>
                
           
                <div class="book-list">
                    <c:forEach items="${bookList}" var="book">
                        <a href="product-detail?id=${book.id}" class="detail-btn"><div class="book-item">
                            <img src="${pageContext.request.contextPath}/${book.coverImage}" alt="${book.title}">
                            <h4>${book.title}</h4>
                            <p>Tác giả: ${book.author}</p>
                            <p class="price"><fmt:formatNumber type="number" value="${book.price}" /> VNĐ</p>
                        </div>
                        </a>
                    </c:forEach>
                    <c:if test="${empty bookList}">
                        <p>Không tìm thấy sản phẩm nào phù hợp.</p>
                    </c:if>
                </div>
            </main>
        </div>
    </div>
    <jsp:include page="footer.jsp" />
</body>
</html>

