<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery-webos,easyui,tools,DatePicker,autocomplete"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="jeecgrowList"  checkbox="true" pagination="true" fitColumns="true" 
  title="jeecg_rowedit" actionUrl="jeecgListDemoController.do?datagrid" idField="id"  queryMode="group">
    <t:dgCol title="id"  field="id"   hidden="true"   queryMode="group"  width="140"></t:dgCol>
    <t:dgCol title="名称"  field="name" query="true" extendParams="editor:'text'" width="150"></t:dgCol>
    <t:dgCol title="年龄"  field="age"  query="true" extendParams="editor:'numberbox'" width="80"></t:dgCol>
    <t:dgCol title="生日"  field="birthday" formatter="yyyy-MM-dd"  extendParams="editor:'datebox'" width="150"></t:dgCol>
    <t:dgCol title="性别"  field="sex"  query="true" dictionary="sex" extendParams="editor:'combobox'" width="100"></t:dgCol>
    <t:dgCol title="工资"  field="salary"  queryMode="group" extendParams="editor:'numberbox'" width="100"></t:dgCol>
    <t:dgCol title="入职状态"  field="status" query="true" dictionary="sf_yn" extendParams="editor:'combobox'" width="100"></t:dgCol>
    <t:dgCol title="个人介绍"  field="content"  hidden="true"   queryMode="group"  width="500" extendParams="editor:'text'" ></t:dgCol>
  
    <t:dgToolBar  title="录入" icon="icon-add"  funname="addRow"></t:dgToolBar>
	<t:dgToolBar  title="编辑" icon="icon-edit"  funname="editRow"></t:dgToolBar>
	<t:dgToolBar  title="保存" icon="icon-save" url="jeecgListDemoController.do?saveRows" funname="saveData"></t:dgToolBar>
	<t:dgToolBar  title="取消编辑" icon="icon-undo" funname="reject"></t:dgToolBar>
	 <t:dgToolBar title="批量删除"  icon="icon-remove" url="jeecgListDemoController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
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
				result["demos["+i+"]."+d]=rows[i][d];
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
			if($('#'+gname).datagrid('validateRow', i)){
				$('#'+gname).datagrid('endEdit', i);
			}else{
				tip("请选择必填项(带有红色三角形状的字段)!");
				return false;
			}
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