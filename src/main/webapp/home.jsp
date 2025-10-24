<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookStore - Khám Phá Thế Giới Tri Thức</title>

    <!-- Bootstrap & Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    
    <!-- Custom Apple-style CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
</head>
<body class="bg-light text-dark">

    <jsp:include page="header.jsp" />

    <!-- HERO SECTION -->
    <section class="hero text-center text-white d-flex align-items-center justify-content-center flex-column">
        <h1 class="display-4 fw-semibold">Khám Phá Thế Giới Tri Thức</h1>
        <p class="lead mt-3 mb-4 w-75 mx-auto">Tìm thấy cuốn sách yêu thích của bạn từ hàng ngàn tựa sách đa dạng thể loại — từ văn học đến khoa học, từ kinh doanh đến truyện thiếu nhi.</p>
        <a href="#shop-section" class="btn btn-dark rounded-pill px-4 py-2 shadow-sm">Khám Phá Ngay</a>
    </section>

    <!-- ABOUT -->
    <section class="container text-center my-5">
        <h2 class="fw-bold mb-4">Về BookStore</h2>
        <p class="text-secondary fs-5 w-75 mx-auto">
            BookStore tự hào là điểm đến tin cậy cho những người yêu sách. Chúng tôi cam kết mang đến những đầu sách chất lượng, cập nhật liên tục với giá cả phải chăng, cùng trải nghiệm mua sắm trực tuyến tiện lợi và nhanh chóng nhất.
        </p>
    </section>

    <!-- FEATURED BOOKS -->
    <section class="container my-5">
        <h2 class="fw-bold text-center mb-5">Sách Nổi Bật</h2>
        <div class="row g-4">
            <c:if test="${not empty bookList}">
                <c:forEach items="${bookList}" var="book" begin="0" end="7">
                    <div class="col-6 col-md-3">
                        <div class="card border-0 shadow-sm book-card h-100 text-center p-3">
                            <a href="${pageContext.request.contextPath}/product-detail?id=${book.id}">
                                <img src="${pageContext.request.contextPath}/${book.coverImage}" class="img-fluid rounded mb-3" alt="${book.title}">
                            </a>
                            <h5 class="fw-semibold">${book.title}</h5>
                            <p class="text-muted mb-1">${book.author}</p>
                            <p class="text-dark fw-bold mb-2"><fmt:formatNumber value="${book.price}" /> VNĐ</p>
                            <a href="${pageContext.request.contextPath}/product-detail?id=${book.id}" class="btn btn-outline-dark rounded-pill px-3 py-1">Xem chi tiết</a>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
            <c:if test="${empty bookList}">
                <p class="text-center text-secondary">Hiện chưa có sách nổi bật nào.</p>
            </c:if>
        </div>
    </section>

    <!-- WHY CHOOSE US -->
    <section class="bg-white py-5">
        <div class="container text-center">
            <h2 class="fw-bold mb-5">Tại Sao Chọn BookStore?</h2>
            <div class="row g-4">
                <div class="col-md-3">
                    <i class="fas fa-shipping-fast fa-2x mb-3 text-dark"></i>
                    <h5>Giao Hàng Nhanh Chóng</h5>
                    <p class="text-muted">Cam kết giao sách đến tay bạn trong thời gian ngắn nhất.</p>
                </div>
                <div class="col-md-3">
                    <i class="fas fa-hand-holding-usd fa-2x mb-3 text-dark"></i>
                    <h5>Giá Cả Cạnh Tranh</h5>
                    <p class="text-muted">Luôn có những ưu đãi hấp dẫn và mức giá tốt nhất.</p>
                </div>
                <div class="col-md-3">
                    <i class="fas fa-book-reader fa-2x mb-3 text-dark"></i>
                    <h5>Đa Dạng Thể Loại</h5>
                    <p class="text-muted">Hàng ngàn đầu sách từ các thể loại khác nhau.</p>
                </div>
                <div class="col-md-3">
                    <i class="fas fa-headphones-alt fa-2x mb-3 text-dark"></i>
                    <h5>Hỗ Trợ 24/7</h5>
                    <p class="text-muted">Đội ngũ tận tâm sẵn sàng hỗ trợ bạn.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- SHOP SECTION -->
    <section class="container py-5" id="shop-section">
        <h2 class="fw-bold text-center mb-4">Tất Cả Sách</h2>
        <div class="row">
            <!-- SIDEBAR -->
            <div class="col-md-3 mb-4">
                <div class="list-group shadow-sm">
                    <a href="${pageContext.request.contextPath}/home#shop-section" class="list-group-item list-group-item-action ${categoryId == 0 ? 'active' : ''}">Tất cả sách</a>
                    <c:forEach items="${categoryList}" var="cat">
                        <a href="${pageContext.request.contextPath}/home?categoryId=${cat.id}#shop-section"
                           class="list-group-item list-group-item-action ${categoryId == cat.id ? 'active' : ''}">
                            ${cat.name}
                        </a>
                    </c:forEach>
                </div>
            </div>

            <!-- MAIN CONTENT -->
            <div class="col-md-9">
                <form class="d-flex mb-4" method="get" action="${pageContext.request.contextPath}/home#shop-section">
                    <input type="text" class="form-control" name="search" placeholder="Tìm tên sách..." value="${searchKeyword}">
                    <button class="btn btn-dark ms-2 px-4" type="submit">Tìm</button>
                </form>

                <div class="row g-4">
                    <c:forEach items="${bookList}" var="book">
                        <div class="col-6 col-md-4">
                            <div class="card border-0 shadow-sm book-card text-center p-3 h-100">
                                <a href="${pageContext.request.contextPath}/product-detail?id=${book.id}">
                                    <img src="${pageContext.request.contextPath}/${book.coverImage}" class="img-fluid rounded mb-3" alt="${book.title}">
                                </a>
                                <h6 class="fw-semibold">${book.title}</h6>
                                <p class="text-muted mb-1">${book.author}</p>
                                <p class="fw-bold text-dark"><fmt:formatNumber value="${book.price}" /> VNĐ</p>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- PAGINATION -->
                <c:if test="${totalPages > 1}">
                    <nav class="mt-5">
                        <ul class="pagination justify-content-center">
                            <c:if test="${currentPage > 1}">
                                <li class="page-item"><a class="page-link" href="?page=${currentPage - 1}">&laquo;</a></li>
                            </c:if>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}">${i}</a>
                                </li>
                            </c:forEach>
                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item"><a class="page-link" href="?page=${currentPage + 1}">&raquo;</a></li>
                            </c:if>
                        </ul>
                    </nav>
                </c:if>
            </div>
        </div>
    </section>

    <!-- CTA SUBSCRIBE -->
    <section class="text-center bg-dark text-white py-5">
        <div class="container">
            <h3 class="fw-semibold mb-3">Đừng Bỏ Lỡ Ưu Đãi Đặc Biệt!</h3>
            <p class="text-secondary mb-4">Đăng ký nhận bản tin để cập nhật sách mới & nhận mã giảm giá 10%.</p>
            <form class="d-flex justify-content-center flex-wrap" action="${pageContext.request.contextPath}/subscribe" method="post">
                <input type="text" name="name" class="form-control w-25 mb-2 me-2" placeholder="Họ và Tên" required>
                <input type="email" name="email" class="form-control w-25 mb-2 me-2" placeholder="Email của bạn" required>
                <button class="btn btn-light text-dark rounded-pill px-4" type="submit">Đăng ký ngay</button>
            </form>
        </div>
    </section>

    <jsp:include page="footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
