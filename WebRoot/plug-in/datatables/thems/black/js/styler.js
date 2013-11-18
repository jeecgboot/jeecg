$(document).ready(function () {

  $('.styler').click(function() {
    $(".styler").toggleClass("styler-active");
    $('.styler-show').slideToggle('slow');     
  }); /* to show the styler */
  
  $('#colorSelector-top-bar').tipTip({content: "Change the top bar color", defaultPosition: "right"});
  $('#colorSelector-box-head').tipTip({content: "Change the box header color", defaultPosition: "right"});
  /* for the tooltips describing what each colorpicker changes */

  $('#colorSelector-top-bar').ColorPicker({
          color: '#292929',
          onShow: function (colpkr) {
            $(colpkr).fadeIn(500);
            return false;
          },
          onHide: function (colpkr) {
            $(colpkr).fadeOut(500);
            return false;
          },
          onChange: function (hsb, hex, rgb) {
            $('.top-bar, #colorSelector-top-bar').css('backgroundColor', '#' + hex);
          }
  });
  $('#colorSelector-box-head').ColorPicker({
          color: '#292929',
          onShow: function (colpkr) {
            $(colpkr).fadeIn(500);
            return false;
          },
          onHide: function (colpkr) {
            $(colpkr).fadeOut(500);
            return false;
          },
          onChange: function (hsb, hex, rgb) {
            $('.box-head, #colorSelector-box-head').css('backgroundColor', '#' + hex);
          }
  });

  
});