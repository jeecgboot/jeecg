var fields={};//存储字段跟字段文本值
//将字段名跟文本储存起来
function storeFields(){
 var fieldTexts=$("input[name$='fieldText'][value!='']");
	$.each(fieldTexts,function(){
		var fieldName=$(this).parent().prev().children().eq(0).val();
		if(fieldName&&fieldName!=''){
			fields[fieldName.toLowerCase()]=this.value;
		}

	});
}
//将存储的字段文本回显
function setFieldText(){
	var fieldTexts=$("input[name$='fieldName']");
	$.each(fieldTexts,function(){
		var fieldText=fields[this.value.toLowerCase()];
		if(fieldText){
			$(this).parent().next().children().eq(0).val(fieldText);
		}
	})
}
<!--update-begin--Author:zzl  Date:20151110 for：解决自定义表单重新sql解析后 查询参数 参数文本、默认值丢失-->
var autoFormParams={};//存储查询参数
function storeParams(){
 	var paramNames=$("#add_autoFormParam_table").find("input[name$='paramName']");
	var paramDescs=$("#add_autoFormParam_table").find("input[name$='paramDesc']");
	var paramValues=$("#add_autoFormParam_table").find("input[name$='paramValue']");
	for(var i=0;i<paramNames.length;i++){
		var item={};
		item["paramName"]=paramNames.eq(i).val().toLowerCase();
		if(paramDescs.eq(i).val()!=''){
			item["paramDesc"]=paramDescs.eq(i).val();
		}
		if(paramValues.eq(i).val()!=''){
			item["paramValue"]=paramValues.eq(i).val();
		}
		var info=autoFormParams[paramNames.eq(i).val()];
		if(info){
			item= $.extend(item,info);
		}
		autoFormParams[paramNames.eq(i).val()]=item;
	}
}
function setParams(){
	var paramNames=$("#add_autoFormParam_table").find("input[name$='paramName']");
	var paramDescs=$("#add_autoFormParam_table").find("input[name$='paramDesc']");
	var paramValues=$("#add_autoFormParam_table").find("input[name$='paramValue']");
	for(var i=0;i<paramNames.length;i++){
		var info=autoFormParams[paramNames.eq(i).val().toLowerCase()];
		if(info){
			if(info["paramDesc"]){
				paramDescs.eq(i).val(info["paramDesc"])
			}
			if(info["paramValue"]){
				paramValues.eq(i).val(info["paramValue"])
			}
		}
	}
}
<!--update-end--Author:zzl  Date:20151110 for：解决自定义表单重新sql解析后 -->

