<script type="text/javascript" src="plug-in/jquery/jquery.cookie.js"></script>
<script type="text/javascript" src="plug-in/jquery-plugs/storage/jquery.storageapi.min.js"></script>
<style>.modal-header{padding: 8px 15px 8px 24px;}.modal-header .close {margin-top: 3px;}
.row .left-div{padding:15px 0px 0px 0px}
.left-top-content{border-bottom:1px dashed #c8d3de;padding:0px 0px 5px 15px}
.left-content{padding:5px 0px 0px 10px}
#superQueryCondition td{padding:2px 5px}
.modal-body {
    padding-top: 0px;
}
.liinput {
	width:75%;
    border: none !important;
    background-color: #fff !important;
}
.liinput.active{
	background-color:none;
}
.convaltd>input{padding-left:8.5px}
#queryRecords > .panel-body{padding:0}
#queryRecords ul{cursor:pointer}
#queryRecords ul li{border-left:none;border-right:none;padding-right:5px;padding-left:5px}
.modal-footer {padding: 6px 15px;}
</style>												
<script>
function addOneRow(){
	var tr = $("#superQueryConditionTemplate tr").clone();
 	 $("#superQueryCondition").append(tr);
 	 resetTrNum();
}
function delOneRow(obj){
	var trCount = $("#superQueryCondition").find("tr").length;
	if(trCount>1){
		$(obj).parent().parent().remove();
		resetTrNum();
	}
}

//初始化下标
function resetTrNum(){
	$("#superQueryCondition").find("tr").each(function(i){
		$(':input,select', this).each(function(){
			var $this = $(this), name = $this.attr('name');
			if(!!name){
				if (name.indexOf("#index#") >= 0){
					$this.attr("name",name.replace('#index#',i));
				}else{
					var s = name.indexOf("[");
					var e = name.indexOf("]");
					var new_name = name.substring(s+1,e);
					$this.attr("name",name.replace(new_name,i));
				}
			}
		});
	});
}
<#-- 高级查询相关函数  -->
var queryConditionArr = new Array();
var StringBuffer = function(){
	this.strings = new Array;
}
StringBuffer.prototype.append = function(str) {
	this.strings.push(str); //追加指定元素  
};

StringBuffer.prototype.toString = function() {
	return "["+this.strings.join(",")+"]"; //向数组之间的元素插入指定字符串（此处为空字符串），并返回。  
};

//高级查询
function superQuerySearch(){
	var json = getCurrCondition();
	$("#_sqlbuilder").val(json.toString());
	console.log($("#_sqlbuilder").val());
	searchList();
}

//重置按钮，清空所有
function superQueryReset() {
	$("#superQueryCondition tr").each(function(index){
		if(index==0){
			$(this).find(":input").val("");
		}else{
			$(this).find("td:last").find("a:last").click();
		}
	});
	searchRest();
}
	
//获取当前查询条件
function getCurrCondition(){
	var json = new StringBuffer();
	var relation = $("#anyallSelect").val();
	var idIndex = 100;
	$("#superQueryCondition tr").each(function(index){
		idIndex++;
		var field = $(this).find("select[name='cons["+index+"].fld']").val();
		var condition = $(this).find("select[name='cons["+index+"].ctyp']").val();
		var cValue = $(this).find("input[name='cons["+index+"].val'],select[name='cons["+index+"].val']").val();
		if(field === '' && condition === '' && cValue === ''){
		}else{
			//判断condition条件，改变sql查询条件
			if (condition == "like") {
				condition = "like";
				cValue = "%" + cValue + "%";
			} else if (condition == "not like") {
				condition = "not like";
				cValue = "%" + cValue + "%";
			} else if (condition == "likeBegin") {
				condition = "like";
				cValue = cValue + "%";
			} else if (condition == "likeEnd") {
				condition = "like";
				cValue = "%" + cValue;
			} else if (condition == "in") {
				condition = "in";
				cValue = "\(" + cValue + "\)";
			} else if(condition == "not in") {
				condition = "not in";
				cValue = "\(" + cValue + "\)";
			}
			json.append("{\"id\":" + idIndex + ",\"field\":\""
						+ field + "\",\"condition\":\"" + condition
						+ "\",\"value\":\"" + cValue
						+ "\",\"relation\":\"" + relation
						+ "\",\"state\":\"open\"}");
		}
	});
	return json;
}
//另存为查询记录
function saveCurrCondition() {
	var name = prompt("查询方案名称","");
	if(!!name) {
		var saveAsJson = getCurrCondition();
		queryConditionArr.push({
			name : name,
			json : saveAsJson
		});
		saveHistory();
		addOneRecord(queryConditionArr.length-1,name);
	}
}
//根据历史记录查询
function searchByRecord(obj){
	$("#superQueryCondition tr").each(function(index){
		if(index==0){
			$(this).find(":input").val("");
		}else{
			$(this).find("td:last").find("a:last").click();
		}
	});
	var input = $(obj).next("input");
	var queryCondition = queryConditionArr[Number(input.data("index"))];
	var queryCons = "["+queryCondition.json.strings+"]";
	var data = JSON.parse(queryCons);
	for(var i = 0; i < data.length; i++) {
		var v = data[i].value;		//获取value值
		var begin = v.indexOf("%")==0;	//表示value是以%开头
		var end = v.charAt(v.length - 1);//表示value是以%结束
		var condition = data[i].condition;	//获取条件字段
		/* 判断'%'以开头还是结束 */
		if(begin && end != "%") {
			condition = "likeEnd";
		} else if(!begin && end == "%") {
			condition = "likeBegin";
		}	
		/* 判断Value值是否包含'%','(',')',有则去掉 */
		if(v != null && v != "") {
			while(v.indexOf("%")>=0){
				v = v.replace("%","");
			}
			while(v.indexOf("(")>0 || v.indexOf(")")>0) {
				v = v.replace("(","");
				v = v.replace(")","");
			}
		}	
		showHistoryRecord(i,v,condition,data[i].field);
		$("#anyallSelect").val(data[i].relation);	
	}
	$('#_sqlbuilder').val(queryCons);
	searchList();
}
//回显字段类型
function echoField(i,field,v) {
	//获取当前field的data属性
	var popup = $(field).data("popup");
	var dictionary = $(field).data("dictionary");
	//sel为字段名称
	var sel = $(field).attr("value");
	var spanVal = $(field).closest("tr").find("td.convaltd");
	var spanHtml="";
	spanVal.empty();
	if(popup && dictionary.indexOf(',')>0) {
		var splitArr = dictionary.split(",");//splitArr=dictionary 0为表编码,1为查询字段,2为返回字段
		var consName = spanVal.find("input").attr("name");
		var html = '<input value="'+v+'" name="'+consName+'" type="text" class="searchbox-inputtext" onclick="popupClick(this,\''+splitArr[2]+'\',\'val\',\''+splitArr[0]+'\')" style="width:140px;background:url(\'plug-in/diy/icons/search.png\') no-repeat 105px"/>';
		spanVal.html(html);
	} else {
		//除了popup通用写法
		var tempSpan=$("span#field_"+sel).html();
		spanVal.html(tempSpan);
		$(spanVal).find("[name='cons[#index#].val']").attr("name","cons["+i+"].val").val(v);
		layerDateInit(spanVal);
	}
}
//显示历史记录
function showHistoryRecord(index,value,condition,field){
	if(index>0){
		var tr = $("#superQueryConditionTemplate tr").clone();
 	 	$("#superQueryCondition").append(tr);
		resetTrNum();
	}
	$("#superQueryCondition tr:eq("+index+")").find("select[name='cons["+index+"].fld']").val(field);
	$("#superQueryCondition tr:eq("+index+")").find("select[name='cons["+index+"].ctyp']").val(condition);
	$("#superQueryCondition tr:eq("+index+")").find("input[name='cons["+index+"].val']").val(value);
	var option = $("#superQueryCondition tr:eq("+index+")").find("select[name='cons["+index+"].fld']").find("option[value='"+field+"']");
	echoField(index,option,value);
}
//在右侧添加一条记录
function addOneRecord(index,name){
	if(!!name){
		var html = '<li class="list-group-item"><span onclick="searchByRecord(this);" title="点我查询" class="glyphicon glyphicon-search"></span><input class="liinput" data-index="'+index+'" type="text" value="'+name+'" readOnly="readOnly"/>';
		html+='<a href="javascript:void(0);" onclick="editRecord(this)" class="fa fa-pencil-square" title="编辑" style="margin-left:2px;"></a>';
		html+='<a href="javascript:void(0);" onclick="delRecord(this)" class="fa fa-minus-square" title="删除"></a></li>';
		$("#queryRecords").find("ul").append(html);
	}
}
function editRecord(obj){
	var input = $(obj).prev("input");
	input.addClass("active").removeAttr("readOnly").focus();
	//var oldvalue = input.val();
	var index = input.data("index");
	input.bind("change",function(){
		queryConditionArr[index].name = input.val();
		saveHistory();
		input.removeClass("active").attr("readOnly","readOnly");
	});
}
function delRecord(obj){
	var input = $(obj).prev().prev("input");
	var index = input.data("index");
	//queryConditionArr[index] = {};
	queryConditionArr.splice(index,1);
	saveHistory();
	$(obj).closest("li").remove();
	$("#queryRecords ul").children("li").each(function(dataindex){
		$(this).find("input.liinput").data("index",dataindex);
	});
	
}
//查询历史操作
function saveHistory() {
	var history = new Array();
	for ( var i = 0; i < queryConditionArr.length; i++) {
		if (!!queryConditionArr[i]) {
			history.push(queryConditionArr[i]);
		}
	}
	var storageFlag = '${tableName}'+'his';//存储数据区分
	storage.set(storageFlag, JSON.stringify(history));
}

//当字段改变时，改变对应值的录入模式
function setConsModel(obj){
	//获取select选中值的data属性
	var popup = $(obj).find("option:selected").data("popup");
	var dictionary = $(obj).find("option:selected").data("dictionary");
	var convaltd = $(obj).closest("tr").find("td.convaltd");
	convaltd.empty();
	if(popup && dictionary.indexOf(',')>0) {
		var splitArr = dictionary.split(",");//splitArr=dictionary 0为表编码,1为目的字段,2为源字段
		var consName = convaltd.find("input").attr("name");
		var html = '<input name="'+consName+'" type="text" class="searchbox-inputtext" onclick="popupClick(this,\''+splitArr[2]+'\',\'val\',\''+splitArr[0]+'\')" style="width:140px;background:url(\'plug-in/diy/icons/search.png\') no-repeat 105px"/>';
		convaltd.html(html);
	}else{
		convaltd.html($("#field_"+$(obj).val()).html());
		layerDateInit(convaltd);
	}
	resetTrNum();
}

//时间插件
function layerDateInit(td){
	var input = td.find("input.layerdate");
	if(input.length>0){
		var format = input.data("format");
		var dateval = input.val();
		if(!!format){
			laydate.render({
    			elem: input[0],
    			type: format,
    			trigger: 'click',
    			value:dateval
    		}); 
		}
	}
}

$(document).ready(function() {
	$(document).on("blur", ".liinput", function(){ 
		$(this).removeClass("active").attr("readOnly","readOnly");
	});
	storage = $.localStorage;
	if (!storage){
		storage = $.cookieStorage;
	}
	var h = storage.get('${tableName}'+'his');
	if (!!h) {
		queryConditionArr = h;
		$("#queryRecords ul").find("li").remove();
		for ( var i = 0; i < queryConditionArr.length; i++) {
			if (!!queryConditionArr[i]) {
				addOneRecord(i, queryConditionArr[i].name);
			}
		}
	}
});
</script>
<!-- Modal -->
<div class="modal fade" id="superQueryModal" tabindex="-1" role="dialog" aria-labelledby="superQueryTitle">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        	<span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id="superQueryTitle">高级查询</h4>
      </div>
      <div class="modal-body">

      	<#-- 内容开始  style="border-right:1px solid #ddd" -->
      	<div class="row">
      		<#-- 左侧-begin -->
      		<div class="left-div col-sm-9 col-md-9" >
      			<div class="left-top-content">
	      			<label for="mchtyp">过滤条件匹配:</label>
	      			<#-- 过滤条件匹配 and/or -->
	  				<select id="anyallSelect" name="mchtyp" style="width: 200px" class="select form-control input-sm">
						<option value="and" selected="selected">And(所有条件都要求匹配)</option>
						<option value="or">Or(条件中的任何一个匹配)</option>
					</select>
					<#-- 过滤条件匹配 and/or -->
				</div>
				<div class="left-content">
	      			<table id="superQueryCondition">
	      			<tr>
	      				<td>
	      				<#-- 字段选择 -->
	      				<select class="field form-control input-sm" id="field" name="cons[0].fld" style="width:140px" onchange="setConsModel(this)" >
							<option value="">&nbsp;</option>
							<#list fields as column>
								<#if '${column.hidden?string("true", "false")}' != "true">
									<option value="${column.field}" data-popup="${column.popup?string}" data-dictionary="${column.dictionary!}">${column.title!}</option>
								</#if>
							</#list>
						</select> 
	      				</td>
	      				<td>
	      					<#-- 条件选择 -->
		      				<select id="condition" name="cons[0].ctyp" class="compareType form-control input-sm" style="width: 140px;margin: 1px;">
								<option value="">&nbsp;</option>
								<option value="=">等于</option>
								<option value="!=">不等于</option>
								<option value=">">大于</option>
								<option value=">=">大于等于</option>
								<option value="&lt;">小于</option>
								<option value="&le;">小于等于</option>
								<option value="likeBegin">以...开始</option>
								<option value="likeEnd">以...结束</option>
								<option value="like">包含</option>
								<option value="not like">不包含</option>
								<option value="in">在...中</option>
								<option value="not in">不在...中</option>
							</select> 
	      				</td>
	      				<td class="convaltd">
	      					<#-- 值录入 -->
	      					<input name="cons[0].val" type="text" class="text conditionValue form-control input-sm" title="" style="width:140px;">
	      				</td>
	      				<td>
	      					<#-- 操作列 -->
	      					<a href="javascript:void(0);" onclick="addOneRow()" class="fa fa-plus-square" title="添加一个新的过滤条件" style="margin-left:8px;"></a> 
							<a href="javascript:void(0);" onclick="delOneRow(this)" class="fa fa-minus-square" title="删除此过滤条件" style="margin-left:10px;"></a>
	      				</td>
	      			</tr>
	      			</table>
				</div>
      		</div>
      		<#-- 左侧-end -->
      		<#-- 右侧-begin -->
      		<div class="col-sm-3 col-md-3">
      			  <div class="panel panel-default">
				    <div class="panel-heading" role="tab" id="headingOne">
				      <h4 class="panel-title">
				        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#queryRecords" aria-expanded="true" aria-controls="collapseOne">
				          	查询历史
				        </a>
				      </h4>
				    </div>
				    <div id="queryRecords" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
				      <div class="panel-body">
				        <ul class="list-group">
						</ul>
				      </div>
				    </div>
				  </div>
      		</div>
      		<#-- 右侧-end -->
      	</div><#-- row-end -->
      	
      <#-- 内容结束 -->
      </div>
      <div class="modal-footer">
      	 <button type="button" class="btn btn-default btn-sm" onclick="superQuerySearch()">
   	 	 	<span class="glyphicon glyphicon-ok"></span>查询
		 </button>
		 <button type="button" class="btn btn-default btn-sm" onclick="superQueryReset()">
   	 	 	<span class="glyphicon glyphicon-repeat"></span>重置
		 </button>
		 <button type="button" class="btn btn-default btn-sm" onclick="saveCurrCondition()">
   	 	 	<span class="glyphicon glyphicon-floppy-disk"></span>另存为查询方案
		 </button>
         <#-- <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>-->
      </div>
    </div>
  </div>
</div>


<table style="display:none" id="superQueryConditionTemplate">
<tr>
	<td>
	<select class="field form-control input-sm" id="field" name="cons[#index#].fld" style="width:140px" onchange="setConsModel(this)" >
		<option value="">&nbsp;</option>
		<#list fields as column>
			<#if '${column.hidden?string("true", "false")}' != "true">
				<option value="${column.field}" data-popup="${column.popup?string}" data-dictionary="${column.dictionary!}">${column.title!}</option>
			</#if>
		</#list>
	</select> 
	</td>
	<td>
		<select id="condition" name="cons[#index#].ctyp" class="compareType form-control input-sm" style="width: 140px;margin: 1px;">
			<option value="">&nbsp;</option>
			<option value="=">等于</option>
			<option value="!=">不等于</option>
			<option value=">">大于</option>
			<option value=">=">大于等于</option>
			<option value="&lt;">小于</option>
			<option value="&le;">小于等于</option>
			<option value="likeBegin">以...开始</option>
			<option value="likeEnd">以...结束</option>
			<option value="like">包含</option>
			<option value="not like">不包含</option>
			<option value="in">在...中</option>
			<option value="not in">不在...中</option>
		</select> 
	</td>
	<td class="convaltd">
		<input name="cons[#index#].val" type="text" class="text conditionValue form-control input-sm" title="" style="width:140px;">
	</td>
	<td>
		<a href="javascript:void(0);" onclick="addOneRow()" class="fa fa-plus-square" title="添加一个新的过滤条件" style="margin-left:8px;"></a> 
		<a href="javascript:void(0);" onclick="delOneRow(this)" class="fa fa-minus-square" title="删除此过滤条件" style="margin-left:10px;"></a>
	</td>
</tr>
</table>
<div style="display:none">
	<#list fields as column>		
		<#if column.formatter??>
			<span id="field_${column.field}">
				<input name="cons[#index#].val" data-format = "<#if column.formatter?length gt 10>datetime<#else>date</#if>" type="text" style="width:140px;" class="layerdate text conditionValue form-control input-sm" title="">
			</span>
		<#elseif column.dictionary??>				
			<#list valueList as val>
				<#if '${column.field}' == '${val.name}'>
					<span id="field_${column.field}">
						<select name="cons[#index#].val" style="width:140px;margin: 1px;" class="form-control input-sm">
						<#list val.value?split(',') as x>
							<#-- update-begin-Author:LiShaoQing -- date:20180111 for:Option的Value为Text,存储取值为VAL---- -->
						 	<option value="${x}">${val.text?split(",")[x_index]}</option>
						 	<#-- update-end-Author:LiShaoQing -- date:20180111 for:Option的Value为Text,存储取值为VAL---- -->
						</#list>
						</select>
					</span>
				</#if>
			</#list>
		<#else>
			<span id="field_${column.field}"><input name="cons[#index#].val" type="text" class="text conditionValue form-control input-sm" title="" style="width:140px;"></span>
		</#if>
	</#list>
</div>