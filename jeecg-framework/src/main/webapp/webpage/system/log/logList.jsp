<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:datagrid title="日志管理" name="logList" actionUrl="logController.do?datagrid" idField="id" sortName="operatetime" sortOrder="desc" pageSize="1000" extendParams="view:scrollview,">
	<t:dgCol title="日志类型 " field="loglevel" hidden="false"></t:dgCol>
	<t:dgCol title="编号" field="id" hidden="false"></t:dgCol>
	<t:dgCol title="日志内容" field="logcontent" width="200"></t:dgCol>
	<t:dgCol title="操作人IP" field="note" width="200"></t:dgCol>
	<t:dgCol title="浏览器" field="broswer" width="100"></t:dgCol>
	<t:dgCol title="操作时间 " field="operatetime" formatter="yyyy-MM-dd hh:mm:ss" width="100"></t:dgCol>
</t:datagrid>
<div id="logListtb" style="padding: 3px; height: 25px"><!-- update---Author:赵俊夫  Date:20130507 for：需要加name=searchColums属性 -->
<div name="searchColums" style="float: right; padding-right: 15px;">日志类型: <!-- update---Author:宋双旺  Date:20130414 for：改变值进行查询 --> <select name="loglevel" id="loglevel"
	onchange="logListsearch();">
	<option value="0">选择日志类型</option>
	<option value="1">登陆</option>
	<option value="2">退出</option>
	<option value="3">插入</option>
	<option value="4">删除</option>
	<option value="5">更新</option>
	<option value="6">上传</option>
	<option value="7">其他</option>
</select> <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="logListsearch();">查询</a></div>
</div>
