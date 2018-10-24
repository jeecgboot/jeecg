<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<style>
ul {
    list-style-type: none;
    list-style-image: none;
    margin-bottom: 3px;
}
li {
    margin-bottom: 3px;
}
.conditionType {
    display: block;
    margin-bottom: 3px;
    padding: 3px 0 3px;
    width: 100%;
}select {
    padding-right: 2px!important;
}
select {
    padding: 5px 7px;
}
textarea, input[type=text], input[type=password], select {
    font-family: "Verdana","微软雅黑","宋体","Lucida Grande";
    padding: 3px;
    border: 1px solid #ddd;
    outline: 0;
    box-sizing: border-box;
}
#dsUL .conditionSelect {
    width: 200px;
}
.datagrid .panel-body {
	position: relative;
    overflow: auto;
}
</style>
<div class="easyui-layout" fit="true">
	<div region="center" style="padding: 1px;">
		<t:datagrid name="jeecgDemoListquery" title="多条件动态查询" actionUrl="jeecgListDemoController.do?datagrid" idField="id" queryMode="group" checkbox="true"
			extendParams="headerContextMenu: [
                { text: '保存列定义', iconCls: 'icon-save', disabled: false, handler: function () { saveHeader(); } },
                { text: '自定义菜单', iconCls: 'icon-reload', disabled: false, handler: function (e, field) { alert($.string.format('您点击了{0}', field)); } }
            ],">
			<t:dgCol title="编号" field="id" hidden="true"></t:dgCol>
			<t:dgCol title="用户名" field="name" query="false"></t:dgCol>
			<t:dgCol title="个人介绍" field="content" query="false"></t:dgCol>
			<t:dgCol title="办公电话" field="phone" query="false"></t:dgCol>
			<t:dgCol title="创建日期" field="createDate" formatter="yyyy-MM-dd" query="false" queryMode="group"></t:dgCol>
			<t:dgCol title="邮箱" field="email" query="false"></t:dgCol>
			<t:dgCol title="年龄" sortable="true" field="age" query="false"></t:dgCol>
			<t:dgCol title="工资" field="salary" query="false"></t:dgCol>
			<t:dgCol title="生日" field="birthday" formatter="yyyy/MM/dd" query="false"></t:dgCol>
		</t:datagrid>
		<div id="jeecgDemoListquerytb"  style="padding: 3px; height: 67px">
			<div style="float: left;">
		  		<ul id="dsUL">
					<li id="anyAll" class="conditionType">
                    	<span class="anyAll">
							过滤条件匹配： 
                        	<select id="anyallSelect" name="mchtyp" style="width:200px" class="select">
                            	<option value="and" selected="selected">And(所有条件都要求匹配)</option>
                            	<option value="or" >Or(条件中的任何一个匹配)</option>
                            </select>
                        </span>
                    </li>
    				<li id="dsLI" name="dsLI" class="conditions oop">
    					<span>
    						<select id="field" name="cons[0].fld" id="orgCode" >
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
                        	<select id="condition" name="cons[0].ctyp" class="compareType" style="width:150px">
								<option>&nbsp;</option>
	    						<option value="=">等于</option>
	    						<option value="!=" >不等于</option>
	    						<option value=">" >大于</option>
	    						<option value=">=" >大于等于</option>
	    						<option value="lt" >小于</option>
	    						<option value="lte" >小于等于</option>
	    						<option value="likeBegin" >以...开始</option>
	    						<option value="likeEnd" >以...结束</option>
	    						<option value="like" >包含</option>
	    						<option value="not like" >不包含</option>
	    						<option value="in" >在...中</option>
	    						<option value="not in" >不在...中</option>
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
			<div style="float: right;">
				 <input  id="_sqlbuilder" name="sqlbuilder"   type="hidden" />
				<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="mySearch()" >查询</a>
				<a href="#" class="easyui-linkbutton" iconCls="icon-reload" onclick="searchReset()">重置</a>
			</div>
  	  	</div>
	</div>
