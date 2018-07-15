<script type="text/javascript" src="plug-in/ztree/js/ztreeCreator.js" ></script>
<link rel="stylesheet" href="plug-in/ztree/css/zTreeStyle.css" type="text/css"/>
<script type="text/javascript" src="plug-in/ztree/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="plug-in/tools/curdtools.js"></script>
<style>
.menuContent{
	filter:alpha(Opacity=100);
} 
.conditionType{
	display: block;
    margin-bottom: 6px;
    padding: 6px 0 8px;
    width: 100%;
}
</style>
<!--高级查询器的弹窗  -->
<div id="w" scroll="no" class="easyui-window" data-options="closed:true,
 resizable:false, title:'高级查询构造器'" style="width: 880px; height: 400px; padding: 0px;">
 <div class="easyui-layout" fit="true">
 	<!--查询历史  -->
 	<div data-options="region:'east',split:false" style="width: 128px;">
				<div class="easyui-accordion" style="width: 126px; height: 316px;">
					<div title="查询历史" data-options="iconCls:'icon-search'"
						style="padding: 0px;">
						<ul id="tt" class="easyui-tree"
							data-options="onClick:function(node){//单击事件
		       			historyQuery( node );  
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
		            	//his[node.id].name=node.text; 
		            	//saveHistory();
		            	updateHistory(node);
		            }
			}">
						</ul>
					</div>
				</div>
			</div>
 
 	<!--查询历史  -->
	<div region="center" style="padding: 1px;">
			<div style="float: left;">
				<div style="float: left; top: 1px">
					<ul id="dsUL">
					<input type="hidden" name="cons[0].mainId" value=""/>
						<li id="anyAll" class="conditionType">
						<span class="anyAll">
								过滤条件匹配：
								 <select id="anyallSelect" name="mchtyp" style="width: 200px" class="select">
									<option value="and" selected="selected">And(所有条件都要求匹配)</option>
									<option value="or">Or(条件中的任何一个匹配)</option>
								</select>
						</span>
						</li>
						<li id="dsLI" name="dsLI" class="conditions oop" data-index="0">
						<span>
							<input id="citySel" name="cons[0].tree" onclick="treeClick(this)" type="text"   style="width:120px;" class=" queryTree" readonly="readonly"  /> &nbsp;
							<input id="tableVal" name="cons[0].hidd" type="hidden" value=""/>
							<input name="cons[0].tableCode" type="hidden" value=""/>
						</span> 
						<span >
							<select id="field" name="cons[0].fld" onchange="changeField(this)">
							</select>
						</span> 
						<span> 
						<select id="condition" name="cons[0].ctyp" class="compareType" style="width: 150px">
									<option>&nbsp;</option>
									<option value="=">等于</option>
									<option value="!=">不等于</option>
									<option value=">">大于</option>
									<option value=">=">大于等于</option>
									<option value="lt">小于</option>
									<option value="lte">小于等于</option>
									<option value="likeBegin">以...开始</option>
									<option value="likeEnd">以...结束</option>
									<option value="like">包含</option>
									<option value="not like">不包含</option>
									<option value="in">在...中</option>
									<option value="not in">不在...中</option>
							</select>
						</span> <span class="spanVal" style="position: relative; z-index: 2000;"> 
						<input id="conValue" name="cons[0].val" type="text" style="width:165px;" class="text conditionValue" title="">
						</span> 
						<span> 
						<a id="add" href="javascript:addULChild()" class="fa fa-plus-square" title="添加一个新的过滤条件" style="margin-left: 3px;"></a>
					    <a id="delete" href="javascript:void(0)" onclick="deleteULChild(this)" class="fa fa-minus-square" title="删除此过滤条件" style="margin-left: 23px;"></a>
						</span>
						</li>
					</ul>
				</div>
				</div>	
		 </div>
		<div data-options="region:'south',border:false"
				style="text-align: right; padding: 5px 0 0;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="javascript:mySearch()">查询</a> 
				<a href="#" class="easyui-linkbutton" iconCls="icon-reload" onclick="searchReset()">重置</a> 
				<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" href="javascript:void(0)" onclick="saveBySelect()">另存为查询方案</a> 
			</div>
	<div id="mmTree" class="easyui-menu" style="width: 100px;">
	<div onclick="editTree()" data-options="iconCls:'icon-edit'">编辑</div>
	<div onclick="deleteTree()" data-options="iconCls:'icon-remove'">删除</div>
	</div>
	
	</div>
	<div id="menuContent" class="menuContent" style="display:none; position: absolute;background:#FFF;overflow:auto;height:120px;border:1px solid #9a848445;">
	<ul id="orgTree" class="ztree" style="margin-top:-7px; width:112px;height:100px;"></ul>
	</div>
	<input type="hidden" name="treeValue" value="" id="treeValue" /> 
	<input type="hidden" name="selectValue" value="" id="selectValue" />
	<input type="hidden" name="queryCode" value="${queryCode}" id="queryCode"/>
	
	<!--隐藏-->
	<ul  id="dsUL_template" style="display:none">
					<li class="conditions oop" data-index="#index#">
					<span>
						<input name="cons[#index#].tree" onclick="treeClick(this)"  type="text"   style="width:120px;" class="tree queryTree" readonly="readonly"  /> &nbsp;
						<input name="cons[#index#].hidd" type="hidden" value=""/>
						<input name="cons[#index#].tableCode" type="hidden" value=""/>
					</span> 
					<span>
						<select class="field" id="field" name="cons[#index#].fld" onchange="changeField(this)">
							 
						</select> 
					</span> 
					<span> 
						<select id="condition" name="cons[#index#].ctyp" class="compareType" style="width: 150px">
							<option >&nbsp;</option>
							<option value="=">等于</option>
							<option value="!=">不等于</option>
							<option value=">">大于</option>
							<option value=">=">大于等于</option>
							<option value="lt">小于</option>
							<option value="lte">小于等于</option>
							<option value="likeBegin">以...开始</option>
							<option value="likeEnd">以...结束</option>
							<option value="like">包含</option>
							<option value="not like">不包含</option>
							<option value="in">在...中</option>
							<option value="not in">不在...中</option>
						</select> 
					</span> 
					<span class="spanVal" style="position: relative; z-index: 2000;"> 
						<input id="conValue1" name="cons[#index#].val" style="width:165px;" type="text" class="text conditionValue" title=""> 
					</span> 
					<span> 
						<a id="add" href="javascript:addULChild()" class="fa fa-plus-square"	title="添加一个新的过滤条件" style="margin-left: 3px;"></a> 
						<a id="delete" href="javascript:void(0)" onclick="deleteULChild(this)" class="fa fa-minus-square" title="删除此过滤条件"  style="margin-left: 23px;"></a> 
					</span>
					</li>
				</ul>