$(function(){
	$("body").append("<link href=\"plug-in/lhgDialog/skins/default.css\" rel=\"stylesheet\" id=\"lhgdialoglink\">");
	var $btn = $("<div class=\"ui_buttons\"  style=\"display:inline-block;padding:0px;\"><input style=\"position: relative;top: 0px;\" class=\"ui_state_highlight\" type=\"button\" value=\"sql解析\"  id=\"sqlAnalyze\" /></div>");
	$("#dbDynSqlButton").after($btn);
	$btn.click(function(){
		storeFields();
		storeParams();
		 $.ajax({
		    url:"autoFormDbController.do?getFields",
		    data:{sql:$("#dbDynSql").val()},
			type:"Post",
		    dataType:"json",
		    success:function(data){
			    if(data.status=="success"){
					  getTableName();
				      $("#sql_div #add_autoFormDbField_table").empty();
				      $.each(data.files,function(index,e){
				    	  var $tr = $("#add_autoFormDbField_table_template tr").clone();
				    	  $tr.find("td:eq(1) :text").val(index);
				    	  $tr.find("td:eq(2) :text").val(e);
				    	  $("#sql_div #add_autoFormDbField_table").append($tr);
				      }); 
				      resetTrNum("sql_div #add_autoFormDbField_table");
				      
				      $("#sql_div #add_autoFormParam_table").empty();
				      $.each(data.params,function(index,e){
				    	  var $tr = $("#add_autoFormParam_table_template tr").clone();
				    	  $tr.find("td:eq(1) :text").val(index);
				    	  $tr.find("td:eq(2) :text").val(e);
				    	  $tr.find("td:eq(5) :text").val(index);
				    	  $("#sql_div #add_autoFormParam_table").append($tr);
				      });
				      
				      resetTrNum("sql_div #add_autoFormParam_table");
					setFieldText();
					setParams();
			    }else{
					$.messager.alert('??',data.datas);
				}
		  }});
	 });
	
	/*add-begin--Author:luobaoli  Date:20150621 for：新增数据源类型为“Table”是，表属性的解析逻辑 */
	var $btnTable = $("<div class=\"ui_buttons\"  style=\"display:inline-block;padding:0px;\"><input style=\"position: relative;top: 0px;\" class=\"ui_state_highlight\" type=\"button\" value=\"解析生成字段\"  id=\"tableAnalyze\" /></div>");
	$("#table_div tr:first td:last").append($btnTable);
	$btnTable.click(function(){
		$.ajax({
			url:"autoFormDbController.do?getTableFields",
		    data:{dbKey:$("#dbKey").val(),tableName:$("#dbTableName").val()},
			type:"Post",
		    dataType:"json",
		    success:function(data){
		    	 if(data.status=="success"){
		    		 $("#table_div #add_autoFormDbFieldForTable_table").empty();
				      $.each(data.files,function(index,e){
				    	  var $tr = $("#add_autoFormDbFieldForTable_table_template tr").clone();
				    	  $tr.find("td:eq(1) :text").val(index);
				    	  $tr.find("td:eq(2) :text").val(e);
				    	  $("#table_div #add_autoFormDbFieldForTable_table").append($tr);
				      });
				      resetTrNum("table_div #add_autoFormDbFieldForTable_table");
		    	 }else{
					$.messager.alert('??',data.datas);
				}
		    }
		});
	});
	/*add-end--Author:luobaoli  Date:20150621 for：新增数据源类型为“Table”是，表属性的解析逻辑*/
});
/*add-begin--Author:luobaoli  Date:20150621 for：数据源和表联动处理逻辑*/
$(function(){
	$("select[name='dbKey']").change(function(){
		$.ajax({
			url:"autoFormDbController.do?getAllTableNames",
		    data:{dbKey:$(this).val()},
			type:"Post",
		    dataType:"json",
		    success:function(data){
				$("#dbTableName").find("option").remove();
		    	if(data.status=="success"){
			    	temp_html = "";

			    	$.each(data.tableNames,function(index,e){
			    		temp_html += "<option value='"+e+"'>"+e+"</option>";
			    	});
			    	$("#dbTableName").html(temp_html);
		    	}else{
					$.messager.alert('表信息获取失败！',data.datas);
				}
		    }
		});
	});
});
/*add-end--Author:luobaoli  Date:20150621 for：数据源和表联动处理逻辑*/

/*add-begin--Author: jg_huangxg  Date:20150724 for：数据源和表联动处理逻辑*/
$(function(){
	$("#tbDbKey").change(function(){
		$.ajax({
			url:"autoFormDbController.do?getAllTableNames",
		    data:{dbKey:$(this).val()},
			type:"Post",
		    dataType:"json",
		    success:function(data){
				$("#tbDbTableName").find("option").remove();
		    	if(data.status=="success"){
			    	temp_html = "<option value=''>--请选择--</option>";
			    	$.each(data.tableNames,function(index,e){
			    		temp_html += "<option value='"+e+"'>"+e+"</option>";
			    	});
			    	$("#tbDbTableName").html(temp_html);
		    	}else{
					$.messager.alert('表信息获取失败！',data.datas);
				}
		    }
		});
	});
});
/*add-end--Author: jg_huangxg  Date:20150724 for：数据源和表联动处理逻辑*/


