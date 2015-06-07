$(document).ready(function () {

    $('.styler').click(function() {
    $(".styler").toggleClass("styler-active");
    $('.styler-show').slideToggle('slow');     
  }); /* to show the styler */
  
  $('#colorSelector-top-bar').tipTip({content: "改变菜单颜色", defaultPosition: "right"});
  $('#colorSelector-box-head').tipTip({content: "改变容器颜色", defaultPosition: "right"});
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