</div>
<script type="text/javascript">
	//高级查询器
	var rowsData;
	function superQuery(queryCode) {
		//打开弹窗
		$('#w').window('open');
		if(queryCode !== null || queryCode !== "") {
			$("#queryCode").val(queryCode);
		}
		//重置 清空所有的 input select 并删除li
		searchReset();
		loadTree();
		//加载当前用户下的历史记录 根据选中的一条数据
		loadHistory();
	}
</script>
<!-- 弹出框页面js -->
 <script type="text/javascript">
 /* 获取所有的option 放在数组中 */
 var optionArr=new Array();
 var saveJson;
 var nArr=new Array();
  
 //历史查询获取json数据 保存在 数据库
function gethistoryDsli(){
	 var select1=new Array();
	 var relation = $("#anyallSelect").val();
		//获取queryCode
		var queryCode=$("#queryCode").val();
		var json = new StringBuffer();
		$("#dsUL li").each(function(i){
			if(i<1){
				return;
			}
			//获取表
			var table=$(this).find("input[name='cons["+(i-1)+"].tree']").val();
			var table1=$(this).find("input[name='cons["+(i-1)+"].hidd']").val();
			//获取条件
			var condition = $(this).find("select[name='cons["+(i-1)+"].ctyp']").val();
			//获取值
			var cValue = $(this).find("[name='cons["+(i-1)+"].val']").val();
					//判断输入的是否为时期格式
					/*if (CheckDate(cValue)) {
						if (condition == "=") {
							condition = "like";
							cValue = "%" + cValue;
						}
					}*/
					//判断table
					if(table==null){
						table="";
					}
					if(table1==null){
						table1="";
					}
					//判断field
					if(field==null){
						field="";
					}
					//判断condition条件，改变sql查询条件
					if (condition == "lt") {
						condition = "<";
					} else if (condition == "lte") {
						condition = "<="
					} else if (condition == "like") {
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
						cValue = "\(" + cValue + "\)"
					}
					//如果是新添加的  获取所有的option 放在数组里 
					/*if(!flg){
						//获取所有的option
						 if(i==1){
						  var a = saveOption(optionArr,i);
						  select1= a.split(",");
						  select1.pop();
						 }	
					} */
					//如果是回显的 修改添加 删除时 重新获取所有的option
					var  optionList=getoption();
					var a = saveOption(optionList,i);
					var bb=a.replace(/"/g,"'");
					select1=bb.split(",");
					select1.pop();
					if (i-1 == 0) {
						json.append("{\"table\":\"" + table + "\",\"table1\":\"" + table1+"\",\"field\":\""
								+ select1[0]+ "\",\"condition\":\"" + condition
								+ "\",\"value\":\"" + cValue
								+ "\",\"relation\":\"" + relation
								+ "\",\"state\":\"open\"}");
					}
					if (i-1 != 0) {
						json.append("{\"table\":\"" + table + "\",\"table1\":\"" + table1+ "\",\"field\":\""
								+ select1[i-1] + "\",\"condition\":\"" + condition
								+ "\",\"value\":\"" + cValue
								+ "\",\"relation\":\"" + relation
								+ "\",\"state\":\"open\"}");
					}	
					
		})
		return json;  
	
}
//获取当前页面上所有的option
function getoption(){
	nArr.splice(0,nArr.length);
	$("#dsUL li").each(function(i){
		if(i<1) return 
		var field = $(this).find("select[name='cons["+(i-1)+"].fld']") ;
		var tmp=field.html()
		 nArr.push(tmp);
	})
	return nArr;
}

//拼接“selected='selected'”
function saveOption(options,i){
	var selectOption="";
	var sel="";
	var selected=" selected='selected'";
	 for (var j = 0; j < options.length; j++) {
			   selectOption=options[j];
			 //获取select中的值
			  $("select[name$='.fld'] option:selected").each(function(m){
				var text=$(this).text();
				if(j==m){
				//回显时去掉 select='selected';
				if(selectOption != null && selectOption != ""){
					if(selectOption.indexOf("selected")>0){
						var remove1=selectOption.substring(0,selectOption.indexOf(' selected="selected"'));
						var remove2=selectOption.substring(selectOption.indexOf(' selected="selected"')+20,selectOption.length);
						selectOption=remove1+remove2;
					}
				}	
				//重新添加
				if(selectOption != null && selectOption != "") {
					if(selectOption.indexOf(text)>0){
						  var sub= selectOption.substring(0,selectOption.indexOf(text)-1);
						  var sub2=sub+selected;
						  var sub3=selectOption.substring(selectOption.indexOf(text)-1,selectOption.length);
						  var sub4=sub2+sub3+",";
						  sel+=sub4;
					}
				}
				}
			 }) 
	} 
	 
	return sel;
}

 //查询获取json数据
 function getDsLi(){
	 var relation = $("#anyallSelect").val();
		//获取queryCode
		var queryCode=$("#queryCode").val();
		var json = new StringBuffer();
		$("#dsUL li").each(function(i){
					if(i<1){
						return;
					}
					//获取表
					var table=$(this).find("input[name='cons["+(i-1)+"].tree']").val();
					var table1=$(this).find("input[name='cons["+(i-1)+"].hidd']").val();
					//获取字段
					var field = $(this).find("select[name='cons["+(i-1)+"].fld']").val();
					//获取条件
					var condition = $(this).find("select[name='cons["+(i-1)+"].ctyp']").val();
					//获取值
					var cValue = $(this).find("[name='cons["+(i-1)+"].val']").val();
					//判断输入的是否为时期格式
					/*if (CheckDate(cValue)) {
						if (condition == "=") {
							condition = "like";
							cValue = "%" + cValue;
						}
					}*/
					if(table==null){
						table="";
					}
					if(table1==null){
						table="";
					}
					//判断field
					if(field==null){
						field="";
					}
					
					//判断condition条件，改变sql查询条件
					if (condition == "lt") {
						condition = "<";
					} else if (condition == "lte") {
						condition = "<="
					} else if (condition == "like") {
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
						cValue = "\(" + cValue + "\)"
					}
					//拼接json格式数据
				  	if(i-1 == 0){
						 json.append("[{\"queryCode\":\"" + queryCode
							 		+ "\",\"relation\":\""+relation
							 		+"\","
							 		+"\"children\":[{\"table\":\"" + table1 
								 	+ "\",\"field\":\"" + field 
							 		+ "\",\"condition\":\"" + condition
							 		+ "\",\"relation\":\""+relation
									+ "\",\"value\":\"" + cValue+"\"}");
					} 
					//json格式数据追加	 
					if (i-1 != 0) {
						json.append(",{\"table\":\"" + table1
								+ "\",\"field\":\"" + field 
								+ "\",\"condition\":\"" + condition 
								+ "\",\"relation\":\""+relation
								+ "\",\"value\":\""  + cValue+"\"}");
					}
		})
		json.append("]}]");
		return json;
 }
 	//查询按钮 点击事件
	function mySearch() {
		var jsonData= getDsLi();
		$("#_complexSqlbuilder").val(jsonData.toString());
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
		return this.strings.join(""); //向数组之间的元素插入指定字符串（此处为空字符串），并返回。  
	};
	//添加相同的li
	function addULChild() {
		var dsUL_template = $("#dsUL_template").html();
		$("#dsUL").append(dsUL_template);
		resetTrNum();
	}
	
	 //初始化下标
	function resetTrNum() {
		$('#dsUL').find('li').each( function(i) {
			var index=$(this).attr("data-index");
			if(!!index){
				$(this).attr("data-index",i-1);
			}
					$(':input,select', this).each( function() {
								var thisli = $(this);
								var name = thisli.attr('name');
								if (name != null) {
									var reg = new RegExp("^cons");
									if (reg.test(name)) {
										if (name.indexOf("#index#") >= 0) {
											thisli.attr("name", name.replace(
													'#index#', i - 1));
										} else {
											var s = name.indexOf("[");
											var e = name.indexOf("]");
											var new_name = name.substring( s + 1, e);
											thisli.attr("name", name.replace( new_name, i - 1));
										}
									}
								}
							});
				});
	} 
	
	//删除当前li
	function deleteULChild(obj) {
		var len = $("#dsUL").find("li").length;
		if (len > 2) {
			$(obj).parent().parent().remove();
			resetTrNum();
		}
	
	}
	
	//重置按钮，清空所有
	function searchReset() {
		$("#dsUL").find(".oop:gt(0)").remove();
		$("#dsLI").find(":input").val("");
		var spanVal = $("#dsUL>li").find("span.spanVal");
		spanVal.html("<input name='cons[0].val' type='text' class='text conditionValue'>");
		$("#field").empty();
		$("#_complexSqlbuilder").val(null);
		${tableName}search();
		resetTrNum();
	}
	//判断输入的是否为日期格式
	/*function CheckDate(strInputDate) {
		if (strInputDate == "") return false;
		strInputDate = strInputDate.replace(/-/g, "/");
		var d = new Date(strInputDate);
		if (isNaN(d)) return false;
		var arr = strInputDate.split("/");
		return ((parseInt(arr[0], 10) == d.getFullYear()) && (parseInt(arr[1], 10) == (d.getMonth() + 1)) && (parseInt(
				arr[2], 10) == d.getDate()));
	}*/
	 
	/* 加载ztree  */
	var orgTree ;
	function loadTree() {
		//获取queryCode编码规则
		var queryCode = $("#queryCode").val();
		var zNodes;
		jQuery.ajax({  
	        async : false,  
	        cache:false,  
	        type: 'POST',  
	        dataType : "json",  
	        url: 'superQueryMainController.do?getTreeData', 
	        data:{
	        	"queryCode":queryCode
	        },
	        error: function () {  
	            tip('服务器未响应，	请稍后再试！');  
	        },  
	        success:function(data){ 
	            zNodes = data.obj;   
	        }  
	    });  
		//ztree初始化
		 var ztreeCreator = new ZtreeCreator('orgTree',"superQueryMainController.do?getTreeData",zNodes)
		 		.setCallback({ onClick:zTreeOnLeftClick})
	 			.initZtree({},function(treeObj){orgTree = treeObj}); 
	};
	 var indexGlobal = "";
	/*ztree点击事件*/
	function zTreeOnLeftClick(e, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("orgTree"),
		nodes = zTree.getSelectedNodes(),
		v = "";
		nodes.sort(function compare(a,b){return a.id-b.id;});
		for (var i=0, l=nodes.length; i<l; i++) {
			v += nodes[i].name + ",";
		}
		if (v.length > 0 ) v = v.substring(0, v.length-1);
		var a =$("#treeValue").val();
		var hidden=a.split(".")[0]+".hidd";
		$("input[name='"+a+"']").val(v);
		$("input[name='"+hidden+"']").val(treeNode.title);
		//获取下拉框
		linkAge(treeNode,indexGlobal);
		//隐藏按钮
		hideMenu();
	}
	 
	/*显示ztree菜单  */
	function showMenu() {
		//获取当前最大DIV位置
		var w = $("#w").parent(".window").offset();
		var val=$("#treeValue").val();
		if(!val) {
			return false;
		}
		//获取当前Input位置
		var cityOffset=$("input[name='"+val+"']").offset();
		//计算文本框相对DIV的位置
		var top = cityOffset.top-w.top+28;
		$("#menuContent").css({top:top +"px"}).slideDown("fast");
		$("body").bind("mousedown", onBodyDown);
	}
	
	/*隐藏ztree菜单*/
	function hideMenu() {
		$("#menuContent").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	 
	/*点击空白处，隐藏ztree*/
	function onBodyDown(event) {
		if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
			hideMenu();
		}
	}
	 
	/* 点击input输入框 显示ztree 并获取当前input的 name值*/
	var treeName=""
	function treeClick(item){
		//TODO 获取文本框的位置显示菜单位置
		var index=$(item).closest("#dsUL>li").data("index");
		indexGlobal = index;
	    treeName=item.name;
		$("#treeValue").val(treeName);
		var selName=treeName.split(".")[0];
		//清空下拉框
		var sName=selName+".fld";
		$("select[name='"+sName+"']").val("");
		showMenu();
	}
	 
	//下拉框ajax请求数据 联动
	function linkAge(treeNode,indexGlobal){
		if(treeNode.title == null || treeNode.title == ""){
			tip("请选择当前表");
			return false;
		}else{
		 	var tableName=treeNode.title;
			jQuery.ajax({  
		        async : false,  
		        cache:false,  
		        type: 'POST',  
		        dataType : "json",  
		        data:{"tableName":tableName},
		        url: 'superQueryMainController.do?getTextByTabelName',
		        success:function(data){ 
		        	var arr = iterators(data);
		    		//下拉框内容 组装option
		    		var content="<option value=''></option>";
		    		if(arr!=null&&arr.length>0){
		    			for (var i = 0; i < arr.length; i++) {
		    				//获取树形获取所有下拉框
		    				content+="<option value='"+arr[i+1]+"'>"+arr[i]+"</option>";
		    				i+=1;
		    			}
		    			//存"<option value='xxx'>xxx</option>"字符串 放在一个数组里
		    			optionArr.push(content);
		    			$("select[name='cons["+indexGlobal+"].fld']").html(content);
		    		}else{
		    			tip("请根据当前表选择字段 ");
		    			return false;
		    		} 
		        },
		        error: function () {
		            tip('服务器未响应，请稍后再试！');  
		        }
		    });  
		}
	}
	
	//Object转数组
	function iterators(item){
		var arr=new Array();
		var mainId = "";
		$.each( item.obj, function(i, n){
				arr.push(n.txt);				
				arr.push(n.name);
				mainId = n.main_id;
    		});
    	$("input[name='cons[0].mainId']").val(mainId);
		return arr;
	}
	
	
/*-------------------------------以下是查询历史记录  -------------------------------*/
	function onContextMenu(e, row) {
		e.preventDefault();
		$(this).treegrid('select', row.id);
		$('#mmTree').menu('show', {
			left : e.pageX,
			top : e.pageY
		});
	}
	//将json存放到数组里
	var his = new Array();
	var h;
	$(document).ready(
			function() {
				resetTrNum();
			});
	//加载history
	function loadHistory(){
		var queryCode = $("#queryCode").val();
		//根据queryCode获取MainId
		jQuery.ajax({  
			type: 'POST',  
			dataType : "json",  
			data:{
				"queryCode":queryCode
			},
			url: 'superQueryMainController.do?getMainIdByQueryCode',
			success:function(data){ 
				if (data.success){
					$("input[name='cons[0].mainId']").val(data.obj);
				} 
			},
			error: function () {
  				tip('服务器未响应，请稍后再试！');  
			}
		});
		//获取当前用户的查询历史
		  jQuery.ajax({  
			async : false,  
			cache:false,  
			type: 'POST',  
			dataType : "json",  
			data:{
				"queryCode":queryCode
			},
			url: 'superQueryMainController.do?getHistoryByUserId',
			success:function(data){ 
				if (data.success){
				 	 h=data.obj;
				} 
			},
			error: function () {
  			tip('服务器未响应，请稍后再试！');  
			}
		});
		$('#tt li').remove();
		if (h) {
			for ( var i = 0; i < h.length; i++) {
				if (h[i]) {
					appendTree(i, h[i]);
				}
			}
		}
	}
	
	//另存为查询记录
	function saveBySelect() {
		//获取queryCode编码规则
		var queryCode = $("#queryCode").val();
		var hisJson=gethistoryDsli();
		var name = prompt("请输入保存方案的名称","");
		if(name!=null && name != "") {
			his.push({
				  name:name, 
				  json : hisJson
			});
		jQuery.ajax({  
	        async : false,  
	        cache:false,  
	        type: 'POST',  
	        dataType : "json",  
	        data:{name:name,json:JSON.stringify(his),"queryCode":queryCode},
	        url: 'superQueryMainController.do?saveHistory',
	        success:function(data){ 
	        	if (data.success){
					appendTree(his.length - 1, name);
				}else{
					tip("系统中已存在此方案名称");
					return ;
				} 
	        },
	        error: function () {
	            tip('服务器未响应，请稍后再试！');  
	        }
	    });
		his.length=0;
		
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
	//历史查询记录删除
	function deleteTree() {
		var node = $('#tt').tree('getSelected');
		jQuery.ajax({  
    		async : false,  
    		cache:false,  
    		type: 'POST',  
    		dataType : "json",  
    		data:{"name":node.text},
    		url: 'superQueryMainController.do?deleteHistoryByName',
    		success:function(data){ 
    			if(data.success=true){
					$('#tt').tree('remove', node.target);
    			}
   			 },
    		error: function () {
        		tip('服务器未响应，请稍后再试！');  
    		}
		});
		
	}
	var nodeName;
	//历史查询记录编辑名称
	function editTree() {
		var node = $('#tt').tree('getSelected');
		$('#tt').tree('beginEdit', node.target);
		nodeName=node.text;
	}
	//历史记录名称修改
	function updateHistory(node){
		if(node.text != null){
			jQuery.ajax({  
    			async : false,  
    			cache:false,  
    			type: 'POST',  
    			dataType : "json",  
    			data:{"name":node.text,"nodeName":nodeName},
    			url: 'superQueryMainController.do?updateHistoryByName',
    			success:function(data){ 
    				 if(data.success==false){
    					 tip("系统中已存在此方案名称");
    					 editTree();
    					 return ;
    				 } 
   			 	},
    			error: function () {
        			tip('服务器未响应，请稍后再试！');  
    			}
			});
		}
	}
	//添加模版li
	function addULChild_template(i,value,condition,table,field,table1) {
		var dsUL_template = $("#dsUL_template").html();
		$("#dsUL").append(dsUL_template);
		resetTrNum();
		$("#dsUL").find("input[name='cons["+i+"].tree']").val(table);
		$("#dsUL").find("input[name='cons["+i+"].hidd']").val(table1);
		$("#dsUL").find("select[name='cons["+i+"].fld']").html(field);
		var eField = $("select[name='cons["+i+"].fld']").val();
		echoField(eField,i,value);
		$("#dsUL").find("select[name='cons["+i+"].ctyp']").val(condition);
	}
	//点击历史记录触发事件回显到页面
	var flg=false;
	var hisData="";
	function historyQuery(node) {
	$("#dsUL").find(".oop:gt(0)").remove();
	$("#dsLI").find(":input").val("");
		 jQuery.ajax({  
	    		async : false,  
	    		cache:false,  
	    		type: 'POST',  
	    		dataType : "json",  
	    		data:{"name":node.text},
	    		url: 'superQueryMainController.do?getHistoryByText',
	    		success:function(data){ 
	    			if (data.success){
						 hisData=data.obj;
					} 
	   			 },
	    		error: function () {
	        		tip('服务器未响应，请稍后再试！');  
	    		}
			});
		
		var jsonData=JSON.parse(hisData);
		var data1="["+jsonData.json.strings+"]";
		var data=JSON.parse(data1);
		var t = $('#dsUL');
		for(var i = 0; i<data.length; i++){
				var v = data[i].value;	
				//获取value值
				var begin = v.indexOf("%")==0;	//表示value是以%开头
				var end = v.charAt(v.length - 1);//表示value是以%结束
				var condition = data[i].condition;	//获取条件字段
				var table=data[i].table;
				var table1=data[i].table1;
				var field=data[i].field;
				/* 判断'%'以开头还是结束 */
				if(begin && end != "%") {
					condition = "likeEnd";
				} else if(!begin && end == "%") {
					condition = "likeBegin";
				}
				/* 判断Value值是否包含'%','(',')',有则去掉 */
				if(v != null && v != "") {
					v = v.replace("%","").replace("%","");
					while(v.indexOf("(")>0 || v.indexOf(")")>0) {
						v = v.replace("(","");
						v = v.replace(")","");
					}
				}
				if(i==0) {
					$("#dsUL").find("input[name='cons[0].tree']").val(data[i].table);	
					$("#dsUL").find("input[name='cons[0].hidd']").val(data[i].table1);	
					$("#dsUL").find("select[name='cons[0].fld']").html(data[i].field);
					$("#dsUL").find("select[name='cons[0].ctyp']").val(condition);
					var eField = $("select[name='cons[0].fld']").val();
					echoField(eField,i,v);
					$("#anyallSelect").val(data[i].relation);
				} else {
					addULChild_template(i,v,condition,data[i].table,data[i].field,data[i].table1);
				}
		}
		flg=true;
	}
	
	//根据字段回显最后值的类型框
	function echoField(field,i,v) {
		var spanVal = $(".oop").eq(i).find("span.spanVal");
		var mainId = $("input[name='cons[0].mainId']").val();
		jQuery.ajax({  
			type: 'POST',  
			dataType : "json",  
			data:{
				"field":field,
				"mainId":mainId
			},
			url: 'superQueryMainController.do?getFieldType',
			success:function(data){
				if("input" == data.obj[0].stype) {
					spanVal.html("<input name='cons["+i+"].val' value='"+v+"' style='width:165px' type='text' class='text conditionValue'>");
				}else if("date" == data.obj[0].stype) {
					spanVal.html("<input name='cons["+i+"].val' type='text' value='"+v+"' style='background: url(\"plug-in/ace/images/datetime.png\") no-repeat scroll right center transparent; width:165px'  class='form-control' onClick='WdatePicker({dateFmt:\"yyyy-MM-dd\"})'/>");
				}else if("datetime" == data.obj[0].stype) {
					spanVal.html("<input name='cons["+i+"].val' type='text' value='"+v+"' style='background: url(\"plug-in/ace/images/datetime.png\") no-repeat scroll right center transparent; width:165px'  class='form-control' onClick='WdatePicker({dateFmt:\"yyyy-MM-dd HH:mm:ss\"})'/>");
				}else if("select" == data.obj[0].stype) {
					var selectContent = "<select name=\"cons["+i+"].val\" class=\"compareType conditionValue\" style=\"width: 165px\">";
					jQuery.ajax({
						type: 'POST',
						dataType : "json",
						data:{
							"typegroup":data.obj[0].dict_code,
						},
						url: 'superQueryMainController.do?getSelectType',
						success:function(type){
							$.each(type.obj, function(index, item){
								selectContent += "<option value='"+item.typecode+"' "+(item.typecode==v?"selected":"")+">"+item.typename+"</option>";
							});
							selectContent += "</select>";
							spanVal.html(selectContent);
						},
						error:function(){
							tip("服务器请求失败，请稍后重试！");
						}
					});
				}else if("popup" == data.obj[0].stype) {
					spanVal.html("<input name=\"cons["+i+"].val\" value='"+v+"' type=\"text\" style=\"width: 150px\" class=\"searchbox-inputtext\" onclick=\"popupClick(this,'"+data.obj[0].dict_text+"','val','"+data.obj[0].dict_table+"')\"/>");
					$("input[name='cons["+i+"].val']").css({"background":"url(\"plug-in/diy/icons/search.png\") no-repeat 140px","width":"165px"});
				}
		 	},
			error: function () {
    			tip('服务器未响应，请稍后再试！');  
			}
		});
	}
	
	//----------字段选择改变字段类型---------
	function changeField(field) {
		var index = $(field).closest("#dsUL>li").data("index");
		var spanVal = $(field).closest("#dsUL>li").find("span.spanVal");
		var mainId = $("input[name='cons[0].mainId']").val();
		var fieldValue = field.value;
		jQuery.ajax({  
			type: 'POST',  
			dataType : "json",  
			data:{
				"field":fieldValue,
				"mainId":mainId
			},
			url: 'superQueryMainController.do?getFieldType',
			success:function(data){
				if("input" == data.obj[0].stype) {
					spanVal.html("<input name='cons["+index+"].val' type='text' style='width:165px' class='text conditionValue'>");
				}else if("date" == data.obj[0].stype) {
					spanVal.html("<input name='cons["+index+"].val' type='text' style='background: url(\"plug-in/ace/images/datetime.png\") no-repeat scroll right center transparent; width:165px'  class='form-control' onClick='WdatePicker({dateFmt:\"yyyy-MM-dd\"})'/>");
				}else if("datetime" == data.obj[0].stype) {
					spanVal.html("<input name='cons["+index+"].val' type='text' style='background: url(\"plug-in/ace/images/datetime.png\") no-repeat scroll right center transparent; width:165px'  class='form-control' onClick='WdatePicker({dateFmt:\"yyyy-MM-dd HH:mm:ss\"})'/>");
				}else if("select" == data.obj[0].stype) {
					var selectContent = "<select name=\"cons["+index+"].val\" class=\"compareType conditionValue\" style=\"width: 165px\">";
					jQuery.ajax({
						type: 'POST',
						dataType : "json",
						data:{
							"typegroup":data.obj[0].dict_code,
						},
						url: 'superQueryMainController.do?getSelectType',
						success:function(type){
							$.each(type.obj, function(index, item){
								selectContent += "<option value='"+item.typecode+"'>"+item.typename+"</option>";
							});
							selectContent += "</select>";
							spanVal.html(selectContent);
						},
						error:function(){
							tip("服务器请求失败，请稍后重试！");
						}
					});
				}else if("popup" == data.obj[0].stype) {
					spanVal.html("<input name=\"cons["+index+"].val\" type=\"text\" style=\"width: 150px\" class=\"searchbox-inputtext\" onclick=\"popupClick(this,'"+data.obj[0].dict_text+"','val','"+data.obj[0].dict_table+"')\"/>");
					$("input[name='cons["+index+"].val']").css({"background":"url(\"plug-in/diy/icons/search.png\") no-repeat 140px","width":"165px"});
				}
		 	},
			error: function () {
    			tip('服务器未响应，请稍后再试！');  
			}
		});
	}
	
</script>
