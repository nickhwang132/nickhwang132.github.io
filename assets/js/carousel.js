document.addEventListener('DOMContentLoaded', function () {
  document.querySelectorAll('[data-gallery]').forEach(function (gallery) {
    var slides = Array.prototype.slice.call(gallery.querySelectorAll('.group-gallery__slide'));
    var controls = gallery.querySelector('.gallery-controls');
    if (slides.length < 2 || !controls) return;
    var current = 0;
    function show(index) {
      current = (index + slides.length) % slides.length;
      slides.forEach(function (slide, i) { slide.hidden = i !== current; });
      gallery.querySelector('[data-gallery-count]').textContent = (current + 1) + ' / ' + slides.length;
    }
    controls.hidden = false;
    gallery.querySelector('[data-gallery-prev]').addEventListener('click', function () { show(current - 1); });
    gallery.querySelector('[data-gallery-next]').addEventListener('click', function () { show(current + 1); });
    show(0);
  });
});
