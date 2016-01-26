<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<!DOCTYPE html>
<html>

<head>
    <title>团队人员榜</title>
    <t:base type="jquery,easyui,tools,DatePicker"></t:base>
    <script type="text/javascript">
        //编写自定义JS代码
    </script>
</head>

<body>
	<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="div" action="tSTeamPersonController.do?doAdd">
		<input id="id" name="id" type="hidden" value="${tSTeamPersonPage.id }">
		<input id="createName" name="createName" type="hidden" value="${tSTeamPersonPage.createName }">
		<input id="createBy" name="createBy" type="hidden" value="${tSTeamPersonPage.createBy }">
		<input id="createDate" name="createDate" type="hidden" value="${tSTeamPersonPage.createDate }">
		<input id="updateName" name="updateName" type="hidden" value="${tSTeamPersonPage.updateName }">
		<input id="updateBy" name="updateBy" type="hidden" value="${tSTeamPersonPage.updateBy }">
		<input id="updateDate" name="updateDate" type="hidden" value="${tSTeamPersonPage.updateDate }">
		<input id="sysOrgCode" name="sysOrgCode" type="hidden" value="${tSTeamPersonPage.sysOrgCode }">
		<input id="sysCompanyCode" name="sysCompanyCode" type="hidden" value="${tSTeamPersonPage.sysCompanyCode }">
		<fieldset class="step">
			<div class="form">
				<label class="Validform_label">名称:</label>
				<input class="inputxt" id="name" name="name" value="" datatype="*">
				<span class="Validform_checktip"></span>
			</div>
			
			<div class="form">
				<label class="Validform_label">头像:</label>
				<input type="hidden" id="imgSrc" name="imgSrc" />
				<a target="_blank" id="imgSrc_href">暂时未上传文件</a>
				<input class="ui-button" type="button" value="上传附件" onclick="commonUpload(imgSrcCallback)" />
				<script type="text/javascript">
					function imgSrcCallback(url, name) {
						$("#imgSrc_href").attr('href', url).html('下载');
						$("#imgSrc").val(url);
					}
				</script>
				<span class="Validform_checktip"></span>
			</div>
			
			<div class="form">
				<label class="Validform_label">简介:</label>
				<textarea style="width:600px;" class="inputxt" rows="6" id="introduction" name="introduction" datatype="*"></textarea>
				<span class="Validform_checktip"></span>
			</div>
			
			<div class="form">
				<label class="Validform_label">加入时间:</label>
				<input id="jionDate" name="jionDate" type="text" style="width: 150px" class="Wdate" onClick="WdatePicker()">
				<span class="Validform_checktip"></span>
			</div>
            <div class="form">
                <label class="Validform_label">是否参与:</label>
                <select id="isJoin" name="isJoin" style="width: 150px" >
                    <option value="1">参与</option>
                    <option value="0">不参与</option>
                </select>
                <span class="Validform_checktip"></span>
            </div>
		</fieldset>
	</t:formvalid>
</body>
<script src="webpage/system/rank/tSTeamPerson.js"></script>