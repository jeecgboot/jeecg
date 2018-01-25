<script type="text/javascript" src="plug-in/tools/curdtools_zh-cn.js"></script>
<div style="position: relative; overflow: auto;">
	<div id="w" class="easyui-window" data-options="closed:true,title:'高级查询构造器'" style="width: 780px; height: 370px; padding: 0px">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'east',split:false" style="width: 128px;">
				<div class="easyui-accordion" style="width: 126px; height: 284px;">
					<div title="查询历史" data-options="iconCls:'icon-search'"
						style="padding: 0px;">
						<ul id="tt" class="easyui-tree"
							data-options="onClick:function(node){//单击事件
		       			historyQuery( node.id);  
		    		},ondbClick: function(node){
						$(this).tree('beginEdit',node.target);
					},onContextMenu: function(e,node){
						e.preventDefault();
						$(this).tree('select',node.target);
						$('#mmTree').menu('show',{
							left: e.pageX,
							top: e.pageY
						});
					},  
		         onAfterEdit:function(node){  
		            if(node.text!=''){ 
		            	his[node.id].name=node.text; 
		            	saveHistory();
		            }
			}">
						</ul>
					</div>
				</div>
			</div>
			<div data-options="region:'center'" style="padding: 0px;">
				<ul id="dsUL">
					<li id="anyAll" class="conditionType">
					<span class="anyAll">
							过滤条件匹配： 
						<select id="anyallSelect" name="mchtyp"
							style="width: 200px" class="select">
								<option value="and" selected="selected">And(所有条件都要求匹配)</option>
								<option value="or">Or(条件中的任何一个匹配)</option>
						</select> 
					</span>
					</li>
					<li><hr style="border: 1px dotted #036" /></li>
					<li class="conditions oop" id="dsLI" style="height: 29px;" data-index="0">
					<span>
						<#-- update-begin-Author:xuelin  Date:20171211 for：TASK #2441 【改造】高级查询目前只支持输入框，不支持下拉和时间控件 -->
						<select class="field" id="field" name="cons[0].fld"  onchange="setConsModel(this)" >
							<option value="">&nbsp;</option>
							<#list fields as column>
								<#--update-begin--Author:xuelin  Date:20171108 for：[#2404]【平台UI改造】UI样式改造点--高级查询弹出窗口遮挡 -->
								<#if '${column.hidden?string("true", "false")}' != "true">
									<#--update-begin--Author:LiShaoQing  Date:20180110 for：[#2452]【新功能】高级查询，支持popup功能 -->
									<option value="${column.field}" data-popup="${column.popup?string}" data-dictionary="${column.dictionary!}">${column.title!}</option>
									<#--update-end--Author:LiShaoQing  Date:20180110 for：[#2452]【新功能】高级查询，支持popup功能 -->
								</#if>
								<#--update-end--Author:xuelin  Date:20171108 for：[#2404]【平台UI改造】UI样式改造点--高级查询弹出窗口遮挡 -->
							</#list>
						</select> 
						<#-- update-end-Author:xuelin  Date:20171211 for：TASK #2441 【改造】高级查询目前只支持输入框，不支持下拉和时间控件 -->
					</span> 
					<span> 
						<select id="condition" name="cons[0].ctyp" class="compareType" style="width: 150px;margin: 1px;">
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
					</span> 
					<#-- update-begin-Author:xuelin  Date:20171211 for：TASK #2441 【改造】高级查询目前只支持输入框，不支持下拉和时间控件 -->
					<span style="position: relative; z-index: 2000;" class="conVal">
							<input id="conValue" name="cons[0].val" type="text" class="text conditionValue" title="" style="width:130px;height:27px;"> 						
					</span> 
					<#-- update-end-Author:xuelin  Date:20171211 for：TASK #2441 【改造】高级查询目前只支持输入框，不支持下拉和时间控件 -->
					<span> 
						<a id="add" href="javascript:addULChild()" class="fa fa-plus-square" title="添加一个新的过滤条件" style="margin-left: 3px;"></a> 
						<a id="delete" href="javascript:void(0)" onclick="deleteULChild(this)" class="fa fa-minus-square" title="删除此过滤条件" style="margin-left: 23px;"></a> 
					</span>
					</li>
				</ul>
			</div>
			<div data-options="region:'south',border:false"
				style="text-align: right; padding: 5px 0 0;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="javascript:mySearch()">OK</a> 
				<a href="#" class="easyui-linkbutton" iconCls="icon-reload" onclick="searchReset()">重置</a> 
				<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" href="javascript:void(0)" onclick="saveBySelect()">另存为查询方案</a>
			</div>
		</div>
	</div>
