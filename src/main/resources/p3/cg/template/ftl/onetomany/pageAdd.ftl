<!DOCTYPE html>
<html lang="en">
#parse("content/base/back/common/head.vm")
<body style='overflow:scroll;overflow-x:hidden'>
	<div class="container bs-docs-container" style="width:100%;">
		<div class="row">
			<div class="panel panel-default">
				<div class="panel-heading">
				<#-- update--begin--author:zhangjiaqiang date:20170524 for:美化p3列表页面的按钮 -->
				<button type="button" class="btn btn-primary" id="formSubmit"><span class="fa fa-save"></span> 保存</button>
				<button type="button" class="btn btn-default" id="formReturn" data-dismiss="modal" onclick="doUrl('$!{basePath}/${projectName}/${lowerName}.do?list')"><span class="fa fa-arrow-circle-left"></span> 返回</button>
				<#-- update--begin--author:zhangjiaqiang date:20170524 for:美化p3列表页面的按钮 -->
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
						
						<div class="form-group mno">
										<ul id="tab_menu" class="nav nav-tabs">
										<#list subEntityList as sub>
											<li <#if sub_index == 0>class="active"</#if>>
												<a href="#${sub.paramData.lowerName}" data-toggle="tab">
													${sub.paramData.codeName}
												</a>
                                            </li>
										</#list>
                                        </ul>
										<div id="tab_menu_content" class="tab-content">
											<#list subEntityList as sub>
												<div class="tab-pane fade in <#if sub_index == 0>active</#if>" id="${sub.paramData.lowerName}">
													<#-- update--begin--author:zhangjiaqiang date:20170524 for:美化p3列表页面的按钮 -->
													<button type="button" id="${sub.paramData.lowerName}_add" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i> 添加</button>
													<button type="button" id="${sub.paramData.lowerName}_del" class="btn btn-danger btn-sm"><i class="fa fa-trash-o"></i> 删除</button>
	                                                <#-- update--end--author:zhangjiaqiang date:20170524 for:美化p3列表页面的按钮 -->
	                                                <table class="table table-striped" id="${sub.paramData.lowerName}_table" style="margin-top:15px;">
														<thead>
																<th>ID</th>
															<#list sub.paramData.columnDatas as item>
																<#if item.columnName?lower_case != 'id'>
																	<th>${item.columnComment}</th>
																</#if>
															</#list>
	                                                    </thead>
														<tbody>
	                                                    </tbody>
													</table>
												</div>
											</#list>
											
										</div>
										
									</div>
									
					</form>
					
					
					<#list subEntityList as sub>
						<!-- ${sub.paramData.codeName}模板 -->
						<table style="display:none;">
						<tbody id="add_${sub.paramData.lowerName}_template">
							<tr>
							<#-- update--begin--author:zhangjiaqiang date:20170616 for:修订checkbox在IE下的兼容性 -->
								<td>
										<input type="checkbox" name="${sub.paramData.lowerName}Entities[#index#].idCheck" id="${sub.paramData.lowerName}Entities#index#_idCheck" />
                                </td>
                                <#-- update--begin--author:zhangjiaqiang date:20170616 for:修订checkbox在IE下的兼容性 -->
                                
                                <#list sub.paramData.columnDatas as item>
									<#if item.domainPropertyName != 'id'>
											<#if item.columnType == "datetime" ||item.columnType == "date" || item.columnType == "timestamp">
												<td>
													<input type="text"  name="${sub.paramData.lowerName}Entities[#index#].${item.domainPropertyName}" maxlength="16" id="${sub.paramData.lowerName}Entities[#index#].${item.domainPropertyName}" class="form-control" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"   style="background: url('$!{basePath}/plug-in-ui/images/datetime.png') no-repeat scroll right center transparent;" <#if item.nullable != 'Y'> datatype="*" </#if>/>
												 </td>
											<#else>
												<td>
													<input type="text" name="${sub.paramData.lowerName}Entities[#index#].${item.domainPropertyName}" maxlength="16" id="${sub.paramData.lowerName}Entities[#index#].${item.domainPropertyName}" class="form-control" <#if item.nullable != 'Y'> datatype="*" </#if>/>
												 </td>
											</#if>
										</#if>
								</#list>
                             </tr>
                        </tbody>
                    </table>
					</#list>
					
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript" src="$!{basePath}/plug-in-ui/js/Validform_v5.3.2.js"></script> 
<script type="text/javascript" src="$!{basePath}/plug-in-ui/js/forminit.p3.js"></script> 
<script type="text/javascript" src="$!{basePath}/${pageAddJsPath}"></script>
<script type="text/javascript">
jQuery(function(){
	<#list subEntityList as sub>
	var ${sub.paramData.lowerName}Tr = $("#add_${sub.paramData.lowerName}_template tr").clone();
	$("#${sub.paramData.lowerName}_table tbody").append(${sub.paramData.lowerName}Tr);
	resetTrNum('${sub.paramData.lowerName}_table');
	
	</#list>
});
</script>