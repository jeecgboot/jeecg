<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>请假表单管理</title>
<meta name="viewport" content="width=device-width" />
<!-- Jquery组件引用 -->
<script src="plug-in/jquery/jquery-1.9.1.js"></script>
<!-- <script src="https://cdn.bootcss.com/jquery/1.12.3/jquery.min.js"></script> -->
<!-- bootstrap组件引用 -->
<link href="plug-in/bootstrap3.3.5/css/bootstrap.min.css" rel="stylesheet">
<script src="plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
<!-- <link href="https://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="https://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script> -->

<!-- bootstrap table组件以及中文包的引用 -->
<link href="plug-in/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
<script src="plug-in/bootstrap-table/bootstrap-table.js"></script>
<script src="plug-in/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
<!-- <link href="https://cdn.bootcss.com/bootstrap-table/1.11.1/bootstrap-table.min.css" rel="stylesheet">
<script src="https://cdn.bootcss.com/bootstrap-table/1.11.1/bootstrap-table.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap-table/1.11.1/locale/bootstrap-table-zh-CN.js"></script> -->

<!-- Layer组件引用 -->
<script src="plug-in/layer/layer.js"></script>
<script src="plug-in/laydate/laydate.js"></script>
<!-- <script src="https://cdn.bootcss.com/layer/3.1.0/layer.js"></script> -->

<!-- 通用组件引用 -->
<link href="plug-in/bootstrap3.3.5/css/default.css" rel="stylesheet" />
<script src="plug-in/themes/bootstrap-ext/js/bootstrap-curdtools.js"></script>

</head>
<body>
	<div class="panel-body" style="padding-bottom:0px;">
        <!-- 搜索 -->
		<div class="accordion-group">
			<div id="collapse_search" class="accordion-body collapse">
				<div class="accordion-inner">
					<div class="panel panel-default" style="margin-bottom: 0px;">
            				<div class="panel-body" >
			                <form id="searchForm" class="form form-horizontal" action="" method="post">
			                    <div class="col-xs-12 col-sm-6 col-md-4">
			                        <label  for="name">名称：</label>
			                        <div class="input-group col-md-12">
			                        	<input type="text" class="form-control input-sm" id="name" name="name">
			                        </div>
			                    </div>
			                    <div class="col-xs-12 col-sm-6 col-md-4">
			                         <label for="age">生日：</label>
			                         <div class="input-group col-md-12">
				                         <input type="text" class="form-control input-sm" name="birthday_begin" id="birthday_begin" />
					                     <span class="input-group-addon" >
					                        <span class="glyphicon glyphicon-calendar"></span>
					                     </span>
					                     <span class="input-group-addon input-sm" >
					                                           至
					                     </span>
					                     <input type="text" class="form-control input-sm" name="birthday_end" id="birthday_end" />
					                     <span class="input-group-addon" >
					                        <span class="glyphicon glyphicon-calendar"></span>
					                     </span>
				                     </div>
			                    </div>
			                    <div class="col-xs-12 col-sm-6 col-md-4">
			                         <label for="age">性别：</label>
			                         <div class="input-group col-md-12">
				                         <select class="form-control input-sm" id="sex" name="sex">
				                              <option value=""></option>
											  <option value="0">男</option>
											  <option value="0">女</option>
										 </select>
									</div>
			                    </div>
			                    <div class="col-xs-12 col-sm-6 col-md-4">
			                         <div  class="input-group col-md-12" style="margin-top:20px">
			                         <a type="button" onclick="jeecgDemoSearch();" class="btn btn-primary btn-rounded  btn-bordered btn-sm"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> 查询</a>
			                         <a type="button" onclick="jeecgDemoRest();" class="btn btn-primary btn-rounded  btn-bordered btn-sm"><span class="glyphicon glyphicon-repeat" aria-hidden="true"></span> 重置</a>
			                         </div>
			                    </div>
			                </form>
			                </div>
			             </div>
			       </div>
			</div>
		</div>
        <div id="toolbar">
            <button id="btn_add" type="button" class="btn btn-primary btn-sm" onclick="add('新增','jeecgListDemoController.do?goBootStrapTableAdd','jeecgDemoList',600,400)">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
            </button>
            <button id="btn_edit" type="button" class="btn btn-success btn-sm" onclick="update('修改','jeecgListDemoController.do?goBootStrapTableUpdate','jeecgDemoList',600,400)">
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
            </button>
            <button id="btn_delete" type="button" class="btn btn-danger btn-sm"  onclick="deleteALLSelect('批量删除','jeecgListDemoController.do?doBatchDel','jeecgDemoList',600,400)">
                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>批量删除
            </button>
            <a class="btn btn-default btn-sm" data-toggle="collapse" href="#collapse_search" id="btn_collapse_search" >
						<span class="glyphicon glyphicon-search" aria-hidden="true"></span> 检索 </a>
        </div>
        <div class="table-responsive">
            <!-- class="text-nowrap" 强制不换行 -->
         	<table id="jeecgDemoList"></table>
        </div>
    </div>
