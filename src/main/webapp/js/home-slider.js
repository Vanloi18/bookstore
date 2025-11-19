document.addEventListener('DOMContentLoaded', () => {
    const track = document.querySelector('.slider-track');
    const slides = document.querySelectorAll('.slide');
    const dots = document.querySelectorAll('.dot');
    const prev = document.querySelector('.prev');
    const next = document.querySelector('.next');
    const banner = document.querySelector('.banner-slider');
    
    if (!track || !prev || !next || !banner) return;

    const totalSlides = slides.length; 
    let index = 0;
    let autoSlideInterval;
    const intervalTime = 3000; 

    function updateSlider() {
        const movePercentage = (100 / totalSlides) * index; 
        track.style.transform = `translateX(-${movePercentage}%)`;
        
        dots.forEach((dot, i) => {
            dot.classList.toggle('active', i === index);
        });
    }

    function nextSlide() {
        index = (index + 1) % totalSlides;
        updateSlider();
    }

    function prevSlide() {
        index = (index - 1 + totalSlides) % totalSlides; 
        updateSlider();
    }

    function startAuto() {
        autoSlideInterval = setInterval(nextSlide, intervalTime);
    }
    
    function stopAuto() {
        clearInterval(autoSlideInterval);
    }

    function resetAuto() {
        stopAuto();
        startAuto();
    }
    
    next.addEventListener('click', () => { nextSlide(); resetAuto(); });
    prev.addEventListener('click', () => { prevSlide(); resetAuto(); });

    dots.forEach((dot, i) => {
        dot.addEventListener('click', () => {
            index = i;
            updateSlider();
            resetAuto();
        });
    });

    banner.addEventListener('mouseenter', stopAuto);
    banner.addEventListener('mouseleave', startAuto);

    updateSlider(); 
    startAuto(); 
});