/* 
* hftable 0.1 
* Copyright (c) 2014 赵俊夫 http://zjfhw.iteye.com
* Date: 2014-02-23
主要功能：将普通的Table的表头/表尾固定
特点：
	1.该版本约定将表格第一行作为表头,所以不需要特别设置<thead>之类的标签标识表头,普通结构的table即可。
	2.同上,如果设置了表尾固定,则约定表格的最后一行为表尾。
入参：
options{
	fixHeader:true/fales	//是否固定表头,默认true
	fixFooter:true/false	//是否固定表尾,默认false
	width					//Table的宽度
	height					//Table的高度
}
*/ 
(function($) {       
	$.fn.createhftable = function(options) {   
		 var defaultOptions = {
			fixHeader:true,
			fixFooter:false,
			width:'100%',
			height:'400px'
		 };
		 if(!options){
			options = {};
		 }
		 $.extend(defaultOptions,options);
		 //1.将原始table分离
		 var $trHead = this.find("tr:first").clone();
		 var $trFoot = this.find("tr:last").clone();
		 var $tableHead = this.clone();
		 var $tableFoot = this.clone();
		 this.find("tr:first").remove();
		 if(defaultOptions.fixFooter){
			this.find("tr:last").remove();
		 }
		 //2.创建一个Div包裹Table,设置成可滚动
		 var tableId = this.attr("id");
		 var divId = tableId+"scrolldiv";
		 var headId = tableId+"scrolldivHead";
		 var footId = tableId+"scrolldivFoot";
		 $tableHead.attr("id",headId);
		 $tableFoot.attr("id",footId);
		 var divStyle = "overflow: auto;width:"+defaultOptions.width+";height:"+defaultOptions.height;
		 var divtp = "<div id='"+divId+"' style=\""+divStyle+"\">"+getOuterHtml(this)+"</div>";
		 this.before(divtp);
		 this.remove();
		 //3.将Table的表头/表尾复制成单独的Table放在hftable的上下方
		 //3.1 添加表头
		 $tableHead.html('');
		 $tableHead.append(getOuterHtml($trHead));
		 $("#"+divId).before(getOuterHtml($tableHead));
		 fix(headId,tableId);
		 //3.2 添加表尾
		 if(defaultOptions.fixFooter){
			$tableFoot.html('');
			$tableFoot.append(getOuterHtml($trFoot));
			$("#"+divId).after(getOuterHtml($tableFoot));
			fix(footId,tableId);
		 }
		 //4.绑定滚动事件
		 bindScrollEvent(headId,footId,divId,defaultOptions.fixFooter);
	}; 
	function getOuterHtml(obj) {
		var box = $('<div></div>');
		box.append(obj.clone());
		return box.html();
	}
	function fix(headid,contentid){
		for(var i=0;i<=$('#'+contentid+' tr:last').find('td:last').index();i++){
				$('#'+headid+' td').eq(i).css('width',
					$('#'+contentid+' tr:last').find('td').eq(i).width());
		}
		$('#'+headid).css('width',$('#'+contentid+' tr:last').width());
	}
	function bindScrollEvent(headId,footId,divId,fixFooter){
		$('#'+divId).scroll(function(){
			$('#'+headId).css('margin-left',-($('#'+divId).scrollLeft()));
			if(fixFooter){
				$('#'+footId).css('margin-left',-($('#'+divId).scrollLeft()));
			}
		});
	}
})(jQuery);  
