<#list columnsarea as po>
    <#if (columns?size>10)>
    <div class="row show-grid">
        <div class="col-xs-3 text-center"><b><@mutiLang langKey="${po.content?if_exists?html}"/>：</b></div>
        <div class="col-xs-3">
								<textarea id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}"  style="width: 600px" rows="6"
                                <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
                                    <#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
                                <#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
                                    <#if po.operationCodesReadOnly?if_exists> readonly = "readonly"</#if>
                                    <#if po.field_valid_type?if_exists?html != ''>
                                          datatype="${po.field_valid_type?if_exists?html}"
                                    <#else>
                                          <#if po.is_null != 'Y'>datatype="*"</#if>
                                    </#if>>${data['${tableName}']['${po.field_name}']?if_exists?html}</textarea>
            <span class="Validform_checktip"></span>
            <label class="Validform_label" style="display: none;"><@mutiLang langKey="${po.content?if_exists?html}"/></label>
            <#if po.show_type=='umeditor'>
                <script type="text/javascript">
                    //实例化编辑器
                    var ${po.field_name}_ue = UE.getEditor('${po.field_name}',{initialFrameWidth:${po.field_length}}).setHeight(260);
                </script>
            </#if>
        </div>
    </div>
    <#else>
    <div class="row show-grid">
        <div class="col-xs-3 text-center"><b><@mutiLang langKey="${po.content?if_exists?html}"/>：</b></div>
        <div class="col-xs-3">
							<textarea id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}"  rows="7" style="width:${po.field_length}px;"
                            <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
                                <#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
                            <#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
                                <#if po.operationCodesReadOnly?if_exists> readonly = "readonly"</#if>
                                <#if po.field_valid_type?if_exists?html != ''>
                                      datatype="${po.field_valid_type?if_exists?html}"
                                <#else>
                                      <#if po.is_null != 'Y'>datatype="*"</#if>
                                </#if>>${data['${tableName}']['${po.field_name}']?if_exists?html}</textarea>
            <span class="Validform_checktip"></span>
            <label class="Validform_label" style="display: none;"><@mutiLang langKey="${po.content?if_exists?html}"/></label>
            <#if po.show_type=='umeditor'>
                <script type="text/javascript">
                    //实例化编辑器
                    var ${po.field_name}_ue = UE.getEditor('${po.field_name}',{initialFrameWidth:${po.field_length}}).setHeight(260);
                </script>
            </#if>
        </div>
    </div>
    </#if>
</#list>