//初始化下标
function resetTrNum(tableId) {
	$tbody = $("#"+tableId+"");
	$tbody.find('>tr').each(function(i){
		$(':input, select,button,a', this).each(function(){
			var $this = $(this), name = $this.attr('name'),id=$this.attr('id'),onclick_str=$this.attr('onclick'), val = $this.val();
			if(name!=null){
				if (name.indexOf("#index#") >= 0){
					$this.attr("name",name.replace('#index#',i));
				}else{
					var s = name.indexOf("[");
					var e = name.indexOf("]");
					var new_name = name.substring(s+1,e);
					$this.attr("name",name.replace(new_name,i));
				}
			}
			if(id!=null){
				if (id.indexOf("#index#") >= 0){
					$this.attr("id",id.replace('#index#',i));
				}else{
					var s = id.indexOf("[");
					var e = id.indexOf("]");
					var new_id = id.substring(s+1,e);
					$this.attr("id",id.replace(new_id,i));
				}
			}
			if(onclick_str!=null){
				if (onclick_str.indexOf("#index#") >= 0){
					$this.attr("onclick",onclick_str.replace(/#index#/g,i));
				}else{
				}
			}
		});
		$(this).find('div[name=\'xh\']').html(i+1);
	});
}
//通用弹出式文件上传
function commonUpload(callback,inputId){
    $.dialog({
           content: "url:systemController.do?commonUpload",
           lock : true,
           title:"文件上传",
           zIndex:2100,
           width:700,
           height: 200,
           parent:windowapi,
           cache:false,
       ok: function(){
               var iframe = this.iframe.contentWindow;
               iframe.uploadCallback(callback,inputId);
               return true;
       },
       cancelVal: '关闭',
       cancel: function(){
       } 
   });
}
//通用弹出式文件上传-回调
function commonUploadDefaultCallBack(url,name,inputId){
	$("#"+inputId+"_href").attr('href',url).html('下载');
	$("#"+inputId).val(url);
}
function browseImages(inputId, Img) {// 图片管理器，可多个上传共用
		var finder = new CKFinder();
		finder.selectActionFunction = function(fileUrl, data) {//设置文件被选中时的函数 
			$("#" + Img).attr("src", fileUrl);
			$("#" + inputId).attr("value", fileUrl);
		};
		finder.resourceType = 'Images';// 指定ckfinder只为图片进行管理
		finder.selectActionData = inputId; //接收地址的input ID
		finder.removePlugins = 'help';// 移除帮助(只有英文)
		finder.defaultLanguage = 'zh-cn';
		finder.popup();
	}
function browseFiles(inputId, file) {// 文件管理器，可多个上传共用
	var finder = new CKFinder();
	finder.selectActionFunction = function(fileUrl, data) {//设置文件被选中时的函数 
		$("#" + file).attr("href", fileUrl);
		$("#" + inputId).attr("value", fileUrl);
		decode(fileUrl, file);
	};
	finder.resourceType = 'Files';// 指定ckfinder只为文件进行管理
	finder.selectActionData = inputId; //接收地址的input ID
	finder.removePlugins = 'help';// 移除帮助(只有英文)
	finder.defaultLanguage = 'zh-cn';
	finder.popup();
}
function decode(value, id) {//value传入值,id接受值
	var last = value.lastIndexOf("/");
	var filename = value.substring(last + 1, value.length);
	$("#" + id).text(decodeURIComponent(filename));
}
<!--update-begin--Author:zzl  Date:20151101 for：sql解析获取数据库表名填充数据源 -->
function getTableName(){
	var sql=$("#dbDynSql").val().toLowerCase();
	if(sql.length==0)
		return ;
	var fromIndex=sql.indexOf("from");
	var whereIndex=sql.indexOf("where")==-1?sql.length:sql.indexOf("where");
	var tableNames=sql.substring(fromIndex+4,whereIndex);
	var tableName=($.trim(tableNames.split(",")[0]));
	if(tableName.length>0){
		var option=$("#tbDbTableName").find("option[text='"+tableName+"']");
		if(option.length==0){
			$("#tbDbTableName").find("option.dAdd").remove();
			$("#tbDbTableName").append("<option class='dAdd'  selected>"+tableName+"</option>");
		}else{
			option.attr("selected","selected");
		}
	}
}
<!--update-end--Author:zzl  Date:20151101 for：sql解析获取数据库表名填充数据源 -->