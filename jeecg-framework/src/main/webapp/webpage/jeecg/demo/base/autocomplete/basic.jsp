<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<script src="plug-in/jquery/jquery-autocomplete/jquery.autocomplete.js" type="text/javascript"></script>
<link href="plug-in/jquery/jquery-autocomplete/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
<style>
<!--
.ac_over {
	background: #E0ECFF;
	cursor: pointer;
	color: #416AA3;
}

.ac_results {
	border: 1px solid rgb(172, 216, 236);
}
-->
</style>
<SCRIPT type="text/javascript">
        function parse(data){
            	var parsed = [];
		        	$.each(data.rows,function(index,row){
		        		parsed.push({data:row,result:row,value:row.id});
		        	});
        				return parsed;
        }
        /**
         * 选择后回调 
         * 
         * @param {Object} data
         */
        function callBack(data) {
        	$("#user").val(data.userName);
        }
        
         /**
          * 每一个选择项显示的信息
          * 
          * @param {Object} data
          */
        function formatItem(data) {
        	return data.userName + "-->" + " " + data.realName;
        }

  </SCRIPT>
<t:formvalid formid="formobj" dialog="false" layout="div" action="demoController.do?saveDemo">
	<fieldset class="step">
	<div class="form"><label class="form"> 自动补全： </label> <t:autocomplete minLength="1" dataSource="commonController.do?getAutoList" closefun="close" valueField="id" searchField="userName,realName"
		labelField="userName,realName" parse="parse" formatItem="formatItem" result="callBack" name="user" entityName="TSUser" datatype="*" maxRows="10" nullmsg="请输入关键字" errormsg="数据不存在,请重新输入"></t:autocomplete>
	</fieldset>
</t:formvalid>
