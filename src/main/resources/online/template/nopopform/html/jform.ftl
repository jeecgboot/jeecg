<#setting number_format="0.#####################">
<#-- update--begin--author:taoyan date:20180514 for:【Online表单】上传空间、树控件 宏封装 -->
<#include "online/template/ui/tag.ftl"/>
<#-- update--end--author:taoyan date:20180514 for:【Online表单】上传空间、树控件 宏封装 -->
<!DOCTYPE html>
<html>
 <head>
  <base href="${basePath}/"/>
  <title></title>
  ${config_iframe}
  <link rel="stylesheet" href="${basePath}/plug-in/easyui/themes/metrole/icon.css" type="text/css">
  <script src="${basePath}/plug-in/layer/layer.js"></script>
  <script type="text/javascript">
	function btn_ok(){
		$('#btn_sub').trigger('click');
	}
  </script>
 </head>
 <body>
  <#--update-start--Author:luobaoli  Date:20150614 for：表单单表属性中增加了扩展参数 ${po.extend_json?if_exists}-->
  <form id="formobj" action="cgFormBuildController.do?saveOrUpdate" name="formobj" method="post">
			<input type="hidden" id="btn_sub" class="btn_sub"/>
			<input type="hidden" name="tableName" value="${tableName?if_exists?html}" >
			<input type="hidden" name="id" value="${id?if_exists?html}" >
			<#list columnhidden as po>
			  <input type="hidden" id="${po.field_name}" name="${po.field_name}" value="${data['${tableName}']['${po.field_name}']?if_exists?html}" >
			</#list>
			<table cellpadding="0" cellspacing="1" class="formtable">
			   <#list columns as po>
			    <#if (columns?size>10)>
					<#if po_index%2==0>
					<tr>
					</#if>
				<#else>
					<tr>
				</#if>
					<td align="right" >
						<label class="Validform_label">
							${po.content}:
						</label>
					</td>
					<td class="value">
						<#--update-begin--Author:钟世云  Date:20150610 for：online支持树配置-->
						<#if head.isTree=='Y' && head.treeParentIdFieldName==po.field_name>
							<!--如果为树形菜单，父id输入框设置为select-->
							<input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" type="text"
							       style="width: 150px" class="inputxt easyui-combotree" value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
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
				               data-options="
				                    panelHeight:'220',
				                    url: 'cgAutoListController.do?datagrid&configId=${tableName?if_exists?html}&field=id,${head.treeFieldname}',  
				                    loadFilter: function(data) {
				                    	var rows = data.rows || data;
				                    	var win = frameElement.api.opener;
				                    	var listRows = win.getDataGrid().treegrid('getData');
				                    	joinTreeChildren(rows, listRows);
				                    	convertTreeData(rows, '${head.treeFieldname}');
				                    	return rows; 
				                    },
				                    onLoadSuccess: function() {
				                    	var win = frameElement.api.opener;
				                    	var currRow = win.getDataGrid().treegrid('getSelected');
				                    	if(!'${id?if_exists?html}') {
				                    		//增加时，选择当前父菜单
				                    		if(currRow) {
				                    			$('#${po.field_name}').combotree('setValue', currRow.id);
				                    		}
				                    	}else {
				                    		//编辑时，选择当前父菜单
				                    		if(currRow) {
				                    			$('#${po.field_name}').combotree('setValue', currRow._parentId);
				                    		}
				                    	}
				                    }
				            ">
				        <#--update-end--Author:钟世云  Date:20150610 for：online支持树配置-->
						<#elseif po.show_type=='text'>
							<input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" type="text"
							       style="width: 150px" class="inputxt" value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
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
					               </#if>>
						<#elseif po.show_type=='password'>
							<input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}"  type="password"
							       style="width: 150px" class="inputxt" value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
					               <#if po.operationCodesReadOnly?if_exists> readonly = "readonly"</#if>
					               <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
						       <#if po.field_valid_type?if_exists?html != ''>
					               datatype="${po.field_valid_type?if_exists?html}"
					               <#else>
					               <#if po.is_null != 'Y'>datatype="*"</#if>
					               </#if>>
						
						<#elseif po.show_type=='radio'>
					        <@DictData name="${po.dict_field?if_exists?html}" text="${po.dict_text?if_exists?html}" tablename="${po.dict_table?if_exists?html}" var="dataList">
								<#list dataList as dictdata> 
								<input value="${dictdata.typecode?if_exists?html}" ${po.extend_json?if_exists} name="${po.field_name}" type="radio"
					            <#if dictdata_index==0&&po.is_null != 'Y'>datatype="*"</#if> 
								<#if po.operationCodesReadOnly?if_exists>onclick="return false;"</#if>
								<#if dictdata.typecode?if_exists?html=="${data['${tableName}']['${po.field_name}']?if_exists?html}"> checked="true" </#if>>
									${dictdata.typename?if_exists?html}
								</#list> 
							</@DictData>
					               
						<#elseif po.show_type=='checkbox'>
							<#assign checkboxstr>${data['${tableName}']['${po.field_name}']?if_exists?html}</#assign>
							<#assign checkboxlist=checkboxstr?split(",")>
							<@DictData name="${po.dict_field?if_exists?html}" text="${po.dict_text?if_exists?html}" tablename="${po.dict_table?if_exists?html}" var="dataList">
								<#list dataList as dictdata> 
								<input value="${dictdata.typecode?if_exists?html}" ${po.extend_json?if_exists} name="${po.field_name}" type="checkbox"
								<#if po.operationCodesReadOnly?if_exists>onclick="return false;"</#if>
					            <#if dictdata_index==0&&po.is_null != 'Y'>datatype="*"</#if> 
								<#list checkboxlist as x >
								<#if dictdata.typecode?if_exists?html=="${x?if_exists?html}"> checked="true" </#if></#list>>
									${dictdata.typename?if_exists?html}
								</#list> 
							</@DictData>
					               
						<#elseif po.show_type=='list'>
							<@DictData name="${po.dict_field?if_exists?html}" text="${po.dict_text?if_exists?html}" tablename="${po.dict_table?if_exists?html}" var="dataList">
								<select id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" <#if po.operationCodesReadOnly?if_exists>onfocus="this.defOpt=this.selectedIndex" onchange="this.selectedIndex=this.defOpt;"</#if>
								<#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								<#if po.is_null != 'Y'>datatype="*"</#if> >
									<#list dataList as dictdata> 
									<option value="${dictdata.typecode?if_exists?html}" 
									<#if dictdata.typecode?if_exists?html=="${data['${tableName}']['${po.field_name}']?if_exists?html}"> selected="selected" </#if>>
										${dictdata.typename?if_exists?html}
									</option> 
									</#list> 
								</select>
							</@DictData>
							
						<#elseif po.show_type=='date'>
							<input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" type="text"
							       style="width: 150px"  value="<#if data['${tableName}']['${po.field_name}']??>${data['${tableName}']['${po.field_name}']?if_exists?string("yyyy-MM-dd")}</#if>"
							       class="Wdate" onClick="WdatePicker({<#if po.operationCodesReadOnly?if_exists> readonly = true</#if>})" 
					              <#if po.operationCodesReadOnly?exists> readonly = "readonly"</#if>
					              <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
						       <#if po.field_valid_type?if_exists?html != ''>
					               datatype="${po.field_valid_type?if_exists?html}"
					               <#else>
					               <#if po.is_null != 'Y'>datatype="*"</#if> 
					               </#if>>
						
						<#elseif po.show_type=='datetime'>
							<input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" type="text"
							       style="width: 150px"  value="<#if data['${tableName}']['${po.field_name}']??>${data['${tableName}']['${po.field_name}']?if_exists?string("yyyy-MM-dd HH:mm:ss")}</#if>"
							       class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'<#if po.operationCodesReadOnly?if_exists> ,readonly = true</#if>})"
						         <#if po.operationCodesReadOnly?exists> readonly = "readonly"</#if>
						         <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
						       <#if po.field_valid_type?if_exists?html != ''>
					               datatype="${po.field_valid_type?if_exists?html}"
					               <#else>
					               <#if po.is_null != 'Y'>datatype="*"</#if> 
					               </#if>>
						
						<#elseif po.show_type=='popup'>
							<input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}"  type="text"
							       style="width: 150px" class="searchbox-inputtext" 
							       onClick="inputClick(this,'${po.dict_text?if_exists?html}','${po.dict_table?if_exists?html}');" 
							       value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
					               <#if po.operationCodesReadOnly?if_exists> readonly = "readonly"</#if>
					               <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
						       <#if po.field_valid_type?if_exists?html != ''>
					               datatype="${po.field_valid_type?if_exists?html}"
					               <#else>
					               <#if po.is_null != 'Y'>datatype="*"</#if>
					               </#if>>
					               
						    <#-- update--begin--author:taoyan date:20180514 for:【Online表单】上传空间、树控件 宏封装 -->
							<#elseif po.show_type=='file' || po.show_type=='image'>
								<@uploadtag po = po />
							<#-- update--end--author:taoyan date:20180514 for:【Online表单】上传空间、树控件 宏封装 -->
								
							<#--update-start--Author: jg_huangxg  Date:20160505 for：TASK #1027 【online】代码生成器模板不支持UE编辑器 -->
							<#elseif po.show_type=='umeditor'>
								<script id="content" type="text/plain" style="width:99%;"></script>
								
								<script type="text/javascript"  charset="utf-8" src="${basePath}/plug-in/ueditor/ueditor.config.js"></script>
								<script type="text/javascript"  charset="utf-8" src="${basePath}/plug-in/ueditor/ueditor.all.min.js"></script>
								<script type="text/javascript">
								var leipiEditor = UE.getEditor('content',{
								    //allowDivTransToP: false,//阻止转换div 为p
								    toolleipi:true,//是否显示，设计器的 toolbars
								    textarea: 'design_content',   
								    //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个            /*
								    toolbars: [[
								    'fullscreen', 'source', '|', 'undo', 'redo', '|',//'date', 'time',
								    'fontfamily', 'fontsize', '|', 'indent', '|',
								    //'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',
								    //'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
								    //'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|',
								    //'directionalityltr', 'directionalityrtl', 'indent', '|',
								    'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', //'touppercase', 'tolowercase', '|',
								    //'link', 'unlink', 'anchor', '|', 'imagenone', 'imageleft', 'imageright', 'imagecenter', '|',
								    //'simpleupload', 'insertimage', 'emotion', 'scrawl', 'insertvideo', 'music', 'attachment', 'map',  'insertframe', 'insertcode', 'webapp', 'pagebreak', 'template', 'background', '|',
								    //'horizontal',  'spechars', 'snapscreen', 'wordimage', '|',
								    'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', '|',
								    //'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols', '|',//'charts', '|',
								    //'print', 'preview', 'searchreplace', 'help', 'drafts'
								    ]],
								    wordCount:false,
								    elementPathEnabled:false,
								    initialFrameHeight:400
								});
								
								var leipiFormDesign = {
									   exec : function (method) {
									        leipiEditor.execCommand(method);
									    },
									   parse_form:function(template,fields)
									    {
										 //正则  radios|checkboxs|select 匹配的边界 |--|  因为当使用 {} 时js报错 (plugins|fieldname|fieldflow)
									        var preg =  /(\|-<span(((?!<span).)*plugins=\"(radios|checkboxs|select)\".*?)>(.*?)<\/span>-\||<(img|input|textarea|select).*?(<\/select>|<\/textarea>|\/>))/gi,preg_attr =/(\w+)=\"(.?|.+?)\"/gi,preg_group =/<input.*?\/>/gi;
									        if(!fields) fields = 0;
								
									        var template_parse = template,template_data = new Array(),add_fields=new Object(),checkboxs=0;
								
									        var pno = 0;
									        template.replace(preg, function(plugin,p1,p2,p3,p4,p5,p6){
									            var parse_attr = new Array(),attr_arr_all = new Object(),name = '', select_dot = '' , is_new=false;
									            var p0 = plugin;
									            var tag = p6 ? p6 : p4;
									            //alert(tag + " \n- t1 - "+p1 +" \n-2- " +p2+" \n-3- " +p3+" \n-4- " +p4+" \n-5- " +p5+" \n-6- " +p6);
								
									            if(tag == 'radios' || tag == 'checkboxs')
									            {
									                plugin = p2;
									            }else if(tag == 'select')
									            {
									                plugin = plugin.replace('|-','');
									                plugin = plugin.replace('-|','');
									            }
									            plugin.replace(preg_attr, function(str0,attr,val) {
									                if(attr=='name')
									                {
									                    if(val=='NEWFIELD')
									                    {
									                        is_new=true;
									                        fields++;
									                        val = 'data_'+fields;
									                    }
									                    name = val;
									                }
								
									                if(tag=='select' && attr=='value')
									                {
									                    if(!attr_arr_all[attr]) attr_arr_all[attr] = '';
									                    attr_arr_all[attr] += select_dot + val;
									                    select_dot = ',';
									                }else
									                {
									                    attr_arr_all[attr] = val;
									                }
									                var oField = new Object();
									                oField[attr] = val;
									                parse_attr.push(oField);
									            })
									            /*alert(JSON.stringify(parse_attr));return;*/
									            if(tag =='checkboxs') /*复选组  多个字段 */
									            {
									                plugin = p0;
									                plugin = plugin.replace('|-','');
									                plugin = plugin.replace('-|','');
									                var name = 'checkboxs_'+checkboxs;
									                attr_arr_all['parse_name'] = name;
									                attr_arr_all['name'] = '';
									                attr_arr_all['value'] = '';
								
									                attr_arr_all['content'] = '<span leipiplugins="checkboxs" selector="'+attr_arr_all['selector']+'"   autofield="'+attr_arr_all['autofield']+'" title="'+attr_arr_all['title']+'">';
									                var dot_name ='', dot_value = '';
									                p5.replace(preg_group, function(parse_group) {
									                    var is_new=false,option = new Object();
									                    parse_group.replace(preg_attr, function(str0,k,val) {
									                        if(k=='name')
									                        {
									                        	if(val=='NEWFIELD')
									                            {
									                                is_new=true;
									                                fields++;
									                                val = 'data_'+fields;
									                            }
								
									                            attr_arr_all['name'] += dot_name + val;
									                            dot_name = ',';
								
									                        }
									                        else if(k=='value')
									                        {
									                            attr_arr_all['value'] += dot_value + val;
									                            dot_value = ',';
								
									                        }
									                        option[k] = val;
									                    });
								
									                    if(!attr_arr_all['options']) attr_arr_all['options'] = new Array();
									                    attr_arr_all['options'].push(option);
									                    if(!option['checked']) option['checked'] = '';
									                    var checked = option['checked'] ? 'checked="checked"' : '';
														var checkedtext=option['checkedtext'] ? option['checkedtext'] :option['value'];
									                    attr_arr_all['content'] +='<input type="checkbox" name="'+option['name']+'" checkedtext="'+checkedtext+'"   value="'+option['value']+'" fieldname="' + attr_arr_all['fieldname'] + option['fieldname'] + '" fieldflow="' + attr_arr_all['fieldflow'] + '" '+checked+'/>'+checkedtext+'&nbsp;';
								
									                    if(is_new)
									                    {
									                        var arr = new Object();
									                        arr['name'] = option['name'];
									                        arr['plugins'] = attr_arr_all['plugins'];
									                        arr['fieldname'] = attr_arr_all['fieldname'] + option['fieldname'];
									                        arr['fieldflow'] = attr_arr_all['fieldflow'];
									                        add_fields[option['name']] = arr;
									                    }
								
									                });
									                attr_arr_all['content'] += '</span>';
								
									                //parse
									                template = template.replace(plugin,attr_arr_all['content']);
									                template_parse = template_parse.replace(plugin,'{'+name+'}');
									                template_parse = template_parse.replace('{|-','');
									                template_parse = template_parse.replace('-|}','');
									                template_data[pno] = attr_arr_all;
									                checkboxs++;
								
									            }else if(name)
									            {
									                if(tag =='radios') /*单选组  一个字段*/
									                {
									                    plugin = p0;
									                    plugin = plugin.replace('|-','');
									                    plugin = plugin.replace('-|','');
									                    attr_arr_all['value'] = '';
									                    attr_arr_all['content'] = '<span leipiplugins="radios" selector="'+attr_arr_all['selector']+'"   name="'+attr_arr_all['name']+'" autofield="'+attr_arr_all['autofield']+'" title="'+attr_arr_all['title']+'">';
									                    var dot='';
									                    p5.replace(preg_group, function(parse_group) {
									                        var option = new Object();
									                        parse_group.replace(preg_attr, function(str0,k,val) {
									                            if(k=='value')
									                            {
									                                attr_arr_all['value'] += dot + val;
									                                dot = ',';
									                            }
									                            option[k] = val;
									                        });
									                        option['name'] = attr_arr_all['name'];
									                        if(!attr_arr_all['options']) attr_arr_all['options'] = new Array();
									                        attr_arr_all['options'].push(option);
									                        if(!option['checked']) option['checked'] = '';
									                        var checked = option['checked'] ? 'checked="checked"' : '';
															var checkedtext=option['checkedtext'] ? option['checkedtext'] :option['value'];
									                        attr_arr_all['content'] +='<input type="radio" name="'+attr_arr_all['name']+'" checkedtext="'+checkedtext+'"  value="'+option['value']+'"  '+checked+'/>'+checkedtext+'&nbsp;';
								
									                    });
									                    attr_arr_all['content'] += '</span>';
								
									                }else
									                {
									                    attr_arr_all['content'] = is_new ? plugin.replace(/NEWFIELD/,name) : plugin;
									                }
									                //attr_arr_all['itemid'] = fields;
									                //attr_arr_all['tag'] = tag;
									                template = template.replace(plugin,attr_arr_all['content']);
									                template_parse = template_parse.replace(plugin,'{'+name+'}');
									                template_parse = template_parse.replace('{|-','');
									                template_parse = template_parse.replace('-|}','');
									                if(is_new)
									                {
									                    var arr = new Object();
									                    arr['name'] = name;
									                    arr['plugins'] = attr_arr_all['plugins'];
									                    arr['title'] = attr_arr_all['title'];
									                    arr['orgtype'] = attr_arr_all['orgtype'];
									                    arr['fieldname'] = attr_arr_all['fieldname'];
									                    arr['fieldflow'] = attr_arr_all['fieldflow'];
									                    add_fields[arr['name']] = arr;
									                }
									                template_data[pno] = attr_arr_all;
								
								
									            }
									            pno++;
									        })
									        var view = template.replace(/{\|-/g,'');
									        view = view.replace(/-\|}/g,'');
									        var parse_form = new Object({
									            'fields':fields,//总字段数
									            'template':template,//完整html
									            'parse':view,
									            'data':template_data,//控件属性
									            'add_fields':add_fields//新增控件
									        });
									        return JSON.stringify(parse_form);
									    },
									    /*type  =  save 保存设计 versions 保存版本  close关闭 */
									    fnCheckForm : function ( type ) {
									        if(formEditor.queryCommandState( 'source' ))
									            formEditor.execCommand('source');//切换到编辑模式才提交，否则有bug
								
									        if(formEditor.hasContents()){
									            formEditor.sync();/*同步内容*/
								
									            //--------------以下仅参考-----------------------------------------------------------------------------------------------------
									            var type_value='',formid=0,fields=$("#fields").val(),formeditor='';
								
									            if( typeof type!=='undefined' ){
									                type_value = type;
									            }
									            //获取表单设计器里的内容
									            formeditor=formEditor.getContent();
									            //解析表单设计器控件
									            var parse_form = this.parse_form(formeditor,fields);
									            //alert(parse_form);
									            //异步提交数据
									            $.ajax({
									                type: 'POST',
									                url : '${ctx}/config/form/processor',
									                //dataType : 'json',
									                data : {'type' : type_value,'formid':'${form.id}','parse_form':parse_form},
									                success : function(data){
														if(data == true) {
															alert('表单保存成功');
															window.location.href='${ctx}/config/form';
														} else {
															alert('表单保存失败');
														}
									                }
									            });
								
									        } else {
									            alert('表单内容不能为空！')
									            $('#submitbtn').button('reset');
									            return false;
									        }
									    } ,
									   // 预览表单
									    fnReview : function (){
									    	if(leipiEditor.queryCommandState( 'source' ))
									            leipiEditor.execCommand('source');
									            
									        if(leipiEditor.hasContents()){
									            leipiEditor.sync();       
									         	
									           var parse_form = this.parse_form(leipiEditor.getContent());
									           $("#formContent").val(parse_form);
									           
									            document.formobj.target="mywin";
									            window.open('','mywin',"menubar=0,toolbar=0,status=0,resizable=1,left=0,top=0,scrollbars=1,width=" +(screen.availWidth-10) + ",height=" + (screen.availHeight-50) + "\"");
								
									            document.formobj.action="autoFormController.do?review";
									            document.formobj.submit(); //提交表单
									           
									        } else {
									            alert('表单内容不能为空！');
									            return false;
									        }
									    }
									};
									function setContent(){
									    if(leipiEditor.queryCommandState( 'source' ))
									            leipiEditor.execCommand('source');//切换到编辑模式才提交，否则有bug
									            
									    if(leipiEditor.hasContents()){
									        leipiEditor.sync();
										    $("#formContent").val(leipiEditor.getContent());
										}
									}
								</script>
							<#--update-end--Author: jg_huangxg  Date:20160505 for：TASK #1027 【online】代码生成器模板不支持UE编辑器 -->
						<#else>
							<input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" type="text"
							       style="width: 150px" class="inputxt" value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
					               <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
					               <#if po.field_valid_type?if_exists?html != ''>
					               datatype="${po.field_valid_type?if_exists?html}"
					               <#else>
					               <#if po.type == 'int'>
					               datatype="n" 
					               <#elseif po.type=='double'>
					               datatype="/^(-?\d+)(\.\d+)?$/" 
					               <#else>
					               <#if po.is_null != 'Y'>datatype="*"</#if>
					               </#if>
					               </#if>>

						</#if>
						<#-- update--begin--author:jiaqiankun Date:20180628 for:TASK #2849 【样式】online开发所有的老的上传，控件高宽改小些 -->
							<span class="Validform_checktip" style="float:left;height:0px;"></span>
					    <#-- update--end--author:jiaqiankun Date:20180628 for:TASK #2849 【样式】online开发所有的老的上传，控件高宽改小些  -->
						<label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
					</td>
				<#if (columns?size>10)>
					<#if (po_index%2==0)&&(!po_has_next)>
					<td align="right">
						<label class="Validform_label">
						</label>
					</td>
					<td class="value">
					</td>
					</#if>
					<#if (po_index%2!=0)||(!po_has_next)>
						</tr>
					</#if>
				<#else>
					</tr>
				</#if>
			  </#list>
			  
			  <#list columnsarea as po>
			  <#if (columns?size>10)>
			  	<tr>
					<td align="right">
						<label class="Validform_label">
							${po.content}:
						</label>
					</td>
					<td class="value" colspan="3">
						<textarea id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" 
						       style="width: 600px" class="inputxt" rows="6"
						<#if po.operationCodesReadOnly?if_exists> readonly = "readonly"</#if>
						<#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
				               <#if po.field_valid_type?if_exists?html != ''>
				               datatype="${po.field_valid_type?if_exists?html}"
				               <#else>
				               <#if po.is_null != 'Y'>datatype="*"</#if> 
				               </#if>>${data['${tableName}']['${po.field_name}']?if_exists?html}</textarea>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
						<#if po.show_type=='umeditor'>
						<script type="text/javascript">
					    //实例化编辑器
					    var ${po.field_name}_ue = UE.getEditor('${po.field_name}',{initialFrameWidth:${po.field_length}}).setHeight(260);
					    </script>
					    </#if>
					</td>
				</tr>
				<#else>
					<tr>
					<td align="right">
						<label class="Validform_label">
							${po.content}:
						</label>
					</td>
					<td class="value">
						<textarea id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" 
						        class="inputxt" rows="7"
						<#if po.operationCodesReadOnly?if_exists> readonly = "readonly"</#if>
						<#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
				               <#if po.field_valid_type?if_exists?html != ''>
				               datatype="${po.field_valid_type?if_exists?html}"
				               <#else>
				               <#if po.is_null != 'Y'>datatype="*"</#if> 
				               </#if>>${data['${tableName}']['${po.field_name}']?if_exists?html}</textarea>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
						<#if po.show_type=='umeditor'>
						<script type="text/javascript">
					    //实例化编辑器
					    var ${po.field_name}_ue = UE.getEditor('${po.field_name}',{initialFrameWidth:${po.field_length}}).setHeight(260);
					    </script>
					    </#if>
					</td>
				</tr>
				</#if>
			  </#list>
			  <tr>
						<td height="50px" align="center" colspan="2">
								<#--update-begin--Author:gj_shaojc  Date:20180410 for：TASK #2626 【online】单表，非弹框表单样式，新增页面，点击返回按钮，连接跳转出错-->
								<a  style="margin-left:80px" href="javascript:history.go(-1)" class="easyui-linkbutton l-btn"  plain="true" iconcls="icon-le-back"> 返 回&nbsp; </a>
								<#--update-end--Author:gj_shaojc  Date:20180410 for：TASK #2626 【online】单表，非弹框表单样式，新增页面，点击返回按钮，连接跳转出错-->
								<a  id="btn_ok" href="javascript:void(0)" class="easyui-linkbutton l-btn"  plain="true" iconcls="icon-le-ok" onclick="btn_ok()"> 提 交 &nbsp;</a>
						</td>
				</tr>
		
			</table>
			<script type="text/javascript">
				$(function(){
				      $("#formobj").Validform(
				      {
				                  tiptype:1,
				                  btnSubmit:"#btn_sub",
				                  btnReset:"#btn_reset",
				                  ajaxPost:true,
				                  usePlugin:{
				                        passwordstrength:{
				                           minLen:6,
				                           maxLen:18,
				                           trigger:function(obj,error){
				                                if(error){
				                                    obj.parent().next().find(".Validform_checktip").show();
				                                    obj.find(".passwordStrength").hide();
				                                }else{
				                                    $(".passwordStrength").show();
				                                    obj.parent().next().find(".Validform_checktip").hide();
				                                }
				                            }
				                        }
				                   },
				                   callback:function(data){
				                           if(data.success==true){
				                              uploadFile(data);
				                              layer.alert(data.msg, function(index){
														window.location.href='${basePath}/cgAutoListController.do?list&id=${tableName?if_exists?html}';
														layer.close(index);	})
				
				                            }
				                            else{
				                               if(data.responseText==''||data.responseText==undefined){
				                                      $.messager.alert('错误', data.msg);
				                                      $.Hidemsg();
				                               }else{
				                                      try{
				                                          var emsg = data.responseText.substring(data.responseText.indexOf('错误描述'),data.responseText.indexOf('错误信息')); 
				                                          $.messager.alert('错误',emsg);
				                                          $.Hidemsg();
				                                       }catch(ex){
				                                          $.messager.alert('错误',data.responseText+'');
				                                       }}
				                               return false;
				                           }
				                          }});});</script>
	</form>
	<#--update-end--Author:luobaoli  Date:20150614 for：表单单表属性中增加了扩展参数 ${po.extend_json?if_exists}-->
<script type="text/javascript">
   $(function(){
    //查看模式情况下,删除和上传附件功能禁止使用
	if(location.href.indexOf("goDetail.do")!=-1){
		$(".jeecgDetail").hide();
	}
	
	if(location.href.indexOf("goDetail.do")!=-1){
		//查看模式控件禁用
		$("#formobj").find(":input").attr("disabled","disabled");
	}
	if(location.href.indexOf("goAddButton.do")!=-1||location.href.indexOf("goUpdateButton.do")!=-1){
		//其他模式显示提交按钮
		$("#sub_tr").show();
	}
   });
  function upload() {
  	<#list columns as po>
  		<#if po.show_type=='file'>
  		$('#${po.field_name}').uploadify('upload', '*');		
  		</#if>
  		<#if po.show_type=='image'>
  		$('#${po.field_name}').uploadify('upload', '*');		
  		</#if>
  	</#list>
  }
  function cancel() {
  	<#list columns as po>
  		<#if po.show_type=='file'>
 	 $('#${po.field_name}').uploadify('cancel', '*');
 	 	</#if>
 	 	<#if po.show_type=='image'>
 	 $('#${po.field_name}').uploadify('cancel', '*');
 	 	</#if>
  	</#list>
  }
  function uploadFile(data){
  		if(!$("input[name='id']").val()){
  			if(data.obj!=null && data.obj!='undefined'){
  				$("input[name='id']").val(data.obj.id);
  			}
  		}
  		if($(".uploadify-queue-item").length>0){
  			upload();
  		}else{
	  		/*var win = frameElement.api.opener;
			win.reloadTable();
			win.tip(data.msg);
			frameElement.api.close();*/
  		} 
  	}
	//update-begin-author：taoYan date:20180519 for:弹出层z-index不足被遮住--
	function del(url,obj){
		$.dialog.setting.zIndex = getzIndex();
	//update-end-author：taoYan date:20180519 for:弹出层z-index不足被遮住--
		$.dialog.confirm("确认删除该条记录?", function(){
		  	$.ajax({
				async : false,
				cache : false,
				type : 'POST',
				url : url,// 请求的action路径
				error : function() {// 请求失败处理函数
				},
				success : function(data) {
					var d = $.parseJSON(data);
					if (d.success) {
						var msg = d.msg;
						tip(msg);
						$(obj).closest("tr").hide("slow");
					}
				}
			});  
		}, function(){
	});
}

<#--add-start--Author:钟世云  Date:20150614 for：online支持树配置-->
/**树形列表数据转换**/
function convertTreeData(rows, textField) {
    for(var i = 0; i < rows.length; i++) {
        var row = rows[i];
        row.text = row[textField];
        if(row.children) {
        	row.state = "open";
            convertTreeData(row.children, textField);
        }
    }
}
/**树形列表加入子元素**/
function joinTreeChildren(arr1, arr2) {
    for(var i = 0; i < arr1.length; i++) {
        var row1 = arr1[i];
        for(var j = 0; j < arr2.length; j++) {
            if(row1.id == arr2[j].id) {
                var children = arr2[j].children;
                if(children) {
                    row1.children = children;
                }
                
            }
        }
    }
}
<#--add-end--Author:钟世云  Date:20150614 for：online支持树配置-->
</script>
	<script type="text/javascript">${js_plug_in?if_exists}</script>		
 </body>
</html>