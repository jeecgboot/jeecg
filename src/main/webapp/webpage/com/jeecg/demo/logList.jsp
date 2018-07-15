<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<t:datagrid title="日志" name="logList" actionUrl="jeecgListDemoController.do?logDatagrid" 
		idField="id" sortName="operatetime" sortOrder="desc" queryMode="group" pageSize="500" extendParams="view:scrollview,">
	<t:dgCol title="common.id" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="日志类型" field="operatetype" replace="登录_1,退出_2,插入_3,删除_4,更新_5,上传_6,其他_7"></t:dgCol>
	<t:dgCol title="log.content" field="logcontent" width="340"></t:dgCol>
	<t:dgCol title="operate.ip" field="note" width="200"></t:dgCol>
	<t:dgCol title="操作人ID" field="TSUser.userName" width="200"></t:dgCol>
	<t:dgCol title="操作人名" field="TSUser.realName" width="200"></t:dgCol>
	<t:dgCol title="浏览器" field="broswer" width="100"></t:dgCol>
	<t:dgCol title="operate.time" field="operatetime" formatter="yyyy-MM-dd hh:mm:ss" width="200"></t:dgCol>
	
	 <t:dgToolBar title="数据报表" icon="icon-search" url="jeecgListDemoController.do?goOnlyData" funname="goBaobiao"></t:dgToolBar>
	 <t:dgToolBar title="图形报表" icon="icon-search" url="jeecgListDemoController.do?goChart" funname="goBaobiao2"></t:dgToolBar>
   	 
</t:datagrid>

<script type="text/javascript">
    $(document).ready(function(){
        $("input").css("height", "24px");
    });
    
    function logListsearch(){
    	var operatetype = $("#operatetype").val();
    	var operatetime_begin = $("#operatetime_begin").val();
    	var operatetime_end = $("#operatetime_end").val();
    	if(jQuery.trim(operatetime_begin) != '' || jQuery.trim(operatetime_end) != ''){
    		$("#logList").datagrid('load',{
        		operatetype : operatetype,
        		operatetime_begin : operatetime_begin,
        		operatetime_end : operatetime_end
        	});
    	}else{
    		$("#logList").datagrid('load',{
        		operatetype : operatetype
        	});
    	}
    }
    
    function clearSearch(){
    	$("#operatetype").val(0);
    	$("#operatetime_begin").val("");
    	$("#operatetime_end").val("");
    	$("#logList").datagrid('load',{});
    }
    
    function goBaobiao(title,addurl){
    	createdetailwindow(title,addurl);
    }
    function goBaobiao2(title,addurl){
    	addOneTab(title,addurl);
    }
</script>
