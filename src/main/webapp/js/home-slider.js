// home-slider.js

document.addEventListener('DOMContentLoaded', () => {
    // Lấy các phần tử cần thiết
    const track = document.querySelector('.slider-track');
    const prev = document.querySelector('.prev');
    const next = document.querySelector('.next');
    const banner = document.querySelector('.banner-slider');
    
    // Nếu thiếu phần tử, thoát ngay để tránh lỗi
    if (!track || !prev || !next || !banner) return;

    const slides = document.querySelectorAll('.slide');
    const dots = document.querySelectorAll('.dot');
    const totalSlides = slides.length; 
    let index = 0;
    let autoSlideInterval;
    const intervalTime = 3000; // 3 giây tự động trượt

    // --- Core Function: Dịch chuyển và Cập nhật ---
	// home-slider.js

	// ... (Các phần khác giữ nguyên)

	// home-slider.js

	// ... (Phần khai báo biến) ...

	function updateSlider() {
	    // 1. Tính toán dịch chuyển
	    const movePercentage = (100 / totalSlides) * index; 

	    // Áp dụng dịch chuyển ngang
	    track.style.transform = `translateX(-${movePercentage}%)`;

	    // 2. CẬP NHẬT TRẠNG THÁI CHẤM TRÒN (ĐÃ THÊM LẠI)
	    dots.forEach((dot, i) => {
	        // Thêm/Xóa class 'active'. Chỉ giữ 'active' cho chấm tròn có index khớp với i.
	        dot.classList.toggle('active', i === index);
	    });
	}

	// ... (Các phần còn lại giữ nguyên) ...
	// ... (Các phần còn lại của JS giữ nguyên)

    // --- Navigation Functions ---
    function nextSlide() {
        // Vòng lặp: 0 -> 1 -> 2 -> 0...
        index = (index + 1) % totalSlides;
        updateSlider();
    }

    function prevSlide() {
        // Vòng lặp ngược: 2 -> 1 -> 0 -> 2...
        index = (index - 1 + totalSlides) % totalSlides; 
        updateSlider();
    }

    // --- Auto Slide Control ---
    function startAuto() {
        autoSlideInterval = setInterval(nextSlide, intervalTime);
    }
    
    function stopAuto() {
        clearInterval(autoSlideInterval);
    }

    function resetAuto() {
        // Dừng và khởi động lại interval khi người dùng tương tác
        stopAuto();
        startAuto();
    }

    // --- Event Listeners ---
    
    // Nút điều hướng
    next.addEventListener('click', () => {
        nextSlide();
        resetAuto();
    });
    
    prev.addEventListener('click', () => {
        prevSlide();
        resetAuto();
    });

    // Chấm tròn (Dots)
    dots.forEach((dot, i) => {
        dot.addEventListener('click', () => {
            index = i;
            updateSlider();
            resetAuto();
        });
    });

    // Tạm dừng tự động khi di chuột
    banner.addEventListener('mouseenter', stopAuto);
    banner.addEventListener('mouseleave', startAuto);

    // --- Khởi tạo (Initialization) ---
    // Đặt vị trí ban đầu (index 0) ngay lập tức
    updateSlider(); 
    // Bắt đầu chạy tự động
    startAuto(); 
});