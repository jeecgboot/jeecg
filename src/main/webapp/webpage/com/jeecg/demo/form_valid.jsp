<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>uitags</title>
<t:base type="jquery,easyui,tools,autocomplete"></t:base>
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
          
          function setContentc(){
        	 alert("表单提交前想干点啥呢");
          }
          function test(){
        	  alert("表单提交后要干点啥呢");
          }

  </SCRIPT>
  </head>
  <body>
<t:formvalid formid="formobj" dialog="false" layout="div" callback="test" action="jeecgFormvalidController.do?testsubmit=2" beforeSubmit="setContentc">
	 <fieldset class="step">
		<div class="form">
			<label class="Validform_label"> 非空验证： </label> 
			<input type="text" name="demotitle" id="demotitle" datatype="*" errormsg="该字段不为空"> 
			<span class="Validform_checktip"></span>
		</div>
		
		<div class="form">
			<label class="Validform_label"> URL验证： </label> 
			<input type="text" name="demourl" id="demourl" datatype="url" errormsg="必须是URL"> 
			<span class="Validform_checktip"></span>
		</div>
		
		<div class="form">
			<label class="Validform_label"> 至少选择2项： </label> 
			<input name="shoppingsite1" class="rt2" id="shoppingsite21" type="checkbox" value="1" datatype="need2" nullmsg="请选择您的爱好！" />阅读 
			<input name="shoppingsite1" class="rt2" id="shoppingsite22" type="checkbox" value="2" /> 音乐
		    <input name="shoppingsite1" class="rt2" id="shoppingsite23" type="checkbox" value="3" /> 运动 
		    <span class="Validform_checktip"></span>
		</div>
		  
		
		<div class="form" id="mail_id">
			<label class="Validform_label"> 邮箱： </label> 
			<input type="text" name="demoorder" id="demoorder" datatype="e" errormsg="邮箱非法">
		    <span class="Validform_checktip"></span>
	    </div>
	    
	 <t:hasPermission code="phone_code">
		<div class="form">
			<label class="Validform_label"> 手机号： </label>
	   		<input type="text" name="phone" id="phone" datatype="m" errormsg="手机号非法"> 
	   		<span class="Validform_checktip"></span>
	   	</div>
	 </t:hasPermission>
		<div class="form" id="money_id">
			<label class="Validform_label"> 金额： </label> 
			<input type="text" name="money" id="money" datatype="d" errormsg="金额非法"> 
			<span class="Validform_checktip"></span>
		</div>
		
		<div class="form">
			<label class="Validform_label"> 日期： </label> 
			<input type="text" name="date" id="date" class="easyui-datebox"> 
			<span class="Validform_checktip"></span>
		</div>
		
		<div class="form">
			<label class="Validform_label"> 时间： </label> 
			<input type="text" name="time" id="time" class="easyui-datetimebox"> 
			<span class="Validform_checktip"></span>
		</div> 
		<div style="text-align:center"><input class="btn" type="submit" value="提交" style="height:30px;width:100px !important;border-radius:5px"></div>
		
	</fieldset>
</t:formvalid>
</body>
</html>
<t:authFilter />