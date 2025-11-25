<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${book.title}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout/header.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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

                    <%-- Form Thêm vào giỏ hàng --%>
                    <form id="addToCartForm" action="${pageContext.request.contextPath}/add-to-cart" method="post">
                        <input type="hidden" name="bookId" value="${book.id}">
                        <label>Số lượng:</label>
                        <input type="number" name="quantity" value="1" min="1" max="${book.stock}" class="quantity-input" required>
                        
                        <c:choose>
                            <c:when test="${book.stock > 0}">
                                <button type="submit">Thêm vào giỏ hàng</button>
                            </c:when>
                            <c:otherwise>
                                <button type="button" disabled style="background-color: gray; cursor: not-allowed;">Hết hàng</button>
                            </c:otherwise>
                        </c:choose>
                    </form>
                </div>
            </div>

            <%-- PHẦN ĐÁNH GIÁ --%>
            <div class="reviews-section">
                <h2>Đánh giá sản phẩm</h2>
                <c:if test="${empty reviewList}">
                    <p>Chưa có đánh giá nào cho sản phẩm này.</p>
                </c:if>
                <c:if test="${not empty reviewList}">
                    <c:forEach items="${reviewList}" var="review">
                        <div class="review-item">
                            <p><strong>${review.user.fullname}</strong></p>
                            <div class="rating-stars">
                                <c:forEach begin="1" end="5" var="i">
                                    <i class="fa-${i <= review.rating ? 'solid' : 'regular'} fa-star"></i>
                                </c:forEach>
                            </div>
                            <p class="comment">${review.comment}</p>
                            <p class="date"><fmt:formatDate value="${review.createdAt}" pattern="dd/MM/yyyy HH:mm" timeZone="Asia/Ho_Chi_Minh"/></p>
                        </div>
                    </c:forEach>
                </c:if>
                <hr>
                
                <%-- Form viết đánh giá --%>
                <c:set var="loggedInUser" value="${sessionScope.loggedInUser}" />
                <c:if test="${not empty loggedInUser}">
                    <div class="add-review-form">
                        <h3>Viết đánh giá của bạn</h3>
                        <form action="${pageContext.request.contextPath}/add-review" method="post">
                            <input type="hidden" name="bookId" value="${book.id}">
                            <div class="form-group">
                                <label>Đánh giá:</label>
                                <div class="rating-input">
                                    <input type="radio" id="star5" name="rating" value="5" required /><label for="star5"><i class="fas fa-star star"></i></label>
                                    <input type="radio" id="star4" name="rating" value="4" /><label for="star4"><i class="fas fa-star star"></i></label>
                                    <input type="radio" id="star3" name="rating" value="3" /><label for="star3"><i class="fas fa-star star"></i></label>
                                    <input type="radio" id="star2" name="rating" value="2" /><label for="star2"><i class="fas fa-star star"></i></label>
                                    <input type="radio" id="star1" name="rating" value="1" /><label for="star1"><i class="fas fa-star star"></i></label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="comment">Nhận xét (tùy chọn):</label>
                                <textarea id="comment" name="comment" rows="4"></textarea>
                            </div>
                            <button type="submit">Gửi đánh giá</button>
                        </form>
                    </div>
                </c:if>
                <c:if test="${empty loggedInUser}">
                    <p><a href="${pageContext.request.contextPath}/login.jsp">Đăng nhập</a> để viết đánh giá.</p>
                </c:if>
            </div>
        </c:if>

        <c:if test="${empty book}">
            <p>Không tìm thấy thông tin sách.</p>
        </c:if>

        <br>
        <a href="${pageContext.request.contextPath}/books">Quay lại Cửa hàng</a>
    </div>
    
    <jsp:include page="footer.jsp" />

    <%-- SCRIPT XỬ LÝ GIỎ HÀNG RIÊNG CHO TRANG CHI TIẾT --%>
    <script>
    document.addEventListener("DOMContentLoaded", function() {
        const form = document.getElementById("addToCartForm");
        
        if (form) {
            form.addEventListener("submit", async function(e) {
                e.preventDefault(); // Chặn load lại trang

                const bookId = form.querySelector("input[name='bookId']").value;
                const quantity = form.querySelector("input[name='quantity']").value;

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
                        // Cập nhật icon giỏ hàng
                        const badge = document.querySelector(".cart-count");
                        if (badge) {
                            badge.textContent = result;
                            badge.classList.add("bump");
                            setTimeout(() => badge.classList.remove("bump"), 200);
                        }
                        showToast("✅ Đã thêm vào giỏ hàng!");
                    } else {
                        showToast("⚠️ Có lỗi xảy ra, vui lòng thử lại.");
                    }
                } catch (err) {
                    console.error(err);
                    showToast("❌ Lỗi kết nối server!");
                }
            });
        }
    });

    // Hàm hiển thị thông báo
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