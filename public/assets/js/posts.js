$ = jQuery;
$(document).ready(function() {
  $(".post").fitVids();
  $('audio').audioPlayer();
  $('.stream-posts article').each(function(index){
  	$(this).find('h2').wrapInner('<a href="' + $(this).data('url') + '"></a>');
  })
});