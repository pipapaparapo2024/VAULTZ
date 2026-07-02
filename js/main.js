// Header scroll
const header = document.querySelector('header');
window.addEventListener('scroll', () => {
  header.classList.toggle('scrolled', window.scrollY > 80);
}, { passive: true });

// Mobile menu
const hamburger = document.querySelector('.hamburger');
const mobileMenu = document.querySelector('.mobile-menu');
hamburger.addEventListener('click', () => {
  const open = hamburger.classList.toggle('open');
  mobileMenu.classList.toggle('open', open);
  document.body.style.overflow = open ? 'hidden' : '';
});
mobileMenu.querySelectorAll('a').forEach(a => a.addEventListener('click', () => {
  hamburger.classList.remove('open');
  mobileMenu.classList.remove('open');
  document.body.style.overflow = '';
}));

// Scroll reveal — standard elements
const revealObs = new IntersectionObserver((entries) => {
  entries.forEach(e => {
    if (e.isIntersecting) {
      e.target.classList.add('visible');
      revealObs.unobserve(e.target);
    }
  });
}, { threshold: 0.12, rootMargin: '0px 0px -40px 0px' });

document.querySelectorAll('.reveal, .reveal-clip').forEach(el => revealObs.observe(el));

// Service cards — clip-path + info reveal
const svcObs = new IntersectionObserver((entries) => {
  entries.forEach(e => {
    if (e.isIntersecting) {
      e.target.classList.add('visible');
      svcObs.unobserve(e.target);
    }
  });
}, { threshold: 0.18 });

document.querySelectorAll('.svc').forEach((el, i) => {
  el.style.transitionDelay = `${i * 0.12}s`;
  el.querySelector('.svc-info').style.transitionDelay = `${i * 0.12 + 0.3}s`;
  svcObs.observe(el);
});

// Work items — staggered clip reveal
const workObs = new IntersectionObserver((entries) => {
  entries.forEach(e => {
    if (e.isIntersecting) {
      e.target.classList.add('visible');
      workObs.unobserve(e.target);
    }
  });
}, { threshold: 0.1 });

document.querySelectorAll('.work-item').forEach((el, i) => {
  el.querySelector('.work-item-inner').style.transitionDelay = `${i * 0.14}s`;
  workObs.observe(el);
});

// Hero wordmark — letter-by-letter reveal on load
const wordmark = document.querySelector('.hero-wordmark');
if (wordmark) {
  const text = wordmark.textContent;
  wordmark.innerHTML = text.split('').map((ch, i) =>
    `<span style="display:inline-block;opacity:0;transform:translateY(40px);transition:opacity 0.8s cubic-bezier(0.16,1,0.3,1) ${0.1 + i * 0.06}s,transform 0.8s cubic-bezier(0.16,1,0.3,1) ${0.1 + i * 0.06}s">${ch}</span>`
  ).join('');
  requestAnimationFrame(() => {
    wordmark.querySelectorAll('span').forEach(s => {
      s.style.opacity = '1';
      s.style.transform = 'none';
    });
  });
}
