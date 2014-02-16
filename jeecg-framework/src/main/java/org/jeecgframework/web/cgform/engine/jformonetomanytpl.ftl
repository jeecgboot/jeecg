		<tbody id="add_${sub}_table_template">
				<tr>
					<td align="center"><div style="width: 25px;" name="xh"></div></td>
					<td align="center">
					<input style="width:20px;" type="checkbox" name="ck"/>
					<input type="hidden" name="${sub}[#index#].id" id="${sub}[#index#].id" />
					<#list field['${sub}'].hiddenFieldList as subTableField >
					<input type="hidden" name="${sub}[#index#].${subTableField.field_name}" id="${sub}[#index#].${subTableField.field_name}"/>
					</#list> 
					</td>
					<#list field['${sub}'].fieldList as subTableField >
					<td align="left">
					<#if subTableField.show_type=='text'>
						<input id="${sub}[#index#].${subTableField.field_name}" name="${sub}[#index#].${subTableField.field_name}" type="text"
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
						<input id="${sub}[#index#].${subTableField.field_name}" name="${sub}[#index#].${subTableField.field_name}"  type="password"
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
							<input value="${dictdata.typecode?if_exists?html}" name="${sub}[#index#].${subTableField.field_name}" type="radio">
								${dictdata.typename?if_exists?html}
							</#list> 
						</@DictData>
				               
					<#elseif subTableField.show_type=='checkbox'>
						<@DictData name="${subTableField.dict_field?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
							<#list dataList as dictdata> 
							<input value="${dictdata.typecode?if_exists?html}" name="${sub}[#index#].${subTableField.field_name}" type="checkbox">
								${dictdata.typename?if_exists?html}
							</#list> 
						</@DictData>
				               
					<#elseif subTableField.show_type=='list'>
						<@DictData name="${subTableField.dict_field?if_exists?html}" text="${subTableField.dict_text?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
							<select id="${sub}[#index#].${subTableField.field_name}" name="${sub}[#index#].${subTableField.field_name}" >
								<#list dataList as dictdata> 
								<option value="${dictdata.typecode?if_exists?html}" >
									${dictdata.typename?if_exists?html}
								</option> 
								</#list> 
							</select>
						</@DictData>
						
					<#elseif subTableField.show_type=='date'>
						<input id="${sub}[#index#].${subTableField.field_name}" name="${sub}[#index#].${subTableField.field_name}" type="text"
						       style="width: 150px"  
						       class="Wdate" onClick="WdatePicker()" 
				               nullmsg="请输入${subTableField.content}！"
							   
				               <#if subTableField.field_valid_type?if_exists?html != ''>
				               datatype="${subTableField.field_valid_type?if_exists?html}"
				               <#else>
					           <#if subTableField.is_null != 'Y'>datatype="*"</#if>
				               </#if>>
					
					<#elseif subTableField.show_type=='datetime'>
						<input id="${sub}[#index#].${subTableField.field_name}" name="${sub}[#index#].${subTableField.field_name}" type="text"
						       style="width: 150px"  
						       class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
				               nullmsg="请输入${subTableField.content}！"
							   
				               <#if subTableField.field_valid_type?if_exists?html != ''>
				               datatype="${subTableField.field_valid_type?if_exists?html}"
				               <#else>
					           <#if subTableField.is_null != 'Y'>datatype="*"</#if>
				               </#if>>
					
					<#elseif subTableField.show_type=='popup'>
						<input id="${sub}[#index#].${subTableField.field_name}" name="${sub}[#index#].${subTableField.field_name}"  type="text"
						       style="width: 150px" class="searchbox-inputtext15" 
						       onClick="inputClick(this,'${subTableField.dict_text?if_exists?html}','${subTableField.dict_table?if_exists?html}');" 
				               nullmsg="请输入${subTableField.content}！"
							   
				               <#if subTableField.field_valid_type?if_exists?html != ''>
				               datatype="${subTableField.field_valid_type?if_exists?html}"
				               <#else>
					           <#if subTableField.is_null != 'Y'>datatype="*"</#if>
				               </#if>>
									
					<#elseif subTableField.show_type=='file'>
						<input id="${sub}[#index#].${subTableField.field_name}" name="${sub}[#index#].${subTableField.field_name}" type="text"
						       style="width: 150px" class="inputxt" 
				               <#if subTableField.field_valid_type?if_exists?html != ''>
				               datatype="${subTableField.field_valid_type?if_exists?html}"
				               <#else>
				               <#if subTableField.is_null != 'Y'>datatype="*"</#if>
				               </#if>>
				               
					<#else>
						<input id="${sub}[#index#].${subTableField.field_name}" name="${sub}[#index#].${subTableField.field_name}" type="text"
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
			 </tbody>