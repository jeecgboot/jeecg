<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
<#include "/ui/datatype.ftl"/>
<#include "/ui/dictInfo.ftl"/>
<#-- update--end--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
<script type="text/javascript">
	$('#add${subsG['${key}'].entityName}Btn').linkbutton({   
	    iconCls: 'icon-add'  
	});  
	$('#del${subsG['${key}'].entityName}Btn').linkbutton({   
	    iconCls: 'icon-remove'  
	}); 
	$('#add${subsG['${key}'].entityName}Btn').bind('click', function(){   
 		 var tr =  $("#add_${subsG['${key}'].entityName?uncap_first}_table_template tr").clone();
	 	 $("#add_${subsG['${key}'].entityName?uncap_first}_table").append(tr);
	 	 resetTrNum('add_${subsG['${key}'].entityName?uncap_first}_table');
	 	 return false;
    });  
	$('#del${subsG['${key}'].entityName}Btn').bind('click', function(){   
      	$("#add_${subsG['${key}'].entityName?uncap_first}_table").find("input[name$='ck']:checked").parent().parent().remove();   
        resetTrNum('add_${subsG['${key}'].entityName?uncap_first}_table'); 
        return false;
    }); 
    $(document).ready(function(){
    	$(".datagrid-toolbar").parent().css("width","auto");
    	if(location.href.indexOf("load=detail")!=-1){
			$(":input").attr("disabled","true");
			$(".datagrid-toolbar").hide();
		}
		<#-- update--begin--author:zhangjiaqiang date:20170614 for:去除表头固定功能 -->
		<#-- //将表格的表头固定
	    $("#${subsG['${key}'].entityName?uncap_first}_table").createhftable({
	    	height:'300px',
			width:'auto',
			fixFooter:false
			}); -->
		<#-- update--end--author:zhangjiaqiang date:20170614 for:去除表头固定功能 -->
    });
</script>
<div style="padding: 3px; height: 25px;width:auto;" class="datagrid-toolbar">
	<a id="add${subsG['${key}'].entityName}Btn" href="#">添加</a> <a id="del${subsG['${key}'].entityName}Btn" href="#">删除</a> 
