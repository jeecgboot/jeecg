<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker,autocomplete"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="jeecgDemoList" checkbox="true" sortName="birthday,name" pagination="true" fitColumns="false" title="jeecg_demo" 
  	  superQuery="true" actionUrl="jeecgListDemoController.do?datagrid" idField="id" fit="true" queryMode="group" filter="true">
    <t:dgCol title="id"  field="id"   hidden="true"   queryMode="group"  width="120"></t:dgCol>
    <t:dgCol title="名称"  field="name" query="true" autocomplete="true"   width="120"></t:dgCol>
    <t:dgCol title="年龄"  extend="{style:'width:50px'}" formatterjs="formatAgeFun"  style="background-color:#3a87ad_50,background-color:#f89406_100" editor="numberbox" field="age"  query="true" width="120"></t:dgCol>
    
    <t:dgCol title="生日"  hidden="true"  field="birthday" formatter="yyyy-MM-dd"   queryMode="group"  width="120"></t:dgCol>
    <t:dgCol title="部门"  field="depId" query="true" queryMode="single" dictionary="t_s_depart,id,departname"  width="120"></t:dgCol>
    <t:dgCol title="部门code" field="extField"></t:dgCol>
    <t:dgCol title="性别"  field="sex"  query="true" showMode="radio" dictionary="sex" width="120" extendParams="styler:fmtype"></t:dgCol>
    <t:dgCol title="电话"  field="phone" queryMode="group"  width="120"></t:dgCol>
    <t:dgCol title="工资"  field="salary" query="true" queryMode="group" width="120"></t:dgCol>
    <t:dgCol title="创建日期"  field="createDate" formatter="yyyy-MM-dd" query="true" queryMode="group" editor="datebox" width="120"></t:dgCol>
    <t:dgCol title="邮箱"  field="email" query="true"  popup="true" dictionary="user_msg,realname,realname" width="120"></t:dgCol>
    <t:dgCol title="入职状态"  field="status" query="true" extend="{style:{width:'300px';color:'red'};datatype:'*';}" defaultVal='N'  dictionary="sf_yn" width="80"></t:dgCol>
    <t:dgCol title="个人介绍"  field="content"  hidden="true"   queryMode="group"  width="500"></t:dgCol>
   <t:dgCol title="头像"  field="touxiang"   queryMode="group"  formatterjs="statusFmt" width="60"></t:dgCol>
    <t:dgCol title="创建人id"  field="createBy"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
    <t:dgCol title="创建人"  field="createName"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
    <t:dgCol title="修改人id"  field="updateBy"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
    <t:dgCol title="修改时间"  field="updateDate" formatter="yyyy-MM-dd" hidden="true"  queryMode="group"  width="120"></t:dgCol>
    <t:dgCol title="修改人"  field="updateName"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="150"></t:dgCol>
   <t:dgDelOpt title="删除" url="jeecgListDemoController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/>
   <t:dgFunOpt exp="status#eq#N" title="审核" funname="szqm(id)" urlclass="ace_button"  urlfont="fa-check" />
   <t:dgToolBar title="录入" icon="icon-add" url="jeecgListDemoController.do?goAdd" funname="add" width="770" height="500"></t:dgToolBar>
   <t:dgToolBar title="弹出TAB表单" icon="icon-add" url="jeecgListDemoController.do?goAdd" funname="addbytab" width="770" height="500"></t:dgToolBar>
   <t:dgToolBar title="录入-提交按钮" icon="icon-add" url="jeecgListDemoController.do?addWithbtn" funname="addWithbtn" width="770"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="jeecgListDemoController.do?goUpdate" funname="update" width="770"></t:dgToolBar>
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="jeecgListDemoController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="jeecgListDemoController.do?goUpdate" funname="detail" width="770"></t:dgToolBar>
   <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
   <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar>
   <t:dgToolBar operationCode="print" title="打印" icon="icon-print" url="jeecgListDemoController.do?print" funname="detail" width="610" height="330"></t:dgToolBar>
   <t:dgToolBar  title="加载百度" icon="icon-print" url="#" funname="testReloadPage"></t:dgToolBar>
    <%-- <t:dgToolBar  title="加载新页面" icon="icon-print" funname="addNewPage(id)"></t:dgToolBar> --%>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">

	function statusFmt(value, row, index){  
		if (value != null && value != '') 
			return '<span style="color:green;font-size: 16px;">✔</span>';
		return '<span style="color:red;font-size: 16px;">x</span>';
	} 

	//列表字段颜色 demo,逻辑判断函数 
	function fmtype(val,row,index){
	    //可添加更多CSS样式
	    var s1 = 'background-color:#f89406;color:#FFF;';
	    var s2 = 'background-color:#3a87ad;color:#FFF;';
	    var s3 = 'background-color:#21B9BB;';
	    if (val =='1') {
	        return s1
	    }
	    if (val =='0') {
	        return s2
	    }
	    return s3
	}
 function testReloadPage(){
		document.location = "http://www.baidu.com"; 
	}
	function szqm(id) {
		createwindow('审核入职', 'jeecgListDemoController.do?goCheck&id=' + id,420,280);
	}
	function addNewPage(id){
		addOneTab("TAB方式添加", "jeecgListDemoController.do?addTab&type=table&id="+id);
	}
	
function addWithbtn(title,addurl,gname,width,height){
	//createdetailwindow("添加", addurl,770);
	openwindow("添加",addurl,gname,770,500);
	
}

//单元格的格式化函数  value：字段的值 row：行的记录数据 index：行的索引
function formatAgeFun(age,row,index){
	var str="原："+age+",现 ："+(Number(age)+20);
	return str;
}


//打开tab页面
function addbytab(){
	addOneTab("添加表单", "jeecgListDemoController.do?addWithbtn");
 }
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'jeecgListDemoController.do?upload', "jeecgDemoList");
}

//导出
function ExportXls() {
	JeecgExcelExport("jeecgListDemoController.do?exportXls","jeecgDemoList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("jeecgListDemoController.do?exportXlsByT","jeecgDemoList");
}
function createwindow_form(title, addurl,width,height) {
	//width = width?width:700;
	//height = height?height:400;
	//if(width=="100%" || height=="100%"){
	//	width = window.top.document.body.offsetWidth;
	//	height =window.top.document.body.offsetHeight-100;
	//}
	width = window.top.document.body.offsetWidth;
	height = window.top.document.body.offsetHeight-100;
	if(typeof(windowapi) == 'undefined'){
		$.dialog({
			content: 'url:'+addurl,
			lock : true,
			zIndex: getzIndex(),
			width:width,
			height:height,
			title:title,
			opacity : 0.3,
			cache:false,
		    cancelVal: '',
		    cancel: true /*为true等价于function(){}*/
		});
	}else{
		W.$.dialog({
			content: 'url:'+addurl,
			lock : true,
			width:width,
			zIndex:getzIndex(),
			height:height,
			parent:windowapi,
			title:title,
			opacity : 0.3,
			cache:false,
		    cancelVal: '',
		    cancel: true /*为true等价于function(){}*/
		});
	}
}
 </script>