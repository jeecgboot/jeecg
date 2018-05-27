${config_iframe}
<script type="text/javascript">
/**
*表单的高度,表单的宽度
**/
var ${config_id}Fw = 700,${config_id}Fh = 400;

$(function(){
	$.get("cgFormHeadController.do?checkIsExit&checkIsTableCreate&name=${config_id}",
	function(data){
		data = $.parseJSON(data);
		if(data.success){
			createDataGrid${config_id}();
		}else{
			alertTip('表:<span style="color:red;">${config_id}</span>还没有生成,请到表单配置生成表');
		}
	});
});

function createDataGrid${config_id}(){
	var initUrl = 'cgAutoListController.do?datagrid&configId=${config_id}&field=${fileds}${initquery}';
	initUrl = encodeURI(initUrl);
	$('#${config_id}List').<#if config_istree=="Y">treegrid<#else>datagrid</#if>(
	{
	<#if config_istree=="Y">treeField:'text',</#if>
	url:initUrl,
	idField: 'id', <#if config_istree=="Y">treeField:"${tree_fieldname}",</#if>
	title: '${config_name}',
	fit:true,
	fitColumns:true,
	striped:true,
	autoRowHeight:true,
	pageSize: 10,
	<#if config_ispagination =="Y">pagination:true,</#if>
	<#if config_ischeckbox=="Y">singleSelect:false,<#else>singleSelect:true,</#if>
	<#if fileds?index_of("create_datetime")!=-1 >
		sortName:'create_datetime',
	<#elseif fileds?index_of("create_date")!=-1 && fileds?index_of("create_datetime")==-1>
		sortName:'create_date',
	<#else>
		sortName:'id',
	</#if>
	pageList:[10,30,50,100],
	sortOrder:'desc',
	rownumbers:true,
	showFooter:true,
	frozenColumns:[[]],
	columns:[
		[	
			<#if config_istree=="Y">
				<#list config_fieldList  as x>  
					<#if x_index==0>{field:"id", title:"${x['field_title']}", hidden:true}, </#if>
					<#if x_index!=0>{field:"${x['field_id']}", title:"${x['field_title']}",<#if x['field_isShow'] == "N" >hidden:true,</#if><#if x['field_href'] != "">formatter:function(value,rec,index){var href='';href+="<a href='#' onclick=\"addOneTab('字段链接','${x['field_href']}')\" ><u>"+value+"</u></a>";return href;},</#if> width:100}, </#if>
				</#list>
			<#else>
					<#if config_ischeckbox=="Y">{field:'ck',checkbox:true},</#if>
					<#list config_fieldList  as x>  
						 {	field:'${x['field_id']}',
						 	title:'${x['field_title']}',
						 	<#if x['field_isShow'] == "N" >hidden:true,
						 	</#if>
						 	<#if x['field_href'] != "">
						 	formatter:function(value,rec,index){
						 		var href='';
						 		href+=applyHref('字段链接','${x['field_href']}',value,rec,index);
						 		return href;
						 	},
						 	</#if>
						 	<#if x['field_showType']=="file">
						 	formatter:function(value,rec,index){
						 		var href='';
						 		if(value==null || value.length==0){
						 			return href;
						 		}
						 		if(value.indexOf(".jpg")>-1 || value.indexOf(".gif")>-1 || value.indexOf(".png")>-1){
						 			href+="<img src='"+value+"'/>";
						 		}else{
						 			href+="<a href='"+value+"' target=_blank><u>点击下载</u></a>";
						 		}
						 		return href;
						 	},
						 	</#if>
						 	sortable:true,
						 	width:${x['field_length']}
						 	},
					</#list>
			</#if>
			{field:'opt',title:'操作',width:200,formatter:function(value,rec,index){
						if(!rec.id){return '';}
						var href='';
						<#if config_noliststr?index_of("delete")==-1>
						href+="[<a href='#' onclick=delObj('cgAutoListController.do?del&configId=${config_id}&id="+rec.id+"','${config_id}List')>";
						href+="删除</a>]";
						</#if>
						<#list config_buttons as x>
							<#if x['buttonStyle'] == 'link' && x['buttonStatus']=='1' && config_noliststr?index_of("${x['buttonCode']}")==-1>
								href+="[<a href='#' buttonCode='${x['buttonCode']}' formId ='${x['formId']}' ";
								<#if x['optType'] == 'action'>
								href+=" onclick=\"doBusButtonForLink('cgFormBuildController.do?doButton&formId=${x['formId']}&buttonCode=${x['buttonCode']}&tableName=${config_id}','${x['buttonName']}','${config_id}List','"+rec.id+"')\"";
								<#else>
								href+=" onclick=\"${x['buttonCode']}('"+rec.id+"');\"";
								</#if>
								href+=" id=\"${x['buttonCode']}\">";
								href+="${x['buttonName']}</a>]";
							</#if>
						</#list>
						return href;
						}
			}
		]
	],
	onLoadSuccess:function(data){
		$("#${config_id}List").<#if config_istree=="Y">treegrid<#else>datagrid</#if>("clearSelections");
	},
	onClickRow:function(rowIndex,rowData)
		{rowid=rowData.id;gridname='${config_id}List';}
	});
	$('#${config_id}List').<#if config_istree=="Y">treegrid<#else>datagrid</#if>('getPager').pagination({beforePageText:'',afterPageText:'/{pages}',displayMsg:'{from}-{to}共{total}条',showPageList:true,showRefresh:true});
	$('#${config_id}List').<#if config_istree=="Y">treegrid<#else>datagrid</#if>('getPager').pagination({onBeforeRefresh:function(pageNumber, pageSize){ $(this).pagination('loading');$(this).pagination('loaded'); }});
	//将没有权限的按钮屏蔽掉
	<#list config_nolist as x>
		$("#${config_id}Listtb").find("${x}").hide();
	</#list>
	}
	//列表刷新
	function reloadTable(){	
		try{
		<#if config_istree=="Y">
			$('#'+gridname).treegrid('reload');
		<#else>
			$('#'+gridname).datagrid('reload');
		</#if>
		}catch(ex){
			//donothing
		}
	}
	//列表刷新-推荐使用
	function reload${config_id}List(){
		$('#${config_id}List').<#if config_istree=="Y">treegrid<#else>datagrid</#if>('reload');
	}
	/**
	 * 获取列表中选中行的数据-推荐使用
	 * @param field 数据中字段名
	 * @return 选中行的给定字段值
	 */
	function get${config_id}ListSelected(field){
		var row = $('#${config_id}List').<#if config_istree=="Y">treegrid<#else>datagrid</#if>('getSelected');
		if(row!=null){value= row[field];
		}else{
			value='';
		}
		return value;
	}
	/**
	 * 获取列表中选中行的数据
	 * @param field 数据中字段名
	 * @return 选中行的给定字段值
	 */
	function getSelected(field){
		var row = $('#'+gridname).<#if config_istree=="Y">treegrid<#else>datagrid</#if>('getSelected');
		if(row!=null){value= row[field];
		}else{
			value='';
		}
		return value;
	}
	
	/**
	 * 获取表格对象
	 * @return 表格对象
	 */
	function getDataGrid(){
		var datagrid = $('#'+gridname);
		return datagrid;
	}
	/**
	 * 获取列表中选中行的数据（多行）
	 * @param field 数据中字段名-不传此参数则获取全部数据
	 * @return 选中行的给定字段值，以逗号分隔
	 */
	function get${config_id}ListSelections(field){
		var ids = '';
		var rows = $('#${config_id}List').<#if config_istree=="Y">treegrid<#else>datagrid</#if>('getSelections');
		for(var i=0;i<rows.length;i++){
			ids+=rows[i][field];
			ids+=',';
		}
		ids = ids.substring(0,ids.length-1);
		return ids;
	}
	/**
	 * 列表查询
	 */
	function ${config_id}Listsearch(){
		var queryParams=$('#${config_id}List').<#if config_istree=="Y">treegrid<#else>datagrid</#if>('options').queryParams;
		$('#${config_id}Listtb').find('*').each(
			function(){
			queryParams[$(this).attr('name')]=$(this).val();});
			$('#${config_id}List').<#if config_istree=="Y">treegrid<#else>datagrid</#if>({url:'cgAutoListController.do?datagrid&configId=${config_id}&field=${fileds}',pageNumber:1});
	}
	function dosearch(params){
		var jsonparams=$.parseJSON(params);
		$('#${config_id}List').<#if config_istree=="Y">treegrid<#else>datagrid</#if>({url:'cgAutoListController.do?datagrid&configId=${config_id}&field=${fileds},',queryParams:jsonparams});
	}
	function ${config_id}Listsearchbox(value,name){
		var queryParams=$('#${config_id}List').<#if config_istree=="Y">treegrid<#else>datagrid</#if>('options').queryParams;
		queryParams[name]=value;
		queryParams.searchfield=name;
		$('#${config_id}List').<#if config_istree=="Y">treegrid<#else>datagrid</#if>('reload');
	}
	$('#${config_id}Listsearchbox').searchbox({
		searcher:function(value,name){
			${config_id}Listsearchbox(value,name);
		},
		menu:'#${config_id}Listmm',
		prompt:'请输入查询关键字'
	});
	//查询重置
	function ${config_id}searchReset(name){ 
		$("#"+name+"tb").find("input[type!='hidden']").val("");
		<#if config_istree=="Y">
		//为树形表单时，删除id查询参数
		delete $('#${config_id}List').treegrid('options').queryParams.id;  
		</#if>
		${config_id}Listsearch();
	}
	//将字段href中的变量替换掉
	function applyHref(tabname,href,value,rec,index){
		//addOneTab(tabname,href);
		var hrefnew = href;
		var re = "";
		var p1 = /\#\{(\w+)\}/g;
		try{
			var vars =hrefnew.match(p1); 
			for(var i=0;i<vars.length;i++){
				var keyt = vars[i];
				var p2 = /\#\{(\w+)\}/g;
				var key = p2.exec(keyt);
				 hrefnew =  hrefnew.replace(keyt,rec[key[1]]);
			}
		}catch(ex){
		}
		re += "<a href = '#' onclick=\"addOneTab('"+tabname+"','"+ hrefnew+"')\" ><u>"+value+"</u></a>";
		return re;
	}
	//SQL增强入口-按钮
	function doBusButton(url,content,gridname){
		var rowData = $('#'+gridname).datagrid('getSelected');
		if (!rowData) {
			tip('请选择一条信息');
			return;
		}	
		url = url + '&id='+rowData.id;
		createdialog('确认 ', '确定'+content+'吗 ?', url,gridname);
	}
	//SQL增强入口-操作列里的链接
	function doBusButtonForLink(url,content,gridname,rowData){
		if (!rowData) {
			tip('请选择一条信息');
			return;
		}	
		url = url + '&id='+rowData;
		createdialog('确认 ', '确定'+content+'吗 ?', url,gridname);
	}
	//新增
	function ${config_id}add(){
		add('${config_name}录入','cgFormBuildController.do?goAddFtlForm&tableName=${config_id}','${config_id}List',${config_id}Fw,${config_id}Fh);
	}
	//修改
	function ${config_id}update(){
		update('${config_name}编辑','cgFormBuildController.do?goUpdateFtlForm&tableName=${config_id}','${config_id}List',${config_id}Fw,${config_id}Fh);
	}
	//查看
	function ${config_id}view(){
		detail('查看','cgFormBuildController.do?goDatilFtlForm&tableName=${config_id}&mode=read','${config_id}List',${config_id}Fw,${config_id}Fh);
	}
	
	//批量删除
	function ${config_id}delBatch(){
		//获取选中的ID串
		var ids = get${config_id}ListSelections('id');
		if(ids.length<=0){
			tip('请选择至少一条信息');
			return;
		}
		$.dialog.confirm('确定删除吗?', function(r) {
			if(!r){return;}
			$.ajax({
			    url:"cgAutoListController.do?delBatch",
			    data:{'ids':ids,'configId':'${config_id}'},
				type:"Post",
			    dataType:"json",
			    success:function(data){
					tip(data.msg);
					reload${config_id}List();
			    },
				error:function(data){
					$.messager.alert('错误',data.msg);
				}
			});
			}
		);
	}

	function ${config_id}ExportExcel(){
		var queryParams = $('#${config_id}List').datagrid('options').queryParams;
		$('#${config_id}Listtb').find('*').each(function() {
		    queryParams[$(this).attr('name')] = $(this).val();
		});
		var params = '&';
		$.each(queryParams, function(key, val){
			params+='&'+key+'='+val;
		}); 
		var fields = '&field=';
		$.each($('#${config_id}List').datagrid('options').columns[0], function(i, val){
			if(val.field != 'opt'&&val.field != 'ck'){
				fields+=val.field+',';
			}
		});
        //update-begin--Author:dangzhenghui  Date:20170429 for：TASK #1906 【online excel】Online excel 导出功能改进
        var id='&id=';
        $.each($('#${config_id}List').datagrid('getSelections'), function(i, val){
            id+=val.id+",";
        });
        window.location.href = "excelTempletController.do?exportXls&tableName=${config_id}"+encodeURI(params+fields+id)
        //update-end--Author:dangzhenghui  Date:20170429 for：TASK #1906 【online excel】Online excel 导出功能改进
	}
	
	
	//JS增强
	${config_jsenhance}
