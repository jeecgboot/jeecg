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
							value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
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
						value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
						onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'<#if po.operationCodesReadOnly?if_exists> readonly = true</#if>})" 
						<#if po.operationCodesReadOnly?exists> readonly = "readonly"</#if>
						<#if po.field_valid_type?if_exists?html != ''>
							datatype="${po.field_valid_type?if_exists?html}" 
							<#else>
								<#if po.is_null != 'Y'>datatype="*"</#if>
						</#if>
					/>
				</div>
			</li>
	</#if>
</#list>