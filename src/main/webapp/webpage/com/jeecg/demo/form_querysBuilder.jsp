<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
	<div region="center" style="padding: 1px;">
		<t:datagrid name="jeecgDemoListquery" title="高级查询示例"
			actionUrl="jeecgListDemoController.do?datagrid" idField="id"
			queryMode="group" checkbox="true" superQuery="true"
			extendParams="headerContextMenu: [
                { text: '保存列定义', iconCls: 'icon-save', disabled: false, handler: function () { saveHeader(); } },
                { text: '自定义菜单', iconCls: 'icon-reload', disabled: false, handler: function (e, field) { alert($.string.format('您点击了{0}', field)); } }
            ],">
			<t:dgCol title="编号" field="id" hidden="true"></t:dgCol>
			<t:dgCol title="用户名" popup="true" dictionary="user_msg,account,realname" field="name" query="true"></t:dgCol>
			<t:dgCol title="个人介绍" field="content" query="true"></t:dgCol>
			<t:dgCol title="办公电话" field="phone" query="true"></t:dgCol>
			<t:dgCol title="创建日期" field="createDate" formatter="yyyy-MM-dd" query="true" queryMode="group"></t:dgCol>
			<t:dgCol title="邮箱" field="email" popup="true" dictionary="user_msg,account,realname" query="true"></t:dgCol>
			<t:dgCol title="年龄" sortable="true" field="age" query="true"></t:dgCol>
			<t:dgCol title="工资" field="salary" query="true"></t:dgCol>
			<t:dgCol title="生日" field="birthday" formatter="yyyy/MM/dd" query="true"></t:dgCol>
			<%-- <t:dgToolBar operationCode="add" title="高级查询" icon="icon-search" funname="queryBuilder"></t:dgToolBar> --%>
		</t:datagrid>
	</div>
</div>
<!-- <div style="position: relative; overflow: auto;">
	<div id="w" class="easyui-window" data-options="closed:true,title:'高级查询构造器'" style="width: 700px; height: 370px; padding: 0px">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'east',split:true" style="width: 130px">
				<div class="easyui-accordion" style="width: 120px; height: 300px;">
					<div title="查询历史" data-options="iconCls:'icon-search'"
						style="padding: 0px;">
						<ul id="tt" class="easyui-tree"
							data-options="onClick:function(node){//单击事件
		       			historyQuery( node.id);  
		    		},ondbClick: function(node){
		    			alert('s');
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
					<li class="conditions oop" id="dsLI">
					<span>
						<select class="field" id="field" name="cons[0].fld">
							<option value="">&nbsp;</option>
							<option value="name">用户名</option>
							<option value="content">个人介绍</option>
							<option value="phone">办公电话</option>
							<option value="createDate">创建日期</option>
							<option value="email">邮箱</option>
							<option value="age">年龄</option>
							<option value="salary">工资</option>
							<option value="birthday">生日</option>
					</select> 
					</span> 
					<span> 
						<select id="condition" name="cons[0].ctyp" class="compareType" style="width: 150px">
								<option>&nbsp;</option>
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
					<span style="position: relative; z-index: 2000;"> 
						<input id="conValue" name="cons[0].val" type="text" class="text conditionValue" title=""> 
					</span> 
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
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="javascript:$('#w').window('close')">Cancel</a>
			</div>
		</div>
	</div>
</div>
				<ul  id="dsUL_template" style="display:none">
					<li class="conditions oop">
					<span>
						<select class="field" id="field" name="cons[#index#].fld">
							<option value="">&nbsp;</option>
							<option value="name">用户名</option>
							<option value="content">个人介绍</option>
							<option value="phone">办公电话</option>
							<option value="createDate">创建日期</option>
							<option value="email">邮箱</option>
							<option value="age">年龄</option>
							<option value="salary">工资</option>
							<option value="birthday">生日</option>
						</select> 
					</span> 
					<span> 
						<select id="condition" name="cons[#index#].ctyp" class="compareType" style="width: 150px">
							<option>&nbsp;</option>
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
					<span style="position: relative; z-index: 2000;"> 
						<input id="conValue1" name="cons[#index#].val" type="text" class="text conditionValue" title=""> 
					</span> 
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

<script type="text/javascript">
	function onContextMenu(e, row) {
		e.preventDefault();
		$(this).treegrid('select', row.id);
		$('#mm').menu('show', {
			left : e.pageX,
			top : e.pageY
		});
	}
	var his = new Array();
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
					var cValue = $(this).find("input[name='cons["+(i-2)+"].val']").val();
					//判断输入的是否为时期格式
					if (CheckDate(cValue)) {
						if (condition == "=") {
							condition = "like";
							cValue = "%" + cValue;
						}
					}
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
		console.log(json.toString());
		$("#_sqlbuilder").val(json.toString());
		var isnew = true;
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
		}
		//-----------------------
		jeecgDemoListquerysearch();
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
	}
	//初始化下标
	function resetTrNum() {
		$('#dsUL').find('li').each(
				function(i) {
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
		$("#_sqlbuilder").val(null);
		jeecgDemoListquerysearch();
		resetTrNum();
	}
	//判断输入的是否为日期格式
	function CheckDate(strInputDate) {
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
	}
	$(document).ready(
			function() {
				resetTrNum();
				storage = $.localStorage;
				if (!storage)
					storage = $.cookieStorage;
				var h = storage.get('his');
				if (h) {
					his = h;
					for ( var i = 0; i < his.length; i++) {
						if (his[i])
							appendTree(i, his[i].name);
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
		var data = JSON.parse(queryCons);
		var t = $('#dsUL');
		for(var i = 0; i < data.length; i++) {
			if(i==0) {
				$("#dsUL").find("select[name='cons[0].fld']").val(data[i].field);
				$("#dsUL").find("select[name='cons[0].ctyp']").val(data[i].condition);
				$("#dsUL").find("input[name='cons[0].val']").val(data[i].value);
				$("#anyallSelect").val(data[i].relation);
			} else {
				addULChild_template(i,data[i].value,data[i].condition,data[i].field);
			}
		}
		$('#_sqlbuilder').val(queryCons);
		jeecgDemoListquerysearch();
	}
	//查询历史操作
	function saveHistory() {
		var history = new Array();
		for ( var i = 0; i < his.length; i++) {
			if (his[i]) {
				history.push(his[i]);
			}
		}
		storage.set('his', JSON.stringify(history));
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
	//添加右侧历史记录
	function appendTree(id, name) {
		$('#tt').tree('append', {
			data : [ {
				id : id,
				text : name
			} ]
		});
	}
</script> -->
