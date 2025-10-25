<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${book.title}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <%-- // thêm: Link CDN cho Font Awesome để dùng icon sao --%>
    <link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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

            <%-- ================= PHẦN ĐÁNH GIÁ MỚI ================= --%>
            <div class="reviews-section">
                <h2>Đánh giá sản phẩm</h2>

                <%-- Hiển thị danh sách đánh giá --%>
                <c:if test="${empty reviewList}">
                    <p>Chưa có đánh giá nào cho sản phẩm này.</p>
                </c:if>
                <c:if test="${not empty reviewList}">
                    <c:forEach items="${reviewList}" var="review">
                        <div class="review-item">
                            <p><strong>${review.user.fullname}</strong></p> <%-- Lấy tên từ User object --%>
                            <div class="rating-stars">
                                <c:forEach begin="1" end="5" var="i">
                                    <i class="fa-${i <= review.rating ? 'solid' : 'regular'} fa-star"></i> <%-- Font Awesome star icons (solid for rated, regular for unrated) --%>
                                </c:forEach>
                            </div>
                            <p class="comment">${review.comment}</p>
                            <p class="date"><fmt:formatDate value="${review.createdAt}" pattern="dd/MM/yyyy HH:mm"/></p>
                        </div>
                    </c:forEach>
                </c:if>

                <hr>

                <%-- Form thêm đánh giá mới (Chỉ hiển thị khi đã đăng nhập) --%>
                <c:set var="loggedInUser" value="${sessionScope.loggedInUser}" />
                <c:if test="${not empty loggedInUser}">
                    <div class="add-review-form">
                        <h3>Viết đánh giá của bạn</h3>
                        <form action="${pageContext.request.contextPath}/add-review" method="post">
                            <input type="hidden" name="bookId" value="${book.id}">
                            <div class="form-group">
                                <label>Đánh giá:</label>
                                <div class="rating-input"> <%-- CSS trick để làm rating sao --%>
                                    <%-- Radio buttons đảo ngược để CSS hover hoạt động đúng --%>
                                    <input type="radio" id="star5" name="rating" value="5" required/><label for="star5" title="5 stars"><i class="fas fa-star star"></i></label>
                                    <input type="radio" id="star4" name="rating" value="4"/><label for="star4" title="4 stars"><i class="fas fa-star star"></i></label>
                                    <input type="radio" id="star3" name="rating" value="3"/><label for="star3" title="3 stars"><i class="fas fa-star star"></i></label>
                                    <input type="radio" id="star2" name="rating" value="2"/><label for="star2" title="2 stars"><i class="fas fa-star star"></i></label>
                                    <input type="radio" id="star1" name="rating" value="1"/><label for="star1" title="1 star"><i class="fas fa-star star"></i></label>
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
            <%-- ================= KẾT THÚC PHẦN ĐÁNH GIÁ ================= --%>

        </c:if>

        <c:if test="${empty book}">
            <p>Không tìm thấy thông tin sách.</p>
        </c:if>

        <br>
         <%-- Sửa link quay lại trỏ về trang cửa hàng --%>
        <a href="${pageContext.request.contextPath}/books">Quay lại Cửa hàng</a>
    </div>
    <jsp:include page="footer.jsp" />
</body>
</html>