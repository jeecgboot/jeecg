<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>

<!-- <h4>分类标题</h4> -->
	    <div class="row">
	      <div class="col-md-12 layout-header">
	        <button id="addBtn_${entityName}" type="button" class="btn btn-default">添加</button>
	        <button id="delBtn_${entityName}" type="button" class="btn btn-default">删除</button>
	        <script type="text/javascript"> 
			$('#addBtn_${entityName}').bind('click', function(){   
		 		 var tr =  $("#add_${entityName?uncap_first}_table_template tr").clone();
			 	 $("#add_${entityName?uncap_first}_table").append(tr);
			 	 resetTrNum('add_${entityName?uncap_first}_table');
			 	 return false;
		    });  
			$('#delBtn_${entityName}').bind('click', function(){   
		       $("#add_${entityName?uncap_first}_table").find("input:checked").parent().parent().remove();   
		        resetTrNum('add_${entityName?uncap_first}_table');
		        return false;
		    });
		    $(document).ready(function(){
		    	if(location.href.indexOf("load=detail")!=-1){
					$(":input").attr("disabled","true");
					$(".datagrid-toolbar").hide();
				}
		    	resetTrNum('add_${entityName?uncap_first}_table');
		    });
		</script>
	      </div>
	    </div>
<div style="margin: 0 15px; background-color: white;">    
	    <!-- Table -->
      <table id="${entityName?uncap_first}_table" class="table table-bordered table-hover" style="margin-bottom: 0;">
		<thead>
	      <tr>
	        <th style="white-space:nowrap;width:50px;">序号</th>
	        <th style="white-space:nowrap;width:50px;">操作</th>
			<#list pageColumns as po>
					 <#assign check = 0 >
					  <#list foreignKeys as key>
					  <#if fieldMeta[po.fieldName]==key?uncap_first>
					  <#assign check = 1 >
					  <#break>
					  </#if>
					  </#list>
					  <#if check==0>
					  <th>
							${po.content}
					  </th>
					  </#if>
		      </#list>
	      </tr>
	    </thead>
        
	<tbody id="add_${entityName?uncap_first}_table">	
	<c:if test="${"$"}{fn:length(${entityName?uncap_first}List)  <= 0 }">
			<tr>
				<th scope="row"><div name="xh"></div></th>
				<td><input style="width:20px;" type="checkbox" name="ck"/></td>
				<#list columns as po>
				<#if po.isShow=="N">
					<input name="${entityName?uncap_first}List[0].${po.fieldName}" type="hidden"/>
				</#if>
				</#list>
				<#list pageColumns as po>
				  <#assign check = 0 >
				  <#list foreignKeys as key>
				  <#if fieldMeta[po.fieldName]==key?uncap_first>
				  <#assign check = 1 >
				  <#break>
				  </#if>
				  </#list>
				  <#if check==0>
				  <td>
					<#if po.showType == "text">
					  	<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" 
					  		type="text" class="form-control"  style="width:120px;" <#if po.fieldValidType?if_exists?html != ''> datatype="${po.fieldValidType?if_exists?html}"<#else><#if po.type == 'int'> datatype="n"<#elseif po.type=='double'> datatype="/^(-?\d+)(\.\d+)?$/"<#else><#if po.isNull != 'Y'>datatype="*"</#if></#if></#if>>
						<#elseif po.showType=='password'>
							<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" 
					  		type="password" class="form-control"  style="width:120px;" <#if po.fieldValidType?if_exists?html != ''> datatype="${po.fieldValidType?if_exists?html}"<#else><#if po.type == 'int'> datatype="n"<#elseif po.type=='double'> datatype="/^(-?\d+)(\.\d+)?$/"<#else> <#if po.isNull != 'Y'>datatype="*"</#if></#if></#if>>
						<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>
							<t:dictSelect field="${entityName?uncap_first}List[0].${po.fieldName}" type="${po.showType?if_exists?html}" extendJson="{class:'form-control',style:'width:150px'}" <#if po.isNull != 'Y'>datatype="*"</#if> 
										<#if po.dictTable?if_exists?html != ''>dictTable="po.dictTable" dictField="${po.dictField?if_exists?html}" dictText="${po.dictText?if_exists?html}"<#else>typeGroupCode="${po.dictField}"</#if> defaultVal="${'$'}{${entityName?uncap_first}Page.${po.fieldName}}" hasLabel="false"  title="${po.content}"></t:dictSelect>     
						<#elseif po.showType=='date'>
							<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" 
					  		type="text" class="form-control" onClick="WdatePicker()"  style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width:160px;" <#if po.fieldValidType?if_exists?html != ''> datatype="${po.fieldValidType?if_exists?html}"<#else> <#if po.isNull != 'Y'>datatype="*"</#if></#if>>
					      <#elseif po.showType=='datetime'>
					      	<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" 
						  		type="text"  class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width:160px;" <#if po.fieldValidType?if_exists?html != ''> datatype="${po.fieldValidType?if_exists?html}"<#else> <#if po.isNull != 'Y'>datatype="*"</#if></#if>>
					       <#elseif po.showType=='file'>
							<input type="hidden" id="${entityName?uncap_first}List[0].${po.fieldName}" name="${entityName?uncap_first}List[0].${po.fieldName}" />
										<a  target="_blank" id="${entityName?uncap_first}List[0].${po.fieldName}_href">未上传</a>
										<br>
									   <input class="form-control" type="button" value="上传附件"
													onclick="commonUpload(commonUploadDefaultCallBack,'${entityName?uncap_first}List\\[0\\]\\.${po.fieldName}')"/> 
					       <#else>
					       	<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" 
						  		type="text" class="form-control"  style="width:120px;" <#if po.fieldValidType?if_exists?html != ''> datatype="${po.fieldValidType?if_exists?html}"<#else><#if po.type == 'int'> datatype="n"<#elseif po.type=='double'> datatype="/^(-?\d+)(\.\d+)?$/"<#else> <#if po.isNull != 'Y'>datatype="*"</#if></#if></#if> >
					  </#if>
					  <label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
					</td>
				  </#if>
	            </#list>
   			</tr>
	</c:if>
	<c:if test="${"$"}{fn:length(${entityName?uncap_first}List)  > 0 }">
		<c:forEach items="${"$"}{${entityName?uncap_first}List}" var="poVal" varStatus="stuts">
			<tr>
				<th scope="row"><div name="xh">${'$'}{stuts.index+1 }</div></th>
				<td><input style="width:20px;" type="checkbox" name="ck"/></td>
				<#list columns as po>
				<#if po.isShow=="N">
					<input name="${entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" type="hidden" value="${'$'}{poVal.${po.fieldName} }"/>
				</#if>
				</#list>
				<#list pageColumns as po>
				  <#assign check = 0 >
				  <#list foreignKeys as key>
				  <#if fieldMeta[po.fieldName]==key?uncap_first>
				  <#assign check = 1 >
				  <#break>
				  </#if>
				  </#list>
				  <#if check==0>
				   <td align="left">
				   <#if po.showType == "text">
					  	<input name="${entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" maxlength="${po.length?c}" 
					  		type="text" class="form-control"  style="width:120px;" <#if po.fieldValidType?if_exists?html != ''> datatype="${po.fieldValidType?if_exists?html}"<#else><#if po.type == 'int'> datatype="n"<#elseif po.type=='double'> datatype="/^(-?\d+)(\.\d+)?$/"<#else><#if po.isNull != 'Y'>datatype="*"</#if></#if></#if> value="${'$'}{poVal.${po.fieldName} }">
						<#elseif po.showType=='password'>
							<input name="${entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" maxlength="${po.length?c}" 
					  		type="password" class="form-control"  style="width:120px;" <#if po.fieldValidType?if_exists?html != ''> datatype="${po.fieldValidType?if_exists?html}"<#else><#if po.type == 'int'> datatype="n"<#elseif po.type=='double'> datatype="/^(-?\d+)(\.\d+)?$/"<#else> <#if po.isNull != 'Y'>datatype="*"</#if></#if></#if> value="${'$'}{poVal.${po.fieldName} }">
						<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>
							<t:dictSelect field="${entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" type="${po.showType?if_exists?html}" extendJson="{class:'form-control',style:'width:150px'}" <#if po.isNull != 'Y'>datatype="*"</#if> 
										<#if po.dictTable?if_exists?html != ''>dictTable="${po.dictTable?if_exists?html}" dictField="${po.dictField?if_exists?html}" dictText="${po.dictText?if_exists?html}"<#else>typeGroupCode="${po.dictField}"</#if> defaultVal="${'$'}{poVal.${po.fieldName} }" hasLabel="false"  title="${po.content}"></t:dictSelect>     
						<#elseif po.showType=='date'>
							<input name="${entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" maxlength="${po.length?c}" 
					  		type="text" class="form-control" onClick="WdatePicker()"  style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width:160px;"  <#if po.fieldValidType?if_exists?html != ''> datatype="${po.fieldValidType?if_exists?html}"<#else> <#if po.isNull != 'Y'>datatype="*"</#if></#if> value="<fmt:formatDate value='${'$'}{poVal.${po.fieldName}}' type="date" pattern="yyyy-MM-dd"/>">
					      <#elseif po.showType=='datetime'>
					      	<input name="${entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" maxlength="${po.length?c}" 
						  		type="text"  class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width:160px;" <#if po.fieldValidType?if_exists?html != ''> datatype="${po.fieldValidType?if_exists?html}"<#else> <#if po.isNull != 'Y'>datatype="*"</#if></#if> value="<fmt:formatDate value='${'$'}{poVal.${po.fieldName}}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>">
					      <#elseif po.showType=='file'>
					        <input type="hidden" id="${entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" name="${entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}"  value="${'$'}{poVal.${po.fieldName} }"/>
										<c:if test="${'$'}{empty poVal.${po.fieldName}}">
											<a  target="_blank" id="${entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}_href">未上传</a>
										</c:if>
										<c:if test="${'$'}{!empty poVal.${po.fieldName}}">
											<a  href="${'$'}{poVal.${po.fieldName}}"  target="_blank" id="${entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}_href">下载</a>
										</c:if>
										<br>
									   <input class="form-control" type="button" value="上传附件"
													onclick="commonUpload(commonUploadDefaultCallBack,'${entityName?uncap_first}List\\[${'$'}{stuts.index }\\]\\.${po.fieldName}')"/> 
					       <#else>
					       	<input name="${entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" maxlength="${po.length?c}" 
						  		type="text" class="form-control"  style="width:120px;" <#if po.fieldValidType?if_exists?html != ''> datatype="${po.fieldValidType?if_exists?html}"<#else><#if po.type == 'int'> datatype="n"<#elseif po.type=='double'> datatype="/^(-?\d+)(\.\d+)?$/"<#else> <#if po.isNull != 'Y'>datatype="*"</#if></#if></#if> value="${'$'}{poVal.${po.fieldName} }">
					  </#if>
					  <label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
				   </td>
				  </#if>
   			 	</#list>
   			</tr>
		</c:forEach>
	</c:if>	
	</tbody>
</table>