</div>
<script type="text/javascript">
function mySearch() {
	//多条件查询
	//-----------------------
	var idIndex = 100;
		//获取页面上And，Or
		var relation = $("#anyallSelect").val();
		var dsli = document.getElementsByName("dsLI");
		var json = new StringBuffer();
		$(dsli).each(function(i){
			idIndex++;
			var field = $(this).find("select[id='field']").val();
			var condition = $(this).find("select[id='condition']").val();
			var cValue = $(this).find("input[id='conValue']").val();
			//判断输入的是否为时期格式
			if(CheckDate(cValue)) {
				if(condition == "=") {
					condition = "like";
					cValue = "%" + cValue;
				}
			}
			//判断condition条件，改变sql查询条件
			if(condition == "lt") {
				condition = "<";
			} else if(condition == "lte") {
				condition = "<="
			} else if(condition == "like") {
				condition = "like";
				cValue = "%"+cValue+"%";
			} else if(condition == "not like") {
				condition = "not like";
				cValue = "%"+cValue+"%";
			} else if(condition == "likeBegin") {
				condition = "like";
				cValue = cValue+"%";
			} else if(condition == "likeEnd"){
				condition = "like";
				cValue = "%"+cValue;
			} else if(condition == "in") {
				condition = "in";
				cValue = "\("+cValue+"\)"
			}
			if(i == 0) {
				json.append("[{\"id\":"+idIndex+",\"field\":\""+field+"\",\"condition\":\""+condition+"\",\"value\":\""+cValue+"\",\"relation\":\""+relation+"\",\"state\":\"open\"}");	
			}
			if(i != 0) {
				json.append(",{\"id\":"+idIndex+",\"field\":\""+field+"\",\"condition\":\""+condition+"\",\"value\":\""+cValue+"\",\"relation\":\""+relation+"\",\"state\":\"open\"}");
			}
		});
		json.append("]");
		$("#_sqlbuilder").val(json.toString());
	//-----------------------
	jeecgDemoListquerysearch();
}

	//添加StringBuffer
	function StringBuffer(){  
	    this.strings = new Array;  
	}  
	  
	StringBuffer.prototype.append=function(str){  
	    this.strings.push(str); //追加指定元素  
	};  
	  
	StringBuffer.prototype.toString = function(){  
	    return this.strings.join(""); //向数组之间的元素插入指定字符串（此处为空字符串），并返回。  
	};
	//添加相同的li
	function addULChild() {
		var	myUl = document.getElementById("dsUL");
		var myLi = document.getElementById("dsLI");
		var newLi = document.createElement("li");
		newLi.setAttribute("name","dsLI");
		$(newLi).addClass("oop");
		newLi.innerHTML=myLi.innerHTML;
		myUl.appendChild(newLi);
		resetTrNum();
	}
	//初始化下标
	function resetTrNum() {
		 $('#dsUL').find('li').each(function(i){
			$(':input,select',this).each(function(){
				var thisli = $(this);
				var name = thisli.attr('name');
				if(name!=null){
				var reg=new RegExp("^cons");
	    			if(reg.test(name)) {
	    				if(name.indexOf("#index#") >= 0) {
	    					thisli.attr("name",name.replace('#index#',i-1));
	    				}else {
	    					var s = name.indexOf("[");
	    					var e = name.indexOf("]");
	    					var new_name = name.substring(s+1,e);
	    					thisli.attr("name",name.replace(new_name,i-1));
	    				}
	    			}
				}
			});
		});
	}
	//删除当前li
	function deleteULChild(col) {
		var dsli = document.getElementsByName("dsLI");
		//判断最后剩一个li则不删除
		$(dsli).each(function(i){
			if(i!=0) {
				$(col).closest("li").remove();
			}
		})
		resetTrNum();
	}
	//重置按钮，清空所有
	function searchReset() {
		$("#dsUL").find(".oop:gt(0)").remove();
	    $("#dsLI").find(":input").val("");
	    $("#_sqlbuilder").val(null);
	    jeecgDemoListquerysearch();
	}
	//判断输入的是否为日期格式
	function CheckDate(strInputDate) {
		  if (strInputDate == "") return false;
		  strInputDate = strInputDate.replace(/-/g, "/");
		  var d = new Date(strInputDate);
		  if (isNaN(d)) return false;
		  var arr = strInputDate.split("/");
		  return ((parseInt(arr[0], 10) == d.getFullYear()) && (parseInt(arr[1], 10) == (d.getMonth() + 1)) && (parseInt(arr[2], 10) == d.getDate()));
	}
</script>
