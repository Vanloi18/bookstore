<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>	
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cửa Hàng - Nhà Sách Online</title>

    <!-- CSS chính -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/books.css">

    <!-- FontAwesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>

<body>
    <!-- Header -->
    <jsp:include page="header.jsp" />

    <main class="shop-container">
        <div class="shop-header">
            <h2 class="section-title"><i class="fa-solid fa-book"></i> Tất Cả Sách</h2>

            <form action="${pageContext.request.contextPath}/books" method="get" class="search-bar">
                <input type="text" name="search"
                       placeholder="Tìm sách theo tên, tác giả..."
                       value="${searchKeyword}">
                <button type="submit"><i class="fa-solid fa-search"></i></button>
            </form>
        </div>

        <div class="shop-main">
            <!-- Sidebar danh mục -->
            <aside class="sidebar">
                <h3>Thể loại</h3>
                <ul class="category-list">
                    <li>
                        <a href="${pageContext.request.contextPath}/books"
                           class="${categoryId == 0 ? 'active' : ''}">
                           Tất cả sách
                        </a>
                    </li>
                    <c:forEach items="${categoryList}" var="cat">
                        <li>
                            <a href="${pageContext.request.contextPath}/books?categoryId=${cat.id}"
                               class="${categoryId == cat.id ? 'active' : ''}">
                               ${cat.name}
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </aside>

            <!-- Nội dung sách -->
            <section class="book-grid">
                <c:forEach items="${bookList}" var="book">
                    <div class="book-card">
                        <a href="${pageContext.request.contextPath}/product-detail?id=${book.id}">
                            <img src="${pageContext.request.contextPath}/${book.coverImage}" 
                                 alt="${book.title}">
                        </a>
                        <h4>${book.title}</h4>
                        <p class="author">${book.author}</p>
                        <p class="price">
                            <fmt:formatNumber value="${book.price}" type="number"/> VNĐ
                        </p>
                     <%-- Nút Thêm vào Giỏ hàng --%>
	<form action="${pageContext.request.contextPath}/add-to-cart" method="post" style="display:inline;">
		<input type="hidden" name="bookId" value="${book.id}">
		<input type="hidden" name="quantity" value="1"> <%-- Mặc định thêm 1 sản phẩm --%>
		<button type="submit" class="btn btn-dark rounded-pill px-3 py-1 mt-auto">
			<i class="fas fa-shopping-cart me-1"></i> Thêm vào giỏ
		</button>
	</form>
                    </div>
                </c:forEach>

                <c:if test="${empty bookList}">
                    <p class="no-result">Không tìm thấy sản phẩm nào phù hợp.</p>
                </c:if>
            </section>
        </div>

        <!-- Phân trang -->
        <c:if test="${totalPages > 1}">
            <nav class="pagination">
                <ul>
                    <c:if test="${currentPage > 1}">
                        <li>
                            <a href="?page=${currentPage - 1}
                            ${categoryId > 0 ? '&categoryId=' + categoryId : '' }
                            ${not empty searchKeyword ? '&search=' + searchKeyword : ''}">
                            &laquo; Trước
                            </a>
                        </li>
                    </c:if>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="${i == currentPage ? 'active' : ''}">
                            <a href="?page=${i}
                            ${categoryId > 0 ? '&categoryId=' + categoryId : '' }
                            ${not empty searchKeyword ? '&search=' + searchKeyword : ''}">
                            ${i}
                            </a>
                        </li>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <li>
                            <a href="?page=${currentPage + 1}
                            ${categoryId > 0 ? '&categoryId=' + categoryId : '' }
                            ${not empty searchKeyword ? '&search=' + searchKeyword : ''}">
                            Sau &raquo;
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </c:if>
    </main>

    <!-- Footer -->
    <jsp:include page="footer.jsp" />
</body>
</html>
