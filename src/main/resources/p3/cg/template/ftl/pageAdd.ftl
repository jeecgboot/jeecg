<!DOCTYPE html>
<html lang="en">
#parse("content/base/back/common/head.vm")
<body style='overflow:scroll;overflow-x:hidden'>
	<div class="container bs-docs-container" style="width:100%;">
		<div class="row">
			<div class="panel panel-default">
				<div class="panel-heading">
				<#-- ## update--begin--author:zhangjiaqiang date:20170524 for:美化p3列表页面的按钮 -->
				<button type="button" class="btn btn-primary" id="formSubmit"><span class="fa fa-save"></span> 保存</button>
				<button type="button" class="btn btn-default" id="formReturn" data-dismiss="modal" onclick="doUrl('$!{basePath}/${projectName}/${lowerName}.do?list')"><span class="fa fa-arrow-circle-left"></span> 返回</button>
				<#-- ## update--end--author:zhangjiaqiang date:20170524 for:美化p3列表页面的按钮 -->
				</div>
				<div class="panel-body">
					<form class="form-horizontal" role="form" id="dailogForm" action="$!{basePath}/${projectName}/${lowerName}.do?doAdd" method="POST">
						<input type="hidden" id="btn_sub" class="btn_sub" />
						<#list columnDatas as item>
							<#if item.domainPropertyName != 'id'>
								<#if item.columnType == "datetime" ||item.columnType == "date" || item.columnType == "timestamp">
									<div class="form-group mno">
										<label for="inputEmail3" class="col-sm-2 control-label" style="text-align:left;">${item.columnComment}</label>
										<div class="col-sm-8">
											<input type="text" value="$!dateTool.format("yyyy-MM-dd",$!{${lowerName}.${item.domainPropertyName}})" name="${item.domainPropertyName}" id="${item.domainPropertyName}" class="form-control" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"   style="background: url('$!{basePath}/plug-in-ui/images/datetime.png') no-repeat scroll right center transparent;" <#if item.nullable != 'Y'> datatype="*" </#if>/>
										</div>
									</div>
								<#else>
									<div class="form-group mno">
										<label for="inputEmail3" class="col-sm-2 control-label" style="text-align:left;">${item.columnComment}</label>
										<div class="col-sm-8">
											<input type="text" value="$!{${lowerName}.${item.domainPropertyName}}" name="${item.domainPropertyName}" id="${item.domainPropertyName}" class="form-control" <#if item.nullable != 'Y'> datatype="*" </#if>/>
										</div>
									</div>
								</#if>
							</#if>
						</#list> 
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript" src="$!{basePath}/plug-in-ui/js/Validform_v5.3.2.js"></script> 
<script type="text/javascript" src="$!{basePath}/plug-in-ui/js/forminit.p3.js"></script> 