<script type="text/javascript">
	$(function () {
	
	    //1.初始化Table
	    var oTable = new TableInit();
	    oTable.Init();
	    
	    //判断是否选中表格中的数据，选中后可编辑或删除
	    $('#jeecgDemoList').on('check.bs.table uncheck.bs.table load-success.bs.table ' +
	            'check-all.bs.table uncheck-all.bs.table', function () {
	        $('#btn_delete').prop('disabled', ! $('#jeecgDemoList').bootstrapTable('getSelections').length);
	        $('#btn_edit').prop('disabled', $('#jeecgDemoList').bootstrapTable('getSelections').length!=1);
	    });
	    
		//日期控件初始化
	    laydate.render({
		   elem: '#birthday_begin'
		  ,type: 'datetime'
		  ,trigger: 'click' //采用click弹出
		  ,ready: function(date){
		  	 $("#birthday_begin").val(DateJsonFormat(date,this.format));
		  }
		});
		
	    //日期控件初始化
	    laydate.render({
		   elem: '#birthday_end'
		  ,type: 'datetime'
		  ,trigger: 'click' //采用click弹出
		  ,ready: function(date){
		  	 $("#birthday_end").val(DateJsonFormat(date,this.format));
		  }
		});
	    
	});
	
	
	var TableInit = function () {
	    var oTableInit = new Object();
	    //初始化Table
	    oTableInit.Init = function () {
	        $('#jeecgDemoList').bootstrapTable({
	            url: 'jeecgListDemoController.do?datagrid',         //请求后台的URL（*）
	            method: 'get',                      //请求方式（*）
	            toolbar: '#toolbar',                //工具按钮用哪个容器
	            striped: true,                      //是否显示行间隔色
	            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
	            pagination: true,                   //是否显示分页（*）
	            sortable: true,                     //是否启用排序
	            sortOrder: "asc",                   //排序方式
	            queryParams: oTableInit.queryParams,//传递参数（*）
	            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
	            pageNumber:1,                       //初始化加载第一页，默认第一页
	            pageSize: 10,                       //每页的记录行数（*）
	            pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
	            strictSearch: true,
	            showColumns: true,                  //是否显示所有的列
	            showRefresh: true,                  //是否显示刷新按钮
	            minimumCountColumns: 2,             //最少允许的列数
	            clickToSelect: true,                //是否启用点击选中行
	            height : $(window).height()-35,   //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
	            uniqueId: "id",                   //每一行的唯一标识，一般为主键列
	            showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
	            cardView: false,                    //是否显示详细视图
	            detailView: false,                   //是否显示父子表
	  	        showExport: true,                    //显示到处按钮
	            columns: [{
	                checkbox: true, // 显示一个勾选框
	                align: 'center' // 居中显示,
	                
	            }, {
	                title: '序号',
	                width:5 ,
	                align:'center',
	                switchable:false,
	                formatter:function(value,row,index){
	                    //return index+1; //序号正序排序从1开始
	                    var pageSize=$('#jeecgDemoList').bootstrapTable('getOptions').pageSize;
	                    var pageNumber=$('#jeecgDemoList').bootstrapTable('getOptions').pageNumber;
	                    return pageSize * (pageNumber - 1) + index + 1; 
	                }
	            },{
	                field: 'name',
	                title: '名称',
	                align: 'center',
	                valign: 'middle',
	                sortable:true
	            },{
	                field: 'sex',
	                title: '性别',
	                align: 'center',
	                valign: 'middle',
	                formatter: function (value, row, index) {
	                	if(value == '1'){
	                		return "女"
	                	}
	                	if(value == '0'){
	                		return "男"
	                	}
	                    return value;
	                }
	            }, {
	                field: 'age',
	                title: '年龄',
	                align: 'center',
	                valign: 'middle',
	                sortable:true
	            }, {
	                field: 'content',
	                title: '个人介绍',
	                align: 'center',
	                valign: 'middle',
	                sortable:true
	            }, {
	                field: 'salary',
	                title: '工资',
	                align: 'center',
	                valign: 'middle',
	                sortable:true
	            },  {
	                field: 'birthday',
	                title: '生日',
	                align: 'center',
	                sortable:true
	            }, {
	                title: "操作",
	                align: 'center',
	                valign: 'middle',
	                width: 160, // 定义列的宽度，单位为像素px
	                formatter: function (value, row, index) {
	                    return '<button class="btn btn-danger btn-xs" onclick="delObj(\'jeecgListDemoController.do?doDel&id='+row.id+'\',\'jeecgDemoList\')"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除</button>';
	                }
	            } ],
	            onLoadSuccess: function(){  //加载成功时执行
	                console.info("加载成功");
	          },
	          onLoadError: function(){  //加载失败时执行
	                console.info("加载数据失败");
	          }
	        });
	    };
	
	    //得到查询的参数
	    oTableInit.queryParams = function (params) {
	        var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
	            pageSize: params.limit, // 每页要显示的数据条数
	            offset: params.offset,  //页码
	            sort: params.sort, // 排序规则
	            order: params.order,
	            rows: params.limit,                         //页面大小
	            page: (params.offset / params.limit) + 1,   //页码
	            pageIndex:params.pageNumber,//请求第几页
	            field:'id,name,sex,age,content,salary,birthday'
	        };
	        var params = $("#searchForm").serializeArray();  
	        for( x in params ){  
	            temp[params[x].name] = params[x].value;  
	        }  
	        return temp;
	    };
	    return oTableInit;
	};
	
	function jeecgDemoSearch(){
		reloadTable();
	}
	
	function reloadTable(){
		$('#jeecgDemoList').bootstrapTable('refresh');
	}
	
	function jeecgDemoRest(){
		$("#searchForm  input").val("");
		$("#searchForm  select").val("");
		$("#searchForm  .select-item").html("");
		reloadTable();
	}
</script>
</body>
</html>