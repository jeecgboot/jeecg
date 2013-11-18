$(function(){
  $('#backdroptrue').on('click',function(evt){
    $('#modalbackdroptrue').modal({
      backdrop:true
    });
  });

  $('#backdropfalse').on('click',function(evt){
    $('#modalbackdropfalse').modal({
      backdrop:false
    });
  });

  $('#keyboardtrue').on('click',function(evt){
    $('#modalkeyboardtrue').modal({
      keyboard:true
    });
  });

  $('#keyboardfalse').on('click',function(evt){
    $('#modalkeyboardfalse').modal({
      keyboard:false
    });
  });

  $('#amodaltoggle').on('click',function(evt){
    $('#modaltoggle').modal('toggle');
  });

});