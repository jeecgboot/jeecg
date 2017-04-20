    
    
    <!-- tab内容 -->
    <div class="con-wrapper" id="con-wrapper${sub_index + 1}" style="display: none;">
	    <!-- <h4>分类标题</h4> -->
	    <div class="row">
	      <div class="col-md-12 layout-header">
	        <button id="addBtn_${sub}" type="button" class="btn btn-default">添加</button>
	        <button id="delBtn_${sub}" type="button" class="btn btn-default">删除</button>
	        <script type="text/javascript"> 
			$('#addBtn_${sub}').bind('click', function(){   
		 		 var tr =  $("#add_${sub}_table_template tr").clone();
			 	 $("#add_${sub}_table").append(tr);
			 	 resetTrNum('add_${sub}_table');
			 	 return false;
		    });  
			$('#delBtn_${sub}').bind('click', function(){   
		       $("#add_${sub}_table").find("input:checked").parent().parent().remove();   
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
	      </div>
	    </div>
	<div style="margin: 0 15px; background-color: white;">    
	    <!-- Table -->
      <table id="${sub}_table" class="table table-bordered table-hover" style="margin-bottom: 0;">
        <thead>
          <tr>
            <th style="white-space:nowrap;width:50px;">序号</th>
            <th style="white-space:nowrap;width:50px;">操作</th>
            <#list field['${sub}'].fieldList as subTableField >
            <th>${subTableField.content?if_exists?html}</th>
			</#list>
          </tr>
        </thead>
        <tbody id="add_${sub}_table">
          <#if data['${sub}']?exists&&(data['${sub}']?size>0) >
								<#list data['${sub}'] as subTableData >
									<tr>
									<th scope="row"><div name="xh"></div></th>
									<td>
										<input style="width:20px;" type="checkbox" name="ck"/>
										<input type="hidden" name="${sub}[${subTableData_index}].id" id="${sub}[${subTableData_index}].id" value="${subTableData['id']?if_exists?html}"/>
										<#list field['${sub}'].hiddenFieldList as subTableField >
										<input type="hidden" name="${sub}[${subTableData_index}].${subTableField.field_name}" id="${sub}[${subTableData_index}].${subTableField.field_name}" value="${subTableData['${subTableField.field_name}']?if_exists?html}"/>
										</#list> 
									</td>
									<#list field['${sub}'].fieldList as subTableField >
									<td>
									<#if subTableField.show_type=='text'>
										<input id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}" type="text"
										       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px" class="form-control" value="${subTableData['${subTableField.field_name}']?if_exists?html}"
								               nullmsg="请输入<@mutiLang langKey="${subTableField.content?if_exists?html}"/>！"
								               <#if subTableField.operationCodesReadOnly?exists> readonly = "readonly"</#if>
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
										<input id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}"  type="password"
										       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px" class="form-control" value="${subTableData['${subTableField.field_name}']?if_exists?html}"
								               nullmsg="请输入<@mutiLang langKey="${subTableField.content?if_exists?html}"/>！"
								                <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
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
											<#if subTableField.operationCodesReadOnly?if_exists>onclick="return false;"</#if>
											 <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
								<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
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
											 <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
								<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
											<#if dictdata_index==0&&subTableField.is_null != 'Y'>datatype="*"</#if>
											<#if subTableField.operationCodesReadOnly?if_exists>onclick="return false;"</#if>
											<#list checkboxlist as x >
											<#if dictdata.typecode?if_exists?html=="${x?if_exists?html}"> checked="true" </#if></#list>>
												${dictdata.typename?if_exists?html}
											</#list> 
										</@DictData>
								               
									<#elseif subTableField.show_type=='list'>
										<@DictData name="${subTableField.dict_field?if_exists?html}" text="${subTableField.dict_text?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
											<select id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} class="form-control" name="${sub}[${subTableData_index}].${subTableField.field_name}" 
											 <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
								<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
											<#if subTableField.operationCodesReadOnly?if_exists>onfocus="this.defOpt=this.selectedIndex" onchange="this.selectedIndex=this.defOpt;"</#if>
											<#if subTableField.is_null != 'Y'>datatype="*"</#if>>
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
										       style="background: url('${basePath}/plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px"  value="${subTableData['${subTableField.field_name}']?if_exists?html}"
										       class="form-control" onClick="WdatePicker({<#if subTableField.operationCodesReadOnly?if_exists> readonly = true</#if>})" 
								               nullmsg="请输入<@mutiLang langKey="${subTableField.content?if_exists?html}"/>！"
								                <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
												<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
												<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								               <#if subTableField.operationCodesReadOnly?exists> readonly = "readonly"</#if>
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
				               					<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if>>
									
									<#elseif subTableField.show_type=='datetime'>
										<input id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}" type="text"
										       style="background: url('${basePath}/plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px"  value="${subTableData['${subTableField.field_name}']?if_exists?html}"
										       class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'<#if subTableField.operationCodesReadOnly?if_exists> ,readonly = true</#if>})"
								               nullmsg="请输入<@mutiLang langKey="${subTableField.content?if_exists?html}"/>！"
								               	 <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
												<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
												<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								               <#if subTableField.operationCodesReadOnly?exists> readonly = "readonly"</#if>
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
				               					<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if>>
								               
									<#elseif subTableField.show_type=='popup'>
										<input id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}"  type="text"
										       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px" class="form-control searchbox-inputtext15" 
										       value="${subTableData['${subTableField.field_name}']?if_exists?html}"
								               nullmsg="请输入<@mutiLang langKey="${subTableField.content?if_exists?html}"/>！"
								                <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
												<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
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
									
									<#elseif subTableField.show_type=='file'>
										<input id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}" type="text"
										       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px" class="form-control" value="${subTableData['${subTableField.field_name}']?if_exists?html}"
								               nullmsg="请输入${subTableField.content}！"
								                <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
												<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
												<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
					          					<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if>>
								               
									<#else>
										<input id="${sub}[${subTableData_index}].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[${subTableData_index}].${subTableField.field_name}" type="text"
										       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px" class="form-control" value="${subTableData['${subTableField.field_name}']?if_exists?html}"
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
								</#list>
								<#else>
									<tr>
									<th scope="row"><div name="xh"></div></th>
									<td>
									<input style="width:20px;" type="checkbox" name="ck"/>
									<input type="hidden" name="${sub}[0].id" id="${sub}[0].id" />
									<#list field['${sub}'].hiddenFieldList as subTableField >
									<input type="hidden" name="${sub}[0].${subTableField.field_name}" id="${sub}[0].${subTableField.field_name}"/>
									</#list> 
									</td>
									<#list field['${sub}'].fieldList as subTableField >
									<td>
									<#if subTableField.show_type=='text'>
										<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" type="text"
										       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px" class="form-control"
								               nullmsg="请输入<@mutiLang langKey="${subTableField.content?if_exists?html}"/>！"
								                <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
												<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
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
										<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}"  type="password"
										       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px" class="form-control" 
								               nullmsg="请输入<@mutiLang langKey="${subTableField.content?if_exists?html}"/>！"
								               	 <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
												<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
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
											 <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
											<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
											<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
											<#if subTableField.operationCodesReadOnly?if_exists>onclick="return false;"</#if>
											<#if subTableField.is_null != 'Y'>datatype="*"</#if> >
												${dictdata.typename?if_exists?html}
											</#list> 
										</@DictData>
								               
									<#elseif subTableField.show_type=='checkbox'>
										<@DictData name="${subTableField.dict_field?if_exists?html}" text="${subTableField.dict_text?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
											<#list dataList as dictdata> 
											<input value="${dictdata.typecode?if_exists?html}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" type="checkbox" 
											 <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
											<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
											<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
											<#if subTableField.operationCodesReadOnly?if_exists>onclick="return false;"</#if>
											<#if subTableField.is_null != 'Y'>datatype="*"</#if>>
												${dictdata.typename?if_exists?html}
											</#list> 
										</@DictData>
								               
									<#elseif subTableField.show_type=='list'>
										<@DictData name="${subTableField.dict_field?if_exists?html}" text="${subTableField.dict_text?if_exists?html}" tablename="${subTableField.dict_table?if_exists?html}" var="dataList">
											<select id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} class="form-control" name="${sub}[0].${subTableField.field_name}" 
											 <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
											<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
											<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
											<#if subTableField.operationCodesReadOnly?if_exists>onfocus="this.defOpt=this.selectedIndex" onchange="this.selectedIndex=this.defOpt;"</#if>
											<#if subTableField.is_null != 'Y'>datatype="*"</#if> >
												<#list dataList as dictdata> 
												<option value="${dictdata.typecode?if_exists?html}" >
													${dictdata.typename?if_exists?html}
												</option> 
												</#list> 
											</select>
										</@DictData>
										
									<#elseif subTableField.show_type=='date'>
										<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" type="text"
										       style="background: url('${basePath}/plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px"  
										       class="form-control" onClick="WdatePicker({<#if subTableField.operationCodesReadOnly?if_exists> readonly = true</#if>})" 
								               nullmsg="请输入<@mutiLang langKey="${subTableField.content?if_exists?html}"/>！"
								                <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
												<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
												<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								               <#if subTableField.operationCodesReadOnly?exists> readonly = "readonly"</#if>
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
					               				<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if>>
									
									<#elseif subTableField.show_type=='datetime'>
										<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" type="text"
										       style="background: url('${basePath}/plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px"  
										       class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'<#if subTableField.operationCodesReadOnly?if_exists> ,readonly = true</#if>})"
								               nullmsg="请输入<@mutiLang langKey="${subTableField.content?if_exists?html}"/>！"
								                <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
											<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
											<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								               <#if subTableField.operationCodesReadOnly?exists> readonly = "readonly"</#if>
								               <#if subTableField.field_valid_type?if_exists?html != ''>
								               datatype="${subTableField.field_valid_type?if_exists?html}"
								               <#else>
					               				<#if subTableField.is_null != 'Y'>datatype="*"</#if>
								               </#if>>
								               
									<#elseif subTableField.show_type=='popup'>
										<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}"  type="text"
										       style="width: ${(subTableField.field_length==0)?string(150, subTableField.field_length)}px" class="form-control searchbox-inputtext15" 
								               nullmsg="请输入<@mutiLang langKey="${subTableField.content?if_exists?html}"/>！"
								                <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
											<#if subTableField.field_must_input?if_exists?html != ''><#if subTableField.field_must_input == 'Y' || subTableField.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
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
									
									<#elseif subTableField.show_type=='file'>
										<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" type="text"
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
								               
									<#else>
										<input id="${sub}[0].${subTableField.field_name}" ${subTableField.extend_json?if_exists} name="${sub}[0].${subTableField.field_name}" type="text"
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
								</#if>
        </tbody>
      </table>
	 </div>   
	    
	    
    </div>
    
    
    
					    
					