<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>页面不用自定义标签实现</title>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<form id="formobj" action="jeecgEasyUIController.do?save" name="formobj" method="post"><input type="hidden" id="btn_sub" class="btn_sub" /> <input id="id" name="id" type="hidden"
	value="${jeecgJdbcPage.id }">
<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
	<tr>
		<td align="right"><label class="Validform_label"> 年龄: </label></td>
		<td class="value"><input class="inputxt" id="age" name="age" ignore="ignore" value="${jeecgJdbcPage.age}" datatype="n"> <span class="Validform_checktip"></span></td>
	</tr>
	<tr>
		<td align="right"><label class="Validform_label"> 生日: </label></td>
		<td class="value"><input class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width: 150px" id="birthday" name="birthday" ignore="ignore"
			value="<fmt:formatDate value='${jeecgJdbcPage.birthday}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>"> <span class="Validform_checktip"></span></td>
	</tr>
	<tr>
		<td align="right"><label class="Validform_label"> 创建时间: </label></td>
		<td class="value"><input class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width: 150px" id="createTime" name="createTime" ignore="ignore"
			value="<fmt:formatDate value='${jeecgJdbcPage.createTime}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>"> <span class="Validform_checktip"></span></td>
	</tr>
	<tr>
		<td align="right"><label class="Validform_label"> 部门: </label></td>
		<td class="value"><select id="depId" name="depId" datatype="*">
			<c:forEach items="${departList}" var="depart">
				<option value="${depart.id }" ${depart.id==jeecgJdbcPage.depId?'selected':''}>${depart.departname}</option>
			</c:forEach>
		</select> <span class="Validform_checktip">请选择部门</span></td>
	</tr>
	<tr>
		<td align="right"><label class="Validform_label"> 邮箱: </label></td>
		<td class="value"><input class="inputxt" id="email" name="email" ignore="ignore" value="${jeecgJdbcPage.email}"> <span class="Validform_checktip"></span></td>
	</tr>
	<tr>
		<td align="right"><label class="Validform_label"> 手机: </label></td>
		<td class="value"><input class="inputxt" id="mobilePhone" name="mobilePhone" ignore="ignore" value="${jeecgJdbcPage.mobilePhone}"> <span class="Validform_checktip"></span></td>
	</tr>
	<tr>
		<td align="right"><label class="Validform_label"> 电话: </label></td>
		<td class="value"><input class="inputxt" id="officePhone" name="officePhone" ignore="ignore" value="${jeecgJdbcPage.officePhone}"> <span class="Validform_checktip"></span></td>
	</tr>
	<tr>
		<td align="right"><label class="Validform_label"> 工资: </label></td>
		<td class="value"><input class="inputxt" id="salary" name="salary" ignore="ignore" value="${jeecgJdbcPage.salary}" datatype="d"> <span class="Validform_checktip"></span></td>
	</tr>
	<tr>
		<td align="right"><label class="Validform_label"> 性别: </label></td>
		<td class="value"><t:dictSelect field="sex" typeGroupCode="sex" hasLabel="false" defaultVal="${jeecgJdbcPage.sex}" type="radio"></t:dictSelect> <span class="Validform_checktip"></span></td>
	</tr>
	<tr>
		<td align="right"><label class="Validform_label"> 用户名: </label></td>
		<td class="value"><input class="inputxt" id="userName" name="userName" value="${jeecgJdbcPage.userName}" datatype="*"> <span class="Validform_checktip"></span></td>
	</tr>
</table>

<link rel="stylesheet" href="plug-in/Validform/css/style.css" type="text/css" />
<link rel="stylesheet" href="plug-in/Validform/css/tablefrom.css" type="text/css" />
<script type="text/javascript" src="plug-in/Validform/js/Validform_v5.3.1_min_zh-cn.js"></script> <script type="text/javascript" src="plug-in/Validform/js/Validform_Datatype_zh-cn.js"></script> <script
	type="text/javascript" src="plug-in/Validform/js/datatype_zh-cn.js"></script> <SCRIPT type="text/javascript" src="plug-in/Validform/plugin/passwordStrength/passwordStrength-min.js"></SCRIPT> <script
	type="text/javascript">
			$(function() {
				$("#formobj").Validform(
						{
							tiptype : 4,
							btnSubmit : "#btn_sub",
							btnReset : "#btn_reset",
							ajaxPost : true,
							usePlugin : {
								passwordstrength : {
									minLen : 6,
									maxLen : 18,
									trigger : function(obj, error) {
										if (error) {
											obj.parent().next().find(
													".Validform_checktip")
													.show();
											obj.find(".passwordStrength")
													.hide();
										} else {
											$(".passwordStrength").show();
											obj.parent().next().find(
													".Validform_checktip")
													.hide();
										}
									}
								}
							},
							callback : function(data) {
								var win = frameElement.api.opener;
								if (data.success == true) {
									frameElement.api.close();
									win.tip(data.msg);
								} else {
									if (data.responseText == ''
											|| data.responseText == undefined)
										$("#formobj").html(data.msg);
									else
										$("#formobj").html(data.responseText);
									return false;
								}
								win.reloadTable();
							}
						});
			});
		</script></form>
</body>