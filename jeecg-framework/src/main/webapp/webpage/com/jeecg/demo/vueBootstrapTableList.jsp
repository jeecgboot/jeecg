<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>vueBootstrapTableList</title>
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
	<div class="row">
		<div class="col-md-4 form-inline pull-left">
			<div class="form-group">
		    	<input v-model="keyword" @keyup.enter="load" class="form-control" placeholder="请输入查询关键字" style="width: 220px;" />
			</div>
			<div class="form-group">
			    <a class="btn btn-primary" @click="load"><i class="fa fa-search"></i>&nbsp;查询</a>
			</div>
		</div>
		<div class="col-md-8">
			<div class="btn-toolbar pull-right">
				<div class="btn-group">
		            <a class="btn btn-default" onclick="reload();"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
		            <a class="btn btn-default" @click="save"><i class="fa fa-plus"></i>&nbsp;新增</a>
		            <a class="btn btn-default" @click="edit"><i class="fa fa-pencil-square-o"></i>&nbsp;编辑</a>
		            <a class="btn btn-default" @click="remove"><i class="fa fa-trash-o"></i>&nbsp;删除</a>
		        </div>
	        </div>
		</div>
	</div>
	<div class="row">
		<table id="dataGrid"></table>
	</div>
</div>
</body>
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- <script src="https://cdn.bootcss.com/layer/3.1.0/layer.js"></script> -->
<script src="https://cdn.bootcss.com/vue/2.5.17-beta.0/vue.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap-table/1.12.1/bootstrap-table.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap-table/1.12.1/locale/bootstrap-table-zh-CN.min.js"></script>
<script src="plug-in/lhgDialog/lhgdialog.min.js?skin=metrole"></script>
<script src="plug-in/laydate/laydate.js"></script>
<script src="plug-in/vue-BootstrapTable/js/common.js"></script>
<script src="plug-in/vue-BootstrapTable/js/form.js"></script>
<script>
$(function() {
	initialPage();
	getGrid();
});

function initialPage() {
	$(window).resize(function() {
		$('#dataGrid').bootstrapTable('resetView', {
			height : $(window).height() - 56
		});
	});
}

function getGrid() {
	$('#dataGrid').bootstrapTableEx({
		url : 'jeecgListDemoController.do?datagrid&field=id,name,sex,age,birthday,phone',
		height : $(window).height() - 56,
		queryParams : function(params) {
			return {
				name : vm.keyword,
				page : params.pageNumber,
				rows : params.pageSize
			}
		},
		columns : [ {
			checkbox : true
		}, {
			field : "name",
			title : "用户名",
			width : "200px"
		}, {
			field : "sex",
			title : "性别",
			width : "300px",
			formatter : function(value, row, index) {
				return value == '0'?'女':value == '1'?'男':'未知';
			}
		}, {
			field : "age",
			title : "年龄",
			width : "130px"
		}, {
			field : "birthday",
			title : "生日",
			width : "130px",
			formatter : function(value, row, index) {
				return !!value?formatDate(value,'yyyy-MM-dd'):'';
			}
		}, {
			field : "phone",
			title : "手机",
			width : "300px"
		} ]
	});
}

var vm = new Vue({
	el : '#dpLTE',
	data : {
		keyword : null,
	},
	methods : {
		load : function() {
			$('#dataGrid').bootstrapTable('refresh');
		},
		save : function() {
			dialogOpen({
				title : '新增用户',
				content: 'url:jeecgListDemoController.do?vueBootstrapTableAdd',
				width : '620px',
				height : '400px'
			});
		},
		edit : function() {
			var ck = $('#dataGrid').bootstrapTable('getSelections');
			if (checkedRow(ck)) {
				dialogOpen({
					title : '编辑用户',
					content: 'url:jeecgListDemoController.do?vueBootstrapTableEdit',
					width : '620px',
					height : '400px',
					init : function() {
						var iframe = this.iframe.contentWindow;
						iframe.vm.user.id = ck[0].id;
						iframe.vm.setForm();
					}
				});
			}
		},
		remove : function() {
			var ck = $('#dataGrid').bootstrapTable('getSelections'), ids = [];
			if (checkedArray(ck)) {
				$.each(ck, function(idx, item) {
					ids[idx] = item.id;
				});
				$.RemoveForm({
					url : 'jeecgListDemoController.do?doBatchDel',
					param : {ids:ids.join(",")},
					success : function(data) {
						vm.load();
					}
				});
			}
		}
	}
});
</script>
</html>