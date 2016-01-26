<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<t:datagrid title="log.manage" name="logList" actionUrl="logController.do?datagrid" idField="id" sortName="operatetime" sortOrder="desc" pageSize="1000" extendParams="view:scrollview,">
	<t:dgCol title="log.level" field="loglevel" hidden="true"></t:dgCol>
	<t:dgCol title="common.id" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="log.content" field="logcontent" width="200"></t:dgCol>
	<t:dgCol title="operate.ip" field="note" width="200"></t:dgCol>
	<t:dgCol title="操作人ID" field="TSUser.userName" width="200"></t:dgCol>
	<t:dgCol title="操作人名" field="TSUser.realName" width="200"></t:dgCol>
	<t:dgCol title="common.browser.recommend" field="broswer" width="100"></t:dgCol>
	<t:dgCol title="operate.time" field="operatetime" formatter="yyyy-MM-dd hh:mm:ss" width="100"></t:dgCol>
</t:datagrid>
<div id="logListtb" style="padding: 3px; height: 25px">
	<%--add-begin--Author:zhoujf  Date:20150531 for：日志详情按钮位置迁移 --%>
	<span style="float:left;">
		<a href="#" class="easyui-linkbutton l-btn l-btn-plain" plain="true" icon="icon-search" onclick="detail('<t:mutiLang langKey="common.view"/>','logController.do?logDetail','logList',null,null)" id="">
		<t:mutiLang langKey="common.view"/>
		</a>
	</span>
	<%--add-end--Author:zhoujf  Date:20150531 for：日志详情按钮位置迁移--%>
    <div name="searchColums" style="float: right; padding-right: 15px;">
        <t:mutiLang langKey="log.level"/>: <!-- update---Author:宋双旺  Date:20130414 for：改变值进行查询 -->
        <select name="loglevel" id="loglevel" onchange="logListsearch();">
            <option value="0"><t:mutiLang langKey="select.loglevel"/></option>
            <option value="1"><t:mutiLang langKey="common.login"/></option>
            <option value="2"><t:mutiLang langKey="common.logout"/></option>
            <option value="3"><t:mutiLang langKey="common.insert"/></option>
            <option value="4"><t:mutiLang langKey="common.delete"/></option>
            <option value="5"><t:mutiLang langKey="common.update"/></option>
            <option value="6"><t:mutiLang langKey="common.upload"/></option>
            <option value="7"><t:mutiLang langKey="common.other"/></option>
        </select>
       <%--add-begin--Author:zhangguoming  Date:20140427 for：添加查询条件  操作时间--%>
        <span>
            <span style="vertical-align:middle;display:-moz-inline-box;display:inline-block;width: 80px;text-align:right;" title="操作时间 "><t:mutiLang langKey="operate.time"/>: </span>
            <input type="text" name="operatetime_begin" style="width: 100px; height: 24px;">~
            <input type="text" name="operatetime_end" style="width: 100px; height: 24px; margin-right: 20px;">
        </span>
        <%--add-end--Author:zhangguoming  Date:20140427 for：添加查询条件  操作时间--%>
        <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="logListsearch();"><t:mutiLang langKey="common.query"/></a>
    </div>
</div>
<%--add-begin--Author:zhangguoming  Date:20140427 for：添加查询条件  操作时间--%>
<script type="text/javascript">
    $(document).ready(function(){
        $("input[name='operatetime_begin']").attr("class","Wdate").attr("style","height:20px;width:140px;").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss '});});
        $("input[name='operatetime_end']").attr("class","Wdate").attr("style","height:20px;width:140px;").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});});

        $("input").css("height", "24px");
    });
</script>
<%--add-end--Author:zhangguoming  Date:20140427 for：添加查询条件  操作时间--%>
