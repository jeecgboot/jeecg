<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
<#include "/ui/datatype.ftl"/>
<#include "/ui/dictInfo.ftl"/>
<#-- update--end--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
<script type="text/javascript">
$(document).ready(function(){
    	if(location.href.indexOf("load=detail")!=-1){
			$(":input").attr("disabled","true");
		}
    });
</script>
<div style="width: auto;height: 300px;overflow-y:auto;overflow-x:auto;">
<#-- update--begin--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
<#assign ue_widget_count = 0>
<#-- update--end--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
<table cellpadding="0" cellspacing="1" class="formtable" id="${subsG['${key}'].entityName?uncap_first}_table" >
	<tbody id="add_${subsG['${key}'].entityName?uncap_first}_table" >	
	<c:if test="${"$"}{fn:length(${subsG['${key}'].entityName?uncap_first}List)  <= 0 }">
			<tr>
				<#list subColumnsMap['${key}'] as po>
				<#if po.isShow=="N">
					<input name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" type="hidden"  value="${'$'}{poVal.${po.fieldName}}"/>
				</#if>
				</#list>
			</tr>
			<#list subPageNoAreatextColumnsMap['${key}'] as po>
			  <#assign check = 0 >
			  <#list subsG['${key}'].foreignKeys as key>
			  <#if subFieldMeta[po.fieldName]==key?uncap_first>
			  <#assign check = 1 >
			  <#break>
			  </#if>
			  </#list>
			 <#if check==0>
			<#if po_index%2==0>
				<tr>
			</#if>
				  <td align="right">
					<label class="Validform_label">
										${po.content}:
									</label>
					</td>
				  <td class="value">
					<#if po.showType == "text">
					<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					  	<input name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text" class="inputxt" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"  tableName="${po.table.tableName}" fieldName="${po.oldFieldName}" idFieldName="${subsG['${key}'].entityName?uncap_first}List[0].id"/>/>
					<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->	
					<#elseif po.showType=='password'>
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<input name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="password" class="inputxt" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" />/>
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<t:dictSelect field="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" type="${po.showType?if_exists?html}" <@datatype inputCheck="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> <@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" /> defaultVal="${'$'}{${subsG['${key}'].entityName?uncap_first}Page.${po.fieldName}}" hasLabel="false"  title="${po.content}"></t:dictSelect>     
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					<#elseif po.showType=='date'>
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<input name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text" class="Wdate" onClick="WdatePicker()" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>/>
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
					<#elseif po.showType=='file' || po.showType == 'image'>
					<#-- update--end--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
										<input type="hidden" id="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" />
									   <#-- update--begin--author:zhangjiaqiang date:20171120 for:TASK #2419 【代码生成器模板】一对多情况下，附件样式改造 -->
									   <input class="ui-button" type="button" value="上传附件"
													onclick="commonUpload(${subsG['${key}'].entityName?uncap_first}List0${po.fieldName}Callback)"/> 
										<a  target="_blank" id="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}_href"></a>
										<#-- update--end--author:zhangjiaqiang date:20171120 for:TASK #2419 【代码生成器模板】一对多情况下，附件样式改造 -->
										<script type="text/javascript">
										function ${subsG['${key}'].entityName?uncap_first}List0${po.fieldName}Callback(url,name){
											$("#${subsG['${key}'].entityName?uncap_first}List\\[0\\]\\.${po.fieldName}_href").attr('href',url).html('下载');
											$("#${subsG['${key}'].entityName?uncap_first}List\\[0\\]\\.${po.fieldName}").val(url);
										}
										</script>
					      <#elseif po.showType=='datetime'>
					      	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					      	<input name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text"  class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>/>
					       <#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					      <#elseif po.showType=='popup'>
					      	<#-- update--begin--author:baiyu Date:20171031 for:popup方法支持返回多个字段-->
							 <input  id="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" type="text" style="width: 150px" class="searchbox-inputtext"   value="${'$'}{poVal.${po.fieldName} }" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /><#if po.dictTable?if_exists?html!=""> onclick="popupClick(this,'${po.dictText}','${po.dictField}','${po.dictTable}')"</#if>/> 			 
							<#-- update--end--author:baiyu Date:20171031 for:popup方法支持返回多个字段--> 
					       <#else>
					       <#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					       	<input name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}"type="text" class="inputxt" <@datatype  validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> />
					  		<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					  </#if>
					  <label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
					</td>
				<#if (po_index+1)%2==0>
				</tr>
				<#else>
				<#if !po_has_next>
				</tr>
				</#if>
				</#if>
			  </#if>
            </#list>
            <#-- update--begin--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
            <#list subPageAreatextColumnsMap['${key}'] as po>
				<tr>
					<td align="right">
						<label class="Validform_label">${po.content}:</label>
					</td>
					<td class="value" colspan="3">
					  <#if po.showType=='textarea' || po.showType='umeditor'>
						  <textarea id="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" style="width:600px;height:60px;" class="inputxt" rows="6" name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" />></textarea>
						<#--
						<#elseif po.showType='umeditor'>
							<#assign ue_widget_count = ue_widget_count + 1>
							<#if ue_widget_count == 1>
							<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.config.js"></script>
							<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.all.min.js"></script>
							</#if>
					    	<textarea name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" id="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" style="width: 650px;height:300px"></textarea>
						    <script type="text/javascript">
						        var ${po.fieldName}_editor = UE.getEditor('${po.fieldName}');
						    </script>
						    -->
						</#if>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
					</td>
				</tr>
			</#list>
			<#-- update--end--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
	</c:if>
	<c:if test="${"$"}{fn:length(${subsG['${key}'].entityName?uncap_first}List)  > 0 }">
		<c:forEach items="${"$"}{${subsG['${key}'].entityName?uncap_first}List}" var="poVal" varStatus="stuts" begin="0" end="0">
			<tr>
				<#list subColumnsMap['${key}'] as po>
				<#if po.isShow=="N">
					<input name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" type="hidden" value="${'$'}{poVal.${po.fieldName}}"/>
				</#if>
				</#list>
			</tr>
			<#list subPageNoAreatextColumnsMap['${key}'] as po>
			  <#assign check = 0 >
			  <#list subsG['${key}'].foreignKeys as key>
			  <#if subFieldMeta[po.fieldName]==key?uncap_first>
			  <#assign check = 1 >
			  <#break>
			  </#if>
			  </#list>
			  <#if check==0>
			 <#if po_index%2==0>
			<tr>
			</#if>
				  <td align="right">
					<label class="Validform_label">
										${po.content}:
									</label>
					</td>
				  <td class="value">
					<#if po.showType == "text">
					<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					  	<input name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text" class="inputxt" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"  tableName="${po.table.tableName}" fieldName="${po.oldFieldName}" idFieldName="${subsG['${key}'].entityName?uncap_first}List[0].id"/> value="${'$'}{poVal.${po.fieldName} }"/>
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<#elseif po.showType=='password'>
							<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							<input name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="password" class="inputxt" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /> value="${'$'}{poVal.${po.fieldName} }"/>
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>
							<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							<#-- update--begin--author:zhoujf Date:20180329 for:TASK #2598 【代码生成器】一对多生成 t:dictSelect控件 表单编辑页面数据不能初始化 -->
							<t:dictSelect field="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" type="${po.showType?if_exists?html}" <@datatype inputCheck="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/><@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" /> defaultVal="${'$'}{poVal.${po.fieldName}}" hasLabel="false"  title="${po.content}"></t:dictSelect>     
							<#-- update--end--author:zhoujf Date:20180329 for:TASK #2598 【代码生成器】一对多生成 t:dictSelect控件 表单编辑页面数据不能初始化 -->
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<#elseif po.showType=='date'>
							<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							<input name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text" class="Wdate" onClick="WdatePicker()" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> value="<fmt:formatDate value='${'$'}{poVal.${po.fieldName}}' type="date" pattern="yyyy-MM-dd"/>"/>
					      	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					      <#elseif po.showType=='datetime'>
					      	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					      	<input name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text"  class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> value="<fmt:formatDate value='${'$'}{poVal.${po.fieldName}}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>"/>
					     	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					     <#elseif po.showType=='file'>
							 <input type="hidden" id="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" value="${'$'}{poVal.${po.fieldName} }"/>
										<c:if test="${'$'}{empty poVal.${po.fieldName}}">
											<a  target="_blank" id="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}_href">暂时未上传文件</a>
										</c:if>
										<c:if test="${'$'}{!empty poVal.${po.fieldName}}">
											<a  href="${'$'}{poVal.${po.fieldName}}"  target="_blank" id="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}_href">下载</a>
										</c:if>
									   <input class="ui-button" type="button" value="上传附件"
													onclick="commonUpload(${subsG['${key}'].entityName?uncap_first}List0${po.fieldName}Callback)"/> 
										<script type="text/javascript">
										function ${subsG['${key}'].entityName?uncap_first}List0${po.fieldName}Callback(url,name){
											$("#${subsG['${key}'].entityName?uncap_first}List\\[0\\]\\.${po.fieldName}_href").attr('href',url).html('下载');
											$("#${subsG['${key}'].entityName?uncap_first}List\\[0\\]\\.${po.fieldName}").val(url);
										}
										</script>
								<#elseif po.showType=='popup'>
									<#-- update--begin--author:baiyu Date:20171031 for:popup方法支持返回多个字段-->
							 		<input  id="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" type="text" style="width: 150px" class="searchbox-inputtext"  value="${'$'}{poVal.${po.fieldName} }"  <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /><#if po.dictTable?if_exists?html!="">  onclick="popupClick(this,'${po.dictText}','${po.dictField}','${po.dictTable}')"</#if>/> 			 
							 		<#-- update--end--author:baiyu Date:20171031 for:popup方法支持返回多个字段-->
					       <#else>
					       	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					       	<input name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text" class="inputxt" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> value="${'$'}{poVal.${po.fieldName} }"/>
					 		<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					   </#if>
					  <label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
					</td>
				<#if (po_index+1)%2==0>
				</tr>
				<#else>
				<#if !po_has_next>
				</tr>
				</#if>
				</#if>
			  </#if>
            </#list>
            <#-- update--begin--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
            <#list subPageAreatextColumnsMap['${key}'] as po>
				<tr>
					<td align="right">
						<label class="Validform_label">${po.content}:</label>
					</td>
					<td class="value" colspan="3">
				     <#if po.showType=='textarea' || po.showType='umeditor'>
						 <textarea id="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" style="width:600px;height:60px;" class="inputxt" rows="6" name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" />>${'$'}{poVal.${po.fieldName}}</textarea>
						<#--
						<#elseif po.showType='umeditor'>
							<#assign ue_widget_count = ue_widget_count + 1>
							<#if ue_widget_count == 1>
							<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.config.js"></script>
							<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.all.min.js"></script>
							</#if>
		                <textarea name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" id="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" style="width: 650px;height:300px">${'$'}{poVal.${po.fieldName} }</textarea>
						    <script type="text/javascript">
						        var ${po.fieldName}_editor = UE.getEditor('${po.fieldName}');
						    </script>
						    -->
						</#if>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
					</td>
				</tr>
			</#list>
			<#-- update--end--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
		</c:forEach>
	</c:if>	
	</tbody>
</table>
</div>