<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>图表配置</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript" src="plug-in/ckfinder/ckfinder.js"></script>
  <script type="text/javascript">
  $(document).ready(function(){
	$('#tt').tabs({
	   onSelect:function(title){
	       $('#tt .panel-body').css('width','auto');
		}
	});
	$(".tabs-wrap").css('width','100%');
  });
 </script>
 </head>
 <body style="overflow-x: hidden;">
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" tiptype="1" action="jformGraphreportHeadController.do?doAdd">
					<input id="id" name="id" type="hidden" value="${jformGraphreportHeadPage.id }">
	<table cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right">
				<label class="Validform_label">名称:</label>
			</td>
			<td class="value">
		     	 <input id="name" name="name" type="text" style="width: 150px" class="inputxt"datatype="*">
				<span class="Validform_checktip"></span>
				<label class="Validform_label" style="display: none;">名称</label>
			</td>
			<td align="right">
				<label class="Validform_label">编码:</label>
			</td>
			<td class="value">
		     	 <input id="code" name="code" type="text" style="width: 150px" class="inputxt"datatype="*">
				<span class="Validform_checktip"></span>
				<label class="Validform_label" style="display: none;">编码</label>
			</td>
		</tr>

		<tr>
			<td align="right">
				<label class="Validform_label">描述:</label>
			</td>
			<td class="value">
				<input id="content" name="content" type="text" style="width: 150px" class="inputxt"datatype="*">
				<span class="Validform_checktip"></span>
				<label class="Validform_label" style="display: none;">描述</label>
			</td>
			<td align="right">
				<label class="Validform_label">y轴文字:</label>
			</td>
			<td class="value">
				<input id="ytext" name="ytext" type="text" style="width: 150px" class="inputxt"datatype="*">
				<span class="Validform_checktip"></span>
				<label class="Validform_label" style="display: none;">y轴文字</label>
			</td>

		</tr>
		<tr>

			<td align="right">
				<label class="Validform_label">x轴数据:</label>
			</td>
			<td class="value">
		     	 <input id="categories" name="categories" type="text" style="width: 150px" class="inputxt"datatype="*">
				<span class="Validform_checktip"></span>
				<label class="Validform_label" style="display: none;">x轴数据</label>
			</td>
			<td align="right">
				<label class="Validform_label">是否显示明细:</label>
			</td>
			<td class="value">
				<t:dictSelect field="isShowList" type="list"
							  typeGroupCode="sf_yn"  hasLabel="false"  title="是否显示明细"></t:dictSelect>
				<span class="Validform_checktip"></span>
				<label class="Validform_label" style="display: none;">是否显示明细</label>
			</td>
		</tr>
		<tr>
			<td align="right">
				<label class="Validform_label">查询数据SQL:</label>
			</td>
			<td class="value" colspan="3">
				<textarea id="cgrSql" style="width:600px;" class="inputxt" rows="4" name="cgrSql"></textarea>
				<span class="Validform_checktip"></span>
				<label class="Validform_label" style="display: none;">查询数据SQL</label>
			</td>

		</tr>
		<tr>

			<td align="right">
				<label class="Validform_label">扩展JS:</label>
			</td>
			<td class="value" colspan="3">
				 <textarea id="xpageJs" style="width:600px;" class="inputxt" rows="4" name="xpageJs"></textarea>
				<span class="Validform_checktip"></span>
				<label class="Validform_label" style="display: none;">扩展JS</label>
			</td>
		</tr>
	</table>
			<div style="width: auto;height: 200px;">
				<%-- 增加一个div，用于调节页面大小，否则默认太小 --%>
				<div style="width:800px;height:1px;"></div>
				<t:tabs id="tt" iframe="false" tabPosition="top" fit="false">
				 <t:tab href="jformGraphreportHeadController.do?jformGraphreportItemList&id=${jformGraphreportHeadPage.id}" icon="icon-search" title="图表配置" id="jformGraphreportItem"></t:tab>
				</t:tabs>
			</div>
			</t:formvalid>
			<!-- 添加 附表明细 模版 -->
	<table style="display:none">
	<tbody id="add_jformGraphreportItem_table_template">
		<tr>
			 <td align="center"><div style="width: 25px;" name="xh"></div></td>
			 <td align="center"><input style="width:20px;" type="checkbox" name="ck"/></td>
				  <td align="left">
					  	<input name="jformGraphreportItemList[#index#].fieldName" maxlength="36" 
					  		type="text" class="inputxt"  style="width:120px;"
					               
					               >
					  <label class="Validform_label" style="display: none;">字段名</label>
				  </td>
				  <td align="left">
					  	<input name="jformGraphreportItemList[#index#].fieldTxt" maxlength="1000" 
					  		type="text" class="inputxt"  style="width:120px;"
					               
					               >
					  <label class="Validform_label" style="display: none;">字段文本</label>
				  </td>
				  <td align="left">
					  	<input name="jformGraphreportItemList[#index#].orderNum" maxlength="10" 
					  		type="text" class="inputxt"  style="width:40px;"
					               
					               >
					  <label class="Validform_label" style="display: none;">排序</label>
				  </td>
				  <td align="left">
							<t:dictSelect field="jformGraphreportItemList[#index#].fieldType" extendJson="{style:'width:100px'}"
										typeGroupCode="fieldtype" defaultVal="" hasLabel="false"  title="字段类型"></t:dictSelect>     
					  <label class="Validform_label" style="display: none;">字段类型</label>
				  </td>
				  <td align="left">
							<t:dictSelect field="jformGraphreportItemList[#index#].isShow" type="list" extendJson="{style:'width:100px'}"
										typeGroupCode="sf_yn" defaultVal="" hasLabel="false"  title="是否显示"></t:dictSelect>     
					  <label class="Validform_label" style="display: none;">是否显示</label>
				  </td>
				  <td align="left">
							<t:dictSelect field="jformGraphreportItemList[#index#].searchFlag" type="list" extendJson="{style:'width:100px'}"
										typeGroupCode="sf_yn" defaultVal="" hasLabel="false"  title="是否查询"></t:dictSelect>     
					  <label class="Validform_label" style="display: none;">是否查询</label>
				  </td>
				  <td align="left">
							<t:dictSelect field="jformGraphreportItemList[#index#].searchMode" type="list" extendJson="{style:'width:100px'}"
										typeGroupCode="searchmode" defaultVal="" hasLabel="false"  title="查询模式"></t:dictSelect>     
					  <label class="Validform_label" style="display: none;">查询模式</label>
				  </td>
				  <td align="left">
					  	<input name="jformGraphreportItemList[#index#].dictCode" maxlength="500" 
					  		type="text" class="inputxt"  style="width:120px;"
					               
					               >
					  <label class="Validform_label" style="display: none;">字典Code</label>
				  </td>
				  <td align="left">
							<t:dictSelect field="jformGraphreportItemList[#index#].isGraph" type="list" extendJson="{style:'width:100px'}"
										typeGroupCode="sf_yn" defaultVal="" hasLabel="false"  title="显示图表"></t:dictSelect>     
					  <label class="Validform_label" style="display: none;">显示图表</label>
				  </td>
				  <td align="left">
							<t:dictSelect field="jformGraphreportItemList[#index#].graphType" type="list" extendJson="{style:'width:100px'}"
										typeGroupCode="tblx" defaultVal="" hasLabel="false"  title="图表类型"></t:dictSelect>     
					  <label class="Validform_label" style="display: none;">图表类型</label>
				  </td>
				  <td align="left">
					  	<input name="jformGraphreportItemList[#index#].graphName" maxlength="100" 
					  		type="text" class="inputxt"  style="width:120px;"
					               
					               >
					  <label class="Validform_label" style="display: none;">图表名称</label>
				  </td>
				  <td align="left">
					  	<input name="jformGraphreportItemList[#index#].tabName" maxlength="50" 
					  		type="text" class="inputxt"  style="width:120px;"
					               
					               >
					  <label class="Validform_label" style="display: none;">标签名称</label>
				  </td>
			</tr>
		 </tbody>
		</table>
 </body>
 <script src = "webpage/jeecg/cgform/graphreport/jformGraphreportHead.js"></script>