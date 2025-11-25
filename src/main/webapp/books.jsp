<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tất Cả Sách - Nhà Sách Online</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/books.css">
</head>

<body>

    <jsp:include page="header.jsp" />

    <main class="shop-container">

        <div class="shop-header">
            <h2 class="section-title"><i class="fa-solid fa-book"></i> Tất Cả Sách</h2>
            <form action="${pageContext.request.contextPath}/books" method="get" class="search-bar">
                <input type="text" name="search" placeholder="Tìm sách theo tên, tác giả..." value="${searchKeyword}">
                <button type="submit"><i class="fa-solid fa-search"></i></button>
            </form>
        </div>

        <div class="shop-main">

            <aside class="sidebar">
                <h3>Thể loại</h3>
                <ul class="category-list">
                    <li>
                        <a href="${pageContext.request.contextPath}/books" class="${categoryId == 0 ? 'active' : ''}">Tất cả sách</a>
                    </li>
                    <c:forEach items="${categoryList}" var="cat">
                        <li>
                            <a href="${pageContext.request.contextPath}/books?categoryId=${cat.id}" class="${categoryId == cat.id ? 'active' : ''}">
                                ${cat.name}
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </aside>

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

                        <form class="add-to-cart-form" data-id="${book.id}">
                             <c:choose>
                                <c:when test="${book.stock > 0}">
                                    <button type="button" class="btn-cart">
                                        <i class="fa fa-cart-plus"></i> Thêm vào giỏ
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button type="button" class="btn-cart" disabled style="background-color: #ccc; cursor: not-allowed;">
                                        Hết hàng
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </form>
                    </div>
                </c:forEach>

                <c:if test="${empty bookList}">
                    <p class="no-result">Không tìm thấy sản phẩm nào.</p>
                </c:if>
            </section>
        </div>

        <%
            int total = (request.getAttribute("totalPages") != null) ? (Integer) request.getAttribute("totalPages") : 1;
            int current = (request.getAttribute("currentPage") != null) ? (Integer) request.getAttribute("currentPage") : 1;
            int start = Math.max(1, current - 2);
            int end = Math.min(total, current + 2);
            if (current <= 3) end = Math.min(5, total);
            if (current >= total - 2) start = Math.max(1, total - 4);
        %>

        <c:if test="${totalPages > 1}">
            <nav class="pagination">
                <ul>
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

                    <c:if test="${currentPage < totalPages}">
                        <li><a href="?page=${currentPage + 1}">»</a></li>
                    </c:if>
                </ul>
            </nav>
        </c:if>

    </main>

    <jsp:include page="footer.jsp" />

    <script>
    document.addEventListener("DOMContentLoaded", function() {
        // Chọn tất cả các nút có class .btn-cart bên trong form .add-to-cart-form
        const buttons = document.querySelectorAll(".add-to-cart-form .btn-cart");

        buttons.forEach(btn => {
            btn.addEventListener("click", function(e) {
                e.preventDefault(); // Chặn hành vi mặc định
                
                // Tìm form cha của nút này
                const form = btn.closest("form");
                addToCartAJAX(form);
            });
        });
    });

    async function addToCartAJAX(form) {
        // Lấy Book ID từ attribute data-id của form
        const bookId = form.getAttribute("data-id");
        // Trang danh sách luôn thêm số lượng là 1
        const quantity = 1;

        if (!bookId) {
            showToast("❌ Lỗi: Không tìm thấy ID sách");
            return;
        }

        try {
            const response = await fetch("${pageContext.request.contextPath}/add-to-cart", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: "bookId=" + encodeURIComponent(bookId) + "&quantity=" + encodeURIComponent(quantity)
            });

            const text = await response.text();
            const result = parseInt(text);

            if (result === -1) {
                showToast("❌ Rất tiếc! Số lượng trong kho không đủ.");
            } else if (result > 0) {
                // Update Badge
                const badge = document.querySelector(".cart-count");
                if (badge) {
                    badge.textContent = result;
                    badge.classList.add("bump");
                    setTimeout(() => badge.classList.remove("bump"), 200);
                }
                showToast("✅ Đã thêm vào giỏ hàng!");
            } else {
                showToast("⚠️ Có lỗi xảy ra.");
            }

        } catch (e) {
            console.error(e);
            showToast("❌ Lỗi kết nối!");
        }
    }

    function showToast(message) {
        const existingToast = document.querySelector(".toast-message");
        if (existingToast) existingToast.remove();

        const toast = document.createElement("div");
        toast.className = "toast-message";
        toast.textContent = message;
        if (message.includes("❌")) toast.style.backgroundColor = "#e74c3c";

        document.body.appendChild(toast);
        setTimeout(() => toast.classList.add("show"), 10);
        setTimeout(() => {
            toast.classList.remove("show");
            setTimeout(() => toast.remove(), 300);
        }, 3000);
    }
    </script>
</body>
</html>