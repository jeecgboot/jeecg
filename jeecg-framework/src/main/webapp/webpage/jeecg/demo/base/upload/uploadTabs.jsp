<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:tabs id="tt" iframe="false" tabPosition="bottom">
	<t:tab iframe="demoController.do?autoupload&turn=upload/autoupload" icon="icon-search" title="自动上传" id="auto"></t:tab>
	<t:tab iframe="demoController.do?autoupload&turn=upload/defaultupload" icon="icon-search" title="普通上传下载" id="default"></t:tab>
</t:tabs>

