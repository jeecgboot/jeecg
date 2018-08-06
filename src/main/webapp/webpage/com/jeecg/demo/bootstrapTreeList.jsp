<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width" />
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="width=device-width,initial-scale=1.0" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta content="telephone=no" name="format-detection">
<meta content="email=no" name="format-detection">
<title>Bootstrap树形列表</title>
<link href="plug-in/bootstrap3.3.5/css/bootstrap.min.css" rel="stylesheet">
<link href="plug-in/bootstrap-table/bootstrap-table.css" rel="stylesheet">
<link href="plug-in/jquery/jquery.treegrid.min.css" rel="stylesheet">
</head>
 <!--update-begin-Author:liushaoqian Date: 20180718 for：TASK #2968 【demo --周俊峰】做一个bootstrap-table 树形列表demo-->
<body>
<div class="panel-body" style="padding-bottom:0px;">
     <!-- <div id="toolbar">
            <button id="btn_add" type="button" class="btn btn-primary btn-sm" onclick="add('新增','jeecgListDemoController.do?goBootStrapTableAdd','table',600,400)">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
            </button>
            <button id="btn_edit" type="button" class="btn btn-success btn-sm" onclick="update('修改','jeecgListDemoController.do?goBootStrapTableUpdate','table',600,400)">
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
            </button>
            <button id="btn_delete" type="button" class="btn btn-danger btn-sm"  onclick="deleteALLSelect('批量删除','jeecgListDemoController.do?doBatchDel','table',600,400)">
                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>批量删除
            </button>
            <a class="btn btn-default btn-sm" data-toggle="collapse" href="#collapse_search" id="btn_collapse_search" >
						<span class="glyphicon glyphicon-search" aria-hidden="true"></span> 检索 </a>
        </div> -->
	    <div class="table-responsive">
	       <table id="table"></table>
	    </div>
	    </div>
</body>
<script src="plug-in/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
<script src="plug-in/bootstrap-table/bootstrap-table-tree.js"></script>
<script type="text/javascript" src="plug-in/bootstrap-table/bootstrap-table-treegrid.js"></script>
<script type="text/javascript" src="plug-in/jquery/jquery.treegrid.min.js"></script>
<script type="text/javascript">
  var $table = $('#table');
  $(function() {
    $table.bootstrapTable({
      url: 'jeecgFormDemoController.do?bootstrapDemoDatagrid',         //请求后台的URL（*）
      method: 'get',                      //请求方式（*）
      striped: true,                      //是否显示行间隔色
      //pagination: true,                   //是否显示分页（*）
      sidePagination: 'server',
      height: $(window).height(),
     // showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
     // cardView: false,                    //是否显示详细视图
     // detailView: false,                   //是否显示父子表
      idField: 'id',
      columns: [
        {
          field: 'ck',
          checkbox: true
        },
        {
          field: 'name',
          title: '名称'
        },
        {
          field: 'status',
          title: '状态',
          align: 'center',
          formatter: 'statusFormatter'
        },
        {
          field: 'permissionValue',
          title: '权限值'
        }
      ],
      treeShowField: 'name',
      parentIdField: 'pid',
      onLoadSuccess: function(data) {
        $table.treegrid({
          treeColumn: 1,
          onChange: function() {
            $table.bootstrapTable('resetWidth');
          }
        });
      }
    });
  });


  // 格式化类型
  function typeFormatter(value, row, index) {
    if (value === 'menu') {
      return '菜单';
    }
    if (value === 'button') {
      return '按钮';
    }
    if (value === 'api') {
      return '接口';
    }
    return '-';
  }

  // 格式化状态
  function statusFormatter(value, row, index) {
    if (value === 1) {
      return '<span class="label label-success">正常</span>';
    } else {
      return '<span class="label label-default">锁定</span>';
    }
  }
</script>
 <!--update-begin-Author:liushaoqian Date: 20180718 for：TASK #2968 【demo --周俊峰】做一个bootstrap-table 树形列表demo-->
</html>
