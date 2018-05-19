
					    <#--update-start--Author:luobaoli  Date:20150614 for：表单类型为onetoone子表属性中增加了扩展参数 ${po.extend_json?if_exists}-->
					    <div title="${field['${sub}'].head.content?if_exists?html}" style="margin:0px;padding:0px;overflow:hidden;">
							<div>
							<table cellpadding="0" cellspacing="1" class="formtable" id="${sub}_table">
								<#if data['${sub}']?exists&&(data['${sub}']?size>0) >
								<#if (data['${sub}']?size>1) >
									<div><font color="red">该附表下存在多条数据</font></div>
								<#else>
										<#list data['${sub}'] as subTableData >
											<input type="hidden" name="${sub}[${subTableData_index}].id" id="${sub}[${subTableData_index}].id" value="${subTableData['id']?if_exists?html}"/>
											<#list field['${sub}'].hiddenFieldList as subTableField >
											<input type="hidden" name="${sub}[${subTableData_index}].${subTableField.field_name}" id="${sub}[${subTableData_index}].${subTableField.field_name}" value="${subTableData['${subTableField.field_name}']?if_exists?html}"/>
											</#list> 
											<#list field['${sub}'].fieldNoAreaList as subTableField >
											<#if subTableField_index%2==0>
											<tr>
											</#if>
											<td align="right">
												<label class="Validform_label">
													${subTableField.content?if_exists?html}
												</label>
											</td>
											<td class="value">
											<#if subTableField.show_type=='text'>
												<input id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}" type="text"
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
												<input id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}"  type="password"
												       style="width: 150px" class="inputxt" value="${subTableData['${subTableField.field_name}']?if_exists?html}"
										               nullmsg="请输入${subTableField.content}！"
										               
										               <#if subTableField.field_valid_type?if_exists?html != ''>
										               datatype="${subTableField.field_valid_type?if_exists?html}"
										               <#else>
						               					<#if subTableField.is_null != 'Y'>datatype="*"</#if>
										               </#if>>
											
											<#elseif subTableField.show_type=='radio'>
										        <@DictData name="${subTableField.dict_field?if_exists?html}" text="${subTableField.dict_text?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
													<#list dataList as dictdata> 
													<input value="${dictdata.typecode?if_exists?html}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}" type="radio"
													<#if dictdata_index==0&&subTableField.is_null != 'Y'>datatype="*"</#if>
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
													<#if dictdata_index==0&&subTableField.is_null != 'Y'>datatype="*"</#if>
													<#list checkboxlist as x >
													<#if dictdata.typecode?if_exists?html=="${x?if_exists?html}"> checked="true" </#if></#list>>
														${dictdata.typename?if_exists?html}
													</#list> 
												</@DictData>
										               
											<#elseif subTableField.show_type=='list'>
												<@DictData name="${subTableField.dict_field?if_exists?html}" text="${subTableField.dict_text?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
													<select id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}" 
													<#if subTableField.is_null != 'Y'>datatype="*"</#if> >
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
												       style="width: 150px"  value="${subTableData['${subTableField.field_name}']?if_exists?html}"
												       class="Wdate" onClick="WdatePicker()" 
										               nullmsg="请输入${subTableField.content}！"
										               
										               <#if subTableField.field_valid_type?if_exists?html != ''>
										               datatype="${subTableField.field_valid_type?if_exists?html}"
										               <#else>
						               					<#if subTableField.is_null != 'Y'>datatype="*"</#if>
										               </#if>>
											
											<#elseif subTableField.show_type=='datetime'>
												<input id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}" type="text"
												       style="width: 150px"  value="${subTableData['${subTableField.field_name}']?if_exists?html}"
												       class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
										               nullmsg="请输入${subTableField.content}！"
										               
										               <#if subTableField.field_valid_type?if_exists?html != ''>
										               datatype="${subTableField.field_valid_type?if_exists?html}"
										               <#else>
						               					<#if subTableField.is_null != 'Y'>datatype="*"</#if>
										               </#if>>
										               
											<#elseif subTableField.show_type=='popup'>
												<input id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}"  type="text"
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
												<input id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}" type="text"
												       style="width: 150px" class="inputxt" value="${subTableData['${subTableField.field_name}']?if_exists?html}"
										               nullmsg="请输入${subTableField.content}！"
										               
										               <#if subTableField.field_valid_type?if_exists?html != ''>
										               datatype="${subTableField.field_valid_type?if_exists?html}"
										               <#else>
							          					<#if subTableField.is_null != 'Y'>datatype="*"</#if>
										               </#if>>
										               
											<#else>
												<input id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}" type="text"
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
											<#if (subTableField_index%2==0)&&(!subTableField_has_next)>
												<td align="right">
													<label class="Validform_label">
													</label>
												</td>
												<td class="value">
												</td>
											</#if>
											<#if (subTableField_index%2!=0)||(!subTableField_has_next)>
												</tr>
											</#if>
											</#list>
											<#list field['${sub}'].fieldAreaList as subTableField>
										  	<tr>
												<td align="right">
													<label class="Validform_label">
														${subTableField.content?if_exists?html}
													</label>
												</td>
												<td class="value" colspan="3">
													<textarea id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}" 
													       style="width: 600px" class="inputxt" rows="6"
											               <#if subTableField.field_valid_type?if_exists?html != ''>
											               datatype="${subTableField.field_valid_type?if_exists?html}"
											               <#else>
											               <#if subTableField.is_null != 'Y'>datatype="*"</#if>
											               </#if>>${subTableData['${subTableField.field_name}']?if_exists?html}</textarea>
													<span class="Validform_checktip"></span>
													<label class="Validform_label" style="display: none;">${subTableData['${subTableField.content}']?if_exists?html}</label>
												</td>
											</tr>
										  	</#list>
										</#list>
									</#if>
									<#else>
										<input type="hidden" name="${sub}[0].id" id="${sub}[0].id" />
										<#list field['${sub}'].hiddenFieldList as subTableField >
										<input type="hidden" name="${sub}[0].${subTableField.field_name}" id="${sub}[0].${subTableField.field_name}"/>
										</#list> 
										<#list field['${sub}'].fieldNoAreaList as subTableField >
										<#if subTableField_index%2==0>
										<tr>
										</#if>
										<td align="right">
											<label class="Validform_label">
												${subTableField.content?if_exists?html}
											</label>
										</td>
										<td class="value">
										<#if subTableField.show_type=='text'>
											<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" type="text"
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
											<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}"  type="password"
											       style="width: 150px" class="inputxt" 
									               nullmsg="请输入${subTableField.content}！"
									               
									               <#if subTableField.field_valid_type?if_exists?html != ''>
									               datatype="${subTableField.field_valid_type?if_exists?html}"
									               <#else>
						               				<#if subTableField.is_null != 'Y'>datatype="*"</#if>
									               </#if>>
										
										<#elseif subTableField.show_type=='radio'>
									        <@DictData name="${subTableField.dict_field?if_exists?html}" text="${subTableField.dict_text?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
												<#list dataList as dictdata> 
												<input value="${dictdata.typecode?if_exists?html}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" type="radio" <#if subTableField.is_null != 'Y'>datatype="*"</#if>>
													${dictdata.typename?if_exists?html}
												</#list> 
											</@DictData>
									               
										<#elseif subTableField.show_type=='checkbox'>
											<@DictData name="${subTableField.dict_field?if_exists?html}" text="${subTableField.dict_text?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
												<#list dataList as dictdata> 
												<input value="${dictdata.typecode?if_exists?html}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" type="checkbox" <#if subTableField.is_null != 'Y'>datatype="*"</#if>>
													${dictdata.typename?if_exists?html}
												</#list> 
											</@DictData>
									               
										<#elseif subTableField.show_type=='list'>
											<@DictData name="${subTableField.dict_field?if_exists?html}" text="${subTableField.dict_text?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
												<select id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" <#if subTableField.is_null != 'Y'>datatype="*"</#if>>
													<#list dataList as dictdata> 
													<option value="${dictdata.typecode?if_exists?html}" >
														${dictdata.typename?if_exists?html}
													</option> 
													</#list> 
												</select>
											</@DictData>
											
										<#elseif subTableField.show_type=='date'>
											<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" type="text"
											       style="width: 150px"  
											       class="Wdate" onClick="WdatePicker()" 
									               nullmsg="请输入${subTableField.content}！"
									               
									               <#if subTableField.field_valid_type?if_exists?html != ''>
									               datatype="${subTableField.field_valid_type?if_exists?html}"
									               <#else>
						               				<#if subTableField.is_null != 'Y'>datatype="*"</#if>
									               </#if>>
										
										<#elseif subTableField.show_type=='datetime'>
											<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" type="text"
											       style="width: 150px"  
											       class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
									               nullmsg="请输入${subTableField.content}！"
									               
									               <#if subTableField.field_valid_type?if_exists?html != ''>
									               datatype="${subTableField.field_valid_type?if_exists?html}"
									               <#else>
						               				<#if subTableField.is_null != 'Y'>datatype="*"</#if>
									               </#if>>
									               
										<#elseif subTableField.show_type=='popup'>
											<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}"  type="text"
											       style="width: 150px" class="searchbox-inputtext15" 
											       onClick="inputClick(this,'${subTableField.dict_text?if_exists?html}','${subTableField.dict_table?if_exists?html}');" 
									               nullmsg="请输入${subTableField.content}！"
									               
									               <#if subTableField.field_valid_type?if_exists?html != ''>
									               datatype="${subTableField.field_valid_type?if_exists?html}"
									               <#else>
						               				<#if subTableField.is_null != 'Y'>datatype="*"</#if>
									               </#if>>
										
										<#elseif subTableField.show_type=='file'>
											<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" type="text"
											       style="width: 150px" class="inputxt" 
									               nullmsg="请输入${subTableField.content}！"
									               
									               <#if subTableField.field_valid_type?if_exists?html != ''>
									               datatype="${subTableField.field_valid_type?if_exists?html}"
									               <#else>
						               				<#if subTableField.is_null != 'Y'>datatype="*"</#if>
									               </#if>>
									               
										<#else>
											<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" type="text"
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
										<#if (subTableField_index%2==0)&&(!subTableField_has_next)>
											<td align="right">
												<label class="Validform_label">
												</label>
											</td>
											<td class="value">
											</td>
										</#if>
										<#if (subTableField_index%2!=0)||(!subTableField_has_next)>
											</tr>
										</#if>
										</#list>
										<#list field['${sub}'].fieldAreaList as subTableField>
										  	<tr>
												<td align="right">
													<label class="Validform_label">
														${subTableField.content?if_exists?html}
													</label>
												</td>
												<td class="value" colspan="3">
													<textarea id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" 
													       style="width: 600px" class="inputxt" rows="6"
											               <#if subTableField.field_valid_type?if_exists?html != ''>
											               datatype="${subTableField.field_valid_type?if_exists?html}"
											               <#else>
											               <#if subTableField.is_null != 'Y'>datatype="*"</#if>
											               </#if>></textarea>
													<span class="Validform_checktip"></span>
													<label class="Validform_label" style="display: none;">${sub}[0].${subTableField.content?if_exists?html}</label>
												</td>
											</tr>
									  	</#list>
								</#if>
							</table>
							</div>
						</div>
						<#--update-end--Author:luobaoli  Date:20150614 for：表单类型为onetoone子表属性中增加了扩展参数 ${po.extend_json?if_exists}-->
					