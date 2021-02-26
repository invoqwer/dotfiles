const overlay = document.getElementById('overlay');
const thumbnails = document.getElementById('thumbnails');

chrome.storage.sync.get(null, req => {
  overlay.checked = req.overlay;
  thumbnails.checked = req.thumbnails
});

overlay.addEventListener('change', e => {
  chrome.storage.sync.set({
    'overlay': e.target.checked
  });
});

thumbnails.addEventListener('change', e => {
  chrome.storage.sync.set({
    'thumbnails': e.target.checked
  });
});
