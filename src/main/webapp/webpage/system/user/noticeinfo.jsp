<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<t:base type="jquery,tools"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" layout="div" dialog="true">
	<fieldset class="step" width="95%">
	    <legend>${notice.noticeTitle}</legend>
			<div class="form">
				<label class="form"><fmt:formatDate value='${notice.createTime}' type='both'/></label>
			</div>
			<div class="form">
				${notice.noticeContent}
		    </div>
	    </div>
	</fieldset>
</t:formvalid>
</body>
</html>