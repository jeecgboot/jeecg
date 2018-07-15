<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<style>
.btn{
	display: inline-block;
    padding: 6px 12px;
    margin-bottom: 0;
    font-size: 14px;
    font-weight: 400;
    line-height: 1.42857143;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    background-image: none;
    border: 1px solid transparent;
    border-radius: 4p
}
.btn.focus, .btn:focus, .btn:hover {
    text-decoration: none;
}
.btn-default {
   color: #07a695;
    background-color: #fff;
    border-color: #07a695;
}
.datagrid-cell.menu-active .opts-menu-parent{
	display: block;
}
div[class$='-opt'] {
    height: 31px !important;
    width: 100px;
    z-index: 2;
    overflow: visible !important;
}
.datagrid-view td[field='opt'],.datagrid-btable td[field='opt'] {
    overflow: visible !important;
}
div[class$='menu-active'] {
    height: 31px !important;
    width: 100px;
    z-index: 2;
    overflow: visible !important;
}
.opts-menu-container{
	float: left;
    font-size: 12px;
    left: 35%;
    position: relative;
    top: 1px;
}

.opts-menu-container.location-left{
    left: 40px;
    top: -1px;
}
.opts-menu-parent{
	display: none;
}
.opts-menu-box{
	position: absolute;
    top:2px;
    z-index: 1000;
    background-color: #FFFFFF;
  /*   background-color: #f5f5f5; */
    border: 1px solid #dddddd;
    border-radius: 4px;
    box-shadow: 2px 2px 5px #969696;
    padding: 2px 4px;
}


.opts-menu-triangle{
    display: inline-block;
    height: 16px;
    position: absolute;
    left: 30px;
    top: 9px;
    width: 16px;
    z-index: 10000;
}
.ops-more {
    font-size: 12px;
    padding: 1px 6px 1px 8px;
    margin: 0px 3px;
    border-radius: 3px;
    text-decoration: none;
}

.ops-more:hover {
    background-color: #07A695;
    border-color: #068577;
    color: #fff;
    font-weight: 100;
}
.icon-triangle{
	 background: url('${webRoot}/plug-in/easyui/themes/icons/hotenticon.png') repeat scroll -80px 0 transparent;
	
}
.datagrid-cell.menu-active .icon-triangle{
	background: url('${webRoot}/plug-in/easyui/themes/icons/hotenticon.png') repeat scroll -80px -35px transparent;
	padding: 0 !important;
}

</style>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="jeecgDemoCollapseList" onLoadSuccess="optsMenuToggle" checkbox="true" pagination="true" fitColumns="true" title="操作列折叠demo" actionUrl="jeecgListDemoController.do?datagrid" idField="id" fit="true" queryMode="group">
 	<t:dgCol title="id"  field="id"   hidden="true"   queryMode="group"  width="120"></t:dgCol>
    <t:dgCol title="名称"  field="name" query="true" width="120"></t:dgCol>
    <!--update-begin-Author:zhangweijian Date: 20180710 for：TASK #2941 【bug】常用示例，小问题,年龄区间查询-->
    <t:dgCol title="年龄"  extend="{style:'width:50px'}" field="age"  query="true" width="120" queryMode="group"></t:dgCol>
    <!--update-end-Author:zhangweijian Date: 20180710 for：TASK #2941 【bug】常用示例，小问题，年龄区间查询-->
    <t:dgCol title="生日"  hidden="true"  field="birthday" formatter="yyyy-MM-dd"   queryMode="group"  width="120"></t:dgCol>
    <t:dgCol title="部门"  field="depId" query="true" queryMode="single" dictionary="t_s_depart,id,departname"  width="120"></t:dgCol>
    <t:dgCol title="性别"  field="sex"  query="false" showMode="radio" dictionary="sex" width="120"></t:dgCol>
    <t:dgCol title="电话"  field="phone" queryMode="group"  width="120"></t:dgCol>
    <t:dgCol title="工资"  field="salary" query="false" queryMode="group" width="120"></t:dgCol>
    <t:dgCol title="创建日期"  field="createDate" formatter="yyyy-MM-dd" query="true" queryMode="group" editor="datebox" width="120"></t:dgCol>
    <t:dgCol title="入职状态"  field="status" query="false" extend="{style:{width:'300px';color:'red'};datatype:'*';}" defaultVal='N'  dictionary="sf_yn" width="80"></t:dgCol>
    <t:dgCol title="操作" field="opt" width="100" formatterjs="collapseOptionMenu"></t:dgCol>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 function collapseOptionMenu(value,row,index){
	 var html = '<div class="opts-menu-container location-left">';
	 html +='<div class="opts-menu-triangle icon-triangle" href="javascript:void(0);" title="更多操作"></div><div style="clear: both;"></div>';
	 html +='<div class="opts-menu-parent">';
	 html+='<div class="opts-menu-box">';
	 html+='<a class="btn btn-default fa fa-eye ops-more" onclick="createdetailwindow(\'查看详情\',\'jeecgListDemoController.do?goUpdate&load=detail&id='+row.id+'\');" herf="javascript:void(0)">查看</a>';
	 html+='<a class="btn btn-default fa fa-trash-o ops-more" onclick="delObj(\'jeecgListDemoController.do?doDel&id='+row.id+'\',\'jeecgDemoCollapseList\')" herf="javascript:void(0)">删除</a>';
	 html+='<a class="btn btn-default fa fa-edit ops-more" onclick="alert(\'这是测试按钮,当前记录名称是：【'+row.name+'】\');" herf="javascript:void(0)">测试</a>';
	
	 html+='</div></div><em class="ops_shadeEm" style="display: inline;"></em></div></div>';
	 return html;
 }
 
  function optsMenuToggle(){
	  var dgPanel = $("#jeecgDemoCollapseList").datagrid('getPanel')
	  var tr = dgPanel.find('div.datagrid-body tr');
	  tr.each(function(){   
	     var td = tr.children('td[field="opt"]'); 
	     td.hover(function(){
	    	    $(this).children(".datagrid-cell").addClass("menu-active");
	    	    var btnCount = $(this).find(".opts-menu-box").children(".ops-more").length;
	    	    var left = "-"+(btnCount*58-10)+"px";
	    	    $(this).find(".opts-menu-box").css("left",left);
			},function(){
				$(this).children(".datagrid-cell").removeClass("menu-active");
			});
	 }); 
  }  
 

 </script>