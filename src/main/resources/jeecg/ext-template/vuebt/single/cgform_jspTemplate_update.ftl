<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<#include "../../ui/datatype.ftl"/>
<#include "../../ui/dictInfo.ftl"/>
<html>
<head>
	<title>${ftl_description}</title>
    <meta charset="UTF-8"></meta>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"></meta>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport"></meta>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="https://cdn.bootcss.com/bootstrap-table/1.12.1/bootstrap-table.min.css" rel="stylesheet"/>
    <link href="plug-in/vue-BootstrapTable/css/common.min.css" rel="stylesheet" />
    <link href="plug-in/vue-BootstrapTable/css/style.min.css" rel="stylesheet" />
</head>
<body>
	<div id="dpLTE" class="container-fluid" v-cloak>
		<table class="form" id="form">
			 <#assign hasDate = false>
			 <#assign hasDateTime = false>
			 <#list pageColumns as po>
			 	<#if po_index%2==0>
				<tr>
				</#if>
				<td class="formTitle">${po.content}</td>
	            <td class="formValue">
	            	<#if po.showType=='textarea'>
	            		<textarea class="form-control" rows="6" v-model="${entityName?uncap_first}.${po.fieldName}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"/>></textarea>
	            	<#elseif po.showType=='text'>
						<input type="text" class="form-control" maxlength="${po.length?c}" v-model="${entityName?uncap_first}.${po.fieldName}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" tableName="${po.table.tableName}" fieldName="${po.oldFieldName}"/> />
	            	<#elseif po.showType=='password'>
	            		<input type="password" maxlength="${po.length?c}" v-model="${entityName?uncap_first}.${po.fieldName}" class="form-control"<@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"/>/>
	            	<#elseif po.showType=='radio'>
	            		<label class="radio-inline">
							<input type="radio" name="${po.fieldName}" v-model="${entityName?uncap_first}.${po.fieldName}" <@datatype inputCheck="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> <@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" />/> ${po.content}
						</label>
	            	<#elseif po.showType=='select' || po.showType=='list'>
	            		<select name="${po.fieldName}" v-model="${entityName?uncap_first}.${po.fieldName}" <@datatype inputCheck="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>>
	            			<option>请选择</option>
	            		</select>
	            	<#elseif po.showType=='checkbox'>
	            		<label class="checkbox-inline">
							<input type="checkbox" name="${po.fieldName}" v-model="${entityName?uncap_first}.${po.fieldName}" <@datatype inputCheck="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> />
						</label>
	            	<#elseif po.showType=='date'>
	            		<#assign hasDate = true>
						<input name="${po.fieldName}" type="text"  class="form-control laydate-date" v-model="${entityName?uncap_first}.${po.fieldName}" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> />
					<#elseif po.showType=='datetime'>
						<#assign hasDateTime = true>
						<input name="${po.fieldName}" type="text"  class="form-control laydate-datetime" v-model="${entityName?uncap_first}.${po.fieldName}" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> />
	            	<#else>
						<input type="text" class="form-control" maxlength="${po.length?c}" v-model="${entityName?uncap_first}.${po.fieldName}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" tableName="${po.table.tableName}" fieldName="${po.oldFieldName}"/> />
	            	</#if>
	            </td>
	            <#if po_index%2!=0>
				</tr>
				</#if>
			 </#list>
		</table>
	</div>
</body>
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdn.bootcss.com/layer/3.1.0/layer.js"></script>
<script src="https://cdn.bootcss.com/vue/2.5.17-beta.0/vue.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap-table/1.12.1/bootstrap-table.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap-table/1.12.1/locale/bootstrap-table-zh-CN.min.js"></script>
<script src="plug-in/Validform/js/Validform_v5.3.1_min_zh-cn.js"></script>
<script src="plug-in/Validform/js/Validform_Datatype_zh-cn.js"></script>
<script src="plug-in/Validform/js/datatype_zh-cn.js"></script>
<script src="plug-in/lhgDialog/lhgdialog.min.js?skin=metrole"></script>
<script src="plug-in/laydate/laydate.js"></script>
<script src="plug-in/vue-BootstrapTable/js/common.js"></script>
<script src="plug-in/vue-BootstrapTable/js/form.js"></script>
<script>
var valid=null;
$(function(){
	valid=$("#form").Validform({
		tiptype:function(msg,o,cssctl){
			if(o.type==3){
				ValidationMessage(o.obj,msg);
			}else{
				removeMessage(o.obj);
			}
		}
    });
	<#if hasDateTime>
		$(".laydate-datetime").each(function(){
			laydate.render({
			  elem: this,
			  format: 'yyyy-MM-dd HH:mm:ss',
			  done: function(value, date, endDate){
				  $(this.elem).each(function(){
					  vm.${entityName?uncap_first}[this.name]=this.value;
				  });
			  }
			});
		});
	</#if>
	<#if hasDate>
		$(".laydate-date").each(function(){
			laydate.render({
			  elem: this,
			  done: function(value, date, endDate){
				  $(this.elem).each(function(){
					  vm.${entityName?uncap_first}[this.name]=this.value;
				  });
			  }
			});
		});
	</#if>
	
});
var vm = new Vue({
	el:'#dpLTE',
	data: {
		${entityName?uncap_first}:{
			id:null,
			<#list pageColumns as po>
			${po.fieldName}:null,
			</#list>
		}
	},
	methods : {
		setForm: function(id) {
			vm.${entityName?uncap_first}.id=id;
			$.SetForm({
				url: '${entityName?uncap_first}Controller.do?getById',
		    	param: {
		    		id: vm.${entityName?uncap_first}.id
		    	},
		    	success: function(e) {
		    		var data=e.obj;
		    		vm.${entityName?uncap_first} = {
		    				id:data.id,
		    				<#list pageColumns as po>
							${po.fieldName}:data.${po.fieldName},
							</#list>
		    		};
		    	}
			});
		},
		acceptClick: function() {
	        if (!valid.check()) {
	            return false;
	        }
		    $.ConfirmForm({
		    	url: '${entityName?uncap_first}Controller.do?doUpdate',
		    	param: vm.${entityName?uncap_first},
		    	success: function(){
		    		frameElement.api.opener.vm.load();
		    	}
		    });
		}
	}
})
</script>
<#if (cgformConfig.formJs.cgJsStr)?? && cgformConfig.formJs.cgJsStr!="">
<script type="text/javascript">
//JS增强
${cgformConfig.formJs.cgJsStr}
</script>
</#if>
</html>