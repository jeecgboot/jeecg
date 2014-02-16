<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>动态报表配置抬头</title>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script type="text/javascript" src="plug-in/ckeditor_new/ckeditor.js"></script>
<script type="text/javascript" src="plug-in/ckfinder/ckfinder.js"></script>
<script type="text/javascript">
  $(document).ready(function(){
	$('#tt').tabs({
	   onSelect:function(title){
	       $('#tt .panel-body').css('width','auto');
		}
	});
  });
 //初始化下标
	function resetTrNum(tableId) {
		$tbody = $("#"+tableId+"");
		$tbody.find('>tr').each(function(i){
			$(':input, select,button,a', this).each(function(){
				var $this = $(this), name = $this.attr('name'),id=$this.attr('id'),onclick_str=$this.attr('onclick'), val = $this.val();
				if(name!=null){
					if (name.indexOf("#index#") >= 0){
						$this.attr("name",name.replace('#index#',i));
					}else{
						var s = name.indexOf("[");
						var e = name.indexOf("]");
						var new_name = name.substring(s+1,e);
						$this.attr("name",name.replace(new_name,i));
					}
				}
				if(id!=null){
					if (id.indexOf("#index#") >= 0){
						$this.attr("id",id.replace('#index#',i));
					}else{
						var s = id.indexOf("[");
						var e = id.indexOf("]");
						var new_id = id.substring(s+1,e);
						$this.attr("id",id.replace(new_id,i));
					}
				}
				if(onclick_str!=null){
					if (onclick_str.indexOf("#index#") >= 0){
						$this.attr("onclick",onclick_str.replace(/#index#/g,i));
					}else{
					}
				}
			});
		});
	}
	function browseImages(inputId, Img) {// 图片管理器，可多个上传共用
		var finder = new CKFinder();
		finder.selectActionFunction = function(fileUrl, data) {//设置文件被选中时的函数 
			$("#" + Img).attr("src", fileUrl);
			$("#" + inputId).attr("value", fileUrl);
		};
		finder.resourceType = 'Images';// 指定ckfinder只为图片进行管理
		finder.selectActionData = inputId; //接收地址的input ID
		finder.removePlugins = 'help';// 移除帮助(只有英文)
		finder.defaultLanguage = 'zh-cn';
		finder.popup();
	}
	function browseFiles(inputId, file) {// 文件管理器，可多个上传共用
		var finder = new CKFinder();
		finder.selectActionFunction = function(fileUrl, data) {//设置文件被选中时的函数 
			$("#" + file).attr("href", fileUrl);
			$("#" + inputId).attr("value", fileUrl);
			decode(fileUrl, file);
		};
		finder.resourceType = 'Files';// 指定ckfinder只为文件进行管理
		finder.selectActionData = inputId; //接收地址的input ID
		finder.removePlugins = 'help';// 移除帮助(只有英文)
		finder.defaultLanguage = 'zh-cn';
		finder.popup();
	}
	function decode(value, id) {//value传入值,id接受值
		var last = value.lastIndexOf("/");
		var filename = value.substring(last + 1, value.length);
		$("#" + id).text(decodeURIComponent(filename));
	}
 </script>
</head>
<body style="overflow-x: hidden;">
<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" tiptype="1" action="cgreportConfigHeadController.do?doUpdate">
	<input id="id" name="id" type="hidden" value="${cgreportConfigHeadPage.id }">
	<table cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right"><label class="Validform_label">编码:</label></td>
			<td class="value"><input id="code" name="code" type="text" style="width: 150px" class="inputxt" datatype="*" value='${cgreportConfigHeadPage.code}'> <span class="Validform_checktip"></span></td>
			<td align="right"><label class="Validform_label">名称:</label></td>
			<td class="value"><input id="name" name="name" type="text" style="width: 150px" class="inputxt" datatype="*" value='${cgreportConfigHeadPage.name}'> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label">查询数据SQL:</label></td>
			<td class="value" colspan="3"><textarea rows="5" cols="90" id="cgrSql" name="cgrSql" datatype="*">${cgreportConfigHeadPage.cgrSql}</textarea> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label">描述:</label></td>
			<td class="value" colspan="3"><textarea rows="3" cols="90" id="content" name="content" datatype="*">${cgreportConfigHeadPage.content}</textarea> <span class="Validform_checktip"></span></td>
		</tr>
	</table>
	<div style="width: auto; height: 200px;"><%-- 增加一个div，用于调节页面大小，否则默认太小 --%>
	<div style="width: 800px; height: 1px;"></div>
	<t:tabs id="tt" iframe="false" tabPosition="top" fit="false">
		<t:tab href="cgreportConfigHeadController.do?cgreportConfigItemList&id=${cgreportConfigHeadPage.id}" icon="icon-search" title="动态报表配置明细" id="cgreportConfigItem"></t:tab>
	</t:tabs></div>
</t:formvalid>
<!-- 添加 附表明细 模版 -->
<table style="display: none">
	<tbody id="add_cgreportConfigItem_table_template">
		<tr>
			<td align="center"><input style="width: 20px;" type="checkbox" name="ck" /></td>
			<td align="left"><input name="cgreportConfigItemList[#index#].fieldName" maxlength="36" type="text" class="inputxt" style="width: 120px;"></td>
			<td align="left"><input name="cgreportConfigItemList[#index#].orderNum" maxlength="10" type="text" class="inputxt" style="width: 30px;"></td>
			<td align="left"><input name="cgreportConfigItemList[#index#].fieldTxt" maxlength="1000" type="text" class="inputxt" style="width: 120px;"></td>
			<td align="left"><t:dictSelect field="cgreportConfigItemList[#index#].fieldType" type="list" typeGroupCode="fieldtype" defaultVal="String" hasLabel="false" title="字段类型"></t:dictSelect></td>
			<td align="left"><select id="isShow" name="cgreportConfigItemList[#index#].isShow"  style="width: 60px;">
				<option value="Y">显示</option>
				<option value="N">隐藏</option>
			</select></td>
			<td align="left"><input name="cgreportConfigItemList[#index#].fieldHref" maxlength="1000" type="text" class="inputxt" style="width: 120px;">
			<td align="left"><t:dictSelect field="cgreportConfigItemList[#index#].SMode" type="list" typeGroupCode="searchmode" defaultVal="" hasLabel="false" title="查询模式"></t:dictSelect></td>
			<td align="left"><input name="cgreportConfigItemList[#index#].replaceVa" maxlength="36" type="text" class="inputxt" style="width: 120px;"></td>
			<td align="left"><input name="cgreportConfigItemList[#index#].dictCode" maxlength="36" type="text" class="inputxt" style="width: 120px;"></td>
			<td align="left"><t:dictSelect field="cgreportConfigItemList[#index#].SFlag" type="list" typeGroupCode="yesorno" defaultVal="" hasLabel="false" title="是否查询"></t:dictSelect></td>
		</tr>
	</tbody>
</table>
</body>
<script src="webpage/jeecg/cgreport/core/cgreportConfigHead.js"></script>