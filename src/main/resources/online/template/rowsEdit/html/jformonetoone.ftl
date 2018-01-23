
					    <#--update-start--Author:luobaoli  Date:20150614 for：表单类型为onetoone子表属性中增加了扩展参数 ${po.extend_json?if_exists}-->
					    <div class="con-wrapper" id="con-wrapper${sub_index}" style="display: none;">
							 <div class="row form-wrapper"> 
								<#if data['${sub}']?exists&&(data['${sub}']?size>0) >
								<#if (data['${sub}']?size>1) >
									<div><font color="red">该附表下存在多条数据</font></div>
								<#else>
										<#list data['${sub}'] as subTableData >
											<input type="hidden" name="${sub}[${subTableData_index}].id" id="${sub}[${subTableData_index}].id" value="${subTableData['id']?if_exists?html}"/>
											<#list field['${sub}'].hiddenFieldList as subTableField >
											<input type="hidden" name="${sub}[${subTableData_index}].${subTableField.field_name}" id="${sub}[${subTableData_index}].${subTableField.field_name}" value="${subTableData['${subTableField.field_name}']?if_exists?html}}"/>
											</#list> 
											<#list field['${sub}'].fieldNoAreaList as subTableField >
											<#if subTableField_index%2==0>
											<div class="row show-grid">
											</#if>
											<div class="col-xs-3 text-center">
									          <b>${subTableField.content?if_exists?html}：</b>
									        </div>
											<div class="col-xs-3">
											<#if subTableField.show_type=='text'>
												<input id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}" type="text"
												       style="width: 150px" class="form-control" value="${subTableData['${subTableField.field_name}']?if_exists?html}"
										               nullmsg="请输入${subTableField.content}！"
										               <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
														<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
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
											
											<#elseif subTableField.show_type=='password'>
												<input id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}"  type="password"
												       style="width: 150px" class="form-control" value="${subTableData['${subTableField.field_name}']?if_exists?html}"
										               nullmsg="请输入${subTableField.content}！"
										                  <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
														<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
														<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
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
													<select id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} class="form-control" name="${sub}[${subTableData_index}].${subTableField.field_name}" 
													   <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
														<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
														<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
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
												       class="form-control" onClick="WdatePicker()" 
										               nullmsg="请输入${subTableField.content}！"
										                  <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
														<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
														<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
										               <#if subTableField.field_valid_type?if_exists?html != ''>
										               datatype="${subTableField.field_valid_type?if_exists?html}"
										               <#else>
						               					<#if subTableField.is_null != 'Y'>datatype="*"</#if>
										               </#if>>
											
											<#elseif subTableField.show_type=='datetime'>
												<input id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}" type="text"
												       style="width: 150px"  value="${subTableData['${subTableField.field_name}']?if_exists?html}"
												       class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
										               nullmsg="请输入${subTableField.content}！"
										                  <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
														<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
														<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
										               <#if subTableField.field_valid_type?if_exists?html != ''>
										               datatype="${subTableField.field_valid_type?if_exists?html}"
										               <#else>
						               					<#if subTableField.is_null != 'Y'>datatype="*"</#if>
										               </#if>>
										               
											<#elseif subTableField.show_type=='popup'>
												<input id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}"  type="text"
												       style="width: 150px" class="form-control searchbox-inputtext15" 
												       onClick="inputClick(this,'${subTableField.dict_text?if_exists?html}','${subTableField.dict_table?if_exists?html}');" 
												       value="${subTableData['${subTableField.field_name}']?if_exists?html}"
										               nullmsg="请输入${subTableField.content}！"
										                  <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
														<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
														<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
										               <#if subTableField.field_valid_type?if_exists?html != ''>
										               datatype="${subTableField.field_valid_type?if_exists?html}"
										               <#else>
						               					<#if subTableField.is_null != 'Y'>datatype="*"</#if>
										               </#if>>
											<#-- update--begin--author:zhangjiaqiang date:20170607 for:优化上传功能 -->
											<#elseif subTableField.show_type=='file' || subTableField.show_type=='image'>
												<input id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}" type="text"
												       style="width: 150px" class="form-control" value="${subTableData['${subTableField.field_name}']?if_exists?html}"
										               nullmsg="请输入${subTableField.content}！"
										                  <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
														<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
														<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
										               <#if subTableField.field_valid_type?if_exists?html != ''>
										               datatype="${subTableField.field_valid_type?if_exists?html}"
										               <#else>
							          					<#if subTableField.is_null != 'Y'>datatype="*"</#if>
										               </#if>>
										<input class="ui-button" type="button" value="上传附件"
															onclick="commonUpload(commonUploadDefaultCallBack,'${sub}[${subTableData_index}].${subTableField.field_name}')"/>
										                  <a  target="_blank" id="${sub}[${subTableData_index}].${subTableField.field_name}_href">未上传</a>
										              	<#-- update--end--author:zhangjiaqiang date:20170607 for:优化上传功能 --> 
											<#else>
												<input id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}" type="text"
												       style="width: 150px" class="form-control" value="${subTableData['${subTableField.field_name}']?if_exists?html}"
										               nullmsg="请输入${subTableField.content}！"
										                  <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
														<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
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
											<label class="Validform_label" style="display: none;">${subTableField.content?if_exists?html}</label>
											</div>
											<#if (subTableField_index%2==0)&&(!subTableField_has_next)>
												<div class="col-xs-3 text-center">
										          <b></b>
										        </div>
												<div class="col-xs-3">
												</div>
											</#if>
											<#if (subTableField_index%2!=0)||(!subTableField_has_next)>
												</div>
											</#if>
											</#list>
											<#list field['${sub}'].fieldAreaList as subTableField>
										  	<div class="row show-grid">
												<div class="col-xs-3 text-center">
										          <b>${subTableField.content?if_exists?html}：</b>
										        </div>
												<div class="col-xs-3">
													<textarea id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}" 
													       style="width: 600px" class="form-control" rows="6"
													          <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
														<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
														<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
											               <#if subTableField.field_valid_type?if_exists?html != ''>
											               datatype="${subTableField.field_valid_type?if_exists?html}"
											               <#else>
											               <#if subTableField.is_null != 'Y'>datatype="*"</#if>
											               </#if>>${subTableData['${subTableField.field_name}']?if_exists?html}</textarea>
													<span class="Validform_checktip"></span>
													<label class="Validform_label" style="display: none;">${subTableData['${subTableField.content}']?if_exists?html}</label>
												</div>
											</div>
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
										<div class="row show-grid">
										</#if>
										<div class="col-xs-3 text-center">
								          <b>${subTableField.content?if_exists?html}：</b>
								        </div>
										<div class="col-xs-3">
										<#if subTableField.show_type=='text'>
											<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" type="text"
											       style="width: 150px" class="form-control"
									               nullmsg="请输入${subTableField.content}！"
									                  <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
														<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
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
										
										<#elseif subTableField.show_type=='password'>
											<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}"  type="password"
											       style="width: 150px" class="form-control" 
									               nullmsg="请输入${subTableField.content}！"
									                  <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
														<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
														<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									               <#if subTableField.field_valid_type?if_exists?html != ''>
									               datatype="${subTableField.field_valid_type?if_exists?html}"
									               <#else>
						               				<#if subTableField.is_null != 'Y'>datatype="*"</#if>
									               </#if>>
										
										<#elseif subTableField.show_type=='radio'>
									        <@DictData name="${subTableField.dict_field?if_exists?html}" text="${subTableField.dict_text?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
												<#list dataList as dictdata> 
												<input value="${dictdata.typecode?if_exists?html}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" type="radio"
												  <#if subTableField.is_null != 'Y'>datatype="*"</#if>>
													${dictdata.typename?if_exists?html}
												</#list> 
											</@DictData>
									               
										<#elseif subTableField.show_type=='checkbox'>
											<@DictData name="${subTableField.dict_field?if_exists?html}" text="${subTableField.dict_text?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
												<#list dataList as dictdata> 
												<input value="${dictdata.typecode?if_exists?html}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" type="checkbox" 
												<#if subTableField.is_null != 'Y'>datatype="*"</#if>>
													${dictdata.typename?if_exists?html}
												</#list> 
											</@DictData>
									               
										<#elseif subTableField.show_type=='list'>
											<@DictData name="${subTableField.dict_field?if_exists?html}" text="${subTableField.dict_text?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
												<select id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} class="form-control" name="${sub}[0].${subTableField.field_name}" 
												   <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
														<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
														<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
												<#if subTableField.is_null != 'Y'>datatype="*"</#if>>
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
											       class="form-control" onClick="WdatePicker()" 
									               nullmsg="请输入${subTableField.content}！"
									                  <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
														<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
														<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									               <#if subTableField.field_valid_type?if_exists?html != ''>
									               datatype="${subTableField.field_valid_type?if_exists?html}"
									               <#else>
						               				<#if subTableField.is_null != 'Y'>datatype="*"</#if>
									               </#if>>
										
										<#elseif subTableField.show_type=='datetime'>
											<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" type="text"
											       style="width: 150px"  
											       class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
									               nullmsg="请输入${subTableField.content}！"
									                  <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
														<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
														<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									               <#if subTableField.field_valid_type?if_exists?html != ''>
									               datatype="${subTableField.field_valid_type?if_exists?html}"
									               <#else>
						               				<#if subTableField.is_null != 'Y'>datatype="*"</#if>
									               </#if>>
									               
										<#elseif subTableField.show_type=='popup'>
											<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}"  type="text"
											       style="width: 150px" class="form-control searchbox-inputtext15" 
											       onClick="inputClick(this,'${subTableField.dict_text?if_exists?html}','${subTableField.dict_table?if_exists?html}');" 
									               nullmsg="请输入${subTableField.content}！"
									                  <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
														<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
														<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									               <#if subTableField.field_valid_type?if_exists?html != ''>
									               datatype="${subTableField.field_valid_type?if_exists?html}"
									               <#else>
						               				<#if subTableField.is_null != 'Y'>datatype="*"</#if>
									               </#if>>
										
										<#elseif subTableField.show_type=='file' || subTableField.show_type=='image'>
												<#-- update--begin--author:zhangjiaqiang date:20170607 for:优化上传功能 -->
											<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" type="text"
											       style="width: 150px" class="form-control" 
									               nullmsg="请输入${subTableField.content}！"
									                  <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
														<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
														<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									               <#if subTableField.field_valid_type?if_exists?html != ''>
									               datatype="${subTableField.field_valid_type?if_exists?html}"
									               <#else>
						               				<#if subTableField.is_null != 'Y'>datatype="*"</#if>
									               </#if>>
										<input class="ui-button" type="button" value="上传附件"
															onclick="commonUpload(commonUploadDefaultCallBack,'${sub}[0].${subTableField.field_name}')"/>
									                  <a  target="_blank" id="${sub}[0].${subTableField.field_name}_href">未上传</a>
									               	<#-- update--begin--author:zhangjiaqiang date:20170607 for:优化上传功能 -->
										<#else>
											<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" type="text"
											       style="width: 150px" class="form-control"
									               nullmsg="请输入${subTableField.content}！"
									                  <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
														<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
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
										<label class="Validform_label" style="display: none;">${subTableField.content?if_exists?html}</label>
										</div>
										<#if (subTableField_index%2==0)&&(!subTableField_has_next)>
											<div class="col-xs-3 text-center">
									          <b></b>
									        </div>
											<div class="col-xs-3">
											</div>
										</#if>
										<#if (subTableField_index%2!=0)||(!subTableField_has_next)>
											</div>
										</#if>
										</#list>
										<#list field['${sub}'].fieldAreaList as subTableField>
										  	<div class="row show-grid">
												<div class="col-xs-3 text-center">
										          <b>${subTableField.content?if_exists?html}：</b>
										        </div>
												<div class="col-xs-3">
													<textarea id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" 
													       style="width: 600px" class="form-control" rows="6"
													          <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
														<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
														<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
											               <#if subTableField.field_valid_type?if_exists?html != ''>
											               datatype="${subTableField.field_valid_type?if_exists?html}"
											               <#else>
											               <#if subTableField.is_null != 'Y'>datatype="*"</#if>
											               </#if>></textarea>
													<span class="Validform_checktip"></span>
													<label class="Validform_label" style="display: none;">${sub}[0].${subTableField.content?if_exists?html}</label>
												</div>
											</div>
									  	</#list>
								</#if>
							</div>
						</div>
						<#--update-end--Author:luobaoli  Date:20150614 for：表单类型为onetoone子表属性中增加了扩展参数 ${po.extend_json?if_exists}-->
					