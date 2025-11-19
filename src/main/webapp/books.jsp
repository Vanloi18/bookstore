<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tất Cả Sách - Nhà Sách Online</title>

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout/header.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/books.css">

</head>

<body>

    <!-- Header -->
    <jsp:include page="header.jsp" />

    <main class="shop-container">

        <!-- Header khu vực Sách -->
        <div class="shop-header">
            <h2 class="section-title"><i class="fa-solid fa-book"></i> Tất Cả Sách</h2>
<!-- Tìm sách  -->
            <form action="${pageContext.request.contextPath}/books" method="get" class="search-bar">
                <input type="text" name="search"
                       placeholder="Tìm sách theo tên, tác giả..."
                       value="${searchKeyword}">
                <button type="submit"><i class="fa-solid fa-search"></i></button>
            </form>
        </div>

        <div class="shop-main">

            <!-- Sidebar -->
            <aside class="sidebar">
                <h3>Thể loại</h3>
                <ul class="category-list">
                    <li>
                        <a href="${pageContext.request.contextPath}/books"
                           class="${categoryId == 0 ? 'active' : ''}">Tất cả sách</a>
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

            <!-- Sách -->
            <section class="book-grid">

                <c:forEach items="${bookList}" var="book">
                    <div class="book-card">

                        <a href="${pageContext.request.contextPath}/product-detail?id=${book.id}">
                            <img src="${pageContext.request.contextPath}/${book.coverImage}" alt="${book.title}">
                        </a>

                        <h4>${book.title}</h4>
                        <p class="author">${book.author}</p>

                        <p class="price">
                            <fmt:formatNumber value="${book.price}" type="number"/> VNĐ
                        </p>

                        <!-- FORM THÊM GIỎ HÀNG BẰNG AJAX -->
                        <form class="add-to-cart-form" data-id="${book.id}">
                            <button type="button" class="btn-cart">
                                <i class="fa fa-cart-plus"></i> Thêm vào giỏ
                            </button>
                        </form>

                    </div>
                </c:forEach>

                <c:if test="${empty bookList}">
                    <p class="no-result">Không tìm thấy sản phẩm nào.</p>
                </c:if>

            </section>
        </div>

        <!-- PHÂN TRANG RÚT GỌN -->
        <%
            int total = (Integer) request.getAttribute("totalPages");
            int current = (Integer) request.getAttribute("currentPage");

            int start = Math.max(1, current - 2);
            int end = Math.min(total, current + 2);

            if (current <= 3) end = Math.min(5, total);
            if (current >= total - 2) start = Math.max(1, total - 4);
        %>

        <c:if test="${totalPages > 1}">
            <nav class="pagination">
                <ul>

                    <!-- Previous -->
                    <c:if test="${currentPage > 1}">
                        <li><a href="?page=${currentPage - 1}">«</a></li>
                    </c:if>

                    <% if (start > 1) { %>
                        <li><a href="?page=1">1</a></li>
                        <li><span>...</span></li>
                    <% } %>

                    <% for (int i = start; i <= end; i++) { %>
                        <li class="<%= (i == current) ? "active" : "" %>">
                            <% if (i == current) { %>
                                <span><%= i %></span>
                            <% } else { %>
                                <a href="?page=<%= i %>"><%= i %></a>
                            <% } %>
                        </li>
                    <% } %>

                    <% if (end < total) { %>
                        <li><span>...</span></li>
                        <li><a href="?page=<%= total %>"><%= total %></a></li>
                    <% } %>

                    <!-- Next -->
                    <c:if test="${currentPage < totalPages}">
                        <li><a href="?page=${currentPage + 1}">»</a></li>
                    </c:if>

                </ul>
            </nav>
        </c:if>

    </main>

    <jsp:include page="footer.jsp" />

    <!-- ======================= AJAX ADD TO CART ======================= -->
    <script>
    document.querySelectorAll(".add-to-cart-form").forEach(form => {
        const btn = form.querySelector("button");

        btn.addEventListener("click", async function () {
            const bookId = form.getAttribute("data-id");

            try {
                const response = await fetch("${pageContext.request.contextPath}/add-to-cart", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: "bookId=" + encodeURIComponent(bookId) + "&quantity=1"
                });

                const text = await response.text();
                const count = parseInt(text) || 0;

                // Cập nhật badge giỏ hàng trên header
                const badge = document.querySelector(".cart-count");
                if (badge) {
                    badge.textContent = count;
                    badge.classList.add("bump");
                    setTimeout(() => badge.classList.remove("bump"), 200);
                }

                showToast("Đã thêm vào giỏ hàng!");

            } catch (e) {
                showToast("Có lỗi khi thêm vào giỏ hàng!");
            }
        });
    });

    function showToast(message) {
        const toast = document.createElement("div");
        toast.className = "toast-message";
        toast.textContent = message;
        document.body.appendChild(toast);

        setTimeout(() => toast.classList.add("show"), 10);

        setTimeout(() => {
            toast.classList.remove("show");
            setTimeout(() => toast.remove(), 300);
        }, 2000);
    }
    </script>

</body>
</html>
