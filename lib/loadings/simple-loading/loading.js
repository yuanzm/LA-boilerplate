window.onload = function () {
  TweenMax.to('#loading-wrapper', 1, {opacity:0, display:'none', onComplete: startPage, ease: Power3.easeOut});
  function startPage () {
    LA.core.start()
  }
};