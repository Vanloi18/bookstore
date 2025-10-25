const track = document.querySelector('.slider-track');
const slides = document.querySelectorAll('.slide');
const dots = document.querySelectorAll('.dot');
const prev = document.querySelector('.prev');
const next = document.querySelector('.next');
let index = 0;
let autoSlide;

function updateSlider() {
    track.style.transform = `translateX(-${index * 100}%)`;
    dots.forEach((dot, i) => dot.classList.toggle('active', i === index));
}

function nextSlide() {
    index = (index + 1) % slides.length;
    updateSlider();
}

function prevSlide() {
    index = (index - 1 + slides.length) % slides.length;
    updateSlider();
}

next.addEventListener('click', () => {
    nextSlide();
    resetAuto();
});
prev.addEventListener('click', () => {
    prevSlide();
    resetAuto();
});

dots.forEach((dot, i) => {
    dot.addEventListener('click', () => {
        index = i;
        updateSlider();
        resetAuto();
    });
});

function startAuto() {
    autoSlide = setInterval(nextSlide, 3000);
}
function resetAuto() {
    clearInterval(autoSlide);
    startAuto();
}

startAuto();
