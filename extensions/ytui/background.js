// Initial install
chrome.runtime.onInstalled.addListener(() => {
  const settings = {
    overlay: true,
    thumbnails: true
  }

  chrome.storage.sync.set(settings, () => {
    console.log('Initialization complete');
  });
});

// Chrome startup
chrome.runtime.onStartup.addListener(() => {
  chrome.storage.sync.get(null, () => {
    console.log('Retrieved settings');
  });
});

const blockThumbnails = () => {
  return {cancel: true};
}

chrome.storage.onChanged.addListener((changes, namespace) => {
  if (namespace === 'sync' && 'thumbnails' in changes) {
    if (changes.thumbnails.newValue === true) {
      console.log("Unblocking thumbnails");
      chrome.webRequest.onBeforeRequest.removeListener(blockThumbnails);
    } else {
      console.log("Blocking thumbnails");
      chrome.webRequest.onBeforeRequest.addListener(
        blockThumbnails,
        {urls: ["*://i.ytimg.com/*"]},
        ["blocking"]
      );
    }

    // reload the page to update thumbnails
    chrome.tabs.getSelected(null, function(tab) {
      chrome.tabs.executeScript(tab.id, {code: 'window.location.reload();'});
    });
  }
});