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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
	<jsp:include page="header.jsp" />

	<%-- Các Section của Landing Page --%>
	<div class="container">
		<section class="hero-section">
			<h2>Khám Phá Thế Giới Tri Thức Vô Tận</h2>
			<p>Tìm thấy cuốn sách yêu thích của bạn từ hàng ngàn tựa sách đa
				dạng thể loại, từ văn học đến khoa học, từ kinh doanh đến truyện
				thiếu nhi.</p>
			<a href="${pageContext.request.contextPath}/books" class="cta-button">KHÁM
				PHÁ SÁCH NGAY</a>
		</section>

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
			<h2 class="section-title">Về BookStore</h2>
			<p>BookStore tự hào là điểm đến tin cậy cho những người yêu sách.
				Chúng tôi cam kết mang đến những đầu sách chất lượng, cập nhật liên
				tục với giá cả phải chăng, cùng trải nghiệm mua sắm trực tuyến tiện
				lợi và nhanh chóng nhất.</p>
		</section>

		<section class="section" id="featured-books-section">
			<h2 class="section-title">Sách Nổi Bật</h2>

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
							<a
								href="${pageContext.request.contextPath}/product-detail?id=${book.id}"
								class="btn-detail"> Xem chi tiết </a>
						</div>
					</c:forEach>
					<%-- (2) SỬA LỖI: Xóa bỏ <c:if empty> bị lồng sai (dead code) --%>
				</c:if>

				<%-- (4) TỐI ƯU: Thay thế style nội tuyến bằng class --%>
				<c:if test="${empty featuredBookList}">
					<p class="no-books-message">Hiện chưa có sách nổi bật nào.</p>
				</c:if>
			</div>

			<div style="text-align: center; margin-top: 30px;">
				<a href="${pageContext.request.contextPath}/books"
					class="cta-button">Xem Tất Cả Sách</a>
			</div>
		</section>

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

		<%-- Form đăng ký nhận tin (CTA) --%>
		<section class="cta-bar-form">
			<h3>Đừng Bỏ Lỡ Ưu Đãi Đặc Biệt!</h3>
			<p>Đăng ký nhận bản tin của chúng tôi để cập nhật những đầu sách
				mới nhất và nhận ngay mã giảm giá 10% cho đơn hàng đầu tiên!</p>
			<form action="${pageContext.request.contextPath}/subscribe"
				method="post">
				<input type="text" name="name" placeholder="Họ và Tên của bạn"
					required> <input type="email" name="email"
					placeholder="Email nhận ưu đãi" required>
				<button type="submit">ĐĂNG KÝ NGAY</button>
			</form>
		</section>

	</div>
	<%-- Đóng container cho landing page sections --%>

	<jsp:include page="footer.jsp" />

	<%-- (3) TỐI ƯU: Chuyển JS ra file riêng --%>
	<script src="${pageContext.request.contextPath}/js/home-slider.js"></script>
</body>
</html>