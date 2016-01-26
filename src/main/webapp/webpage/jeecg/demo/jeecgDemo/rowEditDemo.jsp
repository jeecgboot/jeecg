<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>


<t:datagrid name="jeecgDemoList2" title="行编辑示例"  actionUrl="jeecgDemoController.do?datagrid"
	idField="id" queryMode="group" checkbox="true" >
	<t:dgCol title="编号" field="id" hidden="true" ></t:dgCol>
	<t:dgCol title="用户名" field="userName" query="true"  extendParams="editor:'text''"></t:dgCol>
	<t:dgCol title="电话号码"  field="mobilePhone" query="true" extendParams="editor:'text''"></t:dgCol>
	<t:dgCol title="办公电话" field="officePhone" query="true"  extendParams="editor:'text''"></t:dgCol>
	<t:dgCol title="创建日期" field="createDate" formatter="yyyy-MM-dd" query="true" queryMode="group"  extendParams="editor:'datebox''"></t:dgCol>
	<t:dgCol title="邮箱" field="email" query="true" editor="textbox" extendParams="editor:'text''"></t:dgCol>
	<t:dgCol title="年龄" sortable="true" field="age" query="true" extendParams="editor:'numberbox''"></t:dgCol>
	<t:dgCol title="工资" field="salary" query="true" extendParams="editor:'numberbox''"></t:dgCol>

	<t:dgCol title="生日" field="birthday" formatter="yyyy/MM/dd" query="true" extendParams="editor:'datebox''"></t:dgCol>
	<t:dgToolBar operationCode="add" title="录入" icon="icon-add"  funname="addRow"></t:dgToolBar>
	<t:dgToolBar operationCode="edit" title="编辑" icon="icon-edit"  funname="editRow"></t:dgToolBar>
	<t:dgToolBar operationCode="save" title="保存" icon="icon-save" url="jeecgDemoController.do?saveRows" funname="saveData"></t:dgToolBar>
	<t:dgToolBar operationCode="undo" title="取消编辑" icon="icon-undo" funname="reject"></t:dgToolBar>
</t:datagrid>
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
			url:"${pageContext.request.contextPath}/"+addurl,
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