</script>
<table width="100%"   id="${config_id}List" toolbar="#${config_id}Listtb"></table>
<div id="${config_id}Listtb" style="padding:3px; height: auto">
<div name="searchColums">
<#if config_querymode == "group">
	<#list config_queryList  as x>
		<#if x['field_isQuery']=="Y">
		<span style="display:-moz-inline-box;display:inline-block;">
		<span style="vertical-align:middle;display:-moz-inline-box;display:inline-block;width: 100px;text-align:right;text-align:right;text-overflow:ellipsis;-o-text-overflow:ellipsis; overflow: hidden;white-space:nowrap;" title="${x['field_title']}">${x['field_title']}：</span>
		</#if>
		<#if x['field_queryMode']=="group">
			<#if x['field_isQuery']=="Y">
			<input type="text" name="${x['field_id']}_begin"  style="width: 94px"  <#if x['field_type']=="Date">class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"</#if> value="${x['field_value_begin']}" />
			<span style="display:-moz-inline-box;display:inline-block;width: 8px;text-align:right;">~</span>
			<input type="text" name="${x['field_id']}_end"  style="width: 94px" <#if x['field_type']=="Date">class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"</#if> value="${x['field_value_end']}"/>
			<#else>
			<input type="hidden" name="${x['field_id']}_begin"   value="${x['field_value_begin']}"/>
			<input type="hidden" name="${x['field_id']}_end"    value="${x['field_value_end']}"/>
			</#if>
		</#if>
		<#if x['field_queryMode']=="single">
			<#if x['field_isQuery']=="Y">
				<#if  (x['field_dictlist']?size >0)>
					<select name = "${x['field_id']}"  style="width: 104px">
					<option value = "">-- 请选择 --</option>
					<#list x['field_dictlist']  as xd>
						<option value = "${xd['typecode']}">${xd['typename']}</option>
					</#list>
					</select>
				</#if>
				<#if  (x['field_dictlist']?size <= 0)>
					<#if x['field_showType']!='popup'>
					<input type="text" name="${x['field_id']}" style="width: 100px" <#if x['field_type']=="Date">class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"</#if>  value="${x['field_value']?if_exists?default('')}" />
					<#else>
					<input type="text" name="${x['field_id']}"  style="width: 100px" 
									class="searchbox-inputtext" value="${x['field_value']?if_exists?default('')}"
							       onClick="inputClick(this,'${x['field_dictField']?if_exists?html}','${x['field_dictTable']?if_exists?html}');" />
					</#if>
				</#if>
			<#else>
					<input type="hidden" name="${x['field_id']}"    value="${x['field_value']?if_exists?default('')}" />
			</#if>
		</#if>
		</span>	
	</#list>
