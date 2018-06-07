<#if dataGrid.query==true>
<div class="panel-body" style="padding-bottom:0px;">
        <!-- 搜索 -->
		<div class="accordion-group">
			<div id="collapse_search" class="accordion-body collapse">
				<div class="accordion-inner">
					<div class="panel panel-default" style="margin-bottom: 0px;">
            				<div class="panel-body" >
			                <form id="searchForm" class="form form-horizontal" action="" method="post">
			                	<#list dataGrid.columnList as po>
								<#if po.query==true>
									<#include "/org/jeecgframework/tag/core/factory/ftl/component/bootstrapTable-search.ftl">
								</#if>
								</#list>
			                    <div class="col-xs-12 col-sm-6 col-md-4">
			                         <div  class="input-group col-md-12" style="margin-top:20px">
			                         <a type="button" onclick="searchList();" class="btn btn-primary btn-rounded  btn-bordered btn-sm"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> 查询</a>
			                         <a type="button" onclick="searchRest();" class="btn btn-primary btn-rounded  btn-bordered btn-sm"><span class="glyphicon glyphicon-repeat" aria-hidden="true"></span> 重置</a>
			                         </div>
			                    </div>
			                </form>
			                </div>
			             </div>
			       </div>
			</div>
		</div>
</div>
</#if>
<div class="panel-body" style="padding-top:0px;padding-bottom:0px;">
		<!-- toolbar -->
        <div id="toolbar">
            <#list dataGrid.toolBarList as po>
					<button  onclick="${po.funname}('${po.title}','${po.url}','${dataGrid.name}',600,400)"
					<#if po.icon=="icon-add">
					id="btn_add" class="btn btn-primary btn-sm" >
					<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
					<#elseif po.icon=="icon-edit">
					id="btn_edit" class="btn btn-success btn-sm" >
					<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
					<#elseif po.icon=="icon-put">
					id="btn_download" class="btn btn-info btn-sm" >
					<span class="glyphicon glyphicon-cloud-download" aria-hidden="true"></span>
					<#elseif po.icon=="icon-putout">
					id="btn_upload" class="btn btn-info btn-sm" >
					<span class="glyphicon glyphicon-cloud-upload" aria-hidden="true"></span>
					<#elseif po.icon=="icon-remove">
					id="btn_delete" class="btn btn-danger btn-sm" >
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
					<#elseif po.icon=="icon-search">
					class="btn btn-info btn-sm" >
					<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
					<#else>
					class="btn btn-info btn-sm" >
					<i class="${po.icon}"></i>
					</#if>
					${po.title}</button>
			</#list>
            <a class="btn btn-default btn-sm" data-toggle="collapse" href="#collapse_search" id="btn_collapse_search" >
						<span class="glyphicon glyphicon-search" aria-hidden="true"></span> 检索 </a>
        </div>
        <!-- data table -->
        <div class="table-responsive">
            <!-- class="text-nowrap" 强制不换行 -->
         	<table id="${dataGrid.name}"></table>
        </div>
    </div>
<script type="text/javascript">
	$(function () {
	
	    //1.初始化Table
	    var oTable = new TableInit();
	    oTable.Init();
	    
	    //判断是否选中表格中的数据，选中后可编辑或删除
	    $('#${dataGrid.name}').on('check.bs.table uncheck.bs.table load-success.bs.table ' +
	            'check-all.bs.table uncheck-all.bs.table', function () {
	        $('#btn_delete').prop('disabled', ! $('#${dataGrid.name}').bootstrapTable('getSelections').length);
	        $('#btn_edit').prop('disabled', $('#${dataGrid.name}').bootstrapTable('getSelections').length!=1);
	    });
	    
	});
	
	
	var TableInit = function () {
	    var oTableInit = new Object();
	    //初始化Table
	    oTableInit.Init = function () {
	        $('#${dataGrid.name}').bootstrapTable({
	            url: '${dataGrid.actionUrl}',         //请求后台的URL（*）
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
	            columns: [
	            // 复选框
	      		<#if dataGrid.checkbox==true>
			    {checkbox: true,align: 'center'},
				</#if>
				{
	                title: '序号',
	                width:5 ,
	                align:'center',
	                switchable:false,
	                formatter:function(value,row,index){
	                    //return index+1; //序号正序排序从1开始
	                    var pageSize=$('#${dataGrid.name}').bootstrapTable('getOptions').pageSize;
	                    var pageNumber=$('#${dataGrid.name}').bootstrapTable('getOptions').pageNumber;
	                    return pageSize * (pageNumber - 1) + index + 1; 
	                }
	            }
				<#list dataGrid.columnList as po>
				<#if po.field!="opt">
				 <#include "/org/jeecgframework/tag/core/factory/ftl/component/bootstrapTable-column.ftl">
				<#else>
				 ,{
	              title: "操作",align: 'center',valign: 'middle',width: ${po.width},
	              formatter: function (value, row, index) {
	                 <#include "/org/jeecgframework/tag/core/factory/ftl/component/bootstrapTable-opt.ftl">
	              }
	              }
				</#if>
				</#list>
	            ],
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
	              offset: params.offset, // 每页显示数据的开始行号
	              sort: params.sort, // 排序规则
	              order: params.order,
	              rows: params.limit,                         //页面大小
                  page: (params.offset / params.limit) + 1,   //页码
	              pageIndex:params.pageNumber,//请求第几页
	              field:'${dataGrid.fields}'
	        };
	        
			var params = $("#searchForm").serializeArray();  
	        for( x in params ){  
	            temp[params[x].name] = params[x].value;  
	        }  
	        return temp;
	    };
	    return oTableInit;
	};
	
	function searchList(){
		reloadTable();
	}
	
	function reloadTable(){
		$('#${dataGrid.name}').bootstrapTable('refresh');
	}
	
	function searchRest(){
		$("#searchForm  input").val("");
		$("#searchForm  select").val("");
		$("#searchForm  .select-item").html("");
		reloadTable();
	}
	
</script>
