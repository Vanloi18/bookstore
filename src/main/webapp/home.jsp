<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Nhà Sách Online - Khám Phá Thế Giới Qua Từng Trang Sách</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout/header.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/home.css">

</head>

<body>
	<jsp:include page="header.jsp" />


		<!-- Banner Slider Section -->
		<section class="banner-slider">
			<div class="slider-track">
				<div class="slide">
					<img
						src="${pageContext.request.contextPath}/images/banner1.jpg"
						alt="Banner 1">
				</div>
				<div class="slide">
					<img
						src="${pageContext.request.contextPath}/images/banner2.jpg"
						alt="Banner 2">
				</div>
				<div class="slide">
					<img
						src="${pageContext.request.contextPath}/images/banner3.jpg"
						alt="Banner 3">
				</div>
			</div>

			<!-- Nút điều hướng -->
			<button class="prev">&#10094;</button>
			<button class="next">&#10095;</button>

			<!-- Dấu chấm tròn -->
			<div class="dots">
				<span class="dot active"></span> <span class="dot"></span> <span
					class="dot"></span>
			</div>
		</section>

		<section class="section about-section">
			<h2 class="section-title">Về BookWorld</h2>
			<p>BookWorld tự hào là điểm đến tin cậy cho những người yêu sách.
				Chúng tôi cam kết mang đến những đầu sách chất lượng, cập nhật liên
				tục với giá cả phải chăng, cùng trải nghiệm mua sắm trực tuyến tiện
				lợi và nhanh chóng nhất.</p>
		</section>
<div class="container">
		<section class="section" id="featured-books-section">
			<h2 class="section-title">Sách Nổi Bật</h2>

			<div class="book-grid">
				<c:if test="${not empty featuredBookList}">
					<c:forEach items="${featuredBookList}" var="book">
						<div class="book-card">
							<a
								href="${pageContext.request.contextPath}/product-detail?id=${book.id}">
								<img src="${pageContext.request.contextPath}/${book.coverImage}"
								alt="${book.title}">
							</a>
							<h4>${book.title}</h4>
							<p class="author">${book.author}</p>
							<p class="price">
								<fmt:formatNumber value="${book.price}" type="number" />
								VNĐ
							</p>
							<%-- Nút Thêm vào Giỏ hàng --%>
	                  <form class="home-add-cart" data-id="${book.id}">
    <button type="button" class="btn btn-dark rounded-pill px-3 py-1 mt-auto">
        <i class="fas fa-shopping-cart me-1"></i> Thêm vào giỏ
    </button>
</form>

	                					</div>
					</c:forEach>
				</c:if>

				<c:if test="${empty featuredBookList}">
					<p class="no-books-message">Hiện chưa có sách bán chạy nào.</p>
				</c:if>
			</div>

			<div style="text-align: center; margin-top: 30px;">
				<a href="${pageContext.request.contextPath}/books"
					class="cta-button">Xem Tất Cả Sách</a>
			</div>
		</section>
</div>
	<%-- Các Section của Landing Page --%>
		<section class="hero-section">
			<h2>Khám Phá Thế Giới Tri Thức Vô Tận Với Nhiều Ưu Đãi</h2>
			<p>Tìm thấy cuốn sách yêu thích của bạn từ hàng ngàn tựa sách đa
				dạng thể loại, từ văn học đến khoa học, từ kinh doanh đến truyện
				thiếu nhi.</p>
					<p> UP TO 50%</p>
			<a href="${pageContext.request.contextPath}/books" class="cta-button">KHÁM
				PHÁ SÁCH NGAY</a>
		</section>
<div class="container">
		<section class="section" id="featured-books-section">
			<h2 class="section-title">Sách Bán Chạy</h2>

			<%-- (1) SỬA LỖI: Bỏ <section class="book-grid"> lồng nhau --%>
			<div class="book-grid">
				<c:if test="${not empty featuredBookList}">
					<c:forEach items="${featuredBookList}" var="book">
						<div class="book-card">
							<a
								href="${pageContext.request.contextPath}/product-detail?id=${book.id}">
								<img src="${pageContext.request.contextPath}/${book.coverImage}"
								alt="${book.title}">
							</a>
							<h4>${book.title}</h4>
							<p class="author">${book.author}</p>
							<p class="price">
								<fmt:formatNumber value="${book.price}" type="number" />
								VNĐ
							</p>
							<%-- Nút Thêm vào Giỏ hàng --%>
	                  <form class="home-add-cart" data-id="${book.id}">
    <button type="button" class="btn btn-dark rounded-pill px-3 py-1 mt-auto">
        <i class="fas fa-shopping-cart me-1"></i> Thêm vào giỏ
    </button>
