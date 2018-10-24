<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<#-- update--begin--author:zhangjiaqiang date:20170531 for:增加列表页面对于图片和文件的判断 -->
<#include "../../ui/tdgCol.ftl"/>
<#-- update--end--author:zhangjiaqiang date:20170531 for:增加列表页面对于图片和文件的判断 -->
<#assign orderByCreateDate = false />
<#list columns as po>
	<#if po.fieldName=='createDate'>
		<#assign orderByCreateDate = true />
		<#break>
	</#if>
</#list>
<t:base type="jquery,easyui,tools,DatePicker,autocomplete"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="${entityName?uncap_first}rowList" checkbox="true" <#if cgformConfig.cgFormHead.isPagination == 'Y'> pagination="true"<#else> pagination="false"</#if><#if cgformConfig.cgFormHead.isTree == 'Y'> treegrid="true" treeField="${cgformConfig.cgFormHead.treeFieldnamePage}"</#if> fitColumns="true" <#if orderByCreateDate == true >sortName="createDate"<#else>sortName="id"</#if><#rt/>
  title="${ftl_description}" actionUrl="${entityName?uncap_first}Controller.do?datagrid" idField="id"  queryMode="group">
   <#--<@dgcol columns=columns/> -->
   <#list columns as po>
    <#if po.isShowList == 'N'>
    <t:dgCol title="${po.content}"  field="${po.fieldName}"  hidden="true" ></t:dgCol>
    <#elseif po.showType == 'date'>
    <t:dgCol title="${po.content}"  field="${po.fieldName}" queryMode="${po.queryMode}" <#if  po.isQuery == 'Y'>query="true"</#if> <#if po.dictField??><#if  po.dictField != "">dictionary="${po.dictField}"</#if></#if> formatter="yyyy-MM-dd" extendParams="editor:'datebox'" width="100"></t:dgCol>
    <#elseif po.showType == 'textarea'>
    <t:dgCol title="${po.content}"  field="${po.fieldName}" queryMode="${po.queryMode}" <#if  po.isQuery == 'Y'>query="true"</#if> <#if po.dictField??><#if  po.dictField != "">dictionary="${po.dictField}"</#if></#if> extendParams="editor:'textarea'" width="100"></t:dgCol>
    <#elseif po.showType == 'checkbox' >
    <#-- update--begin--author:zhoujf date:20180330 for:TASK #2592 【代码生成器】单表档案行编辑风格表单，代码生成，点击页面编辑所有的数据不可操作 -->
    <t:dgCol title="${po.content}"  field="${po.fieldName}" queryMode="${po.queryMode}" <#if  po.isQuery == 'Y'>query="true"</#if> <#if po.dictTable?if_exists?html!="">dictionary="${po.dictTable},${po.dictField},${po.dictText}" <#else><#if po.dictField??><#if  po.dictField != "">dictionary="${po.dictField}"</#if></#if></#if> extendParams="editor:'combobox'" width="100"></t:dgCol>
    <#-- update--end--author:zhoujf date:20180330 for:TASK #2592 【代码生成器】单表档案行编辑风格表单，代码生成，点击页面编辑所有的数据不可操作 -->
    <#elseif po.showType == 'radio'> 
    <#-- update--begin--author:zhoujf date:20180330 for:TASK #2592 【代码生成器】单表档案行编辑风格表单，代码生成，点击页面编辑所有的数据不可操作 -->
    <t:dgCol title="${po.content}"  field="${po.fieldName}" queryMode="${po.queryMode}"<#if  po.isQuery == 'Y'>query="true"</#if> <#if po.dictTable?if_exists?html!="">dictionary="${po.dictTable},${po.dictField},${po.dictText}" <#else><#if po.dictField??><#if  po.dictField != "">dictionary="${po.dictField}"</#if></#if></#if> extendParams="editor:'combobox'" width="100"></t:dgCol>
    <#-- update--end--author:zhoujf date:20180330 for:TASK #2592 【代码生成器】单表档案行编辑风格表单，代码生成，点击页面编辑所有的数据不可操作 -->
    <#elseif po.showType == 'datetime'>
    <t:dgCol title="${po.content}"  field="${po.fieldName}" queryMode="${po.queryMode}" <#if  po.isQuery == 'Y'>query="true"</#if> <#if po.dictField??><#if  po.dictField != "">dictionary="${po.dictField}"</#if></#if> formatter="yyyy-MM-dd hh:mm:ss" extendParams="editor:'datebox'" width="100"></t:dgCol>
    <#elseif po.showType == 'list'> 
    <#-- update--begin--author:zhoujf date:20180330 for:TASK #2592 【代码生成器】单表档案行编辑风格表单，代码生成，点击页面编辑所有的数据不可操作 -->
    <t:dgCol title="${po.content}"  field="${po.fieldName}" queryMode="${po.queryMode}" <#if  po.isQuery == 'Y'>query="true"</#if> <#if po.dictTable?if_exists?html!="">dictionary="${po.dictTable},${po.dictField},${po.dictText}" <#else><#if po.dictField??><#if  po.dictField != "">dictionary="${po.dictField}"</#if></#if></#if> extendParams="editor:'combobox'" width="100"></t:dgCol>
    <#-- update--end--author:zhoujf date:20180330 for:TASK #2592 【代码生成器】单表档案行编辑风格表单，代码生成，点击页面编辑所有的数据不可操作 -->
    <#elseif po.type == 'int'> 
    <t:dgCol title="${po.content}"  field="${po.fieldName}" queryMode="${po.queryMode}" <#if  po.isQuery == 'Y'>query="true"</#if> <#if po.dictField??><#if  po.dictField != "">dictionary="${po.dictField}"</#if></#if> extendParams="editor:'numberbox'" width="100"></t:dgCol>
    <#elseif po.type == 'double'>
    <t:dgCol title="${po.content}"  field="${po.fieldName}" queryMode="${po.queryMode}" <#if  po.isQuery == 'Y'>query="true"</#if> <#if po.dictField??><#if  po.dictField != "">dictionary="${po.dictField}"</#if></#if> extendParams="editor:'numberbox'" width="100"></t:dgCol>
    <#elseif po.type == 'BigDecimal'>
    <t:dgCol title="${po.content}"  field="${po.fieldName}" queryMode="${po.queryMode}" <#if  po.isQuery == 'Y'>query="true"</#if> <#if po.dictField??><#if  po.dictField != "">dictionary="${po.dictField}"</#if></#if> extendParams="editor:'numberbox'" width="100"></t:dgCol>
    <#-- update--begin--author:zhoujf date:20180413 for:TASK #2641 【popup重构问题】popup查询条件多字段回填问题-->
    <#elseif po.showType == 'popup'> 
    <t:dgCol title="${po.content}"  field="${po.fieldName}" queryMode="${po.queryMode}" <#if  po.isQuery == 'Y'>query="true"</#if><#if po.dictTable?if_exists?html!=""> dictionary="${po.dictTable},${po.dictField?replace(',', '@')},${po.dictText?replace(',', '@')}"<#if po.showType=='popup'> popup="true"</#if><#else><#if po.dictTable?if_exists?html=="" && po.dictField?if_exists?html!=""> dictionary="${po.dictField}"</#if></#if> extendParams="editor:'text'" width="100"></t:dgCol>
    <#-- update--end--author:zhoujf date:20180413 for:TASK #2641 【popup重构问题】popup查询条件多字段回填问题-->
    <#-- update--begin--author:zhangweijian date:20180710 for:TASK #2927 【bug】代码生成器模板，行编辑模式生成的列表页面，图片和文件展示问题-->
    <#elseif po.showType?index_of("image") != -1>
    <#-- update--begin--author:zhangweijian date:20180710 for:TASK #2951 【样式体验问题】行编辑代码生成器，生成的代码页面， 这个附件字段为什么这么短-->
    <t:dgCol title="${po.content}"  field="${po.fieldName}" extendParams="editor:'text'" image="true" imageSize="50,50" width="100"></t:dgCol>
	<#elseif po.showType?index_of("file") != -1>
    <t:dgCol title="${po.content}"  field="${po.fieldName}" extendParams="editor:'text'" downloadName="附件下载" width="100"></t:dgCol>
    <#-- update--end--author:zhangweijian date:20180710 for:TASK #2951 【样式体验问题】行编辑代码生成器，生成的代码页面， 这个附件字段为什么这么短-->
    <#-- update--end--author:zhangweijian date:20180710 for:TASK #2927 【bug】代码生成器模板，行编辑模式生成的列表页面，图片和文件展示问题-->
    <#else> 
    <#-- update--begin--author:zhoujf date:20180319 for:TASK #2557 popup,当字典Text为多个值时 -->
    <t:dgCol title="${po.content}"  field="${po.fieldName}" queryMode="${po.queryMode}" <#if  po.isQuery == 'Y'>query="true"</#if><#if po.dictTable?if_exists?html!=""> dictionary="${po.dictTable},${po.dictText},${po.dictField}"<#if po.showType=='popup'> popup="true"</#if><#else><#if po.dictTable?if_exists?html=="" && po.dictField?if_exists?html!=""> dictionary="${po.dictField}"</#if></#if> extendParams="editor:'text'" width="100"></t:dgCol>
    <#-- update--end--author:zhoujf date:20180319 for:TASK #2557 popup,当字典Text为多个值时 -->
    </#if> 
   </#list>
   <#--//update-end--Author:zhangjiaqiang  Date:20160925 for：TASK #1344 [链接图标] online功能测试的按钮链接图标修改 -->
    <t:dgToolBar operationCode="add" title="录入" icon="icon-add"  funname="addRow"></t:dgToolBar>
    <t:dgToolBar operationCode="edit" title="编辑" icon="icon-edit"  funname="editRow"></t:dgToolBar>
    <t:dgToolBar operationCode="save" title="保存" icon="icon-save" url="${entityName?uncap_first}Controller.do?saveRows" funname="saveData"></t:dgToolBar>
    <t:dgToolBar operationCode="undo" title="取消编辑" icon="icon-undo" funname="reject"></t:dgToolBar>
    <t:dgToolBar title="批量删除"  icon="icon-remove" url="${entityName?uncap_first}Controller.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
    //添加行
	function addRow(title,addurl,gname){
		$('#'+gname).datagrid('appendRow',{});
		var editIndex = $('#'+gname).datagrid('getRows').length-1;
		$('#'+gname).datagrid('selectRow', editIndex)
				.datagrid('beginEdit', editIndex);
	}
	//保存数据
	function saveData(title,addurl,gname){
		if(!endEdit(gname))
			return false;
		var rows=$('#'+gname).datagrid("getChanges","inserted");
		var uprows=$('#'+gname).datagrid("getChanges","updated");
		rows=rows.concat(uprows);
		if(rows.length<=0){
			tip("没有需要保存的数据！")
			return false;
		}
		var result={};
		for(var i=0;i<rows.length;i++){
			for(var d in rows[i]){
				result["${entityName?uncap_first}List["+i+"]."+d]=rows[i][d];
			}
		}
		$.ajax({
			url:"<%=basePath%>/"+addurl,
			type:"post",
			data:result,
			dataType:"json",
			success:function(data){
				tip(data.msg);
				if(data.success){
					reloadTable();
				}
			}
		})
	}
	//结束编辑
	function endEdit(gname){
		var  editIndex = $('#'+gname).datagrid('getRows').length-1;
		for(var i=0;i<=editIndex;i++){
			if($('#'+gname).datagrid('validateRow', i))
				$('#'+gname).datagrid('endEdit', i);
			else
				return false;
		}
		return true;
	}
	//编辑行
	function editRow(title,addurl,gname){
		var rows=$('#'+gname).datagrid("getChecked");
		if(rows.length==0){
			tip("请选择条目");
			return false;
		}
		for(var i=0;i<rows.length;i++){
			var index= $('#'+gname).datagrid('getRowIndex', rows[i]);
			$('#'+gname).datagrid('beginEdit', index);
		}
	}
	//取消编辑
	function reject(title,addurl,gname){
		$('#'+gname).datagrid('clearChecked');
		$('#'+gname).datagrid('rejectChanges');
	}
 </script>
 <#if (cgformConfig.listJs.cgJsStr)?? && cgformConfig.listJs.cgJsStr!="">
 <script type="text/javascript">
 //JS增强
 ${cgformConfig.listJs.cgJsStr}
 </script>
</#if>