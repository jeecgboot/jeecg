<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
<#include "../../ui/datatype.ftl"/>
<#include "../../ui/dictInfo.ftl"/>
<#include "../../ui/tag.ftl"/>
<#-- update--end--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
<!-- <h4>分类标题</h4> -->
	    <div class="row">
	      <div class="col-md-12 layout-header">
	        <button id="addBtn_${entityName}" type="button" class="btn btn-default">添加</button>
	        <button id="delBtn_${entityName}" type="button" class="btn btn-default">删除</button>
	        <script type="text/javascript"> 
			$('#addBtn_${entityName}').bind('click', function(){   
		 		 var tr =  $("#add_${entityName?uncap_first}_table_template tr").clone();
			 	 $("#add_${entityName?uncap_first}_table").append(tr);
			 	 resetTrNum('add_${entityName?uncap_first}_table');
			 	 return false;
		    });  
			$('#delBtn_${entityName}').bind('click', function(){   
		       $("#add_${entityName?uncap_first}_table").find("input:checked").parent().parent().remove();   
		        resetTrNum('add_${entityName?uncap_first}_table');
		        return false;
		    });
		    $(document).ready(function(){
		    	if(location.href.indexOf("load=detail")!=-1){
					$(":input").attr("disabled","true");
					$(".datagrid-toolbar").hide();
				}
		    	resetTrNum('add_${entityName?uncap_first}_table');
		    });
		</script>
	      </div>
	    </div>
