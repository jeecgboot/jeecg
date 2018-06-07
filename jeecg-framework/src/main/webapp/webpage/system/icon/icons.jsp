<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>图标信息</title>
<t:base type="jquery,easyui,tools"></t:base>

<script type="text/javascript">
	$(function(){
		$("#formobj").submit(function(){
			var file_upload = $("#file_upload").val();

			var existIcon = $("#existIcon");
			if(!!existIcon && existIcon.val()=="1"){
				if(!$("#filediv").html()){
					//此处直接只修改表单数据，不修改图片
					var id = $("#id").val();
					var iconName = $("#iconName").val();
					var iconType = $("#iconType").val();
					var formData = {
						"id":id,
						"iconName":iconName,
						"iconType":iconType
					};
					$.ajax({
						async : false,
						cache : false,
						type : 'POST',
						data:formData,
						url : "iconController.do?updateInfo",
						dataType:"JSON",
						success : function(d) {
							if (d.success) {
								var win = frameElement.api.opener;
						        win.reloadTable();
						        win.tip(d.msg);
							}
							frameElement.api.close();
						}
					});
				}
			}

			if($.trim(file_upload) == ""){
				tip("请选择上载文件.");
				return false;
			}
		});
	})
</script>

</head>
<body>
<t:formvalid formid="formobj" layout="div" dialog="true" beforeSubmit="upload">
	<input name="id" id="id" type="hidden" value="${icon.id}">
	<fieldset class="step">
	<div class="form">
        <label class="Validform_label"> <t:mutiLang langKey="common.icon.name"/>: </label>
        <input name="iconName" datatype="s2-10" id="iconName" value="${icon.iconName}" class="inputxt">
        <span class="Validform_checktip"><t:mutiLang langKey="iconname.rang2to10"/></span>
    </div>
	<div class="form">
        <label class="Validform_label"> <t:mutiLang langKey="common.icon.type"/>: </label>
        <select name="iconType" id="iconType">
            <option value="1" <c:if test="${icon.iconType=='1'}">selected="selected"</c:if>><t:mutiLang langKey="system.icon"/></option>
            <option value="2" <c:if test="${icon.iconType=='2'}">selected="selected"</c:if>><t:mutiLang langKey="menu.icon"/></option>
            <option value="3" <c:if test="${icon.iconType=='3'}">selected="selected"</c:if>><t:mutiLang langKey="desktop.icon"/></option>
        </select>
    </div>
    <c:if test="${not empty icon.id}">
    <div class="form" >
        <label class="Validform_label">图标预览:</label>
        <a target="_blank" href="${icon.iconPath }"><img src="${icon.iconPath }" style="width:25px"></a>
        <input type="hidden" id = "existIcon" value = "1"/>
    </div>
    </c:if>
	<div class="form">
	<div id="filediv"></div>
	<t:upload name="file_upload" uploader="iconController.do?saveOrUpdateIcon" extend="*.png;" id="file_upload" formId="formobj"></t:upload></div>
	</fieldset>
</t:formvalid>
</body>
</html>
