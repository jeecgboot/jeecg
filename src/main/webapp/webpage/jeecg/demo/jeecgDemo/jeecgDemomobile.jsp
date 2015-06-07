<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>DEMO示例</title>
<META name=viewport content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<META name=apple-mobile-web-app-capable content=yes>
<META name=apple-mobile-web-app-status-bar-style content=white>

<t:base type="jquery,tools,toptip"></t:base>
<link rel="stylesheet" href="plug-in/Validform/css/style.css" type="text/css"/>
<link rel="stylesheet" href="plug-in/Validform/css/tablefrom.css" type="text/css"/>
<script type="text/javascript" src="plug-in/Validform/js/Validform_v5.3.1_min_zh-cn.js"></script>
<script type="text/javascript" src="plug-in/Validform/js/Validform_Datatype_zh-cn.js"></script>
<script type="text/javascript" src="plug-in/Validform/js/datatype_zh-cn.js"></script>
<SCRIPT type="text/javascript" src="plug-in/Validform/plugin/passwordStrength/passwordStrength-min.js"></SCRIPT>

<link rel="stylesheet" href="plug-in/jmobile/css/style.css">
<link rel="stylesheet" href="plug-in/jmobile/css/jquery-ui.css">
<script type="text/javascript" src="plug-in/jmobile/js/jquery-ui.js"></SCRIPT>
<STYLE type=text/css>
	.btn_wrap BUTTON {
		WIDTH: 30%
	}
</STYLE>

</head>
<body style="overflow-y: auto" scroll="auto">
	<form id="formobj" action="jeecgDemoController.do?save" name="formobj" method="post">
		<input type="hidden" id="btn_sub" class="btn_sub">
		<input id="id" name="id" type="hidden" value="${jgDemo.id }">
		<div id=container class=wrapper>
			<div class=box>
				<h3>
					DEMO示例
				</h3>
				<div class="box_map order_wrap">
					<label for="userName">
						用户名
					</label>
					<input id="userName" class="form-control" type="text" name="userName" datatype="*" value="${jgDemo.userName }">
				</div>
				<div class="box_map order_wrap">
					<label for=name>
						手机号码
					</label>
					<input id="mobilePhone" class="form-control" type="text" name="mobilePhone" datatype="m" errormsg="手机号码不正确!" value="${jgDemo.mobilePhone}">
				</div>
				<div class="box_map order_wrap">
					<label for=name>
						办公电话
					</label>
					<input id="officePhone" class="form-control" type="text" name="officePhone" value="${jgDemo.officePhone}">
				</div>
				<div class="box_map order_wrap">
					<label for=name>
						常用邮箱
					</label>
					<input id="email" class="form-control" type="text" name="email" datatype="e" errormsg="邮箱格式不正确!" value="${jgDemo.email}">
				</div>
				<div class="box_map order_wrap">
					<label for=name>
						年龄
					</label>
					<input id="age" class="form-control" type="text" name="age" datatype="n" errormsg="年龄格式不正确!" value="${jgDemo.age}">
				</div>
				<div class="box_map order_wrap">
					<label for=name>
						工资
					</label>
					<input id="salary" class="form-control" type="text" name="salary" datatype="d" errormsg="工资格式不正确!" value="${jgDemo.salary}">
				</div>
				<div class="box_map order_wrap">
					<label for=name>
						生日
					</label>
					<input id="birthday" class="form-control" readonly type="text" name="birthday" value="<fmt:formatDate value='${jgDemo.birthday }' type="date" pattern="yyyy-MM-dd"/>">
				</div>
				<div class="box_map order_wrap">
					<label for=name>
						创建日期
					</label>
					<input id="createDate" readonly class="form-control" type="text" name="createDate"value="<fmt:formatDate value='${jgDemo.createDate }' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>" errormsg="日期格式不正确!" >
				</div>
				<div class="box_map order_wrap">
					<label for=name>
						性别
					</label>
					<t:dictSelect field="sex" typeGroupCode="sex" hasLabel="false" defaultVal="${jgDemo.sex}"></t:dictSelect>
				</div>
				<div class="box_map order_wrap">
					<label for=name>
						部门
					</label>
					<select id="depId" name="depId" datatype="*">
						<c:forEach items="${departList}" var="depart">
							<option value="${depart.id }" <c:if test="${depart.id==jgDemo.depId}">selected="selected"</c:if>>${depart.departname}</option>
						</c:forEach>
					</select>
				</div>
				<div style="text-align: center;padding-bottom: 1px;" class="btn_wrap">
					<div  class="btn_wrap">
						<BUTTON class=btn_normal onclick="$('#btn_sub').click();" type=button>
							提交
						</BUTTON>
						<BUTTON class=btn_normal type=reset>
							重置
						</BUTTON>
					
					</div>
				</div>
		
			</div>
		</div>
		<script type="text/javascript">
			$(function() {
				$("#birthday").datepicker();
				$("#formobj")
						.Validform(
								{
									tiptype : 1,
									btnSubmit : "#btn_sub",
									btnReset : "#btn_reset",
									ajaxPost : true,
									callback : function(data) {
										
										if (data.success == true) {
											alert(data.msg);
										} else {
											if (data.responseText == '' || data.responseText == undefined) {
												alert(data.msg);
											} else {
												try {
													var emsg = data.responseText.substring(data.responseText.indexOf('错误描述'),data.responseText.indexOf('错误信息'));
													alert(emsg);
												} catch (ex) {
													alert(data.responseText);
												}
											}
											return false;
										}
										window.open('', '_self');
										window.close();
									}
								});
			});
		</script>
	</form>
</body>
</html>