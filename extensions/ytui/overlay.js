const enabled = false;
const log = (enabled === true) ? console.log : function() {};

// overlay
const overlay = document.createElement("div"); 
overlay.id = "ytoverlay";

const showOverlay = () => {
  log('show overlay');
  overlay.style.display = "block";  
}
const hideOverlay = () => {
  log('hide overlay');
  overlay.style.display = "none";
}

const addOverlay = () => {
  log('adding overlay');
  document.body.appendChild(overlay);
  window.addEventListener("focus", hideOverlay);
  window.addEventListener("blur", showOverlay);
}
const removeOverlay = () => {
  log('removing overlay');
  overlay.remove();
  window.removeEventListener("focus", hideOverlay);
  window.removeEventListener("blur", showOverlay);   
}

chrome.storage.sync.get(null, req => {
  (req.overlay === true) ? addOverlay() : removeOverlay();
});

chrome.storage.onChanged.addListener((changes, namespace) => {
  if (namespace === 'sync' && 'overlay' in changes) {
    (changes.overlay.newValue === true) ? addOverlay() : removeOverlay();
  }
});

// TODO:
// disable video (only audio) while blurred
// toggle: load thumbnails or not
// autoplay / loop controls
// click the continue watching button if it pops up