</#if>
	</div>
	<div style="height:30px;" class="datagrid-toolbar">
	<span style="float:left;" >
	
	<a  id="add" href="#"  class="easyui-linkbutton" plain="true"  icon="icon-add" onclick="${config_id}add()">录入</a>
	<a  id="update" href="#"  class="easyui-linkbutton" plain="true"  icon="icon-edit" onclick="${config_id}update()">编辑</a>
	<a id="delete" href="#" class="easyui-linkbutton" plain="true"  icon="icon-remove" onclick="${config_id}delBatch()">批量删除</a>
	<a id="detail" href="#" class="easyui-linkbutton" plain="true"  icon="icon-search" onclick="${config_id}view()">查看</a>
	<a id="import" href="#"  class="easyui-linkbutton" plain="true"  icon="icon-put" onclick="add('${config_name}Excel数据导入','excelTempletController.do?goImplXls&tableName=${config_id}','${config_id}List')">Excel数据导入</a>
	<a id="excel" href="#" class="easyui-linkbutton" plain="true" onclick="${config_id}ExportExcel()"  icon="icon-putout">Excel导出</a>
	
	<#list config_buttons as x>
		<#if x['buttonStyle'] == 'button' && x['buttonStatus']=='1'>
			<a id="${x['buttonCode']}" href="#" class="easyui-linkbutton" plain="true"  icon="${x['buttonIcon']?if_exists?default('pictures')}" 
				<#if x['optType'] == 'action'>
				onclick="doBusButton('cgFormBuildController.do?doButton&formId=${x['formId']}&buttonCode=${x['buttonCode']}&tableName=${config_id}','${x['buttonName']}','${config_id}List')">${x['buttonName']}</a>
				<#else>
				onclick="${x['buttonCode']}();">${x['buttonName']}</a>
				</#if>
		</#if>
	</#list>
	</span>
	
<#if  (config_queryList?size >0)>
	<#if config_querymode == "group" >
		<span style="float:right">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="${config_id}Listsearch()">查询</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-reload" onclick="${config_id}searchReset('${config_id}List')">重置</a>
		</span>
	</#if>
	<#if config_querymode == "single">
		<span style="float:right">
		<input id="${config_id}Listsearchbox" class="easyui-searchbox"  data-options="searcher:${config_id}Listsearchbox,prompt:'请输入关键字',menu:'#${config_id}Listmm'"></input>
		<div id="${config_id}Listmm" style="width:120px">
		<#list config_queryList  as x>
			<#if x['field_isQuery']=="Y">
			<div data-options="name:'${x['field_id']}',iconCls:'icon-ok'  ">${x['field_title']}</div>
			<#else>
			</#if>
		</#list>
		</div>
		</span>
	</#if>
</#if>
	</div>
</div>
