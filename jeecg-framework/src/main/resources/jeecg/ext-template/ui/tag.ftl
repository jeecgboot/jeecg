<#-- 文件上传使用标签
	po: 对象
	opt：操作类型 add/update
  -->
<#macro uploadtag po opt = "">
	<#if opt == 'update'>
		<table id="${fieldMeta[po.fieldName]?lower_case}_fileTable"></table>
	</#if>
	<#if !(po.operationCodesReadOnly ??)>
 		<#assign fileName = fileName + "${po.fieldName}," />
		<#-- update--end--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
		<div class="form jeecgDetail">
			<t:upload name="${po.fieldName}" id="${po.fieldName}" queueID="filediv_${po.fieldName}" outhtml="false" uploader="cgUploadController.do?saveFiles" <#rt/>
<#if po.showType == 'image'><#rt/>
 extend="pic" buttonText='添加图片' <#rt/>
<#else>
 extend="office" buttonText='添加文件' <#rt/>
</#if>
 onUploadStart="${po.fieldName}OnUploadStart"> <#rt/>
</t:upload>
			<#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
			<div class="form" id="filediv_${po.fieldName}"></div>
			<#-- update--end--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
			<script type="text/javascript">
				function ${po.fieldName}OnUploadStart(file){
					var cgFormId=$("input[name='id']").val();
					$('#${po.fieldName}').uploadify("settings", "formData", {
						'cgFormId':cgFormId,
						'cgFormName':'${tableName}',
						'cgFormField':'${fieldMeta[po.fieldName]}'
					});
				}
			</script>
		</div>
	</#if>
</#macro>

<#-- 树控件使用标签 -->
<#macro treetag po formStyle="" opt="">
					<t:treeSelectTag id="${po.fieldName}" field="${po.fieldName}" code = "${po.dictField}"<#rt/>
<#if formStyle == 'ace'>
 inputClass="form-control" formStyle="ace"<#rt/>
<#else>
 inputClass="inputxt"<#rt/>
</#if>
<#if opt == 'update'>
 defaultVal="${'$'}{${entityName?uncap_first}Page.${po.fieldName}}"<#rt/>
</#if>
 ></t:treeSelectTag>
</#macro>

<#-- dictselect使用标签
	 po: 对象
	 namePre:field前缀
	 valuePre：值前缀
	 formStyle：表单风格
	 opt：操作类型 add/update
  -->
<#macro dictSelecttag po namePre="" valuePre = "" formStyle="" opt="">
							  <t:dictSelect field="${namePre}${po.fieldName}" type="${po.showType?if_exists?html}"<#rt/>
<#if po.showType=='select' || po.showType=='list'>
<#if formStyle == 'aces'>
 extendJson="{class:'form-control',style:'width:150px'}"<#rt/>
<#elseif formStyle == 'ace'>
 extendJson="{class:'form-control',style:'width:164px'}"<#rt/>
</#if><#rt/>
</#if><#rt/>
<@datatype inputCheck="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/><#rt/>
<@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" /><#rt/>
<#if opt == 'update'>
 defaultVal="${'$'}{${valuePre}${po.fieldName}}" <#rt/>
</#if>
 hasLabel="false"  title="${po.content}"></t:dictSelect>
</#macro>