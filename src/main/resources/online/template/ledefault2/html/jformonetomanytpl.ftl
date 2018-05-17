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
				               nullmsg="请输入<@mutiLang langKey="${subTableField.content?if_exists?html}"/>！"
				                <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
								<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
							   <#if subTableField.operationCodesReadOnly?exists> readonly = "readonly"</#if>
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
							<input value="${dictdata.typecode?if_exists?html}" ${subTableField.extend_json?if_exists} name="${sub}[#index#].${subTableField.field_name}" type="radio"
							<#if subTableField.operationCodesReadOnly?exists> readonly = "readonly"</#if>
								<#-- update--begin--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
							  	<#if dictdata_index == 0>
							  	 <#if subTableField.field_valid_type?if_exists?html != ''>
				               	 datatype="${subTableField.field_valid_type?if_exists?html}"
				                <#elseif subTableField.is_null != 'Y'>
				                 datatype="*"
				                </#if>
				                <#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
							  	</#if>>
				                <#-- update--end--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
								${dictdata.typename?if_exists?html}
							</#list> 
						</@DictData>
				               
					<#elseif subTableField.show_type=='checkbox'>
						<@DictData name="${subTableField.dict_field?if_exists?html}" text="${subTableField.dict_text?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
							<#list dataList as dictdata> 
							<input value="${dictdata.typecode?if_exists?html}" ${subTableField.extend_json?if_exists} name="${sub}[#index#].${subTableField.field_name}" type="checkbox"
							<#if subTableField.operationCodesReadOnly?exists> readonly = "readonly"</#if>
								<#-- update--begin--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
						  	<#if dictdata_index == 0>
						  	 <#if subTableField.field_valid_type?if_exists?html != ''>
			               	 datatype="${subTableField.field_valid_type?if_exists?html}"
			                <#elseif subTableField.is_null != 'Y'>
			                 datatype="*"
			                </#if>
			                <#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
						  	</#if>>
			                <#-- update--end--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
								${dictdata.typename?if_exists?html}
							</#list> 
						</@DictData>
				               
					<#elseif subTableField.show_type=='list'>
						<@DictData name="${subTableField.dict_field?if_exists?html}" text="${subTableField.dict_text?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
							<select id="${sub}[#index#].${subTableField.field_name}" ${subTableField.extend_json?if_exists} class="form-control" name="${sub}[#index#].${subTableField.field_name}" 
							<#if subTableField.operationCodesReadOnly?if_exists>onfocus="this.defOpt=this.selectedIndex" onchange="this.selectedIndex=this.defOpt;"</#if>
							 <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
							<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
							<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
							<#-- update--begin--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
						  	 <#if subTableField.field_valid_type?if_exists?html != ''>
			               	 datatype="${subTableField.field_valid_type?if_exists?html}"
			                <#elseif subTableField.is_null != 'Y'>
			                 datatype="*"
			                </#if>>
			                <#-- update--end--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
								<#list dataList as dictdata> 
								<option value="${dictdata.typecode?if_exists?html}" >
									${dictdata.typename?if_exists?html}
								</option> 
								</#list> 
							</select>
						</@DictData>
						
					<#elseif subTableField.show_type=='date'>
						<input id="${sub}[#index#].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[#index#].${subTableField.field_name}" type="text"
						       style="background: url('${basePath}/plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px"  
						       class="form-control" onClick="WdatePicker({<#if subTableField.operationCodesReadOnly?if_exists> readonly = true</#if>})" 
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
						<input id="${sub}[#index#].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[#index#].${subTableField.field_name}" type="text"
						       style="background: url('${basePath}/plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px"  
						       class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'<#if subTableField.operationCodesReadOnly?if_exists> ,readonly = true</#if>})"
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
						<input id="${sub}[#index#].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[#index#].${subTableField.field_name}"  type="text"
						       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px" class="form-control searchbox-inputtext15" 
				               nullmsg="请输入<@mutiLang langKey="${subTableField.content?if_exists?html}"/>！"
				                <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
								<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
							   <#if subTableField.operationCodesReadOnly?if_exists> readonly = "readonly"
							   <#else>
						       onClick="popupClick(this,'${subTableField.dict_text?if_exists?html}','${subTableField.dict_field?if_exists?html}','${subTableField.dict_table?if_exists?html}');" 
							   </#if>
				               <#if subTableField.field_valid_type?if_exists?html != ''>
				               datatype="${subTableField.field_valid_type?if_exists?html}"
				               <#else>
					           <#if subTableField.is_null != 'Y'>datatype="*"</#if>
				               </#if>>
					<#-- update--begin--author:zhangjiaqiang date:20170608 for:增加对于图片文件的支持 -->									
					<#elseif subTableField.show_type=='file' || subTableField.show_type=='image'>
						<input id="${sub}[#index#].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[#index#].${subTableField.field_name}" type="hidden"
						       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px" class="form-control" 
						        <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif subTableField.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
								<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
				               <#if subTableField.field_valid_type?if_exists?html != ''>
				               datatype="${subTableField.field_valid_type?if_exists?html}"
				               <#else>
				               <#if subTableField.is_null != 'Y'>datatype="*"</#if>
				               </#if>>
										<input class="ui-button" type="button" value="上传附件"
															onclick="commonUpload(commonUploadDefaultCallBack,'${sub}[#index#].${subTableField.field_name}')"/> 
				               <a  target="_blank" id="${sub}[#index#].${subTableField.field_name}_href"></a>
						<#-- update--end--author:zhangjiaqiang date:20170608 for:增加对于图片文件的支持 -->
					<#else>
						<input id="${sub}[#index#].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[#index#].${subTableField.field_name}" type="text"
						       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px" class="form-control"
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
			 </tbody>
			 <#--update-end--Author:luobaoli  Date:20150614 for：表单类型为onetomany子表属性中增加了扩展参数 ${po.extend_json?if_exists}-->