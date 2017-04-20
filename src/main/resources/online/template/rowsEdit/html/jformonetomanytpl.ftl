		<#--update-start--Author:luobaoli  Date:20150614 for：表单类型为onetomany子表属性中增加了扩展参数 ${po.extend_json?if_exists}-->
		<tbody id="add_${sub}_table_template">
				<tr>
					<th scope="row"><div name="xh"></div></th>
					<td>
						<input style="width:20px;" type="checkbox" name="ck"/>
						<input type="hidden" name="${sub}[#index#].id" id="${sub}[#index#].id"/>
						<#list field['${sub}'].hiddenFieldList as subTableField >
						<input type="hidden" name="${sub}[#index#].${subTableField.field_name}" id="${sub}[#index#].${subTableField.field_name}"/>
						</#list> 
					</td>
					<#list field['${sub}'].fieldList as subTableField >
					<td>
					<#if subTableField.show_type=='text'>
						<input id="${sub}[#index#].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[#index#].${subTableField.field_name}" type="text"
						       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px" class="form-control"
				               nullmsg="请输入${subTableField.content}！"
							   <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
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
						<input id="${sub}[#index#].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[#index#].${subTableField.field_name}"  type="password"
						       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px" class="form-control" 
				               nullmsg="请输入${subTableField.content}！"
							   <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
								<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
				               <#if subTableField.field_valid_type?if_exists?html != ''>
				               datatype="${subTableField.field_valid_type?if_exists?html}"
				               <#else>
					           <#if subTableField.is_null != 'Y'>datatype="*"</#if>
				               </#if>>
					
					<#elseif subTableField.show_type=='radio'>
				        <@DictData name="${subTableField.dict_field?if_exists?html}" text="${subTableField.dict_text?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
							<#list dataList as dictdata> 
							<input value="${dictdata.typecode?if_exists?html}" ${subTableField.extend_json?if_exists} name="${sub}[#index#].${subTableField.field_name}" type="radio"
							<#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
								<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
							<#if dictdata_index==0&&subTableField.is_null != 'Y'>datatype="*"</#if> >
								${dictdata.typename?if_exists?html}
							</#list> 
						</@DictData>
				               
					<#elseif subTableField.show_type=='checkbox'>
						<@DictData name="${subTableField.dict_field?if_exists?html}" text="${subTableField.dict_text?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
							<#list dataList as dictdata> 
							<input value="${dictdata.typecode?if_exists?html}" ${subTableField.extend_json?if_exists} name="${sub}[#index#].${subTableField.field_name}" type="checkbox"
							<#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
								<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
							<#if dictdata_index==0&&subTableField.is_null != 'Y'>datatype="*"</#if> >
								${dictdata.typename?if_exists?html}
							</#list> 
						</@DictData>
				               
					<#elseif subTableField.show_type=='list'>
						<@DictData name="${subTableField.dict_field?if_exists?html}" text="${subTableField.dict_text?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
							<select id="${sub}[#index#].${subTableField.field_name}" ${subTableField.extend_json?if_exists} class="form-control" name="${sub}[#index#].${subTableField.field_name}" 
							<#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
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
						<input id="${sub}[#index#].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[#index#].${subTableField.field_name}" type="text"
						       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px"  
						       class="form-control" onClick="WdatePicker()" 
				               nullmsg="请输入${subTableField.content}！"
							   <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
								<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
				               <#if subTableField.field_valid_type?if_exists?html != ''>
				               datatype="${subTableField.field_valid_type?if_exists?html}"
				               <#else>
					           <#if subTableField.is_null != 'Y'>datatype="*"</#if>
				               </#if>>
					
					<#elseif subTableField.show_type=='datetime'>
						<input id="${sub}[#index#].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[#index#].${subTableField.field_name}" type="text"
						       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px"  
						       class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
				               nullmsg="请输入${subTableField.content}！"
							   <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
								<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
				               <#if subTableField.field_valid_type?if_exists?html != ''>
				               datatype="${subTableField.field_valid_type?if_exists?html}"
				               <#else>
					           <#if subTableField.is_null != 'Y'>datatype="*"</#if>
				               </#if>>
					
					<#elseif subTableField.show_type=='popup'>
						<input id="${sub}[#index#].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[#index#].${subTableField.field_name}"  type="text"
						       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px" class="form-control searchbox-inputtext15" 
						       onClick="inputClick(this,'${subTableField.dict_text?if_exists?html}','${subTableField.dict_table?if_exists?html}');" 
				               nullmsg="请输入${subTableField.content}！"
							   <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
								<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
				               <#if subTableField.field_valid_type?if_exists?html != ''>
				               datatype="${subTableField.field_valid_type?if_exists?html}"
				               <#else>
					           <#if subTableField.is_null != 'Y'>datatype="*"</#if>
				               </#if>>
									
					<#elseif subTableField.show_type=='file'>
						<input id="${sub}[#index#].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[#index#].${subTableField.field_name}" type="text"
						       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px" class="form-control" 
				               <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
								<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
				               <#if subTableField.field_valid_type?if_exists?html != ''>
				               datatype="${subTableField.field_valid_type?if_exists?html}"
				               <#else>
				               <#if subTableField.is_null != 'Y'>datatype="*"</#if>
				               </#if>>
				               
					<#else>
						<input id="${sub}[#index#].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[#index#].${subTableField.field_name}" type="text"
						       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px" class="form-control"
				               nullmsg="请输入${subTableField.content}！"
							   <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
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
					</td>
					</#list>
					</tr>
			 </tbody>
			 <#--update-end--Author:luobaoli  Date:20150614 for：表单类型为onetomany子表属性中增加了扩展参数 ${po.extend_json?if_exists}-->