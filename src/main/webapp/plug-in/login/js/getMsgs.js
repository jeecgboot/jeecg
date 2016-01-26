/**
* 查询当前登录人是否有系统类型信息
* 并且每一个小时查询并提醒一次
**/
$(function(){
	  //首次进入系统，立即执行一次查询
	  getMsgs();
	  
	  window.setInterval(getMsgs, 10000*60*60); 
  })

  function getMsgs(){
	$.post(
		'tSSmsController.do?getMsgs',
	    function(data){
			var d = $.parseJSON(data);
			console.log(d);
			if(d.success && $.trim(d.msg) != ''){
				tip(d.msg);
			}
		}
	);
  }