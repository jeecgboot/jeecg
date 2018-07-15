
					    <div title="<@mutiLang langKey="${field['${sub}'].head.content?if_exists?html}"/>" style="margin:0px;padding:0px;overflow:hidden;">
							<script type="text/javascript"> 
								$('#addBtn_${sub}').linkbutton({   
								    iconCls: 'icon-add'  
								});  
								$('#delBtn_${sub}').linkbutton({   
								    iconCls: 'icon-remove'  
								}); 
								$('#addBtn_${sub}').bind('click', function(){   
							 		 var tr =  $("#add_${sub}_table_template tr").clone();
								 	 $("#add_${sub}_table").append(tr);
								 	 resetTrNum('add_${sub}_table');
								 	 return false;
							    });  
								$('#delBtn_${sub}').bind('click', function(){   
							       $("#add_${sub}_table").find("input[name$='ck']:checked").parent().parent().remove();   
							        resetTrNum('add_${sub}_table');
							        return false;
							    });
							    $(document).ready(function(){
							    	$(".datagrid-toolbar").parent().css("width","auto");
							    	if(location.href.indexOf("load=detail")!=-1){
							    		$(".datagrid-toolbar").hide();
										$(":input").each(function(){
											var $thisThing = $(this);
											$thisThing.attr("title",$thisThing.val());
										});
							    	}
							    	resetTrNum('add_${sub}_table');
							    });
							</script>
							<div style="padding: 3px; height: 25px;width:auto;" class="datagrid-toolbar">
								<a id="addBtn_${sub}" href="#">添加</a> <a id="delBtn_${sub}" href="#">删除</a> 
							</div>
							<div style="width: auto;height: 400px;overflow-y:auto;overflow-x:scroll;">
							<table border="0" cellpadding="2" cellspacing="0" id="${sub}_table">
							<tr bgcolor="#E6E6E6">
								<td align="center" bgcolor="#EEEEEE">序号</td>
								<td align="center" bgcolor="#EEEEEE">操作</td>
							<#list field['${sub}'].fieldList as subTableField >
								<td align="left" bgcolor="#EEEEEE"><@mutiLang langKey="${subTableField.content?if_exists?html}"/></td>
							</#list>
							</tr>
							<#--update-start--Author:luobaoli  Date:20150614 for：表单类型为onetomany子表属性中增加了扩展参数 ${po.extend_json?if_exists}-->
							<tbody id="add_${sub}_table">
								<#if data['${sub}']?exists&&(data['${sub}']?size>0) >
								<#list data['${sub}'] as subTableData >
									<tr>
									<td align="center"><div style="width: 25px;" name="xh"></div></td>
									<td align="center">
										<input style="width:20px;" type="checkbox" name="ck"/>
										<input type="hidden" name="${sub}[${subTableData_index}].id" id="${sub}[${subTableData_index}].id" value="${subTableData['id']?if_exists?html}"/>
										<#list field['${sub}'].hiddenFieldList as subTableField >
										<input type="hidden" name="${sub}[${subTableData_index}].${subTableField.field_name}" id="${sub}[${subTableData_index}].${subTableField.field_name}" value="${subTableData['${subTableField.field_name}']?if_exists?html}"/>
										</#list> 
									</td>
									<#list field['${sub}'].fieldList as subTableField >
									<td align="left">
									<#if subTableField.show_type=='text'>
										<input id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}" type="text"
										       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px" class="inputxt" value="${subTableData['${subTableField.field_name}']?if_exists?html}"
								               nullmsg="请输入<@mutiLang langKey="${subTableField.content}"/>！"
								                 <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
												<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
												<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								               <#if subTableField.operationCodesReadOnly?exists> readonly = "readonly"</#if>
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               <#if subTableField.field_valid_type=='only'>
						       		   				validType="${sub},${subTableField.field_name},${sub}[${subTableData_index}].id"
						       		   				datatype="*"
						       					<#else>
					                   				datatype="${subTableField.field_valid_type?if_exists?html}"
					               				</#if>
								               <#else>
								               <#if subTableField.type == 'int'>
								               datatype="n" 
								               <#elseif subTableField.type=='double'>
								               datatype="/^(-?\d+)(\.\d+)?$/"
								                <#else>
					               				<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if></#if>>
									
									<#elseif subTableField.show_type=='password'>
										<input id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}"  type="password"
										       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px" class="inputxt" value="${subTableData['${subTableField.field_name}']?if_exists?html}"
								               nullmsg="请输入<@mutiLang langKey="${subTableField.content}"/>！"
								                 <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
												<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
												<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								               <#if subTableField.operationCodesReadOnly?exists> readonly = "readonly"</#if>
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
				               					<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if>>
									
									<#elseif subTableField.show_type=='radio'>
								        <@DictData name="${subTableField.dict_field?if_exists?html}" text="${subTableField.dict_text?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
											<#list dataList as dictdata> 
											<input value="${dictdata.typecode?if_exists?html}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}" type="radio"
											 <#-- update--begin--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
										  	<#if dictdata_index == 0>
										  	 <#if subTableField.field_valid_type?if_exists?html != ''>
							               	 datatype="${subTableField.field_valid_type?if_exists?html}"
							                <#elseif subTableField.is_null != 'Y'>
							                 datatype="*"
							                </#if>
							                <#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
										  	</#if>
							                <#-- update--end--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
											<#if subTableField.operationCodesReadOnly?if_exists>onclick="return false;"</#if>
											<#if dictdata.typecode?if_exists?html=="${subTableData['${subTableField.field_name}']?if_exists?html}"> checked="true" </#if>>
												${dictdata.typename?if_exists?html}
											</#list> 
										</@DictData>
								               
									<#elseif subTableField.show_type=='checkbox'>
										<#assign checkboxstr>${subTableData['${subTableField.field_name}']?if_exists?html}</#assign>
										<#assign checkboxlist=checkboxstr?split(",")>
										<@DictData name="${subTableField.dict_field?if_exists?html}" text="${subTableField.dict_text?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
											<#list dataList as dictdata> 
											<input value="${dictdata.typecode?if_exists?html}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}" type="checkbox"
											<#-- update--begin--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
										  	<#if dictdata_index == 0>
										  	 <#if subTableField.field_valid_type?if_exists?html != ''>
							               	 datatype="${subTableField.field_valid_type?if_exists?html}"
							                <#elseif subTableField.is_null != 'Y'>
							                 datatype="*"
							                </#if>
							                <#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
										  	</#if>
							                <#-- update--end--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
											<#if subTableField.operationCodesReadOnly?if_exists>onclick="return false;"</#if>
											<#list checkboxlist as x >
											<#if dictdata.typecode?if_exists?html=="${x?if_exists?html}"> checked="true" </#if></#list>>
												${dictdata.typename?if_exists?html}
											</#list> 
										</@DictData>
								               
									<#elseif subTableField.show_type=='list'>
										<@DictData name="${subTableField.dict_field?if_exists?html}" text="${subTableField.dict_text?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
											<select id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}" 
											  <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
										<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
										<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
											<#if subTableField.operationCodesReadOnly?if_exists>onfocus="this.defOpt=this.selectedIndex" onchange="this.selectedIndex=this.defOpt;"</#if>
											<#-- update--begin--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
										  	 <#if subTableField.field_valid_type?if_exists?html != ''>
							               	 datatype="${subTableField.field_valid_type?if_exists?html}"
							                <#elseif subTableField.is_null != 'Y'>
							                 datatype="*"
							                </#if>
										  	>
							                <#-- update--end--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
												<#list dataList as dictdata> 
												<option value="${dictdata.typecode?if_exists?html}" 
												<#if dictdata.typecode?if_exists?html=="${subTableData['${subTableField.field_name}']?if_exists?html}"> selected="selected" </#if>>
													${dictdata.typename?if_exists?html}
												</option> 
												</#list> 
											</select>
										</@DictData>
										
									<#elseif subTableField.show_type=='date'>
										<input id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}" type="text"
										       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px"  value="${subTableData['${subTableField.field_name}']?if_exists?html}"
										       class="Wdate" onClick="WdatePicker({<#if subTableField.operationCodesReadOnly?if_exists> readonly = true</#if>})" 
								               nullmsg="请输入<@mutiLang langKey="${subTableField.content}"/>！"
								                <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
												<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
												<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								                <#if subTableField.operationCodesReadOnly?exists> readonly = "readonly"</#if>
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
				               					<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if>>
									
									<#elseif subTableField.show_type=='datetime'>
										<input id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}" type="text"
										       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px"  value="${subTableData['${subTableField.field_name}']?if_exists?html}"
										       class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'<#if subTableField.operationCodesReadOnly?if_exists> ,readonly = true</#if>})"
								               nullmsg="请输入<@mutiLang langKey="${subTableField.content}"/>！"
								                 <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
												<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
												<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								               <#if subTableField.operationCodesReadOnly?exists> readonly = "readonly"</#if>
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
				               					<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if>>
								               
									<#elseif subTableField.show_type=='popup'>
										<input id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}"  type="text"
										       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px" class="searchbox-inputtext15" 
										       value="${subTableData['${subTableField.field_name}']?if_exists?html}"
								               nullmsg="请输入<@mutiLang langKey="${subTableField.content}"/>！"
								                <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
												<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
												<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								                <#if subTableField.operationCodesReadOnly?if_exists> readonly = "readonly"
								               <#else>
								               <#-- update--begin--author:baiyu Date:20171031 for:popupClick支持返回多个字段-->
								               onClick="popupClick(this,'${subTableField.dict_text?if_exists?html}','${subTableField.dict_field?if_exists?html}','${subTableField.dict_table?if_exists?html}');" 
								               <#-- update--end--author:baiyu Date:20171031 for:popupClick支持返回多个字段 -->
								               </#if>
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
				               					<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if>>
									
									<#elseif subTableField.show_type=='file'  || subTableField.show_type == 'image'>
										<#-- update--begin--author:zhangjiaqiang date:20170607 for：增加图片和文件格式支持上传 -->
										<input id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}" type="hidden"
										       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px" class="inputxt" value="${subTableData['${subTableField.field_name}']?if_exists?html}"
								               nullmsg="请输入<@mutiLang langKey="${subTableField.content}"/>！"
								                <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
												<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
												<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								               <#if subTableField.operationCodesReadOnly?exists> readonly = "readonly"</#if>
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
				               					<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if>>
								              
											   <input class="ui-button" type="button" value="上传附件"
															onclick="commonUpload(commonUploadDefaultCallBack,'${sub}[${subTableData_index}].${subTableField.field_name}')"/>
								         <a  target="_blank" id="${sub}[${subTableData_index}].${subTableField.field_name}_href"  <#if subTableData['${subTableField.field_name}']?if_exists?html != ''>href="${subTableData['${subTableField.field_name}']?if_exists?html}">下载<#else>></#if></a>
								           <#-- update--begin--author:zhangjiaqiang date:20170607 for：增加图片和文件格式支持上传 -->    
									<#else>
										<input id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}" type="text"
										       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px" class="inputxt" value="${subTableData['${subTableField.field_name}']?if_exists?html}"
								               nullmsg="请输入<@mutiLang langKey="${subTableField.content}"/>！"
								                 <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
												<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
												<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
								               <#if subTableField.type == 'int'>
								               datatype="n" 
								               <#elseif subTableField.type=='double'>
								               datatype="/^(-?\d+)(\.\d+)?$/"
								                <#else>
					               				<#if subTableField.is_null != 'Y'>datatype="*"</#if>  
								               </#if></#if>>
									</#if>
									<label class="Validform_label" style="display: none;"><@mutiLang langKey="${subTableField.content?if_exists?html}"/></label>
									</td>
									</#list>
									</tr>
								</#list>
								<#else>
									<tr>
									<td align="center"><div style="width: 25px;" name="xh"></div></td>
									<td align="center">
									<input style="width:20px;" type="checkbox" name="ck"/>
									<input type="hidden" name="${sub}[0].id" id="${sub}[0].id" />
									<#list field['${sub}'].hiddenFieldList as subTableField >
									<input type="hidden" name="${sub}[0].${subTableField.field_name}" id="${sub}[0].${subTableField.field_name}"/>
									</#list> 
									</td>
									<#list field['${sub}'].fieldList as subTableField >
									<td align="left">
									<#if subTableField.show_type=='text'>
										<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" type="text"
										       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px" class="inputxt"
								               nullmsg="请输入<@mutiLang langKey="${subTableField.content?if_exists?html}"/>！"
								               <#if subTableField.operationCodesReadOnly?exists> readonly = "readonly"</#if>
								                <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
												<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
												<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								                <#if subTableField.field_valid_type?if_exists?html != ''>
								                <#if subTableField.field_valid_type=='only'>
						       		   				validType="${sub},${subTableField.field_name},${sub}[0].id"
						       		   				datatype="*"
						       					<#else>
					                   				 datatype="${subTableField.field_valid_type?if_exists?html}"
					               				</#if>
								              
								               <#else>
								               <#if subTableField.type == 'int'>
								               datatype="n" 
								               <#elseif subTableField.type=='double'>
								               datatype="/^(-?\d+)(\.\d+)?$/" 
								                <#else>
					               				<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if></#if>>
									
									<#elseif subTableField.show_type=='password'>
										<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}"  type="password"
										       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px" class="inputxt" 
								               nullmsg="请输入<@mutiLang langKey="${subTableField.content?if_exists?html}"/>！"
								                 <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
												<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
												<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								               <#if subTableField.operationCodesReadOnly?exists> readonly = "readonly"</#if>
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
					               				<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if>>
									
									<#elseif subTableField.show_type=='radio'>
								        <@DictData name="${subTableField.dict_field?if_exists?html}" text="${subTableField.dict_text?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
											<#list dataList as dictdata> 
											<input value="${dictdata.typecode?if_exists?html}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" type="radio" 
											<#if subTableField.operationCodesReadOnly?if_exists>onclick="return false;"</#if>
											 <#-- update--begin--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
										  	<#if dictdata_index == 0>
										  	 <#if subTableField.field_valid_type?if_exists?html != ''>
							               	 datatype="${subTableField.field_valid_type?if_exists?html}"
							                <#elseif subTableField.is_null != 'Y'>
							                 datatype="*"
							                </#if>
							                <#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
										  	</#if>
							                <#-- update--end--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
							                 >
												${dictdata.typename?if_exists?html}
											</#list> 
										</@DictData>
								               
									<#elseif subTableField.show_type=='checkbox'>
										<@DictData name="${subTableField.dict_field?if_exists?html}" text="${subTableField.dict_text?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
											<#list dataList as dictdata> 
											<input value="${dictdata.typecode?if_exists?html}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" type="checkbox" 
											<#if subTableField.operationCodesReadOnly?if_exists>onclick="return false;"</#if>
											 <#-- update--begin--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
										  	<#if dictdata_index == 0>
										  	 <#if subTableField.field_valid_type?if_exists?html != ''>
							               	 datatype="${subTableField.field_valid_type?if_exists?html}"
							                <#elseif subTableField.is_null != 'Y'>
							                 datatype="*"
							                </#if>
							                <#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
										  	</#if>
							                <#-- update--end--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
											>
												${dictdata.typename?if_exists?html}
											</#list> 
										</@DictData>
								               
									<#elseif subTableField.show_type=='list'>
										<@DictData name="${subTableField.dict_field?if_exists?html}" text="${subTableField.dict_text?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
											<select id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" 
											<#if subTableField.operationCodesReadOnly?if_exists>onfocus="this.defOpt=this.selectedIndex" onchange="this.selectedIndex=this.defOpt;"</#if>
											  <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
											<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
											<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
											<#-- update--begin--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
										  	 <#if subTableField.field_valid_type?if_exists?html != ''>
							               	 datatype="${subTableField.field_valid_type?if_exists?html}"
							                <#elseif subTableField.is_null != 'Y'>
							                 datatype="*"
							                </#if>
										  	>
							                <#-- update--end--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
												<#list dataList as dictdata> 
												<option value="${dictdata.typecode?if_exists?html}" >
													${dictdata.typename?if_exists?html}
												</option> 
												</#list> 
											</select>
										</@DictData>
										
									<#elseif subTableField.show_type=='date'>
										<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" type="text"
										       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px"  
										       class="Wdate" onClick="WdatePicker({<#if subTableField.operationCodesReadOnly?if_exists> readonly = true</#if>})" 
								               nullmsg="请输入<@mutiLang langKey="${subTableField.content?if_exists?html}"/>！"
								                 <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
											<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
											<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								               <#if subTableField.operationCodesReadOnly?exists> readonly = "readonly"</#if>
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
					               				<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if>>
									
									<#elseif subTableField.show_type=='datetime'>
										<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" type="text"
										       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px"  
										       class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'<#if subTableField.operationCodesReadOnly?if_exists> ,readonly = true</#if>})"
								               nullmsg="请输入<@mutiLang langKey="${subTableField.content?if_exists?html}"/>！"
								                 <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
											<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
											<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								               <#if subTableField.operationCodesReadOnly?exists> readonly = "readonly"</#if>
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
					               				<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if>>
								               
									<#elseif subTableField.show_type=='popup'>
										<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}"  type="text"
										       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px" class="searchbox-inputtext15" 
								               nullmsg="请输入<@mutiLang langKey="${subTableField.content?if_exists?html}"/>！"
								                 <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
												<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
												<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								               <#if subTableField.operationCodesReadOnly?if_exists> readonly = "readonly"
								               <#else>
												<#-- update--begin--author:baiyu Date:20171031 for:popupClick支持返回多个字段-->
										       onClick="popupClick(this,'${subTableField.dict_text?if_exists?html}','${subTableField.dict_field?if_exists?html}','${subTableField.dict_table?if_exists?html}');" 
												<#-- update--end--author:baiyu Date:20171031 for:popupClick支持返回多个字段 -->
								               </#if>
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
					               				<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if>>
									
									<#elseif subTableField.show_type=='file' || subTableField.show_type=='image'>
										<#-- update--begin--author:zhangjiaqiang date:20170607 for：增加图片和文件格式支持上传 -->
										<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" type="hidden"
										       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px" class="inputxt" 
								               nullmsg="请输入<@mutiLang langKey="${subTableField.content?if_exists?html}"/>！"
								                 <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
												<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
												<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								               <#if subTableField.operationCodesReadOnly?if_exists> readonly = "readonly"
								               <#else>
										       onClick="inputClick(this,'${subTableField.dict_text?if_exists?html}','${subTableField.dict_table?if_exists?html}');" 
								               </#if>
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
					               				<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if>>
										<input class="ui-button" type="button" value="上传附件"
															onclick="commonUpload(commonUploadDefaultCallBack,'${sub}[0].${subTableField.field_name}')"/>
								         <a  target="_blank" id="${sub}[0].${subTableField.field_name}_href"></a>
								         <#-- update--begin--author:zhangjiaqiang date:20170607 for：增加图片和文件格式支持上传 -->
									<#else>
										<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" type="text"
										       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px" class="inputxt"
								               nullmsg="请输入<@mutiLang langKey="${subTableField.content?if_exists?html}"/>！"
								                 <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
												<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
												<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
								               <#if subTableField.type == 'int'>
								               datatype="n" 
								               <#elseif subTableField.type=='double'>
								               datatype="/^(-?\d+)(\.\d+)?$/" 
								                <#else>
					               				<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if></#if>>
									</#if>
									<label class="Validform_label" style="display: none;"><@mutiLang langKey="${subTableField.content?if_exists?html}"/></label>
									</td>
									</#list>
									</tr>
								</#if>
							</tbody>
							<#--update-end--Author:luobaoli  Date:20150614 for：表单类型为onetomany子表属性中增加了扩展参数 ${po.extend_json?if_exists}-->
							</table>
							</div>
						</div>
					