<div style="margin: 0 15px; background-color: white;">    
	    <!-- Table -->
      <table id="${entityName?uncap_first}_table" class="table table-bordered table-hover" style="margin-bottom: 0;">
		<thead>
	      <tr>
	        <th style="white-space:nowrap;width:50px;">序号</th>
	        <th style="white-space:nowrap;width:50px;">操作</th>
	        <#-- update--begin--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
			<#list columns as po>
				<#if po.isShow=="Y">
		    <#-- update--end--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
					 <#assign check = 0 >
					  <#list foreignKeys as key>
					  <#if fieldMeta[po.fieldName]==key?uncap_first>
					  <#assign check = 1 >
					  <#break>
					  </#if>
					  </#list>
					  <#if check==0>
					  <th>
							${po.content}
					  </th>
					  </#if>
			     <#-- update--begin--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
				 </#if>
				 <#-- update--end--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
		      </#list>
	      </tr>
	    </thead>
        
	<tbody id="add_${entityName?uncap_first}_table">	
	<c:if test="${"$"}{fn:length(${entityName?uncap_first}List)  <= 0 }">
			<tr>
				<th scope="row"><div name="xh"></div></th>
				<td><input style="width:20px;" type="checkbox" name="ck"/></td>
				<#list columns as po>
				<#if po.isShow=="N">
					<input name="${entityName?uncap_first}List[0].${po.fieldName}" type="hidden"/>
				</#if>
				</#list>
				<#-- update--begin--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
				<#list columns as po>
				<#if po.isShow=="Y">
				<#-- update--end--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
				  <#assign check = 0 >
				  <#list foreignKeys as key>
				  <#if fieldMeta[po.fieldName]==key?uncap_first>
				  <#assign check = 1 >
				  <#break>
				  </#if>
				  </#list>
				  <#if check==0>
				  <td>
					<#if po.showType == "text">
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<#-- update--begin--author:Yandong Date:20180226 for:TASK #2513 【bug】代码生成器，新添加的online唯一校验生成代码问题-->
					  	<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text" class="form-control"  style="width:120px;" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}" tableName="${po.table.tableName}" fieldName="${po.oldFieldName}" idFieldName="${entityName?uncap_first}List[0].id"/>/>
						<#-- update--end--author:Yandong Date:20180226 for:TASK #2513 【bug】代码生成器，新添加的online唯一校验生成代码问题-->
						<#-- update--end--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					<#elseif po.showType=='password'>
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="password" class="form-control"  style="width:120px;" <@datatype  validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>/>
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>
						<#-- update-begin-author:taoyan Date:20180519 for:dictselect改用标签便于以后统一修改 -->
						<@dictSelecttag po = po namePre="${entityName?uncap_first}List[0]." formStyle="aces" opt="" />
						<#-- update-end-author:taoyan Date:20180519 for:dicselect改用标签便于以后统一修改 -->
					<#elseif po.showType=='date'>
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text" class="form-control" onClick="WdatePicker()"  style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width:160px;" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>/>
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					<#elseif po.showType=='datetime'>
						   <#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						   <input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text"  class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width:160px;" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>/>
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
					<#elseif po.showType=='popup'>
						<#-- update--begin--author:baiyu Date:20171031 for:popupClick支持返回多个字段 -->
						<#-- update--begin--author:gj_shaojc Date:20180302 for:TASK #2548 【代码生成器】样式问题-->
						<#-- update--begin--author:gj_shaojc Date:20180315 for:TASK #2548 【代码生成器】样式问题-->
						<input  id="${entityName?uncap_first}List[0].${po.fieldName}" name="${entityName?uncap_first}List[0].${po.fieldName}" type="text"  class="form-control"  value="${'$'}{poVal.${po.fieldName} }" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /><#if po.dictTable?if_exists?html!=""> onclick="popupClick(this,'${po.dictText}','${po.dictField}','${po.dictTable}')"</#if>/> 			 
						<#-- update--end--author:gj_shaojc Date:20180315 for:TASK #2548 【代码生成器】样式问题-->
						<#-- update--end--author:gj_shaojc Date:20180302 for:TASK #2548 【代码生成器】样式问题-->
						<#-- update--end--author:baiyu Date:20171031 for:popupClick支持返回多个字段 -->
					<#elseif po.showType=='file' || po.showType == 'image'>
					<#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
							<input type="hidden" id="${entityName?uncap_first}List[0].${po.fieldName}" name="${entityName?uncap_first}List[0].${po.fieldName}" />
									   <#-- update--begin--author:zhangjiaqiang date:20171120 for:TASK #2419 【代码生成器模板】一对多情况下，附件样式改造 -->
									   <#-- update--begin--author:zhangjiaqiang date:20170614 for:修订上传附件按钮的大小 -->
									   <input class="btn btn-sm btn-success" style="margin-left:10px;" type="button" value="上传附件"
													onclick="commonUpload(commonUploadDefaultCallBack,'${entityName?uncap_first}List\\[0\\]\\.${po.fieldName}')"/> 
					 					<#-- update--end--author:zhangjiaqiang date:20170614 for:修订上传附件按钮的大小 -->
					 					<a  target="_blank" id="${entityName?uncap_first}List[0].${po.fieldName}_href"></a>
					 					<#-- update--end--author:zhangjiaqiang date:20171120 for:TASK #2419 【代码生成器模板】一对多情况下，附件样式改造 -->
					   <#else>
					  		<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					       	<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text" class="form-control"  style="width:120px;" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> />
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
	</c:if>
	<c:if test="${"$"}{fn:length(${entityName?uncap_first}List)  > 0 }">
		<c:forEach items="${"$"}{${entityName?uncap_first}List}" var="poVal" varStatus="stuts">
			<tr>
				<th scope="row"><div name="xh">${'$'}{stuts.index+1 }</div></th>
				<td><input style="width:20px;" type="checkbox" name="ck"/></td>
				<#list columns as po>
				<#if po.isShow=="N">
					<input name="${entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" type="hidden" value="${'$'}{poVal.${po.fieldName} }"/>
				</#if>
				</#list>
				<#-- update--begin--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
				<#list columns as po>
				<#if po.isShow=="Y">
				<#-- update--end--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
				  <#assign check = 0 >
				  <#list foreignKeys as key>
				  <#if fieldMeta[po.fieldName]==key?uncap_first>
				  <#assign check = 1 >
				  <#break>
				  </#if>
				  </#list>
				  <#if check==0>
				   <td align="left">
				   <#if po.showType == "text">
				   		<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					  	<input name="${entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" maxlength="${po.length?c}" type="text" class="form-control"  style="width:120px;" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}" tableName="${po.table.tableName}" fieldName="${po.oldFieldName}" idFieldName="${entityName?uncap_first}List[${'$'}{stuts.index }].id"/> value="${'$'}{poVal.${po.fieldName} }"/>
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<#elseif po.showType=='password'>
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							<input name="${entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" maxlength="${po.length?c}" type="password" class="form-control"  style="width:120px;" <@datatype  validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> value="${'$'}{poVal.${po.fieldName} }"/>
							<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>
							<#-- update-begin-author:taoyan Date:20180519 for:dictselect改用标签便于以后统一修改 -->
							<@dictSelecttag po = po namePre="${entityName?uncap_first}List[${'$'}{stuts.index }]." valuePre = "poVal." formStyle="aces" opt="update" />
							<#-- update-end-author:taoyan Date:20180519 for:dicselect改用标签便于以后统一修改 -->
						<#elseif po.showType=='date'>
							<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							<input name="${entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" maxlength="${po.length?c}" type="text" class="form-control" onClick="WdatePicker()"  style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width:160px;" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> value="<fmt:formatDate value='${'$'}{poVal.${po.fieldName}}' type="date" pattern="yyyy-MM-dd"/>"/>
					    	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					    <#elseif po.showType=='datetime'>
					      	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					      	<input name="${entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" maxlength="${po.length?c}" type="text"  class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width:160px;" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> value="<fmt:formatDate value='${'$'}{poVal.${po.fieldName}}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>"/>
					    	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					    	
						<#elseif po.showType=='popup'>
					        <#-- update--begin--author:baiyu Date:20171031 for:popupClick支持返回多个字段 -->
					        <#-- update--begin--author:gj_shaojc Date:20180302 for:TASK #2548 【代码生成器】样式问题-->
							<input  id="${entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" name="${entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}"  type="text"  class="form-control"  <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /><#if po.dictTable?if_exists?html!="">  onclick="popupClick(this,'${po.dictText}','${po.dictField}','${po.dictTable}')"</#if>   value="${'$'}{poVal.${po.fieldName} }" /> 			 
							<#-- update--end--author:gj_shaojc Date:20180302 for:TASK #2548 【代码生成器】样式问题-->
							<#-- update--end--author:baiyu Date:20171031 for:popupClick支持返回多个字段 -->
					    <#elseif po.showType=='file' || po.showType == 'image'>
					        <input type="hidden" id="${entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" name="${entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}"  value="${'$'}{poVal.${po.fieldName} }"/>
						    <#-- update--begin--author:zhangjiaqiang date:20171120 for:TASK #2419 【代码生成器模板】一对多情况下，附件样式改造 -->
						   <#-- update--begin--author:zhangjiaqiang date:20170614 for:修订上传附件按钮的大小 -->
						   <input  class="btn btn-sm btn-success" style="margin-left:10px;" type="button" value="上传附件" onclick="commonUpload(commonUploadDefaultCallBack,'${entityName?uncap_first}List\\[${'$'}{stuts.index }\\]\\.${po.fieldName}')"/> 
					    	<#-- update--begin--author:zhangjiaqiang date:20170614 for:修订上传附件按钮的大小 -->
					   		<c:if test="${'$'}{empty poVal.${po.fieldName}}">
								<a  target="_blank" id="${entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}_href"></a>
							</c:if>
							<c:if test="${'$'}{!empty poVal.${po.fieldName}}">
								<a  href="${'$'}{poVal.${po.fieldName}}"  target="_blank" id="${entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}_href">下载</a>
							</c:if>
					     <#else>
					      <#-- update--end--author:zhangjiaqiang date:20171120 for:TASK #2419 【代码生成器模板】一对多情况下，附件样式改造 -->
					       	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					       	<input name="${entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" maxlength="${po.length?c}" type="text" class="form-control"  style="width:120px;" <@datatype  validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> value="${'$'}{poVal.${po.fieldName} }"/>
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
