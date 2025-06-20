// Navbar scroll effect
const navbar = document.getElementById('mainNavbar');
let lastScroll = 0;
window.addEventListener('scroll', () => {
    const cur = window.scrollY;
    if (cur <= 0) {
        navbar.classList.remove('scrolled');
    } else if (cur < lastScroll) {
        navbar.classList.add('scrolled');
    } else {
        navbar.classList.remove('scrolled');
    }
    lastScroll = cur;
});

// Multi-card per slide carousel
const items = document.querySelectorAll('#prodCarousel .carousel-item');
items.forEach((el) => {
    for (let i = 1; i < 4; i++) {
        const next = el.nextElementSibling || items[0];
        const clone = next.querySelector('.col-md-3').cloneNode(true);
        el.querySelector('.row').appendChild(clone);
    }
});