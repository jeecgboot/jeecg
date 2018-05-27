<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ace列表</title>
<script type="text/javascript" src="plug-in/mutiLang/zh-cn.js"></script>
<script type="text/javascript" src="plug-in/jquery/jquery-1.8.3.js"></script>
<script type="text/javascript" src="plug-in/jquery/jquery.cookie.js" ></script>
<script type="text/javascript" src="plug-in/jquery-plugs/storage/jquery.storageapi.min.js" >
</script><script type="text/javascript" src="plug-in/tools/dataformat.js"></script>
<link id="easyuiTheme" rel="stylesheet" href="plug-in/easyui/themes/metrole/easyui.css" type="text/css"></link>
<link id="easyuiTheme" rel="stylesheet" href="plug-in/easyui/themes/metrole/main.css" type="text/css"></link>
<link id="easyuiTheme" rel="stylesheet" href="plug-in/easyui/themes/metrole/icon.css" type="text/css"></link>
<link rel="stylesheet" type="text/css" href="plug-in/accordion/css/accordion.css">
<link rel="stylesheet" type="text/css" href="plug-in/accordion/css/icons.css">
<script type="text/javascript" src="plug-in/easyui/jquery.easyui.min.1.3.2.js"></script>
<script type="text/javascript" src="plug-in/easyui/locale/zh-cn.js"></script>
<script type="text/javascript" src="plug-in/tools/syUtil.js"></script>
<script type="text/javascript" src="plug-in/easyui/extends/datagrid-scrollview.js"></script>
<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
<link rel="stylesheet" href="plug-in/tools/css/metrole/common.css" type="text/css"></link>
<link rel="stylesheet" href="plug-in/ace/css/font-awesome.css" type="text/css"></link>
<script type="text/javascript" src="plug-in/lhgDialog/lhgdialog.min.js?skin=metrole"></script>
<script type="text/javascript" src="plug-in/ace/js/bootstrap-tab.js"></script>
<script type="text/javascript" src="plug-in/layer/layer.js"></script>
<script type="text/javascript" src="plug-in/tools/curdtools_zh-cn.js"></script>
<script type="text/javascript" src="plug-in/tools/easyuiextend.js"></script>
<script type="text/javascript" src="plug-in/jquery-plugs/hftable/jquery-hftable.js"></script>
<script type="text/javascript" src="plug-in/tools/json2.js" ></script>
<link rel="stylesheet" href="plug-in/jquery/jquery-autocomplete/jquery.autocomplete.css" type="text/css"></link>
<script type="text/javascript" src="plug-in/jquery/jquery-autocomplete/jquery.autocomplete.min.js"></script>
</head>
<body>
<script>
$(function(){
	initDatagrid();
	$('#aceEasyuiList').datagrid('getPager').pagination({
        beforePageText: '',
        afterPageText: '/{pages}',
        displayMsg: '{from}-{to}共 {total}条',
        showPageList: true,
        showRefresh: true
    });
    $('#aceEasyuiList').datagrid('getPager').pagination({
        onBeforeRefresh: function(pageNumber, pageSize) {
            $(this).pagination('loading');
            $(this).pagination('loaded');
        }
    });
});

function initDatagrid(){
	var actionUrl = "jeecgListDemoController.do?datagrid&field=id,name,age,birthday,depId,extField,sex,phone,salary,createDate,email,status,content,touxiang,createBy,createName,updateBy,updateDate,updateName,";
 	$('#aceEasyuiList').datagrid({
		url:actionUrl,
		idField: 'id', 
		title: 'aceDEMO列表页面',
		loadMsg: '数据加载中...',
		fit:true,
		fitColumns:true,
		striped:true,
		autoRowHeight: true,
		pageSize: 10,
		pagination:true,
		singleSelect:false,
	/* 	sortName: 'birthday,name,age,salary',
        sortOrder: 'asc', */
		pageList:[10,30,50,100],
		rownumbers:true,
		showFooter:true,
		toolbar: '#aceEasyuiListToolbar',
		frozenColumns:[[]],
		columns:[[
			{field:'ck',checkbox:true},
			{field:'id',title:'主键',	hidden:true},
			{field:'name',title: '名称', sortable: true,width:120},		
			{field:'age',title: '年龄', sortable: true,width:120},
            {
				field: 'sex',title: '性别',width: 120,
				formatter: function(value, rec, index) {
					if (value == '0') {
                        return '男';
                    }
                    if (value == '1') {
                        return '女';
                    } else {
                        return value;
                    }
				}
            },
			{field:'salary',title: '工资', sortable: true,width:120},
			{
				field:'birthday',title: '生日', sortable: true,width:120,
				formatter: function(value, rec, index) {
	                return new Date().format('yyyy-MM-dd', value);
	            }
			},
	        {field:'content',title: '个人介绍',width:150},
			{
	            field: 'opt',title: '操作',width: 150,
	            formatter: function(value, rec, index) {
	                if (!rec.id) {
	                    return '';
	                }
	                var href = '';
	                href += "<a href='#'   class='ace_button'  onclick=delObj('jeecgListDemoController.do?doDel&id=" + rec.id + "','aceEasyuiList')>  <i class=' fa fa-trash-o'></i> ";
	                href += "删除</a>&nbsp;";
	                return href;
	            }
	        }
		]],
		onLoadSuccess: function(data) {
            $("#aceEasyuiList").datagrid("clearSelections");
            if (!false) {
                if (data.total && data.rows.length == 0) {
                    var grid = $('#aceEasyuiList');
                    var curr = grid.datagrid('getPager').data("pagination").options.pageNumber;
                    grid.datagrid({
                        pageNumber: (curr - 1)
                    });
                }
            }
        }
	});
}
function reloadTable() {
	 $('#aceEasyuiList').datagrid('reload');
}
</script>
<div class="easyui-layout" fit="true">
	<div region="center" style="padding:0px;border:0px">
		<table id="aceEasyuiList"></table>  
	</div>
	<div id = "aceEasyuiListToolbar">
		<a href="#" class="easyui-linkbutton l-btn l-btn-plain" plain="true" icon="icon-add" onclick="add('录入','jeecgListDemoController.do?goNatureAceTableAdd','aceEasyuiList',700,500)">
			录入
		</a>
		<a href="#" class="easyui-linkbutton l-btn l-btn-plain" plain="true" icon="icon-edit" onclick="update('编辑','jeecgListDemoController.do?goNatureAceTableUpdate','aceEasyuiList',700,500)">
			编辑
		</a>
		<a href="#" class="easyui-linkbutton l-btn l-btn-plain" plain="true" icon="icon-remove" onclick="deleteALLSelect('批量删除','jeecgListDemoController.do?doBatchDel','aceEasyuiList',null,null)">
			批量删除
		</a>
	</div>
</div>
</body>
</html>