</div>
				<ul  id="dsUL_template" style="display:none">
					<li class="conditions oop"  style="height: 29px;" data-index="#index#">
					<span>
						<#-- update-begin-Author:xuelin  Date:20171211 for：TASK #2441 【改造】高级查询目前只支持输入框，不支持下拉和时间控件 -->
						<select class="field" id="field" name="cons[#index#].fld" onchange="setConsModel(this)" >
							<option value="">&nbsp;</option>
							<#list fields as column>
							<#--update-begin--Author:xuelin  Date:20171108 for：[#2404]【平台UI改造】UI样式改造点--高级查询弹出窗口遮挡 -->
								<#if '${column.hidden?string("true", "false")}' != "true">
									<option value="${column.field}" data-popup="${column.popup?string}" data-dictionary="${column.dictionary!}">${column.title!}</option>
								</#if>
							<#--update-end--Author:xuelin  Date:20171108 for：[#2404]【平台UI改造】UI样式改造点--高级查询弹出窗口遮挡 -->
							</#list>
						</select> 
						<#-- update-end-Author:xuelin  Date:20171211 for：TASK #2441 【改造】高级查询目前只支持输入框，不支持下拉和时间控件 -->
					</span> 
					<span> 
						<select id="condition" name="cons[#index#].ctyp" class="compareType" style="width: 150px;margin: 1px;">
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
					</span> 
					<#-- update-begin-Author:xuelin  Date:20171211 for：TASK #2441 【改造】高级查询目前只支持输入框，不支持下拉和时间控件 -->
					<span style="position: relative; z-index: 2000;" class="conVal">
						<input id="conValue1" name="cons[#index#].val" type="text" class="text conditionValue" title="" style="width:130px;height:27px;"> 
					</span>
					<#-- update-end-Author:xuelin  Date:20171211 for：TASK #2441 【改造】高级查询目前只支持输入框，不支持下拉和时间控件 --> 
					<span> 
						<a id="add" href="javascript:addULChild()" class="fa fa-plus-square"	title="添加一个新的过滤条件" style="margin-left: 3px;"></a> 
						<a id="delete" href="javascript:void(0)" onclick="deleteULChild(this)" class="fa fa-minus-square" title="删除此过滤条件"  style="margin-left: 23px;"></a> 
					</span>
					</li>
				</ul>
<div id="mmTree" class="easyui-menu" style="width: 100px;">
	<div onclick="editTree()" data-options="iconCls:'icon-edit'">编辑</div>
	<div onclick="deleteTree()" data-options="iconCls:'icon-remove'">删除</div>
</div>
<script type="text/javascript" src="plug-in/jquery/jquery.cookie.js"></script>
<script type="text/javascript" src="plug-in/jquery-plugs/storage/jquery.storageapi.min.js"></script>
<#-- update-begin-Author:xuelin  Date:20171211 for：TASK #2441 【改造】高级查询目前只支持输入框，不支持下拉和时间控件 -->
<span style="display:none;">
		<#list fields as column>		
			<#if column.formatter??>
				<span id="field_${column.field}">
					<input id="conValue1" name="cons[#index#].val" type="text" style="width:130px;height:27px;" onclick="WdatePicker({dateFmt:'${column.formatter}'})" class="Wdate text conditionValue" title="">
				</span>
			<#elseif column.dictionary??>				
				<#list valueList as val>
					<#if '${column.field}' == '${val.name}'>
						<span id="field_${column.field}">
							<select id="conValue1" name="cons[#index#].val" style="width:130px;margin: 1px;">
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
				<span id="field_${column.field}"><input id="conValue1" name="cons[#index#].val" type="text" class="text conditionValue" title="" style="width:130px;height:27px;"></span>
			</#if>
		</#list>
