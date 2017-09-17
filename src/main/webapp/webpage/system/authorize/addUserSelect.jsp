<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools"></t:base>
<style>
table.table-list {
 	width: 99.6%;
 	font-size: 12px;
 	margin:5px auto;
 	border:0px solid #e5e5e5;
}
table.table-list thead {
}

table.table-list thead > tr > td{
	text-align: left;
	padding-left: 5px;
	
}
table.table-list  tr {
	height: 32px;
}
table.table-list thead th {
	background: #FDFDFF;
	height: 32px;
	text-align: center;
	background-color: #e5e5e5
}
table.table-list tr > th {
	background-color: #FBFCFF;
	padding: 0px 5px;
	text-align: center;
	color: #282831;
	font-weight: bold;
	font-size:12px;
	border:1px solid #e5e5e5;
}
table.table-list td {
	font-weight: normal;
	padding: 5px 5px;
	border:1px solid #e5e5e5;
}

</style>
<div class="easyui-layout" style="width:700px;height:400px;">
<div data-options="region:'east',split:true" title="用户选择" style="width:200px;">
        	<table class="table-list" cellspacing="0" id="table1">
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
        <t:datagrid checkbox="false" name="userList1" title="common.user.select" actionUrl="functionGroupController.do?userDataGrid"
                    fit="true" fitColumns="true" idField="id" queryMode="group" sortName="createDate" sortOrder="desc" onClick="checkSelect">
            <t:dgCol title="common.id" field="id" sortable="false" ></t:dgCol>
            <t:dgCol title="common.username" sortable="false" field="userName" query="true"></t:dgCol>
            <t:dgCol title="common.real.name" field="realName" query="false"></t:dgCol>
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
