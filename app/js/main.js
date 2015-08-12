$(document).ready(function(){
    // Load lightbox
    $('a.gallery').colorbox({
      rel:'gal',
      scalePhotos: true,
      maxWidth: '100%',
      maxHeight: '100%'
    });

    // Stop Map scrolling automatically
    $('.home-map').click(function () {
      $('.home-map iframe').css("pointer-events", "auto");
    });
});
