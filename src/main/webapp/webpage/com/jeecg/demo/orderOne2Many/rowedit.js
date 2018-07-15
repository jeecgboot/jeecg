	//添加行
	function addRow(title,addurl,gname){
		$('#'+gname).datagrid('appendRow',{});
		var editIndex = $('#'+gname).datagrid('getRows').length-1;
		$('#'+gname).datagrid('selectRow', editIndex)
				.datagrid('beginEdit', editIndex);
	}
	//保存数据
	function saveData(title,addurl,gname){
		if(!endEdit(gname))
			return false;
		var rows=$('#'+gname).datagrid("getChanges","inserted");
		var uprows=$('#'+gname).datagrid("getChanges","updated");
		rows=rows.concat(uprows);
		if(rows.length<=0){
			tip("没有需要保存的数据！")
			return false;
		}
		var result={};
		for(var i=0;i<rows.length;i++){
			for(var d in rows[i]){
				result["demos["+i+"]."+d]=rows[i][d];
			}
		}
		//<%=basePath%>/"
		$.ajax({
			url:addurl,
			type:"post",
			data:result,
			dataType:"json",
			success:function(data){
				tip(data.msg);
				if(data.success){
					reloadTable();
				}
			}
		})
	}
	//结束编辑
	function endEdit(gname){
		var  editIndex = $('#'+gname).datagrid('getRows').length-1;
		for(var i=0;i<=editIndex;i++){
			if($('#'+gname).datagrid('validateRow', i)){
				$('#'+gname).datagrid('endEdit', i);
			}else{

				tip("请输入有效的内容!");

				return false;
			}
		}
		return true;
	}
	//编辑行
	function editRow(title,addurl,gname){
		var rows=$('#'+gname).datagrid("getChecked");
		if(rows.length==0){
			tip("请选择条目");
			return false;
		}
		for(var i=0;i<rows.length;i++){
			var indexk= $('#'+gname).datagrid('getRowIndex', rows[i]);
			$('#'+gname).datagrid('beginEdit', indexk);
			var ed = $('#'+gname).datagrid('getEditor', {index:indexk,field:"name"});
			$(ed.target).bind('click', function(){
				var defaultval = $(ed.target).val();
				openSelect(defaultval,"测试demo",this);
				$(this).focus();
			});
		}
		
	}
	//取消编辑
	function reject(title,addurl,gname){
		$('#'+gname).datagrid('clearChecked');
		$('#'+gname).datagrid('rejectChanges');
	}
 
	//自定义验证
  $.extend($.fn.validatebox.defaults.rules, {
	 phoneRex: {
	   validator: function(value){
	   var rex=/^1[3-8]+\d{9}$/;
	   //var rex=/^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
	   //区号：前面一个0，后面跟2-3位数字 ： 0\d{2,3}
	   //电话号码：7-8位数字： \d{7,8
	   //分机号：一般都是3位数字： \d{3,}
	    //这样连接起来就是验证电话的正则表达式了：/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/		 
	   var rex2=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
	   if(rex.test(value)||rex2.test(value))
	   {
	     // alert('t'+value);
	     return true;
	   }else
	   {
	    //alert('false '+value);
	      return false;
	   }
	     
	   },
	   message: '请输入正确电话或手机格式'
	 }
  });