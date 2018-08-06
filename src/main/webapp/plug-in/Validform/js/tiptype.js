/* * js: {validform验证效果扩展} * ----------*/

  //提示信息
  function ValidationMessage(obj, Validatemsg) {
      try {
          removeMessage(obj);
          //obj.focus();
          var $poptip_error = $('<div class="poptip"><span class="poptip-arrow poptip-arrow-top"><em>◆</em></span>' + Validatemsg + '</div>').css("left", obj.offset().left + 'px').css("top", obj.offset().top + obj.parent().height() + 5 + 'px')
          $('body').append($poptip_error);
          if (obj.hasClass('form-control') || obj.hasClass('ui-select')) {
              obj.parent().addClass('has-error');
          }
          if (obj.hasClass('ui-select')) {
              $('.input-error').remove();
          }
          obj.change(function () {
              if (obj.val()) {
                  removeMessage(obj);
              }
          });
          if (obj.hasClass('ui-select')) {
              $(document).click(function (e) {
                  if (obj.attr('data-value')) {
                      removeMessage(obj);
                  }
                  e.stopPropagation();
              });
          }
          return false; 
      } catch (e) {
          alert(e)
      }
  }
  //移除提示
  function removeMessage(obj) {
      obj.parent().removeClass('has-error');
      $('.poptip').remove();
      $('.input-error').remove();
  }