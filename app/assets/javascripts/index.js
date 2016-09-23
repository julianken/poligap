

$( document ).on('turbolinks:load', function() {
  var i, paths, svg;

  svg = document.querySelector('svg');

  paths = document.querySelectorAll('path');

  i = paths.length;

  while (i--) {
    paths[i].addEventListener('mouseenter', function(e) {
      svg.appendChild(e.target);
    });
  }

  $('path').click(function(){
    var state = $(this).get(0);
    var stateId = state.id;
    $("." + stateId).children('a').get(0).click();
  });
});
