#parse("content/base/back/common/macro.vm")
<!DOCTYPE html>
<html lang="en">
#parse("content/base/back/common/head.vm")
<body style='overflow:scroll;overflow-x:hidden'>
	<div class="container bs-docs-container" style="width:100%;">
		<div class="row">
			<form role="form" class="form-inline" action="$!{basePath}/${projectName}/${lowerName}.do?list" method="post"  id="formSubmit">
				<div  class="col-md-10" style="width:100%">
					<div class="panel panel-default">
						<div class="panel-heading">列表</div>
						<div class="panel-body">
							<div class="search">
								<#list columnDatas as item>
									<#if item.columnName?lower_case != 'id'>
									<#if item.columnType == "datetime" ||item.columnType == "date" || item.columnType == "timestamp">
										<div class="form-group col-sm-3">
											<label for="${item.domainPropertyName}" class="control-label col-sm-3 line34">${item.columnComment}</label>
											<div class="col-sm-8">
												<input type="text" name="${item.domainPropertyName}" id="${item.domainPropertyName}" value="$!dateTool.format('yyyy-MM-dd',$!{${lowerName}.${item.domainPropertyName}})" class="form-control">
											</div>
										 </div>
									<#else>
										 <div class="form-group col-sm-3">
											<label for="${item.domainPropertyName}" class="control-label col-sm-3 line34">${item.columnComment}</label>
											<div class="col-sm-8">
												<input type="text" name="${item.domainPropertyName}" id="${item.domainPropertyName}" value="$!{${lowerName}.${item.domainPropertyName}}" class="form-control">
											</div>
										 </div>
									</#if>
									</#if>
								</#list>
								<#-- update--begin--author:zhangjiaqiang date:20170524 for:美化p3列表页面的按钮 -->
								<button type="submit" class="btn btn-primary"><i class="fa fa-search"></i> 搜  索</button>
								<#-- update--begin--author:LiShaoQing date:20170818 for:美化p3列表页面的按钮  -->
								<button type="button" class="btn btn-primary" onclick="searchReset()"><i class="fa fa-refresh"></i> 重  置</button>
								<#-- update--end--author:LiShaoQing date:20170818 for:美化p3列表页面的按钮  -->
								<#-- update--begin--author:zhangjiaqiang date:20170524 for:美化p3列表页面的按钮 -->
								<div class="clearfix"></div>
							</div>
							<div id="legend">
								<#-- update--begin--author:zhangjiaqiang date:20170524 for:美化p3列表页面的按钮 -->
								<legend  class="le">
									<button type="button" class="btn btn-primary" onclick="doUrl('$!{basePath}/${projectName}/${lowerName}.do?toAdd')" ><i class="fa fa-plus"></i> 新增</button> 
									<button type="button" class="btn btn-primary" onclick="batchDelete()" ><i class="fa fa-trash-o"></i> 批量删除</button>
								</legend>
								<#-- update--end--author:zhangjiaqiang date:20170524 for:美化p3列表页面的按钮 -->
							</div>
							<table class="table table-striped">
								<thead>
									<#-- update--begin--author:zhangjiaqiang date:20170616 for:修订checkbox在IE下的兼容性 -->
									<th>
											<input type="checkbox" name="ckAll" id="ckAll" />
					        		</th>
									<#-- update--end--author:zhangjiaqiang date:20170616 for:修订checkbox在IE下的兼容性 -->
									<#list columnDatas as item>
										<#if item.columnName?lower_case != 'id'>
										<#if item.columnName?lower_case != 'del_stat' 
										    && item.columnName?lower_case != 'create_by'
											&& item.columnName?lower_case != 'create_name' 
											&& item.columnName?lower_case != 'create_date' 
											&& item.columnName?lower_case != 'update_by'
											&& item.columnName?lower_case != 'update_name' 
											&& item.columnName?lower_case != 'update_date' 
											&& item.columnName?lower_case != 'creator'
											&& item.columnName?lower_case != 'editor' 
											&& item.columnName?lower_case != 'create_dt' 
											&& item.columnName?lower_case != 'edit_dt' 
											&& item.columnName?lower_case != 'last_edit_dt' 
											&& item.columnName?lower_case != 'record_version'>
											<th>${item.columnComment}</th>
											</#if>
										</#if>
									</#list>
									<th>操作</th>
								</thead>
								<tbody>
								#if($!{pageInfos})
									#foreach($!{info} in $!{pageInfos})
										<tr>	
											<#-- update--begin--author:zhangjiaqiang date:20170525 for:美化P3页面按钮 -->		
											<td>
													<input type="checkbox" name="ck" id="ck_$!{velocityCount}" value="$!{info.id}"/>
											</td>	
											<#-- update--end--author:zhangjiaqiang date:20170525 for:美化P3页面按钮 -->	
											<#list columnDatas as item>
												<#if item.columnName?lower_case != 'id'>
												<#if item.columnName?lower_case != 'del_stat' 
												    && item.columnName?lower_case != 'create_by'
													&& item.columnName?lower_case != 'create_name' 
													&& item.columnName?lower_case != 'create_date' 
													&& item.columnName?lower_case != 'update_by'
													&& item.columnName?lower_case != 'update_name' 
													&& item.columnName?lower_case != 'update_date' 
													&& item.columnName?lower_case != 'creator'
													&& item.columnName?lower_case != 'editor' 
													&& item.columnName?lower_case != 'create_dt' 
													&& item.columnName?lower_case != 'edit_dt' 
													&& item.columnName?lower_case != 'last_edit_dt' 
													&& item.columnName?lower_case != 'record_version'>
													<#if item.columnType == "datetime" ||item.columnType == "date" || item.columnType == "timestamp">
														<td>$!dateTool.format("yyyy-MM-dd",$!{info.${item.domainPropertyName}})</td>
													<#else>
														<td>$!{info.${item.domainPropertyName}}</td>
													</#if>
												</#if>
												</#if>
											</#list> 
											<td class="last">
											<#-- update--begin--author:zhangjiaqiang date:20170524 for:美化p3列表页面的按钮 --> 
											<a class="btn btn-success btn-xs"  href="javascript:doUrl('$!{basePath}/${projectName}/${lowerName}.do?toEdit&id=$!{info.id}')" ><i class="fa fa-edit"></i> 编辑</a>
											<a class="btn btn-danger btn-xs" href="javascript:delData('$!{basePath}/${projectName}/${lowerName}.do?doDelete&id=$!{info.id}')"><i class="fa fa-trash-o"></i> 删除</a>
											<#-- update--end--author:zhangjiaqiang date:20170524 for:美化p3列表页面的按钮 -->
											</td>
										</tr>
									 #end
								 #end
								</tbody>
							</table>
							<div class="text-right">
								<!--公用翻页代码-->
								#set($attr='formSubmit')
								#showPageList($pageInfos $attr)
								<!--END公用翻页代码-->
							</div>
						</div>
					</div>
				</div>  
			</form>
		</div>
	</div>
