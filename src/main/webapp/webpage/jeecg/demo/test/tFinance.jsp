<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html style="overflow-x: hidden;">
<head>
<title>多附件管理</title>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script type="text/javascript">
  $(function(){
    //查看模式情况下,删除和上传附件功能禁止使用
	if(location.href.indexOf("load=detail")!=-1){
		$(".jeecgDetail").hide();
	}
   });

  	function uploadFile(data){
  		$("#financeId").val(data.obj.id);
  		if($(".uploadify-queue-item").length>0){
  			upload();
  		}else{
  			frameElement.api.opener.reloadTable();
  			frameElement.api.close();
  		}
  	}
  	
  	function close(){
  		frameElement.api.close();
  	}
  </script>
<!-- 弹出页面窗口大小控制 -->
<style type="text/css">
#formobj {
	height: 65%;
	min-height: 300px;
	overflow-y: auto;
	overflow-x: auto;
	min-width: 600px;
}
</style>
</head>
<body>
<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" callback="@Override uploadFile" action="tFinanceController.do?save">
	<input id="id" name="id" type="hidden" value="${tFinancePage.id }">
	<table cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right"><label class="Validform_label"> 类别: </label></td>
			<td class="value"><input class="inputxt" id="category" name="category" ignore="ignore" value="${tFinancePage.category}"> <span class="Validform_checktip"></span></td>
			<td align="right"><label class="Validform_label"> 年份: </label></td>
			<td class="value"><input class="inputxt" id="happenyear" name="happenyear" ignore="ignore" value="${tFinancePage.happenyear}" datatype="n"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 拨款时间: </label></td>
			<td class="value"><input class="Wdate" onClick="WdatePicker()" style="width: 150px" id="paytime" name="paytime" ignore="ignore"
				value="<fmt:formatDate value='${tFinancePage.paytime}' type="date" pattern="yyyy-MM-dd"/>"> <span class="Validform_checktip"></span></td>
			<td align="right"><label class="Validform_label"> 收款单位: </label></td>
			<td class="value"><input class="inputxt" id="collectorg" name="collectorg" ignore="ignore" value="${tFinancePage.collectorg}"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 拨款文件类别: </label></td>
			<td class="value"><input class="inputxt" id="approfiletype" name="approfiletype" ignore="ignore" value="${tFinancePage.approfiletype}"> <span class="Validform_checktip"></span></td>
			<td align="right"><label class="Validform_label"> 指标文号: </label></td>
			<td class="value"><input class="inputxt" id="zbwno" name="zbwno" ignore="ignore" value="${tFinancePage.zbwno}"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 金额合计: </label></td>
			<td class="value"><input class="inputxt" id="moneytotal" name="moneytotal" ignore="ignore" value="${tFinancePage.moneytotal}" datatype="d"> <span class="Validform_checktip"></span></td>
			<td align="right"><label class="Validform_label"> 支出科目: </label></td>
			<td class="value"><input class="inputxt" id="expenseaccount" name="expenseaccount" ignore="ignore" value="${tFinancePage.expenseaccount}"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label">附件:</label></td>
			<td colspan="3" class="value">
			<table>
				<c:forEach items="${tFinancePage.financeFiles}" var="financeFile">
					<tr style="height: 34px;">
<!--xugj---begin---2016年3月19号    for:TASK #820 【常用示例】多附件上传报错 -->
						<td>${financeFile.attachmenttitle}</td>
						<td><a href="commonController.do?viewFile&fileid=${financeFile.id}&subclassname=org.jeecgframework.web.demo.entity.test.TFinanceFilesEntity" title="下载">下载</a></td>
						<td><a href="javascript:void(0);"
							onclick="openwindow('预览','commonController.do?openViewFile&fileid=${financeFile.id}&subclassname=org.jeecgframework.web.demo.entity.test.TFinanceFilesEntity','fList','800','700')">预览</a></td>
						<td><a href="javascript:void(0)" class="jeecgDetail" onclick="del('tFinanceController.do?delFile&id=${financeFile.id}',this)">删除</a></td>
					</tr>
				</c:forEach>
			</table>
			</td>
		</tr>
		<tr>
			<td></td>
			<td colspan="3" class="value"><script type="text/javascript">
					$.dialog.setting.zIndex =1990;
					function del(url,obj){
						$.dialog.confirm("确认删除该条记录?", function(){
						  	$.ajax({
								async : false,
								cache : false,
								type : 'POST',
								url : url,// 请求的action路径
								error : function() {// 请求失败处理函数
								},
								success : function(data) {
									var d = $.parseJSON(data);
									if (d.success) {
										var msg = d.msg;
										tip(msg);
										$(obj).closest("tr").hide("slow");
									}
								}
							});  
						}, function(){
						});
					}
					</script>
			<div class="form" id="filediv"></div>
			<div class="form jeecgDetail">
			<t:upload name="fiels" id="file_upload" extend="*.doc;*.docx;*.txt;*.ppt;*.xls;*.xlsx;*.html;*.htm;*.pdf;" buttonText="添加文件" formId="uploadForm" uploader="tFinanceController.do?saveFiles">
			</t:upload>
				</div>
			</td>
		</tr>
	</table>
</t:formvalid>
<form action="" id ="uploadForm"> <input type="hidden" value="${tFinancePage.id}" id="financeId" name="financeId" /> </form>
<!--xugj---end---2016年3月19号    for:TASK #820 【常用示例】多附件上传报错 -->

</body>