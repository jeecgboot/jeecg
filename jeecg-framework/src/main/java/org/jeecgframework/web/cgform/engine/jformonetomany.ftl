
					    <div title="${field['${sub}'].head.content?if_exists?html}" style="margin:0px;padding:0px;overflow:hidden;">
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
							    });  
								$('#delBtn_${sub}').bind('click', function(){   
							       $("#add_${sub}_table").find("input:checked").parent().parent().remove();   
							        resetTrNum('add_${sub}_table');
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
								<td align="center" bgcolor="#EEEEEE"><label class="Validform_label">序号</label></td>
								<td align="center" bgcolor="#EEEEEE"><label class="Validform_label">操作</label></td>
							<#list field['${sub}'].fieldList as subTableField >
								<td align="left" bgcolor="#EEEEEE">${subTableField.content?if_exists?html}</td>
							</#list>
							</tr>
							<tbody id="add_${sub}_table">
								<#if data['${sub}']?exists&&(data['${sub}']?size>0) >
								<#list data['${sub}'] as subTableData >
									<tr>
									<td align="center"><div style="width: 25px;" name="xh"></div></td>
									<td align="center">
										<input style="width:20px;" type="checkbox" name="ck"/>
										<input type="hidden" name="${sub}[${subTableData_index}].id" id="${sub}[${subTableData_index}].id" value="${subTableData['id']?if_exists?html}"/>
										<#list field['${sub}'].hiddenFieldList as subTableField >
										<input type="hidden" name="${sub}[${subTableData_index}].${subTableField.field_name}" id="${sub}[${subTableData_index}].${subTableField.field_name}" value="${subTableData['${subTableField.field_name}']?if_exists?html}}"/>
										</#list> 
									</td>
									<#list field['${sub}'].fieldList as subTableField >
									<td align="left">
									<#if subTableField.show_type=='text'>
										<input id="${sub}[${subTableData_index}].${subTableField.field_name}" name="${sub}[${subTableData_index}].${subTableField.field_name}" type="text"
										       style="width: 150px" class="inputxt" value="${subTableData['${subTableField.field_name}']?if_exists?html}"
								               nullmsg="请输入${subTableField.content}！"
								               
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
									
									<#elseif subTableField.show_type=='password'>
										<input id="${sub}[${subTableData_index}].${subTableField.field_name}" name="${sub}[${subTableData_index}].${subTableField.field_name}"  type="password"
										       style="width: 150px" class="inputxt" value="${subTableData['${subTableField.field_name}']?if_exists?html}"
								               nullmsg="请输入${subTableField.content}！"
								               
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
				               					<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if>>
									
									<#elseif subTableField.show_type=='radio'>
								        <@DictData name="${subTableField.dict_field?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
											<#list dataList as dictdata> 
											<input value="${dictdata.typecode?if_exists?html}" name="${sub}[${subTableData_index}].${subTableField.field_name}" type="radio"
											<#if dictdata.typecode=="${subTableData['${subTableField.field_name}']?if_exists?html}"> checked="true" </#if>>
												${dictdata.typename?if_exists?html}
											</#list> 
										</@DictData>
								               
									<#elseif subTableField.show_type=='checkbox'>
										<#assign checkboxstr>${subTableData['${subTableField.field_name}']?if_exists?html}</#assign>
										<#assign checkboxlist=checkboxstr?split(",")>
										<@DictData name="${subTableField.dict_field?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
											<#list dataList as dictdata> 
											<input value="${dictdata.typecode?if_exists?html}" name="${sub}[${subTableData_index}].${subTableField.field_name}" type="checkbox"
											<#list checkboxlist as x >
											<#if dictdata.typecode=="${x?if_exists?html}"> checked="true" </#if></#list>>
												${dictdata.typename?if_exists?html}
											</#list> 
										</@DictData>
								               
									<#elseif subTableField.show_type=='list'>
										<@DictData name="${subTableField.dict_field?if_exists?html}" text="${subTableField.dict_text?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
											<select id="${sub}[${subTableData_index}].${subTableField.field_name}" name="${sub}[${subTableData_index}].${subTableField.field_name}" >
												<#list dataList as dictdata> 
												<option value="${dictdata.typecode?if_exists?html}" 
												<#if dictdata.typecode=="${subTableData['${subTableField.field_name}']?if_exists?html}"> selected="selected" </#if>>
													${dictdata.typename?if_exists?html}
												</option> 
												</#list> 
											</select>
										</@DictData>
										
									<#elseif subTableField.show_type=='date'>
										<input id="${sub}[${subTableData_index}].${subTableField.field_name}" name="${sub}[${subTableData_index}].${subTableField.field_name}" type="text"
										       style="width: 150px"  value="${subTableData['${subTableField.field_name}']?if_exists?html}"
										       class="Wdate" onClick="WdatePicker()" 
								               nullmsg="请输入${subTableField.content}！"
								               
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
				               					<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if>>
									
									<#elseif subTableField.show_type=='datetime'>
										<input id="${sub}[${subTableData_index}].${subTableField.field_name}" name="${sub}[${subTableData_index}].${subTableField.field_name}" type="text"
										       style="width: 150px"  value="${subTableData['${subTableField.field_name}']?if_exists?html}"
										       class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
								               nullmsg="请输入${subTableField.content}！"
								               
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
				               					<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if>>
								               
									<#elseif subTableField.show_type=='popup'>
										<input id="${sub}[${subTableData_index}].${subTableField.field_name}" name="${sub}[${subTableData_index}].${subTableField.field_name}"  type="text"
										       style="width: 150px" class="searchbox-inputtext15" 
										       onClick="inputClick(this,'${subTableField.dict_text?if_exists?html}','${subTableField.dict_table?if_exists?html}');" 
										       value="${subTableData['${subTableField.field_name}']?if_exists?html}"
								               nullmsg="请输入${subTableField.content}！"
								               
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
				               					<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if>>
									
									<#elseif subTableField.show_type=='file'>
										<input id="${sub}[${subTableData_index}].${subTableField.field_name}" name="${sub}[${subTableData_index}].${subTableField.field_name}" type="text"
										       style="width: 150px" class="inputxt" value="${subTableData['${subTableField.field_name}']?if_exists?html}"
								               nullmsg="请输入${subTableField.content}！"
								               
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
					          					<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if>>
								               
									<#else>
										<input id="${sub}[${subTableData_index}].${subTableField.field_name}" name="${sub}[${subTableData_index}].${subTableField.field_name}" type="text"
										       style="width: 150px" class="inputxt" value="${subTableData['${subTableField.field_name}']?if_exists?html}"
								               nullmsg="请输入${subTableField.content}！"
								               
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
									<label class="Validform_label" style="display: none;">${subTableField.content?if_exists?html}</label>
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
										<input id="${sub}[0].${subTableField.field_name}" name="${sub}[0].${subTableField.field_name}" type="text"
										       style="width: 150px" class="inputxt"
								               nullmsg="请输入${subTableField.content}！"
								               
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
									
									<#elseif subTableField.show_type=='password'>
										<input id="${sub}[0].${subTableField.field_name}" name="${sub}[0].${subTableField.field_name}"  type="password"
										       style="width: 150px" class="inputxt" 
								               nullmsg="请输入${subTableField.content}！"
								               
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
					               				<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if>>
									
									<#elseif subTableField.show_type=='radio'>
								        <@DictData name="${subTableField.dict_field?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
											<#list dataList as dictdata> 
											<input value="${dictdata.typecode?if_exists?html}" name="${sub}[0].${subTableField.field_name}" type="radio">
												${dictdata.typename?if_exists?html}
											</#list> 
										</@DictData>
								               
									<#elseif subTableField.show_type=='checkbox'>
										<@DictData name="${subTableField.dict_field?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
											<#list dataList as dictdata> 
											<input value="${dictdata.typecode?if_exists?html}" name="${sub}[0].${subTableField.field_name}" type="checkbox">
												${dictdata.typename?if_exists?html}
											</#list> 
										</@DictData>
								               
									<#elseif subTableField.show_type=='list'>
										<@DictData name="${subTableField.dict_field?if_exists?html}" text="${subTableField.dict_text?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
											<select id="${sub}[0].${subTableField.field_name}" name="${sub}[0].${subTableField.field_name}" >
												<#list dataList as dictdata> 
												<option value="${dictdata.typecode?if_exists?html}" >
													${dictdata.typename?if_exists?html}
												</option> 
												</#list> 
											</select>
										</@DictData>
										
									<#elseif subTableField.show_type=='date'>
										<input id="${sub}[0].${subTableField.field_name}" name="${sub}[0].${subTableField.field_name}" type="text"
										       style="width: 150px"  
										       class="Wdate" onClick="WdatePicker()" 
								               nullmsg="请输入${subTableField.content}！"
								               
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
					               				<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if>>
									
									<#elseif subTableField.show_type=='datetime'>
										<input id="${sub}[0].${subTableField.field_name}" name="${sub}[0].${subTableField.field_name}" type="text"
										       style="width: 150px"  
										       class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
								               nullmsg="请输入${subTableField.content}！"
								               
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
					               				<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if>>
								               
									<#elseif subTableField.show_type=='popup'>
										<input id="${sub}[0].${subTableField.field_name}" name="${sub}[0].${subTableField.field_name}"  type="text"
										       style="width: 150px" class="searchbox-inputtext15" 
										       onClick="inputClick(this,'${subTableField.dict_text?if_exists?html}','${subTableField.dict_table?if_exists?html}');" 
								               nullmsg="请输入${subTableField.content}！"
								               
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
					               				<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if>>
									
									<#elseif subTableField.show_type=='file'>
										<input id="${sub}[0].${subTableField.field_name}" name="${sub}[0].${subTableField.field_name}" type="text"
										       style="width: 150px" class="inputxt" 
								               nullmsg="请输入${subTableField.content}！"
								               
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
					               				<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if>>
								               
									<#else>
										<input id="${sub}[0].${subTableField.field_name}" name="${sub}[0].${subTableField.field_name}" type="text"
										       style="width: 150px" class="inputxt"
								               nullmsg="请输入${subTableField.content}！"
								               
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
									<label class="Validform_label" style="display: none;">${subTableField.content?if_exists?html}</label>
									</td>
									</#list>
									</tr>
								</#if>
							</tbody>
							</table>
							</div>
						</div>
					