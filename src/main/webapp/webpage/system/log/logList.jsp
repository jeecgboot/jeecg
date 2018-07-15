<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<t:datagrid title="log.manage" name="logList" actionUrl="logController.do?datagrid" idField="id" sortName="operatetime" sortOrder="desc" pageSize="500" extendParams="view:scrollview">
	<t:dgCol title="common.id" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="日志类型" field="operatetype" replace="登录_1,退出_2,插入_3,删除_4,更新_5,上传_6,其他_7"></t:dgCol>
	<t:dgCol title="log.content" field="logcontent" width="200"></t:dgCol>
	<t:dgCol title="operate.ip" field="note" width="200"></t:dgCol>
	<t:dgCol title="操作人ID" field="username" width="200"></t:dgCol>
	<t:dgCol title="操作人名" field="realname" width="200"></t:dgCol>
	<t:dgCol title="(推荐使用IE8+,<br>谷歌浏览器可以获得更快,<br>更安全的页面响应速度) " field="broswer" width="100"></t:dgCol>
	<t:dgCol title="operate.time" field="operatetime" formatter="yyyy-MM-dd hh:mm:ss" width="200"></t:dgCol>
</t:datagrid>
<div id="logListtb" style="padding: 3px; height: 25px">
	<span style="float:left;">
		<a href="#" class="easyui-linkbutton l-btn l-btn-plain" plain="true" icon="icon-search" onclick="detail('<t:mutiLang langKey="common.view"/>','logController.do?logDetail','logList',680,450)" id="">
		<t:mutiLang langKey="common.view"/>
		</a>
	</span>
    <div style="float: right; padding-right: 15px;">
      	  日志类型: 
        <select name="operatetype" id="operatetype" onchange="logListsearch();">
            <option value="0">请选择</option>
            <option value="1"><t:mutiLang langKey="common.login"/></option>
            <option value="2"><t:mutiLang langKey="common.logout"/></option>
            <option value="3"><t:mutiLang langKey="common.insert"/></option>
            <option value="4"><t:mutiLang langKey="common.delete"/></option>
            <option value="5"><t:mutiLang langKey="common.update"/></option>
            <option value="6"><t:mutiLang langKey="common.upload"/></option>
            <option value="7"><t:mutiLang langKey="common.other"/></option>
        </select>
        <span>
            <span style="vertical-align:middle;display:-moz-inline-box;display:inline-block;width: 80px;text-align:right;" title="操作时间">
            <t:mutiLang langKey="operate.time"/>: </span>
            <input type="text" name="operatetime_begin" id="operatetime_begin" style="width: 140px; " class="Wdate" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'operatetime_end\')}',dateFmt:'yyyy-MM-dd HH:mm:ss'})">~
            <input type="text" name="operatetime_end" id="operatetime_end" style="width: 140px; margin-right: 20px;" class="Wdate"  onFocus="WdatePicker({minDate:'#F{$dp.$D(\'operatetime_begin\')}',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
        </span>
        <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="logListsearch();"><t:mutiLang langKey="common.query"/></a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="clearSearch();"><t:mutiLang langKey="common.clear"/></a>
    </div>
</div>
<script type="text/javascript">
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
</script>
