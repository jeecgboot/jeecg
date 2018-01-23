<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>菜单集合</title>
<t:base type="jquery,easyui,tools"></t:base>
<script type="text/javascript" charset="UTF-8">
	 var editRow;
	 var treegrid;
	$(function() {
		treegrid=$('#treegrid').treegrid({
			url : 'functionController.do?setFunction',				
			title : '',			 
			fit : true,
			fitColumns : true,
			nowrap : true,
			animate : false,
			border : true,
			idField : 'id',
			treeField : 'text',
			frozenColumns : [ [ {
				title : 'id',
				field : 'id',
				width : 50,
				hidden : true
			}, {
				field : 'text',
				title : '菜单名称',
				width : 200	 
			} ] ],
			columns : [ [{
				field : 'src',
				title : '菜单地址',
				width : 200
				 
			}, {
				field : 'code',
				title : '菜单编码',
				width : 50				 
			}, {
				field : 'parentId',
				title : '上级菜单',
				width : 200,
				formatter : function(value, rowData, rowIndex) {
					return rowData.parentText;
				}},
                   {
				field : 'parentText',
				title : '上级菜单',
				width : 80,
				hidden : true
			} ] ],		
			onLoadSuccess : function(row, data) {
				var t = $(this);
				if (data) {
					$(data).each(function(index, d) {
						if (this.state == 'closed') {
							//t.treegrid('expandAll');
						}
					});
				}
			}
			
  });

	 	});

 
 
</script>
</head>
<body>
<table id="treegrid"></table>


</body>
</html>