</div>
<table border="0" cellpadding="2" cellspacing="0" id="${subsG['${key}'].entityName?uncap_first}_table">
	<tr bgcolor="#E6E6E6">
		<td align="center" bgcolor="#EEEEEE" style="width: 25px;">序号</td>
		<td align="center" bgcolor="#EEEEEE" style="width: 25px;">操作</td>
		 <#-- update--begin--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
		 <#list subColumnsMap['${key}'] as po>
			<#if po.isShow=="Y">
		<#-- update--end--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
				 <#assign check = 0 >
				  <#list subsG['${key}'].foreignKeys as key>
				  <#if subFieldMeta[po.fieldName]==key?uncap_first>
				  <#assign check = 1 >
				  <#break>
				  </#if>
				  </#list>
				  <#if check==0>
				  <td align="left" bgcolor="#EEEEEE" style="width: 126px;">
						${po.content}
				  </td>
				  </#if>
		<#-- update--begin--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
			</#if>
		<#-- update--end--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
	      </#list>
	</tr>
	<tbody id="add_${subsG['${key}'].entityName?uncap_first}_table">
	<#-- --author: jg_renjie ------start----date:20160328-------for: #1004 [代码生成器] coding生成一对多代码多个bug和解决办法 -->	
	<c:if test="${"$"}{fn:length(${subsG['${key}'].entityName?uncap_first}List)  <= 0 }">
			<tr>
				<td align="center"><div style="width: 25px;" name="xh">1</div></td>
				<td align="center"><input style="width:20px;"  type="checkbox" name="ck"/></td>
				<#list subColumnsMap['${key}'] as po>
				<#if po.isShow=="N">
					<input name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" type="hidden"/>
				</#if>
				</#list>
				<#-- update--begin--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
				<#list subColumnsMap['${key}'] as po>
				<#if po.isShow=="Y">
				<#-- update--end--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
				  <#assign check = 0 >
				  <#list subsG['${key}'].foreignKeys as key>
				  <#if subFieldMeta[po.fieldName]==key?uncap_first>
				  <#assign check = 1 >
				  <#break>
				  </#if>
				  </#list>
				  <#if check==0>
				  <td align="left">
					<#if po.showType == "text">
					  	<input name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text" class="inputxt"  style="width:120px;" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"  tableName="${po.table.tableName}" fieldName="${po.oldFieldName}" idFieldName="${subsG['${key}'].entityName?uncap_first}List[0].id" />>
						<#elseif po.showType=='password'>
							<input name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}"  type="password" class="inputxt"  style="width:120px;" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" />>
						<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>
							<t:dictSelect field="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" type="${po.showType?if_exists?html}" <@datatype inputCheck="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> <@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" /> defaultVal="${'$'}{${subsG['${key}'].entityName?uncap_first}Page.${po.fieldName}}" hasLabel="false"  title="${po.content}"></t:dictSelect>     
						<#elseif po.showType=='date'>
							<#-- update--begin--author:gj_shaojc Date:20180409 for:TASK #2622 【代码生成体验问题】代码生成 [多tab风格]、[table风格] 列表时间控件长度短了 -->
							<input name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}"  type="text" class="Wdate" onClick="WdatePicker()"  style="width:150px;" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>>
					      	<#-- update--end--author:gj_shaojc Date:20180409 for:TASK #2622 【代码生成体验问题】代码生成 [多tab风格]、[table风格] 列表时间控件长度短了 -->
					      <#elseif po.showType=='datetime'>
					      	<#-- update--begin--author:gj_shaojc Date:20180409 for:TASK #2622 【代码生成体验问题】代码生成 [多tab风格]、[table风格] 列表时间控件长度短了 -->
					      	<input name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text"  class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  style="width:150px;" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>>
					      	<#-- update--end--author:gj_shaojc Date:20180409 for:TASK #2622 【代码生成体验问题】代码生成 [多tab风格]、[table风格] 列表时间控件长度短了 -->
					       <#elseif po.showType=='file' || po.showType == 'image'>
							<input type="hidden" id="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" />
									  <#-- update--begin--author:zhangjiaqiang date:20171120 for:TASK #2419 【代码生成器模板】一对多情况下，附件样式改造 -->
									    <input class="ui-button" type="button" value="上传附件" onclick="commonUpload(commonUploadDefaultCallBack,'${subsG['${key}'].entityName?uncap_first}List\\[0\\]\\.${po.fieldName}')"/> 
										<a  target="_blank" id="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}_href">未上传</a>
										<#-- update--end--author:zhangjiaqiang date:20171120 for:TASK #2419 【代码生成器模板】一对多情况下，附件样式改造 -->
						   <#elseif po.showType=='popup'>
						   	 <#-- update--begin--author:baiyu Date:20171031 for:popup方法支持返回多个字段-->
							 <input  id="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" type="text" style="width: 150px" class="searchbox-inputtext"  value="${'$'}{poVal.${po.fieldName} }"  <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /><#if po.dictTable?if_exists?html!="">  onclick="popupClick(this,'${po.dictText}','${po.dictField}','${po.dictTable}')"</#if>/> 			 
							 <#-- update--end--author:baiyu Date:20171031 for:popup方法支持返回多个字段-->
							 <#else>
					       	<input name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text" class="inputxt"  style="width:120px;" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> >
					  </#if>
					  <label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
					</td>
				  </#if>
				  <#-- update--begin--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
				  </#if>
				  <#-- update--end--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
	            </#list>
   			</tr>
	</c:if>
	<#-- --author: jg_renjie ------end----date:20160328-------for: #1004 [代码生成器] coding生成一对多代码多个bug和解决办法 -->	
	<c:if test="${"$"}{fn:length(${subsG['${key}'].entityName?uncap_first}List)  > 0 }">
		<c:forEach items="${"$"}{${subsG['${key}'].entityName?uncap_first}List}" var="poVal" varStatus="stuts">
			<tr>
				<td align="center"><div style="width: 25px;" name="xh">${'$'}{stuts.index+1 }</div></td>
				<td align="center"><input style="width:20px;"  type="checkbox" name="ck" /></td>
				<#list subColumnsMap['${key}'] as po>
					<#if po.isShow=="N">
						<input name="${subsG['${key}'].entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" type="hidden" value="${'$'}{poVal.${po.fieldName} }"/>
					</#if>
				</#list>
				<#-- update--begin--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
				<#list subColumnsMap['${key}'] as po>
				<#if po.isShow=="Y">
				<#-- update--end--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
				  <#assign check = 0 >
				  <#list subsG['${key}'].foreignKeys as key>
				  <#if subFieldMeta[po.fieldName]==key?uncap_first>
				  <#assign check = 1 >
				  <#break>
				  </#if>
				  </#list>
				  <#if check==0>
				   <td align="left">
				   <#if po.showType == "text">
				   <#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					  	<input name="${subsG['${key}'].entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" maxlength="${po.length?c}" type="text" class="inputxt"  style="width:120px;" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"  tableName="${po.table.tableName}" fieldName="${po.oldFieldName}" idFieldName="${subsG['${key}'].entityName?uncap_first}List[${'$'}{stuts.index }].id" /> value="${'$'}{poVal.${po.fieldName} }"/>
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<#elseif po.showType=='password'>
							<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							<input name="${subsG['${key}'].entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" maxlength="${po.length?c}" type="password" class="inputxt"  style="width:120px;" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /> value="${'$'}{poVal.${po.fieldName} }"/>
							<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>
							<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							<t:dictSelect field="${subsG['${key}'].entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" type="${po.showType?if_exists?html}" <@datatype inputCheck="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> <@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" /> defaultVal="${'$'}{poVal.${po.fieldName} }" hasLabel="false"  title="${po.content}"></t:dictSelect>     
							<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<#elseif po.showType=='date'>
							<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							<#-- update--begin--author:gj_shaojc Date:20180409 for:TASK #2622 【代码生成体验问题】代码生成 [多tab风格]、[table风格] 列表时间控件长度短了 -->
							<input name="${subsG['${key}'].entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" maxlength="${po.length?c}" type="text" class="Wdate" onClick="WdatePicker()"  style="width:150px;"  <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> value="<fmt:formatDate value='${'$'}{poVal.${po.fieldName}}' type="date" pattern="yyyy-MM-dd"/>"/>
					     	<#-- update--end--author:gj_shaojc Date:20180409 for:TASK #2622 【代码生成体验问题】代码生成 [多tab风格]、[table风格] 列表时间控件长度短了 -->
					     	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					     <#elseif po.showType=='datetime'>
					      	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					      	<#-- update--begin--author:gj_shaojc Date:20180409 for:TASK #2622 【代码生成体验问题】代码生成 [多tab风格]、[table风格] 列表时间控件长度短了 -->
					      	<input name="${subsG['${key}'].entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" maxlength="${po.length?c}" type="text"  class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  style="width:150px;" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> value="<fmt:formatDate value='${'$'}{poVal.${po.fieldName}}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>"/>
					     	<#-- update--end--author:gj_shaojc Date:20180409 for:TASK #2622 【代码生成体验问题】代码生成 [多tab风格]、[table风格] 列表时间控件长度短了 -->
					     	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					     	<#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
					     <#elseif po.showType=='file' || po.showType == 'image'>
					     <#-- update--end--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
					        <input type="hidden" id="${subsG['${key}'].entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" name="${subsG['${key}'].entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}"  value="${'$'}{poVal.${po.fieldName} }"/>
										 <#-- update--begin--author:zhangjiaqiang date:20171120 for:TASK #2419 【代码生成器模板】一对多情况下，附件样式改造 -->
									   <input class="ui-button" type="button" value="上传附件"
													onclick="commonUpload(commonUploadDefaultCallBack,'${subsG['${key}'].entityName?uncap_first}List\\[${'$'}{stuts.index }\\]\\.${po.fieldName}')"/> 
					  	 		<c:if test="${'$'}{empty poVal.${po.fieldName}}">
											<a  target="_blank" id="${subsG['${key}'].entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}_href"></a>
										</c:if>
										<c:if test="${'$'}{!empty poVal.${po.fieldName}}">
											<a  href="${'$'}{poVal.${po.fieldName}}"  target="_blank" id="${subsG['${key}'].entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}_href">下载</a>
										</c:if>
										 <#-- update--end--author:zhangjiaqiang date:20171120 for:TASK #2419 【代码生成器模板】一对多情况下，附件样式改造 -->
					  	 	<#elseif po.showType=='popup'>
					  	 	<#-- update--begin--author:baiyu Date:20171031 for:popup方法支持返回多个字段-->
							 <input  id="${subsG['${key}'].entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" name="${subsG['${key}'].entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}"  type="text" style="width: 150px" class="searchbox-inputtext"  <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /><#if po.dictTable?if_exists?html!=""> onclick="popupClick(this,'${po.dictText}','${po.dictField}','${po.dictTable}')"</#if>    value="${'$'}{poVal.${po.fieldName} }" /> 			 
							 <#-- update--end--author:baiyu Date:20171031 for:popup方法支持返回多个字段-->
					       <#else>
					       	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					       	<input name="${subsG['${key}'].entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" maxlength="${po.length?c}" type="text" class="inputxt"  style="width:120px;" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> value="${'$'}{poVal.${po.fieldName} }"/>
					  		<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					  </#if>
					  <label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
				   </td>
				  </#if>
				  <#-- update--begin--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
				  </#if>
				  <#-- update--end--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
   			 	</#list>
   			</tr>
		</c:forEach>
	</c:if>	
	</tbody>
</table>
