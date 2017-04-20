<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>动态报表配置抬头</title>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script type="text/javascript">
  $(document).ready(function(){
	$('#tt').tabs({
	   onSelect:function(title){
	       $('#tt .panel-body').css('width','auto');
		}
	});
	
	$('#tts').tabs({
		   onSelect:function(title){
		       $('#tts .panel-body').css('width','auto');
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
	function decode(value, id) {//value传入值,id接受值
		var last = value.lastIndexOf("/");
		var filename = value.substring(last + 1, value.length);
		$("#" + id).text(decodeURIComponent(filename));
	}
 </script>
</head>
<body style="overflow-x: hidden;">
<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" tiptype="1" action="cgDynamGraphConfigHeadController.do?doAdd">
	<input id="id" name="id" type="hidden" value="${cgDynamGraphConfigHeadPage.id }">
	<table cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right"><label class="Validform_label"><t:mutiLang langKey="common.code"/>:</label></td>
			<td class="value"><input id="code" name="code" type="text" style="width: 150px" class="inputxt" datatype="w1"> <span class="Validform_checktip"></span></td>
			<td align="right"><label class="Validform_label"><t:mutiLang langKey="common.name"/> :</label></td>
			<td class="value"><input id="name" name="name" type="text" style="width: 150px" class="inputxt" datatype="*"> <span class="Validform_checktip"></span></td>
            <td align="right"><label class="Validform_label"><t:mutiLang langKey="common.dynamic.dbsource"/> :</label></td>
            <td class="value"><t:dictSelect field="dbSource" dictTable="t_s_data_source" dictField="DB_KEY" dictText="DB_KEY" /><span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"><t:mutiLang langKey="query.sql"/>:</label></td>
			<td class="value" colspan="5"><textarea rows="5" cols="150" id="cgrSql" name="cgrSql" datatype="*"></textarea> <span class="Validform_checktip"></span>
						<p>&nbsp;&nbsp;&nbsp;&nbsp;您可以键入“${abc}”作为一个参数，这里abc是参数的名称。例如：<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;select broswer name,count(1) value, '#286FBB' color from t_s_log  where id = <%="${abc}"%> group by broswer。<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;select broswer name,count(1) value, '#286FBB' color from t_s_log  where id = <%="'${abc}'"%>  group by broswer。（如果id字段为字符串类型）<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">注：必要用 name,value,color 列。 name 为X轴数据,value 为Y轴数据,color为图表的颜色</font><p/>
			</td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"><t:mutiLang langKey="common.description"/>:</label></td>
			<td class="value" colspan="5"><textarea rows="3" cols="150" id="content" name="content" datatype="*"></textarea> <span class="Validform_checktip"></span></td>
		</tr>
        
		<tr>
			<td align="right"><label class="Validform_label">图表类型:</label></td>
			<td class="value"><t:dictSelect field="graphType" typeGroupCode="graphType" hasLabel="false"/><span class="Validform_checktip"></span></td>
			<td align="right"><label class="Validform_label">数据结构类型:</label></td>
			<td class="value" colspan="3"><t:dictSelect field="dataStructure" typeGroupCode="fieldtype" hasLabel="false"/> <span class="Validform_checktip"></span></td>
        </tr>
	</table>
	<div style="width: auto; height: 200px;"><%-- 增加一个div，用于调节页面大小，否则默认太小 --%>
	<div style="width: 800px; height: 1px;"></div>
	
	<t:tabs id="ttp" iframe="false" tabPosition="top" fit="false"><t:tab href="cgDynamGraphConfigHeadController.do?cgDynamGraphConfigParamList&id=${cgDynamGraphConfigHeadPage.id}" icon="icon-search" title="报表参数" id="cgDynamGraphConfigParam"></t:tab></t:tabs>				
	<t:tabs id="tt" iframe="false" tabPosition="top" fit="false"><t:tab href="cgDynamGraphConfigHeadController.do?cgDynamGraphConfigItemList&id=${cgDynamGraphConfigHeadPage.id}" icon="icon-search" title="dynamic.report.config.detail" id="cgDynamGraphConfigItem"></t:tab></t:tabs></div>
</t:formvalid>
<!-- 添加 附表明细 模版 -->
<table style="display: none">
	<tbody id="add_cgDynamGraphConfigItem_table_template">
		<tr>
			<td align="center"><input style="width: 20px;" type="checkbox" name="ck" /></td>
			<td align="left"><input name="cgDynamGraphConfigItemList[#index#].fieldName" maxlength="36" type="text" class="inputxt" style="width: 120px;"></td>
			<td align="left"><input name="cgDynamGraphConfigItemList[#index#].orderNum" maxlength="10" type="text" class="inputxt" style="width: 30px;"></td>
			<td align="left"><input name="cgDynamGraphConfigItemList[#index#].fieldTxt" maxlength="1000" type="text" class="inputxt" style="width: 120px;"></td>
			<td align="left"><t:dictSelect field="cgDynamGraphConfigItemList[#index#].fieldType" extendJson="{style:'width:80px'}" type="list" typeGroupCode="fieldtype" defaultVal="String" hasLabel="false" title="common.text.type"></t:dictSelect></td>
			<td align="left"><select id="isShow" name="cgDynamGraphConfigItemList[#index#].isShow"  style="width: 60px;">
				<option value="Y"><t:mutiLang langKey="common.show"/></option>
				<option value="N"><t:mutiLang langKey="common.hide"/></option>
			</select></td>
			<td align="left"><input name="cgDynamGraphConfigItemList[#index#].fieldHref" maxlength="1000" type="text" class="inputxt" style="width: 120px;">
			<td align="left"><t:dictSelect field="cgDynamGraphConfigItemList[#index#].SMode"  extendJson="{style:'width:90px'}" type="list" typeGroupCode="searchmode" defaultVal="" hasLabel="false" title="common.query.module"></t:dictSelect></td>
			<td align="left"><input name="cgDynamGraphConfigItemList[#index#].replaceVa" maxlength="36" type="text" class="inputxt" style="width: 120px;"></td>
			<td align="left"><input name="cgDynamGraphConfigItemList[#index#].dictCode" maxlength="36" type="text" class="inputxt" style="width: 120px;"></td>
			<td align="left"><t:dictSelect field="cgDynamGraphConfigItemList[#index#].SFlag"  extendJson="{style:'width:60px'}" type="list" typeGroupCode="yesorno" defaultVal="" hasLabel="false" title="common.isquery"></t:dictSelect></td>
		</tr>
	</tbody>
</table>
<table style="display: none">
	<tbody id="add_cgDynamGraphConfigParam_table_template">
		<tr>
		 <td align="center"><input style="width:20px;" type="checkbox" name="ck"/></td>
		 <td align="left"><input name="cgDynamGraphConfigParamList[#index#].paramName" maxlength="32" type="text" class="inputxt"  style="width:120px;" datatype="*" ></td>
		 <td align="left"><input name="cgDynamGraphConfigParamList[#index#].paramDesc" maxlength="32" type="text" class="inputxt"  style="width:120px;" ></td>
	     <td align="left"><input name="cgDynamGraphConfigParamList[#index#].paramValue" maxlength="32" type="text" class="inputxt"  style="width:120px;" ></td>
		 <td align="left"><input name="cgDynamGraphConfigParamList[#index#].seq" maxlength="32" type="text" class="inputxt"  style="width:120px;"></td>
		</tr>
	 </tbody>
</table>
</body>
<script src="webpage/jeecg/cgdynamgraph/core/cgDynamGraphConfigHead.js"></script>