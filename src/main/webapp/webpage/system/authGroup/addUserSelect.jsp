<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools"></t:base>
<style>
table.table-list {
 	width: 99.6%;
 	font-size: 12px;
 	margin:5px auto;
 	border-collapse:collapse;
}
table.table-list th {
	background: #FDFDFF;
	height: 32px;
	text-align: center;
}
table.table-list td {
	font-weight: normal;
	padding: 5px 5px;
}
 
</style>
<div class="easyui-layout" style="width:800px;height:400px;">
<div data-options="region:'east',split:true" title="用户选择" style="width:200px;">
        	<table class="table-list" border="1" bordercolor="#e5e5e5" cellspacing="0" id="table1">
				<thead>
					<tr>
						<th>姓名</th>
						<th>操作 <a href="javascript:javaScript:void(0)"
							ng-click="clear()" class="btn btn-sm fa fa-close" onclick="deleteAll()"></a></th>
					</tr>
				</thead>
				<tbody>
				
				</tbody>
			</table>
    </div>
    <div data-options="region:'center'">
    <input type="hidden" id="groupId" name="groupId" value="${groupId}">
        <t:datagrid checkbox="false" name="userList1" title="common.user.select" actionUrl="departAuthGroupController.do?getUserDataGrid&groupId=${groupId}"
                    fit="true" fitColumns="true" idField="id" queryMode="group" sortName="createDate" sortOrder="desc" onClick="checkSelect">
            <t:dgCol title="common.id" field="id" hidden="true" sortable="false" ></t:dgCol>
            <t:dgCol title="common.username" width="150" sortable="false" field="userName" query="true"></t:dgCol>
            <t:dgCol title="common.real.name" width="150" field="realName" query="true"></t:dgCol>
        </t:datagrid>
    </div>
</div>

<script type="text/javascript">
function checkSelect() {
	var rows = $("#userList1").datagrid("getChecked");
	if(rows.length>=1) {
		for(var i =0; i<rows.length;i++) {
			var rowsName = rows[i]['realName'];
			var userName = rows[i]['userName'];
    		var rowsId = rows[i]['id'];
    		if(hasRepeart(rowsId)) {
				var newRow = '<tr><td><input type="hidden" value='+rowsId+' id="id"><input type="hidden" value='+userName+' id="userName"><span>'+rowsName+'</span></td><td><a href="#" class="ace_button" onclick="deleteRow(this)"><i class=" fa fa-trash-o"></i>删除</a></td></tr>';
				$("#table1").append(newRow);
		  	}
		}
		
	}
}
function hasRepeart(col) {
	var flag = true;
	$("#table1").find("tbody").find("tr").each(function() {
		if ($(this).find("input").val() == col) {
			flag = false;
			return false;
		}
	});
	return flag;
}
function deleteRow(row) {
	var tr = row.parentNode.parentNode;
	var tbody = tr.parentNode;
	tbody.removeChild(tr);
}
function deleteAll() {
	$("#table1 tbody").html("");
}
</script>
