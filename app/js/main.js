$(document).ready(function(){
    // Load lightbox
    $('a.gallery').colorbox({
      rel:'gal',
      scalePhotos: true,
      maxWidth: '100%',
      maxHeight: '100%'
    });
    // Fire Lightbox gallery from Main image.
    $('a.gallery-trigger').click(function(e){
      e.preventDefault();
      $('a.gallery').first().trigger('click');
    });

    // Stop Map scrolling automatically
    $('.home-map').click(function () {
      $('.home-map iframe').css("pointer-events", "auto");
    });
});
