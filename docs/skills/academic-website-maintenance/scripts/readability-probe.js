// Run this function with a supported browser tool's read-only evaluate API.
// No network, page mutation, navigation, or browser launch takes place here.
() => {
  const root = document.querySelector('main') || document.body;
  const visible = element => {
    const style = getComputedStyle(element);
    const rect = element.getBoundingClientRect();
    return rect.width > 0 && rect.height > 0 && style.display !== 'none' &&
      style.visibility !== 'hidden' && style.opacity !== '0';
  };
  const samples = [];
  // Explicit semantic selectors also work with browser tools' restricted DOM APIs.
  for (const element of document.querySelectorAll('p,li,dt,dd,figcaption,h1,h2,h3,h4,span,a,summary,label,small,button,address')) {
    if (!element.textContent.trim() || !visible(element) ||
        element.closest('script,style,svg,sup,sub,[aria-hidden="true"]')) continue;
    const style = getComputedStyle(element);
    samples.push({
      tag: element.tagName, className: element.className,
      text: element.textContent.trim().slice(0, 90),
      fontSize: +style.fontSize.replace('px', ''), lineHeight: style.lineHeight,
      fontFamily: style.fontFamily
    });
  }
  const controls = [...document.querySelectorAll('header nav a, .section-nav a, button, input[type="search"], summary')]
    .filter(visible).map(element => ({
      text: (element.innerText || element.getAttribute('aria-label') || element.name || '').trim().slice(0, 60),
      height: element.getBoundingClientRect().height
    }));
  return {
    url: location.href, width: innerWidth,
    horizontalOverflow: document.documentElement.scrollWidth > innerWidth ? document.documentElement.scrollWidth - innerWidth : 0,
    h1Count: root.querySelectorAll('h1').length,
    smallText: samples.filter(item => item.fontSize < 15),
    shortControls: controls.filter(item => item.height < 43.5),
    brokenImages: [...document.images].filter(image => visible(image) && image.complete && !image.naturalWidth).map(image => image.getAttribute('src')),
    pendingImages: [...document.images].filter(image => visible(image) && !image.complete).map(image => image.getAttribute('src')),
    samples, controls
  };
}
