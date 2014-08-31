window.onload = function () {
  var $loadingWrapper = $('#loading-wrapper');
  
  $loadingWrapper.css('opacity', '0');

  setTimeout(function () {
    $loadingWrapper.css('display', 'none');
    startPage();
  }, 1000);

  function startPage () {
    LA.core.start()
  }
};