<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>${ftl_description}</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript">
  //初始化下标
	function resetTrNum(tableId) {
		$tbody = $("#"+tableId+"");
		$tbody.find('>tr').each(function(i){
			$(':input, select', this).each(function(){
				var $this = $(this), name = $this.attr('name'), val = $this.val();
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
			});
			$(this).find('div[name=\'xh\']').html(i+1);
		});
	}
 </script>
 </head>
 <body style="overflow-y: hidden" scroll="no">
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" tiptype="1" action="${entityName?uncap_first}Controller.do?save">
			<input id="id" name="id" type="hidden" value="${'$'}{${entityName?uncap_first}Page.id }">
			<table cellpadding="0" cellspacing="1" class="formtable">
			<#list columns as po>
			<#if po_index%2==0>
			<tr>
			</#if>
			<td align="right"><label class="Validform_label"><#if po.filedComment?length lt 7 ><#if po.filedComment?length lt 7 >${po.filedComment}<#else>${po.filedComment[0..6]}</#if><#else>${po.filedComment[0..6]}</#if>:</label></td>
			<td class="value">
				<input nullmsg="请填写<#if po.filedComment?length lt 7 ><#if po.filedComment?length lt 7 >${po.filedComment}<#else>${po.filedComment[0..6]}</#if><#else>${po.filedComment[0..6]}</#if>" errormsg="<#if po.filedComment?length lt 7 ><#if po.filedComment?length lt 7 >${po.filedComment}<#else>${po.filedComment[0..6]}</#if><#else>${po.filedComment[0..6]}</#if>格式不对" <#if po.classType=='easyui-datetimebox'>class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  style="width: 150px"<#elseif po.classType=='easyui-datebox'>class="Wdate" onClick="WdatePicker()"  style="width: 150px"<#else>class="${po.classType}"</#if> id="${po.fieldName}" name="${po.fieldName}" <#if po.nullable == 'Y'>ignore="ignore"</#if>	<#if po.fieldType?index_of("time")!=-1>  value="<fmt:formatDate value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>"<#else><#if po.fieldType?index_of("date")!=-1>value="<fmt:formatDate value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}' type="date" pattern="yyyy-MM-dd"/>"<#else>value="${'$'}{${entityName?uncap_first}Page.${po.fieldName}}"</#if></#if><#if po.optionType?trim?length !=0> datatype="${po.optionType}"</#if> />
				<span class="Validform_checktip"></span>
			</td>
			<#if (po_index+1)%2==0>
			</tr>
			<#else>
			<#if !po_has_next>
			</tr>
			</#if>
			</#if>
			</#list>
			</table>
			<div style="width: auto;height: 200px;">
				<%-- 增加一个div，用于调节页面大小，否则默认太小 --%>
				<div style="width:690px;height:1px;"></div>
				<t:tabs id="tt" iframe="false" tabPosition="top" fit="false">
				<#list subTab as sub>
				 <t:tab href="${entityName?uncap_first}Controller.do?${sub.entityName?uncap_first}List<#list sub.foreignKeys as key><#if key?lower_case?index_of("${jeecg_table_id}")!=-1>&${jeecg_table_id}=${"$"}{${entityName?uncap_first}Page.${jeecg_table_id}}<#else>&${key?uncap_first}=${"$"}{${entityName?uncap_first}Page.${key?uncap_first}}</#if></#list>" icon="icon-search" title="${sub.ftlDescription}" id="${sub.entityName?uncap_first}"></t:tab>
				</#list>
				</t:tabs>
			</div>
			</t:formvalid>
			<!-- 添加 明细 模版 -->
		<table style="display:none">
		<#list subTab as sub>
		<tbody id="add_${sub.entityName?uncap_first}_table_template">
			<tr>
			 <td align="center"><div style="width: 25px;" name="xh"></div></td>
			 <td align="center"><input style="width:20px;" type="checkbox" name="ck"/></td>
			 <#list sub.subColums as po>
				 <#assign check = 0 >
				  <#list sub.foreignKeys as key>
				  <#if po.fieldName==key?uncap_first>
				  <#assign check = 1 >
				  <#break>
				  </#if>
				  </#list>
				  <#if check==0>
				  <td align="left"><input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" maxlength="${po.charmaxLength}" type="text" style="width:120px;"></td>
				  </#if>
              </#list>
			</tr>
		 </tbody>
		 </#list>
		</table>
 </body>