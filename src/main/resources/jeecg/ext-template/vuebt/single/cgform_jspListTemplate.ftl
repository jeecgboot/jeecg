<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title></title>
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
		<div class="col-md-8 form-inline pull-left">
			<#assign hasDate = false>
			<#assign hasDateTime = false>
			<#list columns as po>
			<#if po.isQuery =='Y'>
				<div class="form-group">
				<#if po.showType?index_of("datetime")!=-1>
					<#assign hasDateTime = true>
					<input name="${po.fieldName}" class="form-control dateRange-datetime" placeholder="请选择时间范围" style="width:  190px;" />
				<#elseif po.showType?index_of("date")!=-1>
					<#assign hasDate = true>
					<input name="${po.fieldName}" class="form-control dateRange-date" placeholder="请选择时间范围" style="width:  190px;" />
				<#else>
			    	<input v-model="${po.fieldName}" @keyup.enter="load" class="form-control" placeholder="请输入${po.content}" style="width: 220px;" />
				</#if>
				</div>
			</#if>
			</#list>
			
			<div class="form-group">
			    <a class="btn btn-primary" @click="load"><i class="fa fa-search"></i>&nbsp;查询</a>
			</div>
		</div>
		<div class="col-md-4">
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
		<table id="${entityName?uncap_first}List"></table>
	</div>
</div>
</body>
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdn.bootcss.com/layer/3.1.0/layer.js"></script>
<script src="https://cdn.bootcss.com/vue/2.5.17-beta.0/vue.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap-table/1.12.1/bootstrap-table.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap-table/1.12.1/locale/bootstrap-table-zh-CN.min.js"></script>
<script src="plug-in/lhgDialog/lhgdialog.min.js?skin=metrole"></script>
<script src="plug-in/laydate/laydate.js"></script>
<script src="plug-in/vue-BootstrapTable/js/common.js"></script>
<script src="plug-in/vue-BootstrapTable/js/form.js"></script>
<script src = "webpage/${bussiPackage?replace('.','/')}/${entityPackage}/${entityName?uncap_first}List.js"></script>
<script>
$(function() {
	initialPage();
	getGrid();
});

function initialPage() {
	$(window).resize(function() {
		$('#${entityName?uncap_first}List').bootstrapTable('resetView', {
			height : $(window).height() - 56
		});
	});
	<#if hasDateTime>
		$(".dateRange-datetime").each(function(){
			laydate.render({
			  elem: this,
			  range: true,
		      theme: '#3C8DBC',
		      type: 'datetime',
		      trigger: 'click',
			  done: function(value, date, endDate){
				  vm[this.elem[0].name+"_begin"] = formatDate(date.year + '-' + date.month + '-' + date.date, 'yyyy-MM-dd hh:mm:ss');
		          vm[this.elem[0].name+"_end"] = formatDate(endDate.year + '-' + endDate.month + '-' + endDate.date, 'yyyy-MM-dd hh:mm:ss');
			  }
			});
		});
	</#if>
	<#if hasDate>
		$(".dateRange-date").each(function(){
			laydate.render({
			  elem: this,
			  range: true,
		      theme: '#3C8DBC',
			  done: function(value, date, endDate){
				  vm[this.elem[0].name+"_begin"] = formatDate(date.year + '-' + date.month + '-' + date.date, 'yyyy-MM-dd');
		          vm[this.elem[0].name+"_end"] = formatDate(endDate.year + '-' + endDate.month + '-' + endDate.date, 'yyyy-MM-dd');
			  }
			});
		});
	</#if>
}

function getGrid() {
	$('#${entityName?uncap_first}List').bootstrapTableEx({
		url : '${entityName?uncap_first}Controller.do?datagrid',
		height : $(window).height() - 56,
		queryParams : function(params) {
			var fields=[];
			var queryFields=[];
			<#list columns as po>
				fields.push('${po.fieldName}');
				<#if po.isQuery =='Y'>
				<#if po.showType?index_of("datetime")!=-1 || po.showType?index_of("date")!=-1>
					queryFields.push("${po.fieldName}_begin");
					queryFields.push("${po.fieldName}_end");
				<#else>
					queryFields.push("${po.fieldName}");
				</#if>
				</#if>
			</#list>
			
			var param={
				field: fields.join(","),
				page : params.pageNumber,
				rows : params.pageSize,
				sort: params.sortName,      //排序列名  
				order: params.sortOrder //排位命令（desc，asc） 
			};
			for (let queryField of queryFields) {
				param[queryField]=vm[queryField];
			}
			return param;
		},
		columns : [ {
			checkbox : true
		}
		<#list columns as po>
		, {
			field : "${po.fieldName}",
			title : "${po.content}",
			width : "${po.fieldLength}px",
			sortable: true,
			<#if po.isShowList?if_exists?html =='N'>
			visible: false,
			</#if>
			<#if po.showType?index_of("datetime")!=-1>
			formatter : function(value, row, index) {
				return !!value?formatDate(value,'yyyy-MM-dd hh:mm:ss'):'';
			}
			<#elseif po.showType?index_of("date")!=-1>
			formatter : function(value, row, index) {
				return !!value?formatDate(value,'yyyy-MM-dd'):'';
			}
			</#if>
		}
		</#list>
		]
	});
}

var vm = new Vue({
	el : '#dpLTE',
	data : {
		<#list columns as po>
		<#if po.isQuery =='Y'>
			<#if po.showType?index_of("datetime")!=-1 || po.showType?index_of("date")!=-1>
				${po.fieldName}_begin:null,
				${po.fieldName}_end:null,
			<#else>
				${po.fieldName}:null,
			</#if>
		</#if>
		</#list>
	},
	methods : {
		load : function() {
			$('#${entityName?uncap_first}List').bootstrapTable('refresh');
		},
		save : function() {
			dialogOpen({
				title : '录入',
				content: 'url:${entityName?uncap_first}Controller.do?goAdd',
				width : '620px',
				height : '400px'
			});
		},
		edit : function() {
			var ck = $('#${entityName?uncap_first}List').bootstrapTable('getSelections');
			if (checkedRow(ck)) {
				dialogOpen({
					title : '编辑',
					content: 'url:${entityName?uncap_first}Controller.do?goUpdate',
					width : '620px',
					height : '400px',
					init : function() {
						var iframe = this.iframe.contentWindow;
						iframe.vm.setForm(ck[0].id);
					}
				});
			}
		},
		remove : function() {
			var ck = $('#${entityName?uncap_first}List').bootstrapTable('getSelections'), ids = [];
			if (checkedArray(ck)) {
				$.each(ck, function(idx, item) {
					ids[idx] = item.id;
				});
				$.RemoveForm({
					url : '${entityName?uncap_first}Controller.do?doBatchDel',
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