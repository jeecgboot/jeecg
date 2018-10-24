<#list columns as po>
	<#if po.show_type=='text'>
		<li id="${po.field_name}" class="clearfix " typ="name" reqd="1">
			<label class="desc">${po.content}:<#if po.is_null != 'Y'><span class="req">*</span></#if></label>
			<div class="content">
				<input 
					type="text" 
					maxlength="256" 
					class="ui-input-text xl input fld" 
					name="${po.field_name}" 
					id="${po.field_name}" 
					${po.extend_json?if_exists}
					value="${data['${tableName}']['${po.field_name}']?if_exists?html}" 
					<#if po.operationCodesReadOnly?exists> readonly = "readonly"</#if>
					<#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
					<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
					<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
					<#if po.field_valid_type?if_exists?html != ''>
						datatype="${po.field_valid_type?if_exists?html}" 
						<#else>
							<#if po.type == 'int'>
								datatype="n"  <#if po.is_null == 'Y'>ignore="ignore" </#if>
								<#elseif po.type=='double'>
								datatype="/^(-?\d+)(\.\d+)?$/" <#if po.is_null == 'Y'>ignore="ignore" </#if>
								<#else>
								<#if po.is_null != 'Y'>datatype="*"</#if>
							</#if>
					</#if>
				/>
			</div>
		</li>
		<#elseif po.show_type=='password'>
			<li id="${po.field_name}" class="clearfix " typ="password" reqd="1">
				<label class="desc">${po.content}: <#if po.is_null != 'Y'><span class="req">*</span></#if></label>
				<div class="content">
					<input 
						type="text" 
						maxlength="256" 
						class="ui-input-text xl input fld" 
						name="${po.field_name}" 
						id="${po.field_name}" 
						${po.extend_json?if_exists}
						value="${data['${tableName}']['${po.field_name}']?if_exists?html}" 
						<#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
					<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
					<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
						<#if po.operationCodesReadOnly?exists> readonly = "readonly"</#if>
						<#if po.field_valid_type?if_exists?html != ''>
							datatype="${po.field_valid_type?if_exists?html}" 
							<#else>
								<#if po.is_null != 'Y'>datatype="*"</#if>
						</#if>
					/>
				</div>
			</li>
		<#elseif po.show_type=='radio'>
			<li id="${po.field_name}" class="clearfix " typ="radio" reqd="1">
				<label class="desc">${po.content} <#if po.is_null != 'Y'><span class="req">*</span></#if></label>
				<div class="content">
					<fieldset class="controlgroup">
						<@DictData name="${po.dict_field?if_exists?html}" text="${po.dict_text?if_exists?html}" tablename="${po.dict_table?if_exists?html}" var="dataList">
							<#list dataList as dictdata> 
								<label <#if dictdata_index==0>class="first"</#if>>
									<input 
										value="${dictdata.typecode?if_exists?html}" 
										${po.extend_json?if_exists} 
										name="${po.field_name}" 
										type="radio" 
										<#if dictdata_index==0&&po.is_null != 'Y'>datatype="*"</#if> 
										<#if po.operationCodesReadOnly?if_exists>onclick="return false;"</#if>
										<#if dictdata.typecode?if_exists?html=="${data['${tableName}']['${po.field_name}']?if_exists?html}"> checked="true</#if> 
									/><label></label>${dictdata.typename?if_exists?html}
								</label>
							</#list> 
						</@DictData>
					</fieldset>
				</div>
			</li>
		<#elseif po.show_type=='checkbox'>
			<li id="${po.field_name}" class="clearfix " typ="radio" reqd="1">
				<label class="desc">${po.content}: <#if po.is_null != 'Y'><span class="req">*</span></#if></label>
				<div class="content">
					<fieldset class="controlgroup">
						<#assign checkboxstr>${data['${tableName}']['${po.field_name}']?if_exists?html}</#assign>
						<#assign checkboxlist=checkboxstr?split(",")>
						<@DictData name="${po.dict_field?if_exists?html}" text="${po.dict_text?if_exists?html}" tablename="${po.dict_table?if_exists?html}" var="dataList">
							<#list dataList as dictdata> 
								<label <#if dictdata_index==0>class="first"</#if>>
									<input 
										value="${dictdata.typecode?if_exists?html}" 
										${po.extend_json?if_exists} 
										name="${po.field_name}" 
										type="checkbox" 
										<#if po.operationCodesReadOnly?if_exists>onclick="return false;"</#if>
										<#if dictdata_index==0&&po.is_null != 'Y'>datatype="*"</#if> 
										<#list checkboxlist as x >
											<#if dictdata.typecode?if_exists?html=="${x?if_exists?html}"> checked="true" </#if>
										</#list>
									/><label></label>${dictdata.typename?if_exists?html}
								</label>
							</#list> 
						</@DictData>
					</fieldset>
				</div>
			</li>
		<#elseif po.show_type=='list'>
			<li id="${po.field_name}" class="clearfix " typ="list">
				<label class="desc">${po.content}:<#if po.is_null != 'Y'><span class="req">*</span></#if></label>
				<div class="content">
						<@DictData name="${po.dict_field?if_exists?html}" text="${po.dict_text?if_exists?html}" tablename="${po.dict_table?if_exists?html}" var="dataList">
							<select 
								id="${po.field_name}" 
								${po.extend_json?if_exists} 
								name="${po.field_name}" 
								<#if po.operationCodesReadOnly?if_exists>
									onfocus="this.defOpt=this.selectedIndex" onchange="this.selectedIndex=this.defOpt;"</#if><#if po.is_null != 'Y'>datatype="*"
								</#if> 
								<#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
							<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
							<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								class="ui-input-select fld"
								>
								<#list dataList as dictdata> 
									<option 
										value="${dictdata.typecode?if_exists?html}" 
										<#if dictdata.typecode?if_exists?html=="${data['${tableName}']['${po.field_name}']?if_exists?html}">
											selected="selected"
										</#if>>${dictdata.typename?if_exists?html}
									</option> 
								</#list> 
							</select>
						</@DictData>
				</div>
			</li>
		<#elseif po.show_type=='date'>
			<li id="${po.field_name}" class="clearfix " typ="date" reqd="1">
					<label class="desc">${po.content}: <#if po.is_null != 'Y'><span class="req">*</span></#if></label>
					<div class="content">
						<input 
							type="text" 
							maxlength="256" 
							class="ui-input-text xl input fld" 
							name="${po.field_name}" 
							id="${po.field_name}" 
							${po.extend_json?if_exists}
							value="<#if data['${tableName}']['${po.field_name}']??>${data['${tableName}']['${po.field_name}']?if_exists?string("yyyy-MM-dd")}</#if>"
							<#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
							<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
							<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
							onClick="WdatePicker({<#if po.operationCodesReadOnly?if_exists> readonly = true</#if>})" 
							<#if po.operationCodesReadOnly?exists> readonly = "readonly"</#if>
							<#if po.field_valid_type?if_exists?html != ''>
								datatype="${po.field_valid_type?if_exists?html}" 
								<#else>
									<#if po.is_null != 'Y'>datatype="*"</#if>
							</#if>
						/>
					</div>
				</li>
		<#elseif po.show_type=='datetime'>
			<li id="${po.field_name}" class="clearfix " typ="date" reqd="1">
				<label class="desc">${po.content}: <#if po.is_null != 'Y'><span class="req">*</span></#if>/label>
				<div class="content">
					<input 
						type="text" 
						maxlength="256" 
						class="ui-input-text xl input fld" 
						name="${po.field_name}" 
						id="${po.field_name}" 
						${po.extend_json?if_exists}
						value="<#if data['${tableName}']['${po.field_name}']??>${data['${tableName}']['${po.field_name}']?if_exists?string("yyyy-MM-dd HH:mm:ss")}</#if>"
						onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'<#if po.operationCodesReadOnly?if_exists> readonly = true</#if>})" 
						<#if po.operationCodesReadOnly?exists> readonly = "readonly"</#if>
						<#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
					<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
					<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
						<#if po.field_valid_type?if_exists?html != ''>
							datatype="${po.field_valid_type?if_exists?html}" 
							<#else>
								<#if po.is_null != 'Y'>datatype="*"</#if>
						</#if>
					/>
				</div>
			</li>
			<#--update-begin--Author:liushaoqian  Date:20180710 for：TASK #2930 【online样式】通用移动模板一对多，支持上传图片和附件-->
			<#-- update-begin-author:taoYan date:20180903 for:移动模板文件上传改造 -->
			<#elseif po.show_type=='file'>
			<li class="clearfix" typ="name" reqd="1">
				<label class="desc">${po.content}:<#if po.is_null != 'Y'><span class="req">*</span></#if></label>
				<@uploadFile po = po />
			</li>
			<#elseif po.show_type=='image'>
			<li class="clearfix" typ="name" reqd="1">
				<label class="desc">${po.content}:<#if po.is_null != 'Y'><span class="req">*</span></#if></label>
				<@uploadImg po = po />
			</li>
			<#-- update-end-author:taoYan date:20180903 for:移动模板文件上传改造 -->
			<#--update-end--Author:liushaoqian  Date:20180710 for：TASK #2930 【online样式】通用移动模板一对多，支持上传图片和附件-->
		<#-- update--begin--author:taoyan Date:20170707 for:TASK #2918 【bug】online样式，通用移动模板2一对多 -->
		<#else>
			<li id="${po.field_name}" class="clearfix " typ="name" reqd="1">
				<label class="desc">${po.content}:<#if po.is_null != 'Y'><span class="req">*</span></#if></label>
				<div class="content">
					<input type="text" maxlength="256" class="ui-input-text xl input fld" 
						name="${po.field_name}" id="${po.field_name}" ${po.extend_json?if_exists}
						value="${data['${tableName}']['${po.field_name}']?if_exists?html}" 
						<#if po.operationCodesReadOnly?exists> readonly = "readonly"</#if>
						<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
						<#if po.field_valid_type?if_exists?html != ''>
							datatype="${po.field_valid_type?if_exists?html}" 
							<#else>
								<#if po.type == 'int'>
									datatype="n"  <#if po.is_null == 'Y'>ignore="ignore" </#if>
									<#elseif po.type=='double'>
									datatype="/^(-?\d+)(\.\d+)?$/" <#if po.is_null == 'Y'>ignore="ignore" </#if>
									<#else>
									<#if po.is_null != 'Y'>datatype="*"</#if>
								</#if>
						</#if>/>
				</div>
			</li>
		<#-- update--end--author:taoyan Date:20170707 for:TASK #2918 【bug】online样式，通用移动模板2一对多 -->
	</#if>
</#list>