${config_iframe}
<script type="text/javascript">
$(function(){$('#${config_id}List').datagrid(
	{
	idField: 'id',
	title: '${config_name}',
	//update-begin--Author:gengjiajia---------date:20160721--------for: 支持online报表  popup选择时支持传递参数
	//url:'cgReportController.do?datagrid&configId=${config_id}',
	url:'cgReportController.do?datagrid&configId=${config_id}${config_params}',
	//update-end--Author:gengjiajia---------date:20160721--------for: 支持online报表  popup选择时支持传递参数
	fit:true,
	fitColumns:true,
	pageSize: 10,
	pagination:true,
	pageList:[10,30,50,100],
	singleSelect:<#if (main.pop_retype=='2')>false<#else>true</#if>,
	sortOrder:'asc',
	rownumbers:true,
	showFooter:true,
	frozenColumns:[[]],
	columns:[
		[			<#if (config_fieldList?size>0)>
					{field:'ck',checkbox:true},
					<#list config_fieldList  as x>  
				 	<#if x_has_next>
					{field:'${x['field_name']}',title:'${x['field_txt']}',<#if x['is_show'] == 'N'>hidden:true,</#if>width:50},
					<#else>
					{field:'${x['field_name']}',title:'${x['field_txt']}',<#if x['is_show'] == 'N'>hidden:true,</#if>width:50}
				  	</#if>
					</#list>
					</#if>
		]
	],
	onLoadSuccess:function(data){$("#${config_id}List").datagrid("clearSelections");},
	onClickRow:function(rowIndex,rowData)
		{rowid=rowData.id;gridname='${config_id}List';}
	});
	$('#${config_id}List').datagrid('getPager').pagination({beforePageText:'',afterPageText:'/{pages}',displayMsg:'{from}-{to}共{total}条',showPageList:true,showRefresh:true});
	$('#${config_id}List').datagrid('getPager').pagination({onBeforeRefresh:function(pageNumber, pageSize){ $(this).pagination('loading');$(this).pagination('loaded'); }});});
	function reloadTable(){	
		try{
		$('#'+gridname).datagrid('reload');
		$('#'+gridname).treegrid('reload');
		}catch(ex){
			//donothing
		}
	}
	function reload${config_id}List(){$('#${config_id}List').datagrid('reload');}
	function get${config_id}ListSelected(field){return getSelected(field);}
	function getSelected(field){var row = $('#'+gridname).datagrid('getSelected');if(row!=null){value= row[field];}else{value='';}return value;}
	function get${config_id}ListSelections(field){var ids = [];var rows = $('#${config_id}List').datagrid('getSelections');for(var i=0;i<rows.length;i++){ids.push(rows[i][field]);}ids.join(',');return ids};
	function ${config_id}Listsearch(){var queryParams=$('#${config_id}List').datagrid('options').queryParams;$('#${config_id}Listtb').find('*').each(function(){queryParams[$(this).attr('name')]=$(this).val();});$('#${config_id}List').datagrid({url:'cgReportController.do?datagrid&configId=${config_id}',pageNumber:1});}
	function dosearch(params){var jsonparams=$.parseJSON(params);$('#${config_id}List').datagrid({url:'cgReportController.do?datagrid&configId=${config_id},',queryParams:jsonparams});}
	function ${config_id}Listsearchbox(value,name){var queryParams=$('#${config_id}List').datagrid('options').queryParams;queryParams[name]=value;queryParams.searchfield=name;$('#${config_id}List').datagrid('reload');}$('#${config_id}Listsearchbox').searchbox({searcher:function(value,name){${config_id}Listsearchbox(value,name);},menu:'#${config_id}Listmm',prompt:'请输入查询关键字'});
	function searchReset_${config_id}(name){ $("#"+name+"tb").find(":input").val("");${config_id}Listsearch();}
	function getSelectRows(){
		//update-begin--Author:jg_renjie---------date:20150606--------for: popup功能多选只能返回一个值的错误
		//return $('#${config_id}List').datagrid('getSelections');
		//update-end--Author:jg_renjie---------date:20150606--------for: popup功能多选只能返回一个值的错误
		
		/**
		 * 解决popup功能多选只能返回一个值的错误
		 * add by suyh
		 */
		var allRowDataArr = $('#${config_id}List').datagrid('getData');
		var allSelectedRowDataArr = new Array();
		
		var selectedRowIndexArr = new Array();
		var selectedRows = $('.datagrid-view2 .datagrid-row-selected');
		if(selectedRows.size()>0){ //有被选中的行
			for(var i=0; i<selectedRows.size(); i++){
				var selectedRowIndex = $('.datagrid-view2 .datagrid-row-selected:eq(' + i + ')').attr('datagrid-row-index');
				selectedRowIndexArr.push(Number(selectedRowIndex));
				allSelectedRowDataArr.push(allRowDataArr.rows[Number(selectedRowIndex)]);
			}
		}
		
		return allSelectedRowDataArr;
	}
</script>
<table width="100%"   id="${config_id}List" toolbar="#${config_id}Listtb"></table>
<#-- update--begin--author:scott date:20170608 for:无查询条件不生成 -->
<#if  (config_queryList?size >0)>
<div id="${config_id}Listtb" style="padding:3px; height: auto">
<div name="searchColums" style="border-bottom:0px">
</#if>
<#-- update--end--author:scott date:20170608 for:无查询条件不生成 -->
	<#list config_queryList  as x>
		<span style="display:-moz-inline-box;display:inline-block;">
		<span style="vertical-align:middle;display:-moz-inline-box;display:inline-block;width: 100px;text-align:right;text-align:right;text-overflow:ellipsis;-o-text-overflow:ellipsis; overflow: hidden;white-space:nowrap;" title="${x['field_txt']}">${x['field_txt']}：</span>
		<#if x['search_mode']=="group">
			<input type="text" name="${x['field_name']}_begin"  style="width: 94px"  <#if x['field_type']=="Date">class="easyui-datebox"</#if> />
			<span style="vertical-align:middle;display:-moz-inline-box;display:inline-block;width: 8px;text-align:right;">~</span>
			<input type="text" name="${x['field_name']}_end"  style="width: 94px" <#if x['field_type']=="Date">class="easyui-datebox"</#if> />
		</#if>
		<#if x['search_mode']=="single">
				<#if  (x['field_dictlist']?size >0)>
				<select name = "${x['field_name']}" WIDTH="100" style="width: 104px">
				<option value = "">-- 请选择 --</option>
				<#list x['field_dictlist']  as xd>
					<option value = "${xd['typecode']}">${xd['typename']}</option>
				</#list>
				</select>
			</#if>
			<#if  (x['field_dictlist']?size <= 0)>
				<input type="text" name="${x['field_name']}"  style="width: 100px" <#if x['field_type']=="Date">class="easyui-datebox"</#if>  />
			</#if>
		</#if>
		</span>	
	</#list>
	<#-- update--begin--author:scott date:20171121 for:查询按钮调整位置 -->
	<#if  (config_queryList?size >0)>
		<span style="float:right">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="${config_id}Listsearch()">查询</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-reload" onclick="searchReset_${config_id}('${config_id}List')">重置</a>
		</span>
	</#if>
	<#-- update--end--author:scott date:2011121 for:查询按钮调整位置 -->
<#-- update--begin--author:scott date:20170608 for:无查询条件不生成 -->
<#if  (config_queryList?size >0)>
</div>
</div>
</#if>
<#-- update--end--author:scott date:20170608 for:无查询条件不生成 -->