<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<#include "/ui/datatype.ftl"/>
<#include "/ui/dictInfo.ftl"/>
<#include "/ui/formControl.ftl"/>
<#include "/ui/tag.ftl"/>
<script type="text/javascript"> 
    $(document).ready(function(){
    	if(location.href.indexOf("load=detail")!=-1){
			$(":input").attr("disabled","true");
		}
    });
</script>
<div style="margin: 0 15px;padding-bottom:10px;">
	<div class="conc-wrapper" style="margin-top:10px">
		<div class="row form-wrapper">
		<#list subPageNoAreatextColumnsMap['${key}'] as po>
			<#if po.isShow=="Y">
			<div class="row show-grid">
				<div class="col-xs-3 text-center">
		        	<b>${po.content}：</b>
		        </div>
		        <#if po.showType=='file' || po.showType == 'image'>
	          	<div class="col-xs-6">
	          	<#else>
	          	<div class="col-xs-3">
	          	</#if>
		      		<@formControl po = po namepre="${subsG['${key}'].entityName?uncap_first}List[0]." valuepre = "${subsG['${key}'].entityName?uncap_first}List[0]."/>
	        		<span class="Validform_checktip" style="float:left;height:0px;"></span>
					<label class="Validform_label" style="display: none">${po.content?if_exists?html}</label>
		        </div>
		     </div>				
			</#if>
		</#list>
		
		<#list subPageAreatextColumnsMap['${key}'] as po>
			<#if po.isShow=="Y">
			<div class="row show-grid">
				<div class="col-xs-3 text-center">
		        	<b>${po.content}：</b>
		        </div>
	          	<div class="col-xs-6">
		      		<@formControl po = po namepre="${subsG['${key}'].entityName?uncap_first}List[0]." valuepre = "${subsG['${key}'].entityName?uncap_first}List[0]."/>
	        		<span class="Validform_checktip" style="float:left;height:0px;"></span>
					<label class="Validform_label" style="display: none">${po.content?if_exists?html}</label>
		        </div>
		     </div>				
			</#if>
		</#list>
		</div>
	</div>
</div>