</form>

	                					</div>
					</c:forEach>
					<%-- (2) SỬA LỖI: Xóa bỏ <c:if empty> bị lồng sai (dead code) --%>
				</c:if>

				<%-- (4) TỐI ƯU: Thay thế style nội tuyến bằng class --%>
				<c:if test="${empty featuredBookList}">
					<p class="no-books-message">Hiện chưa có sách bán chạy nào.</p>
				</c:if>
			</div>

			<div style="text-align: center; margin-top: 30px;">
				<a href="${pageContext.request.contextPath}/books"
					class="cta-button">Xem Tất Cả Sách</a>
			</div>
		</section>
</div>
		<section class="section">
			<h2 class="section-title">Tại Sao Chọn BookStore?</h2>
			<div class="why-choose-us-grid">
				<div class="reason-item">
					<i class="fas fa-shipping-fast"></i>
					<h3>Giao Hàng Nhanh Chóng</h3>
					<p>Cam kết giao sách đến tay bạn trong thời gian ngắn nhất.</p>
				</div>
				<div class="reason-item">
					<i class="fas fa-hand-holding-usd"></i>
					<h3>Giá Cả Cạnh Tranh</h3>
					<p>Luôn có những ưu đãi hấp dẫn và mức giá tốt nhất cho bạn.</p>
				</div>
				<div class="reason-item">
					<i class="fas fa-book-reader"></i>
					<h3>Đa Dạng Thể Loại</h3>
					<p>Hàng ngàn đầu sách từ các thể loại khác nhau, luôn cập nhật.</p>
				</div>
				<div class="reason-item">
					<i class="fas fa-headphones-alt"></i>
					<h3>Hỗ Trợ Khách Hàng</h3>
					<p>Đội ngũ tận tâm sẵn sàng hỗ trợ bạn 24/7.</p>
				</div>
			</div>
		</section>

		<section class="section">
			<h2 class="section-title">Khách Hàng Nói Gì Về Chúng Tôi</h2>
			<div class="testimonial-grid">
				<div class="testimonial-item">
					<p>"Trang web rất dễ sử dụng, tôi đã tìm được cuốn sách mình
						cần chỉ trong vài phút. Dịch vụ giao hàng cũng rất nhanh!"</p>
					<span class="author">Nguyễn Thị Mai, Hà Nội</span>
				</div>
				<div class="testimonial-item">
					<p>"Tôi rất ấn tượng với sự đa dạng của các đầu sách tại
						BookStore. Giá cả cũng rất phải chăng, chắc chắn sẽ quay lại mua
						nữa."</p>
					<span class="author">Lê Văn Hùng, TP.HCM</span>
				</div>
				<div class="testimonial-item">
					<p>"Cuốn sách được đóng gói cẩn thận và giao đúng hẹn. Đây là
						địa chỉ mua sách online yêu thích của tôi từ bây giờ!"</p>
					<span class="author">Trần Thu Hương, Đà Nẵng</span>
				</div>
			</div>
		</section>

	<%-- Đóng container cho landing page sections --%>

	<jsp:include page="footer.jsp" />

	<%-- (3) TỐI ƯU: Chuyển JS ra file riêng --%>
	<script src="${pageContext.request.contextPath}/js/home-slider.js"></script>
	<script>
document.querySelectorAll(".home-add-cart").forEach(form => {
    const btn = form.querySelector("button");

    btn.addEventListener("click", async function () {
        const bookId = form.getAttribute("data-id");

        try {
            const response = await fetch("${pageContext.request.contextPath}/add-to-cart", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: "bookId=" + encodeURIComponent(bookId) + "&quantity=1"
            });

            const text = await response.text();
            const count = parseInt(text) || 0;

            // cập nhật badge giỏ hàng
            const badge = document.querySelector(".cart-count");
            if (badge) {
                badge.textContent = count;
                badge.classList.add("bump");
                setTimeout(() => badge.classList.remove("bump"), 200);
            }

            showToast("Đã thêm vào giỏ hàng!");

        } catch (e) {
            showToast("Lỗi không thêm được sản phẩm!");
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