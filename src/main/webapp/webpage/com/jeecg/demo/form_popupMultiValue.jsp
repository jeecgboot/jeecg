<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker,autocomplete"></t:base>
 <style type="text/css">
 	th{
 		text-align: center;
 		line-height: 25px;
 	}
 	.value{
 		padding: 10px auto 10px 10px;
 	}
 	.inputxt{
 		width: 150px;
 	}
 </style>
 <script type="text/javascript">
 
	 //设置表单内容
	 function setMultiVlaue(obj,rowTag,selected){
	
	     if (selected == '' || selected == null) {
             alert("请选择");
             return false;
	     } else {
             var str = "";
             var str1 = "";	
             $.each(selected, function(i, n) {
	             if (i == 0) {
		             str += n.realname;
		             str1 += n.account;	
	             } else {
		             str += "," + n.realname;
		             str1 += "," + n.account;
	             }	
             });	             
             $("input[name='"+rowTag+".name']").val(str);
             $("input[name='"+rowTag+".account']").val(str1);           
             return true;
	     }
	 }
	 
	 /**
	  * 弹出popup窗口获取
	  * @param obj
	  * @param rowTag 行标记
	  * @param code  动态报表配置ID
	  */
	 function inputClick(obj, rowTag, code) {
	     if (rowTag == null || code == "") {
	         alert("popup参数配置不全");
	         return;
	     }
	     var inputClickUrl = basePath + "/cgReportController.do?popup&id=" + code;
	     if (typeof (windowapi) == 'undefined') {//页面弹出popup
	         $.dialog({
		        content : "url:" + inputClickUrl,
		        zIndex : getzIndex(),
		        lock : true,
		        title : "选择",
		        width : 800,
		        height : 400,
		        cache : false,
		        ok : function() {
	                iframe = this.iframe.contentWindow;
	                var selected = iframe.getSelectRows();//重要，此处获取行数据
	                return setMultiVlaue(obj,rowTag,selected);
		        },
		        cancelVal : '关闭',
		        cancel : true//为true等价于function(){}
	   		});
	     } else {//popup内弹出popup
	         $.dialog({
		         content : "url:" + inputClickUrl,
		         zIndex : getzIndex(),
		         lock : true,
		         title : "选择",
		         width : 800,
		         height : 400,
		         parent : windowapi,//设置弹出popup的openner
		         cache : false,
		         ok : function() {
	                 iframe = this.iframe.contentWindow;
	                 var selected = iframe.getSelectRows();//重要，此处获取行数据
	                 return setMultiVlaue(obj,rowTag,selected);
		         },
		         cancelVal : '关闭',
		         cancel : true//为true等价于function(){}
	  		});
	     }
	}
  
 </script>
    <div title="Popup Demo" style="height:350px;" name="editPanel" id="editPanel" fit="true" class="easyui-panel">  	
		<t:formvalid formid="ff" dialog="true" layout="table" tiptype="4" action="jeecgListDemoController.do?saveRows">
			<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
				<thead>
					<tr><th>姓名</th><th>账号</th><th>生日</th><th>性别</th><th>工资</th><th>入职状态</th></tr>
				</thead>
				<tbody>
					<tr>
						<td class="value">							
							 <input name="demos[0].id" type="hidden" value="" /> 
						     <input onclick="inputClick(this,'demos[0]','user_msg');" placeholder="点击选择用户" name="demos[0].name" type="text" style="cursor: pointer;" class="inputxt" value="">
						</td>
						<td class="value">
						     <input placeholder="←" name="demos[0].account" type="text" class="inputxt" value="">
						</td>
						<td class="value">
							<input class="easyui-datebox" type="text" name="demos[0].birthday" id="birthday"/>
						</td>
						<td class="value">
							<t:dictSelect field="demos[0].sex" typeGroupCode="sex" title="性别"></t:dictSelect>
						</td>
						<td class="value">
						     	 <input id="salary" name="demos[0].salary" type="text" class="inputxt" value="">
						</td>
						<td class="value">
							<t:dictSelect field="demos[0].status" typeGroupCode="sf_yn" title="入职状态"></t:dictSelect>
						</td>
					</tr>
					<tr>
						<td class="value">							
							 <input name="demos[1].id" type="hidden" value="" /> 
						     <input onclick="inputClick(this,'demos[1]','user_msg');" placeholder="点击选择用户" name="demos[1].name" type="text" style="cursor: pointer;" class="inputxt" value="">
						</td>
						<td class="value">
						     <input placeholder="←" name="demos[1].account" type="text" class="inputxt" value="">
						</td>
						<td class="value">
							<input class="easyui-datebox" type="text" name="demos[1].birthday"/>
						</td>
						<td class="value">
							<t:dictSelect field="demos[1].sex" typeGroupCode="sex" title="性别"></t:dictSelect>
						</td>
						<td class="value">
						     	 <input id="salary" name="demos[1].salary" type="text" class="inputxt" value="">
						</td>
						<td class="value">
							<t:dictSelect field="demos[1].status" typeGroupCode="sf_yn" title="入职状态"></t:dictSelect>
						</td>
					</tr>
				</tbody>
			</table>		
		</t:formvalid>
    </div>