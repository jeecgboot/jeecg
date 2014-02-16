<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>物料Bom</title>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script type="text/javascript">
		$(function() {
			$('#parent').combotree({
				url : 'jeecgMatterBomController.do?getChildren'
			});
		});
		</script>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" layout="div" dialog="true" action="jeecgMatterBomController.do?doSave">
	<input name="id" type="hidden" value="${entity.id}" />
	<fieldset class="step">
	<div class="form"><label class="Validform_label">编码:</label> <input name="code" class="inputxt" value="${entity.code}" datatype="s3-10" maxlength="50" /> <span class="Validform_checktip">编码在3~10位字符</span>
	</div>
	<div class="form"><label class="Validform_label">名称:</label> <input name="name" class="inputxt" value="${entity.name}" datatype="*" maxlength="50" /> <span class="Validform_checktip"></span></div>
	<div class="form"><label class="Validform_label">上级物料Bom:</label> <input id="parent" name="parent.id" value="${entity.parent.id}" /></div>
	<div class="form"><label class="Validform_label">单位:</label> <input name="unit" value="${entity.unit}" /></div>
	<div class="form"><label class="Validform_label">大小:</label> <input name="weight" value="${entity.weight}" /></div>
	<div class="form"><label class="Validform_label">价格:</label> <input name="price" value="${entity.price}" datatype="d" /></div>
	<div class="form"><label class="Validform_label">库存:</label> <input name="stock" value="${entity.stock}" datatype="n" /></div>
	<div class="form"><label class="Validform_label">产地:</label> <input name="address" value="${entity.address}" /></div>
	<div class="form"><label class="Validform_label">生产日期:</label> <input class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width: 150px" name="productionDate"
		ignore="ignore" value="<fmt:formatDate value='${entity.productionDate}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>" /></div>
	<div class="form"><label class="Validform_label">数量:</label> <input name="quantity" value="${entity.quantity}" datatype="n" /></div>
	</fieldset>
</t:formvalid>
</body>
</html>