</span>
<#-- update-end-Author:xuelin  Date:20171211 for：TASK #2441 【改造】高级查询目前只支持输入框，不支持下拉和时间控件 -->
<script type="text/javascript">

	<#-- update-begin-Author:xuelin  Date:20171211 for：TASK #2441 【改造】高级查询目前只支持输入框，不支持下拉和时间控件 -->
	function setConsModel(field){
		$(field).parent().parent().find(".conVal").html($("#field_"+$(field).val()).html());
		<#-- update-begin--Author:LiShaoQing  Date:20180110 for：[#2452]【新功能】高级查询，支持popup功能 -->
		var index = $(field).closest("#dsUL>li").data("index");
		//获取select选中值的data属性
		var popup = $(field).find("option:selected").data("popup");
		var dictionary = $(field).find("option:selected").data("dictionary");
		if(popup&&dictionary.indexOf(',')>0) {
			var splitArr = new Array();
			splitArr = dictionary.split(",");
			var spanVal = $(field).closest("#dsUL>li").find("span.conVal");
			//splitArr=dictionary 0为表编码,1为查询字段,2为返回字段
			spanVal.html("<input name=\"cons["+index+"].val\" type=\"text\" class=\"searchbox-inputtext\" onclick=\"popupClick(this,'"+splitArr[1]+"','val','"+splitArr[0]+"')\"/>");
			$("input[name='cons["+index+"].val']").css({"background":"url(\"plug-in/diy/icons/search.png\") no-repeat 105px","width":"130px"});
		}
		<#--update-end--Author:LiShaoQing  Date:20180110 for：[#2452]【新功能】高级查询，支持popup功能 -->
		
		resetTrNum();
	}
	<#-- update-end-Author:xuelin  Date:20171211 for：TASK #2441 【改造】高级查询目前只支持输入框，不支持下拉和时间控件 -->

	function onContextMenu(e, row) {
		e.preventDefault();
		$(this).treegrid('select', row.id);
		$('#mm').menu('show', {
			left : e.pageX,
			top : e.pageY
		});
	}
	var his = new Array();
	var saveAsJson;
	//查询并保存数据
	function mySearch() {
		//多条件查询
		//-----------------------
		var idIndex = 100;
		//获取页面上And，Or
		var relation = $("#anyallSelect").val();
		var dsli = $("#dsLI");
		var json = new StringBuffer();
		$("#dsUL li").each(
				function(i) {
					idIndex++;
					if(i<=1){
						return;
					}
					var field = $(this).find("select[name='cons["+(i-2)+"].fld']").val();
					var condition = $(this).find("select[name='cons["+(i-2)+"].ctyp']").val();
					<#-- update-begin-Author:xuelin  Date:20171211 for：TASK #2441 【改造】高级查询目前只支持输入框，不支持下拉和时间控件 -->
					var cValue = $(this).find("input[name='cons["+(i-2)+"].val'],select[name='cons["+(i-2)+"].val']").val();
					<#-- update-end-Author:xuelin  Date:20171211 for：TASK #2441 【改造】高级查询目前只支持输入框，不支持下拉和时间控件 -->
					
					<#-- update-begin-Author:xuelin  Date:20171221 for：TASK #2399 【bug】高级查询，条件为空的情况下，点击查询报错 -->
					if(field === '' && condition === '' && cValue === ''){
						return ture;
					}
					<#-- update-end-Author:xuelin  Date:20171221 for：TASK #2399 【bug】高级查询，条件为空的情况下，点击查询报错 -->
					//判断输入的是否为时期格式
					/*if (CheckDate(cValue)) {
						if (condition == "=") {
							condition = "like";
							cValue = "%" + cValue;
						}
					}*/
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
					if ((i-2) == 0) {
						json.append("{\"id\":" + idIndex + ",\"field\":\""
								+ field + "\",\"condition\":\"" + condition
								+ "\",\"value\":\"" + cValue
								+ "\",\"relation\":\"" + relation
								+ "\",\"state\":\"open\"}");
					}
					if ((i-2) != 0) {
						json.append("{\"id\":" + idIndex + ",\"field\":\""
								+ field + "\",\"condition\":\"" + condition
								+ "\",\"value\":\"" + cValue
								+ "\",\"relation\":\"" + relation
								+ "\",\"state\":\"open\"}");
					}
				});
		$("#_sqlbuilder").val(json.toString());
		saveAsJson = json;
		/*var isnew = true;
		//验证右侧是否存在相同的记录
		for ( var i = 0; i < his.length; i++) {
			//比较JSON
			if (his[i] && his[i].json == json.toString()) {
				isnew = false;
			}
		}
		if (isnew) {
			his.push({
				name : 'Query' + his.length,
				json : json
			});
			saveHistory();
			var name = 'Query' + (his.length - 1);
			appendTree(his.length - 1, name);
		}*/
		//-----------------------
		${tableName}search();
	}

	//添加StringBuffer
	function StringBuffer() {
		this.strings = new Array;
	}

	StringBuffer.prototype.append = function(str) {
		this.strings.push(str); //追加指定元素  
	};

	StringBuffer.prototype.toString = function() {
		return "["+this.strings.join(",")+"]"; //向数组之间的元素插入指定字符串（此处为空字符串），并返回。  
	};
	//添加相同的li
	function addULChild() {
		var dsUL_template = $("#dsUL_template").html();
		$("#dsUL").append(dsUL_template);
		resetTrNum();
	}
	//添加模版li
	function addULChild_template(i,value,condition,field) {
		var dsUL_template = $("#dsUL_template").html();
		$("#dsUL").append(dsUL_template);
		resetTrNum();
		$("#dsUL").find("select[name='cons["+i+"].fld']").val(field);
		$("#dsUL").find("select[name='cons["+i+"].ctyp']").val(condition);
		$("#dsUL").find("input[name='cons["+i+"].val']").val(value);
		var field = $("#dsUL").find("select[name='cons["+i+"].fld']").find("option:selected");
		echoField(i,field,value);
	}
	//初始化下标
	function resetTrNum() {
		$('#dsUL').find('li').each(
				function(i) {
				var index=$(this).attr("data-index");
				if(!!index){
					$(this).attr("data-index",i-2);
				}
					$(':input,select', this).each(
							function() {
								var thisli = $(this);
								var name = thisli.attr('name');
								if (name != null) {
									var reg = new RegExp("^cons");
									if (reg.test(name)) {
										if (name.indexOf("#index#") >= 0) {
											thisli.attr("name", name.replace(
													'#index#', i - 2));
										} else {
											var s = name.indexOf("[");
											var e = name.indexOf("]");
											var new_name = name.substring(
													s + 1, e);
											thisli.attr("name", name.replace(
													new_name, i - 2));
										}
									}
								}
							});
				});
	}
	//删除当前li
	function deleteULChild(obj) {
		var len = $("#dsUL").find("li").length;
		if (len > 3) {
			$(obj).parent().parent().remove();
			resetTrNum();
		}
	
	}
	//重置按钮，清空所有
	function searchReset() {
		$("#dsUL").find(".oop:gt(0)").remove();
		$("#dsLI").find(":input").val("");
		var spanVal = $("#dsUL>li").find("span.conVal");
		spanVal.html("<input name='cons[0].val' type='text' style='width:130px;' class='text conditionValue'>");
		$("#_sqlbuilder").val(null);
		${tableName}search();
		resetTrNum();
	}
	//判断输入的是否为日期格式
	/*function CheckDate(strInputDate) {
		if (strInputDate == "")
			return false;
		if(strInputDate!="" && strInputDate!=null){
			strInputDate = strInputDate.replace(/-/g, "/");
		}
		var d = new Date(strInputDate);
		if (isNaN(d))
			return false;
		var arr = strInputDate.split("/");
		return ((parseInt(arr[0], 10) == d.getFullYear())
				&& (parseInt(arr[1], 10) == (d.getMonth() + 1)) && (parseInt(
				arr[2], 10) == d.getDate()));
	}*/
	//update-begin--Author:xuelin  Date:20171101 for：TASK #2404 【平台UI改造】UI样式改造点---高级查询弹出窗口遮挡----
	//让window居中
	var easyuiPanelOnOpen = function (left, top) {
	    var iframeWidth = $(this).parent().parent().width();
	   
	    var iframeHeight = $(this).parent().parent().height();
	
	    var windowWidth = $(this).parent().width();
	    var windowHeight = $(this).parent().height();
	
	    var setWidth = (iframeWidth - windowWidth) / 2;
	    var setHeight = (iframeHeight - windowHeight) / 2;
	    $(this).parent().css({//修正面板位置 
	        left: setWidth,
	        top: setHeight
	    });
	
	    if (iframeHeight < windowHeight)
	    {
	        $(this).parent().css({//修正面板位置 
	            left: setWidth,
	            top: 0
	        });
	    }
	    $(".window-shadow").hide();
	};
	$.fn.window.defaults.onOpen = easyuiPanelOnOpen;
	//update-end--Author:xuelin  Date:20171101 for：TASK #2404 【平台UI改造】UI样式改造点---高级查询弹出窗口遮挡----
	$(document).ready(
	
			function() {
				resetTrNum();
				storage = $.localStorage;
				if (!storage)
					storage = $.cookieStorage;
				var h = storage.get('${tableName}'+'his');
				if (h) {
					his = h;
					$('#tt li').remove();
					for ( var i = 0; i < his.length; i++) {
						if (his[i]) {
							appendTree(i, his[i].name);
						}
					}
				}
			});
	//打开高级查询框
	function queryBuilder() {
		$('#w').window('open');
	}
	//点击历史记录触发事件
	function historyQuery(index) {
		$("#dsUL").find(".oop:gt(0)").remove();
		$("#dsLI").find(":input").val("");
		var queryCons = "["+his[index].json.strings+"]";
		var queryCondition = queryCons;
		var data = JSON.parse(queryCons);
		var t = $('#dsUL');
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
			if(i==0) {
				$("#dsUL").find("select[name='cons[0].fld']").val(data[i].field);
				$("#dsUL").find("select[name='cons[0].ctyp']").val(condition);
				$("#dsUL").find("input[name='cons[0].val']").val(v);
				$("#anyallSelect").val(data[i].relation);
				var field = $("#dsUL").find("select[name='cons[0].fld']").find("option:selected");
				echoField(i,field,v);
			} else {
				addULChild_template(i,v,condition,data[i].field);
			}
		}
		$('#_sqlbuilder').val(queryCondition);
		${tableName}search();
	}
	
	//回显字段类型
	function echoField(i,field,v) {
		//获取当前field的data属性
		var popup = $(field).data("popup");
		var dictionary = $(field).data("dictionary");
		//sel为字段名称
		var sel = $(field).val();
		var spanVal = $(field).closest("#dsUL>li").find("span.conVal");
		//判断popup是否为TRUE和dictionary是否有逗号
		var spanHtml="";
		if(popup&&dictionary.indexOf(',')>0) {
			var splitArr = new Array();
			splitArr = dictionary.split(",");
			//splitArr=dictionary 0为表编码,1为查询字段,2为返回字段
			spanHtml+="<input name=\"cons["+i+"].val\" value='"+v+"' type=\"text\" class=\"searchbox-inputtext\" onclick=\"popupClick(this,'"+splitArr[1]+"','val','"+splitArr[0]+"')\"/>";
			spanVal.html(spanHtml);
			$("input[name='cons["+i+"].val']").css({"background":"url(\"plug-in/diy/icons/search.png\") no-repeat 105px","width":"130px"});
		} else {
			//除了popup通用写法
			var tempSpan=$("span#field_"+sel).html();
			spanVal.html(tempSpan);
			$(spanVal).find("[name='cons[#index#].val']").attr("name","cons["+i+"].val").removeAttr("id").val(v);
		}
		
	}
	
	//查询历史操作
	function saveHistory() {
		var history = new Array();
		for ( var i = 0; i < his.length; i++) {
			if (his[i]) {
				history.push(his[i]);
			}
		}
		var tableName = '${tableName}'+'his';	//存储数据区分
		storage.set(tableName, JSON.stringify(history));
	}
	//历史查询记录删除
	function deleteTree() {
		var node = $('#tt').tree('getSelected');
		his[node.id] = null;
		saveHistory();
		$('#tt').tree('remove', node.target);
	}
	//历史查询记录编辑名称
	function editTree() {
		var node = $('#tt').tree('getSelected');
		$('#tt').tree('beginEdit', node.target);
		his[node.id].name = null;
		saveHistory();
	}
	//另存为查询记录
	function saveBySelect() {
		var name = prompt("查询方案名称","");
		if(name!=null && name != "") {
			his.push({
				name : name,
				json : saveAsJson
			});
			saveHistory();
			appendTree(his.length - 1, name);
		}
	}
	
	//添加右侧历史记录
	function appendTree(id, name) {
		$('#tt').tree('append', {
			data : [ {
				id : id,
				text : name,
				iconCls:"icon-history-search"
			} ]
		});
	}
	
</script>
