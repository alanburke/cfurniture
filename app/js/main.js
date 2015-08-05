$(document).ready(function(){
    if (window.matchMedia) {
      // Establishing media check
        width700Check = window.matchMedia("(min-width: 700px)");
        if (width700Check.matches){
          $('a.gallery').colorbox({
            rel:'gal',
            scalePhotos: true,
            maxWidth: '100%',
            maxHeight: '100%'
          });
          $('a.single').colorbox({
            rel:'single',
            scalePhotos: true,
            maxWidth: '100%',
            maxHeight: '100%'
          });
        }
    }

    // Stop Map scrolling automatically
    $('.home-map').click(function () {
      $('.home-map iframe').css("pointer-events", "auto");
    });
});