</body>
</html>
<script>
$("#ckAll").click(function(){ 
	if($(this).prop("checked")){ 
	 $(":checkbox").prop("checked",true) 
	}else{ 
	$(":checkbox").prop("checked",false)  
	} 
}); 

//jquery获取复选框值    
function getCkValue(){  
  var chk_value =[];    
  $('input[name="ck"]:checked').each(function(){    
   chk_value.push($(this).val());    
  });    
  //alert(chk_value.length==0 ?'你还没有选择任何内容！':chk_value);    
}
//获得所有选中行的ID进行批量删除
function batchDelete() {
    var ids = [];
    var check = document.getElementsByName("ck");
    for(var i=0;i<check.length;i++){
        if(check[i].checked){
    		ids.push(check[i].value);
        }
    }
   	if(ids.length > 0) {
    	parent.layer.confirm('确认进行批量删除吗？', {
        	btn: ['确定','取消'] //按钮
    	}, function(){
       		jQuery.ajax({
       			url : '$!{basePath}/${projectName}/${lowerName}.do?batchDelete',
       			data : {
       				ids : ids,
       			},
       			type : 'POST',
    			dataType: 'json',
       			traditional:true,
    			success:function(data) {
    				if(data.success){
    					parent.layer.alert(data.msg, {
    	        	        icon: 1,
    	        	        shadeClose: false,
    	        	        title: '提示'
    	        	    },function(index){
    						document.getElementById('formSubmit').submit();
    	        	    	parent.layer.close(index);
    					});
    				}else {
    					layeralert(data.msg,0);
    				}
    			},
    			error: function(data, status, e){  
    	        	if(data.status == "401"){
    	        		layeralert("没有权限！",0);
    					return;
    				}
    	        }
       		});
		});
   	}else {
		layeralert("您还没有选择要删除的行");
   	}
}
//重置按钮    
function searchReset() {
	$("#formSubmit").find(":input").val("");
	$("#formSubmit").submit();
}
</script>