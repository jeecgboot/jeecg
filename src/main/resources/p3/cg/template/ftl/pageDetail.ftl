<!DOCTYPE html>
<html lang="en">
#parse("content/base/back/common/head.vm")
<body style='overflow:scroll;overflow-x:hidden'>
	<div class="container bs-docs-container" style="width:100%;">
		<div class="row">
			<div class="panel panel-default">
				<div class="panel-heading">详情</div>
				<div class="panel-body">
					<form class="form-horizontal" role="form">
						<fieldset disabled>
							<#list columnDatas as item>
								<#if item.domainPropertyName != 'id'>
										<#if item.columnType == "datetime" ||item.columnType == "date" || item.columnType == "timestamp">
											<div class="form-group mno">
												<label for="inputEmail3" class="col-sm-2 control-label" style="text-align:left;">${item.columnComment}</label>
												<div class="col-sm-2">
													<input type="text" value="$!dateTool.format("yyyy-MM-dd",$!{${lowerName}.${item.domainPropertyName}})" name="${item.domainPropertyName}" id="${item.domainPropertyName}" class="form-control" />
												</div>
											</div>
											<#else>
											<div class="form-group mno">
												<label for="inputEmail3" class="col-sm-2 control-label" style="text-align:left;">${item.columnComment}</label>
												<div class="col-sm-2">
													<input type="text" value="$!{${lowerName}.${item.domainPropertyName}}" name="${item.domainPropertyName}" id="${item.domainPropertyName}" class="form-control" />
												</div>
											</div>
										</#if>
								</#if>
							</#list> 
						</fieldset>
						<div class="form-group mno">
							<div class="col-sm-offset-1 col-sm-6">
								<#-- ## update--begin--author:zhangjiaqiang date:20170524 for:美化p3页面的按钮 -->
								<button type="button" class="btn btn-default" id="formReturn" data-dismiss="modal" onclick="doUrl('$!{basePath}/${projectName}/${lowerName}.do?list')"><i class="fa fa-arrow-circle-left"></i> 返回</button>
							 	<#-- ## update--begin--author:zhangjiaqiang date:20170524 for:美化p3页面的按钮 -->
							 </div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>