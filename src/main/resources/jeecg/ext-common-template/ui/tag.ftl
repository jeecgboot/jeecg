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

<#-- 文件上传使用新标签
	po: 对象
	opt：操作类型 add/update
  -->
<#macro webuploadtag po defval="" namepre = "">
<#local validType="${po.fieldValidType!''}"/>
<#local isNull="${po.isNull}"/>
				<t:webUploader name="${namepre}${po.fieldName}" outJs="true" auto="true" showImgDiv="filediv_${po.fieldName}"<#rt/>
<#if po.showType == 'image'><#rt/>
 type="image" buttonText='添加图片' displayTxt="false"<#rt/>
</#if><#rt/>
<#if defval != ''><#rt/>
 pathValues="${defval}"<#rt/>
</#if><#rt/>
<#if validType?if_exists?html != ''><#rt/>
 datatype="${validType?if_exists?html}"<#rt/>
<#elseif isNull != 'Y'><#rt/>
 datatype="*"<#rt/>
</#if><#rt/>
></t:webUploader>
				<div class="form" id="filediv_${po.fieldName}"></div>
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