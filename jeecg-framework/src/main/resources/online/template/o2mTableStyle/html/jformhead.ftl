<#--update-start--Author:luobaoli  Date:20150614 for：表单（主表/单表）属性中增加了扩展参数 ${po.extend_json?if_exists}-->
<#-- update--begin--author:taoyan date:20180514 for:【Online表单】上传空间、树控件 宏封装 -->
<#include "/online/template/ui/tag.ftl"/>
<#-- update--end--author:taoyan date:20180514 for:【Online表单】上传空间、树控件 宏封装 -->
<div class="con-wrapper" id="con-wrapper0" style="display: none;">
	<input type="hidden" name="tableName" value="${tableName?if_exists?html}" >
    <input type="hidden" name="id" value="${data['${tableName}']['id']?if_exists?html}" >
	<#list columnhidden as po>
		<input type="hidden" id="${po.field_name}" name="${po.field_name}" value="${data['${tableName}']['${po.field_name}']?if_exists?html}" >
	</#list>
    <!-- tab内容 -->
	<div class="row"> 
		<div class="row form-wrapper">
			<#list columns as po>
				<#if po_index%2==0>
					<div class="row show-grid">
				</#if>
				<div class="col-xs-3 text-center">
					<b>${po.content}：</b>
				</div>
				<#if po.show_type=='file' || po.show_type=='image'>
		          <div class="col-xs-6">
		          <#else>
		          <div class="col-xs-3">
		          </#if>
					<#if head.isTree=='Y' && head.treeParentIdFieldName==po.field_name>
						<!--如果为树形菜单，父id输入框设置为select-->
						<input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" type="text"
							        class="form-control easyui-combotree" value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
					               <#if po.operationCodesReadOnly?exists> readonly = "readonly"</#if>
					               <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.file_must_input??><#if po.file_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
						       <#if po.field_valid_type?if_exists?html != ''>
					               datatype="${po.field_valid_type?if_exists?html}"
					               <#else>
					               <#if po.type == 'int'>
					               datatype="n"  
					               <#elseif po.type=='double'>
					               datatype="/^(-?\d+)(\.\d+)?$/"
					               <#else>
					               <#if po.is_null != 'Y'>datatype="*"</#if>
					               </#if>
					               </#if> 
				               data-options="
				                    panelHeight:'220',
				                    url: '${basePath}/cgAutoListController.do?datagrid&configId=${tableName?if_exists?html}&field=id,${head.treeFieldname}',  
				                    loadFilter: function(data) {
				                    	var rows = data.rows || data;
				                    	var win = frameElement.api.opener;
				                    	var listRows = win.getDataGrid().treegrid('getData');
				                    	joinTreeChildren(rows, listRows);
				                    	convertTreeData(rows, '${head.treeFieldname}');
				                    	return rows; 
				                    },
				                    onLoadSuccess: function() {
				                    	var win = frameElement.api.opener;
				                    	var currRow = win.getDataGrid().treegrid('getSelected');
				                    	if(!'${id?if_exists?html}') {
				                    		//增加时，选择当前父菜单
				                    		if(currRow) {
				                    			$('#${po.field_name}').combotree('setValue', currRow.id);
				                    		}
				                    	}else {
				                    		//编辑时，选择当前父菜单
				                    		if(currRow) {
				                    			$('#${po.field_name}').combotree('setValue', currRow._parentId);
				                    		}
				                    	}
				                    }
				            ">
				        <#--update-end--Author:钟世云  Date:20150610 for：online支持树配置-->
						<#elseif po.show_type=='text'>
							<input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" type="text"
							        class="form-control" value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
					               <#if po.operationCodesReadOnly?exists> readonly = "readonly"</#if>
					               <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								   <#if po.file_must_input??><#if po.file_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
						       <#if po.field_valid_type?if_exists?html != ''>
					               datatype="${po.field_valid_type?if_exists?html}"
					               <#else>
					               <#if po.type == 'int'>
					               datatype="n" 
					               <#elseif po.type=='double'>
					               datatype="/^(-?\d+)(\.\d+)?$/" 
					               <#else>
					               <#if po.is_null != 'Y'>datatype="*"</#if>
					               </#if>
					               </#if>>
						<#elseif po.show_type=='password'>
							<input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}"  type="password"
							        class="form-control" value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
					               <#if po.operationCodesReadOnly?if_exists> readonly = "readonly"</#if>
					               <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.file_must_input??><#if po.file_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
						       <#if po.field_valid_type?if_exists?html != ''>
					               datatype="${po.field_valid_type?if_exists?html}"
					               <#else>
					               <#if po.is_null != 'Y'>datatype="*"</#if>
					               </#if>>
						
						<#elseif po.show_type=='radio'>
					        <@DictData name="${po.dict_field?if_exists?html}" text="${po.dict_text?if_exists?html}" tablename="${po.dict_table?if_exists?html}" var="dataList">
								<#list dataList as dictdata> 
								<input value="${dictdata.typecode?if_exists?html}" ${po.extend_json?if_exists} name="${po.field_name}" type="radio"
					            <#-- update--begin--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
							   	<#if dictdata_index==0>
								   	<#if po.field_valid_type?if_exists?html != ''>
					               	 	datatype="${po.field_valid_type?if_exists?html}"
					                <#elseif po.is_null != 'Y'>
					                	datatype="*"
					                </#if>
					                <#if po.field_must_input?if_exists?html != ''><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
				                </#if>
				                <#-- update--end--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
								<#if po.operationCodesReadOnly?if_exists>onclick="return false;"</#if>
								<#if dictdata.typecode?if_exists?html=="${data['${tableName}']['${po.field_name}']?if_exists?html}"> checked="true" </#if>>
									${dictdata.typename?if_exists?html}
								</#list> 
							</@DictData>
					               
						<#elseif po.show_type=='checkbox'>
							<#assign checkboxstr>${data['${tableName}']['${po.field_name}']?if_exists?html}</#assign>
							<#assign checkboxlist=checkboxstr?split(",")>
							<@DictData name="${po.dict_field?if_exists?html}" text="${po.dict_text?if_exists?html}" tablename="${po.dict_table?if_exists?html}" var="dataList">
								<#list dataList as dictdata> 
								<input value="${dictdata.typecode?if_exists?html}" ${po.extend_json?if_exists} name="${po.field_name}" type="checkbox"
								<#if po.operationCodesReadOnly?if_exists>onclick="return false;"</#if>
					            <#-- update--begin--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
							   	<#if dictdata_index==0>
								   	<#if po.field_valid_type?if_exists?html != ''>
					               	 	datatype="${po.field_valid_type?if_exists?html}"
					                <#elseif po.is_null != 'Y'>
					                	datatype="*"
					                </#if>
					                <#if po.field_must_input?if_exists?html != ''><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
				                </#if>
				                <#-- update--end--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
								<#list checkboxlist as x >
								<#if dictdata.typecode?if_exists?html=="${x?if_exists?html}"> checked="true" </#if></#list>>
									${dictdata.typename?if_exists?html}
								</#list> 
							</@DictData>
					               
						<#elseif po.show_type=='list'>
							<@DictData name="${po.dict_field?if_exists?html}" text="${po.dict_text?if_exists?html}" tablename="${po.dict_table?if_exists?html}" var="dataList">
								<select id="${po.field_name}" ${po.extend_json?if_exists} class="form-control" name="${po.field_name}" <#if po.operationCodesReadOnly?if_exists>onfocus="this.defOpt=this.selectedIndex" onchange="this.selectedIndex=this.defOpt;"</#if>
								<#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								 <#-- update--begin--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
								   	<#if po.field_valid_type?if_exists?html != ''>
					               	 	datatype="${po.field_valid_type?if_exists?html}"
					                <#elseif po.is_null != 'Y'>
					                	datatype="*"
					                </#if>>
				                <#-- update--end--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
									<#list dataList as dictdata> 
									<option value="${dictdata.typecode?if_exists?html}" 
									<#if dictdata.typecode?if_exists?html=="${data['${tableName}']['${po.field_name}']?if_exists?html}"> selected="selected" </#if>>
										${dictdata.typename?if_exists?html}
									</option> 
									</#list> 
								</select>
							</@DictData>
							
						<#elseif po.show_type=='date'>
							<input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" type="text"
							         value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
							       class="form-control" onClick="WdatePicker({<#if po.operationCodesReadOnly?if_exists> readonly = true</#if>})" 
					              <#if po.operationCodesReadOnly?exists> readonly = "readonly"</#if>
					              <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.file_must_input??><#if po.file_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
						       <#if po.field_valid_type?if_exists?html != ''>
					               datatype="${po.field_valid_type?if_exists?html}"
					               <#else>
					               <#if po.is_null != 'Y'>datatype="*"</#if> 
					               </#if>>
						
						<#elseif po.show_type=='datetime'>
							<input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" type="text"
							         value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
							       class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'<#if po.operationCodesReadOnly?if_exists> ,readonly = true</#if>})"
						         <#if po.operationCodesReadOnly?exists> readonly = "readonly"</#if>
						         <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.file_must_input??><#if po.file_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
						       <#if po.field_valid_type?if_exists?html != ''>
					               datatype="${po.field_valid_type?if_exists?html}"
					               <#else>
					               <#if po.is_null != 'Y'>datatype="*"</#if> 
					               </#if>>
						
						<#elseif po.show_type=='popup'>
							<input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}"  type="text"
							        class="form-control searchbox-inputtext" 
							       value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
							       <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.file_must_input??><#if po.file_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
					               <#if po.operationCodesReadOnly?if_exists> readonly = "readonly"
					               <#else>
					               <#-- update--begin--author:baiyu Date:20171031 for:popupClick支持返回多个字段 -->
							       onClick="popupClick(this,'${po.dict_text?if_exists?html}','${po.dict_field?if_exists?html}','${po.dict_table?if_exists?html}');" 
					               <#-- update--end--author:baiyu Date:20171031 for:popupClick支持返回多个字段 -->
					               </#if>
						       	   <#if po.field_valid_type?if_exists?html != ''>
					               datatype="${po.field_valid_type?if_exists?html}"
					               <#else>
					               <#if po.is_null != 'Y'>datatype="*"</#if>
					               </#if>>
					    
					    <#-- update--begin--author:taoyan date:20180514 for:【Online表单】上传空间 宏封装 -->
						<#elseif po.show_type=='file' || po.show_type=='image'>
							<@uploadtag po = po />
						<#-- update--end--author:taoyan date:20180514 for:【Online表单】上传空间 宏封装 -->
						
						<#else>
							<input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" type="text"
							        class="form-control" value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
							        <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.file_must_input??><#if po.file_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
					               <#if po.field_valid_type?if_exists?html != ''>
					               datatype="${po.field_valid_type?if_exists?html}"
					               <#else>
					               <#if po.type == 'int'>
					               datatype="n" 
					               <#elseif po.type=='double'>
					               datatype="/^(-?\d+)(\.\d+)?$/" 
					               <#else>
					               <#if po.is_null != 'Y'>datatype="*"</#if>
					               </#if>
					               </#if>>

						</#if>
						<span class="Validform_checktip" style="float:left;height:0px;"></span>
						<label class="Validform_label" style="display: none">${po.content?if_exists?html}</label>
				</div>
			          
				<#if (po_index%2==0)&&(!po_has_next)>
					<div class="col-xs-2 text-center"><b></b></div>
			        <div class="col-xs-4"></div>
				</#if>
				<#if (po_index%2!=0)||(!po_has_next)>
					</div>
				</#if>
			</#list>
			  
			   <#list columnsarea as po>
				  	<div class="row show-grid">
						<div class="col-xs-3 text-center"><b>${po.content}：</b></div>
						<div class="col-xs-3">
							<textarea id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" 
							       style="width: 600px;height:150px" <#if po.show_type!='umeditor'>class="form-control"</#if> rows="6"
							<#if po.operationCodesReadOnly?if_exists> readonly = "readonly"</#if>
							<#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.file_must_input??><#if po.file_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
					               <#if po.field_valid_type?if_exists?html != ''>
					               datatype="${po.field_valid_type?if_exists?html}"
					               <#else>
					               <#if po.is_null != 'Y'>datatype="*"</#if> 
					               </#if>>${data['${tableName}']['${po.field_name}']?if_exists?html}</textarea>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
							<#if po.show_type=='umeditor'>
							<script type="text/javascript">
						    //实例化编辑器
						    var ${po.field_name}_ue = UE.getEditor('${po.field_name}',{initialFrameWidth:${po.field_length}}).setHeight(260);
						    </script>
						    </#if>
						</div>
					</div>
				</#list>

		</div>
	</div>
</div>
			<#--update-end--Author:luobaoli  Date:20150614 for：表单（主表/单表）属性中增加了扩展参数 ${po.extend_json?if_exists}-->