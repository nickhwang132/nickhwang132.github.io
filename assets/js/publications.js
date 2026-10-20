document.addEventListener('DOMContentLoaded', function () {
  var root = document.querySelector('[data-publications]');
  if (!root) return;
  var page = root.closest('main');
  var input = page.querySelector('.publications-search');
  var toolbar = page.querySelector('.publications-toolbar');
  var groups = Array.prototype.slice.call(root.querySelectorAll('.publication-year-group'));
  var empty = root.querySelector('.publications-empty');
  var count = page.querySelector('.publications-count');
  if (!input || !toolbar) return;
  toolbar.hidden = false;
  function filter() {
    var query = input.value.trim().toLowerCase();
    var total = 0;
    groups.forEach(function (group) {
      var visible = 0;
      Array.prototype.forEach.call(group.querySelectorAll('.publication-item'), function (item) {
        var matches = (item.textContent + ' ' + item.dataset.year).toLowerCase().indexOf(query) !== -1;
        item.hidden = !matches;
        if (matches) visible++;
      });
      group.hidden = visible === 0;
      total += visible;
    });
    empty.hidden = total !== 0;
    count.textContent = total + (total === 1 ? ' entry' : ' entries');
  }
  input.addEventListener('input', filter);
  var index = page.querySelector('.publications-index');
  index.addEventListener('click', function (event) {
    if (event.target.closest('a')) index.open = false;
  });
  document.addEventListener('click', function (event) {
    if (!index.contains(event.target)) index.open = false;
  });
  index.addEventListener('keydown', function (event) {
    if (event.key === 'Escape') {
      index.open = false;
      index.querySelector('summary').focus();
    }
  });
  filter();
});
