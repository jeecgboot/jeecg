<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
<div region="center" style="padding:0px;border:0px">
<table id="jeecgEasyUIList" style="width: 700px; height: 300px">
	<thead>
		<tr>
			<th field="id" hidden="hidden">编号</th>
			<th field="userName" width="50">姓名</th>
			<th field="depId" width="50" replace="${departsReplace}">部门</th>
			<th field="sex" width="50">性别</th>
			<th field="age" width="50">年龄</th>
			<th field="birthday" width="50">生日</th>
			<th field="email" width="50">E-Mail</th>
			<th field="mobilePhone" width="50">手机</th>
			<th field="opt" width="100">操作</th>
		</tr>
	</thead>
</table>
<div id="tb2" style="height: 30px;" class="datagrid-toolbar"><span style="float: left;"> 
<a href="#" id='add' class="easyui-linkbutton" plain="true" icon="icon-add"
	onclick="add('录入','jeecgEasyUIController.do?addorupdate','jeecgEasyUIList')" id="">录入</a> 
	<a href="#" class="easyui-linkbutton" plain="true" icon="icon-edit"
	onclick="update('编辑','jeecgEasyUIController.do?addorupdate','jeecgEasyUIList')" id="">编辑</a> 
	<a href="#" class="easyui-linkbutton" plain="true" icon="icon-search"
	onclick="detail('查看','jeecgEasyUIController.do?addorupdate','jeecgEasyUIList')" id="">查看</a> </span> 
	<span style="float: right"> <input id="jeecgEasyUIListsearchbox" class="easyui-searchbox"
	data-options="searcher:jeecgEasyUIListsearchbox,prompt:'请输入关键字',menu:'#jeecgEasyUIListmm'"></input>
<div id="jeecgEasyUIListmm" style="width: 120px">
<div data-options="name:'userName',iconCls:'icon-ok'">姓名</div>
<div data-options="name:'mobilePhone',iconCls:'icon-ok'">手机</div>
</div>
</span></div>
<script type="text/javascript">
	    // 编辑初始化数据
		function getData(data){
			var rows = [];			
			var total = data.total;
			for(var i=0; i<data.rows.length; i++){
				rows.push({
					id: data.rows[i].id,
					userName: data.rows[i].userName,
					depId: data.rows[i].depId,
					sex: data.rows[i].sex,
					age: data.rows[i].age,
					birthday: data.rows[i].birthday,
					email: data.rows[i].email,
					mobilePhone: data.rows[i].mobilePhone,
					opt: "[<a href=\"#\" onclick=\"delObj('jeecgEasyUIController.do?del&id="+data.rows[i].id+"','jeecgEasyUIList')\">删除</a>]"
				});
			}
			var newData={"total":total,"rows":rows};
			return newData;
		}
	    // 筛选
		function jeecgEasyUIListsearchbox(value,name){
    		var queryParams=$('#jeecgEasyUIList').datagrid('options').queryParams;
    		queryParams[name]=value;
    		queryParams.searchfield=name;
    		$('#jeecgEasyUIList').datagrid('load');
    	}
	    // 刷新
	    function reloadTable(){
	    	$('#jeecgEasyUIList').datagrid('reload');
	    }
	    
		// 设置datagrid属性
		$('#jeecgEasyUIList').datagrid({
			title: '页面不用自定义标签',
	        idField: 'id',
	        fit:true,
	        loadMsg: '数据加载中...',
	        pageSize: 10,
	        pagination:true,
	        sortOrder:'asc',
	        rownumbers:true,
	        singleSelect:true,
	        fitColumns:true,
	        showFooter:true,
	        url:'jeecgEasyUIController.do?datagrid',  
	        toolbar: '#tb2',
	        loadFilter: function(data){
	        	return getData(data);
	    	}
	        
	    }); 
	    //设置分页控件  
	    $('#jeecgEasyUIList').datagrid('getPager').pagination({  
	        pageSize: 10,  
	        pageList: [10,20,30],  
	        beforePageText: '',  
	        afterPageText: '/{pages}',
	        displayMsg: '{from}-{to}共{total}条',
	        showPageList:true,
	        showRefresh:true,
	        onBeforeRefresh:function(pageNumber, pageSize){
	            $(this).pagination('loading');
	            $(this).pagination('loaded');
	        }
	    });
	    // 设置筛选
    	$('#jeecgEasyUIListsearchbox').searchbox({
    		searcher:function(value,name){
    			jeecgEasyUIListsearchbox(value,name);
    		},
    		menu:'#jeecgEasyUIListmm',
    		prompt:'请输入查询关键字'
    	});
	</script></div>
</div>
