$(document).ready(function () {
      
      /* GLOBAL SCRIPTS */

      $('#top-nav li').hover(
       function () {
           $('ul', this).slideDown(100);
         }, 
       function () {
           $('ul', this).slideUp(100);         
      }); /*for the dropdown sub-nav*/

      $('.ad-notif-success, .ad-notif-warn, .ad-notif-error, .ad-notif-info').click(function() {
        $(this).slideUp(300);
      }); /* for dismissing notifications */

      $('#usr-notif a').click(function () {
        $.sticky('Well hello there!');
      }); /* for displaying a sticky notification */ 

      $('.box-head').click(function() {
          $(this).next(".box-content").css("min-height", "0").slideToggle(400);
      }); /* for collapsing panels on header click */


      var link = $("<link>");
      link.attr({
              type: 'text/css',
              rel: 'stylesheet',
              href: 'css/icons.css'
      });
      if($('.silk, .fugue, .fugue-2, .fugue-24, .opsrc').length>0) {

          $("head").append( link ); 
      }; /* for only including "icons.css" (big file) if an icon class is used anywhere in the page */

      /* FOR ADAPTIVE LAYOUT, remove if not needed */

      function fullHeight(){
          if ($(window).width() > 600)  {
            if ($(window).width() < 1250) {
               $(".top-bar").height($(document).height());
            }
            else {
              $(".top-bar").height(80);
            }
          }
          else {
              $(".top-bar").height(30);
            }
      }
          fullHeight();

          $(window).resize(function(){
              fullHeight();
          }); 
      /* sets the .top-bar height to 100% of document height if resolution smaller than 1250px and larger than 600px */
});