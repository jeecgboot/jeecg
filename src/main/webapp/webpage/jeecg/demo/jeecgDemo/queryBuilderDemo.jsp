<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script>
//去掉sysUtil.js中定义的原默认右键菜单
//$.fn.datagrid.defaults.onHeaderContextMenu =null;
//$.fn.treegrid.defaults.onHeaderContextMenu =null;
</script>
<div class="easyui-layout" fit="true">
<div region="center" style="padding: 1px;">
<t:datagrid name="jeecgDemoList2" title="高级查询示例"  actionUrl="jeecgDemoController.do?datagrid"
	idField="id" queryMode="group" checkbox="true" extendParams="headerContextMenu: [
                { text: '保存列定义', iconCls: 'icon-save', disabled: false, handler: function () { saveHeader(); } },
                { text: '自定义菜单', iconCls: 'icon-reload', disabled: false, handler: function (e, field) { alert($.string.format('您点击了{0}', field)); } }
            ],">
	<t:dgCol title="编号" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="用户名" field="userName" query="true" ></t:dgCol>
	<t:dgCol title="电话号码"  field="mobilePhone" query="true"></t:dgCol>
	<t:dgCol title="办公电话" field="officePhone" query="true"></t:dgCol>
	<t:dgCol title="创建日期" field="createDate" formatter="yyyy-MM-dd" query="true" queryMode="group"></t:dgCol>
	<t:dgCol title="邮箱" field="email" query="true"></t:dgCol>
	<t:dgCol title="年龄" sortable="true" field="age" query="true"></t:dgCol>
	<t:dgCol title="工资" field="salary" query="true"></t:dgCol>

	<t:dgCol title="生日" field="birthday" formatter="yyyy/MM/dd" query="true"></t:dgCol>
	<t:dgToolBar operationCode="edit" title="录入" icon="icon-edit" url="jeecgDemoController.do?addorupdate" funname="add"></t:dgToolBar>
	<t:dgToolBar operationCode="edit" title="编辑" icon="icon-edit" url="jeecgDemoController.do?addorupdate" funname="update"></t:dgToolBar>
	<t:dgToolBar operationCode="add" title="高级查询" icon="icon-search" funname="queryBuilder" ></t:dgToolBar>
</t:datagrid></div>
</div>
<div style="position:relative;overflow:auto;">
	<div id="w" class="easyui-window" data-options="closed:true,title:'高级查询构造器'" style="width:600px;height:370px;padding:0px">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'east',split:true" style="width:130px">
<div class="easyui-accordion" style="width:120px;height:300px;">
		<div title="查询历史" data-options="iconCls:'icon-search'" style="padding:0px;">
			<ul id="tt" class="easyui-tree" data-options="onClick:function(node){//单击事件  
       historyQuery( node.id);  
    },ondbClick: function(node){alert('s');
				$(this).tree('beginEdit',node.target);
			},onContextMenu: function(e,node){
				e.preventDefault();
				$(this).tree('select',node.target);
				$('#mmTree').menu('show',{
					left: e.pageX,
					top: e.pageY
				});
			},  
         onAfterEdit:function(node){  
            if(node.text!=''){ his[node.id].name=node.text; saveHistory();}
	}">
			</ul>
		</div>
</div></div>
			<div data-options="region:'center'" style="padding:0px;">
				<table id="tg" class="easyui-treegrid" title="查询条件编辑" style="width:450px;height:300px;"
			data-options="
				iconCls: 'icon-ok',
				rownumbers: true,
				animate: true,
				fitColumns: true,
				//url: 'sqlbuilder.json',//可以预加载条件
				method: 'get',
				idField: 'id', autoEditing: true,          //该属性启用双击行时自定开启该行的编辑状态
                extEditing: false,           //该属性启用行编辑状态的 ExtEditing 风格效果，该属性默认为 true。
                singleEditing: false ,
				treeField: 'field',toolbar:toolbar,onClickRow: function (e) {
                   $('#tg').treegrid('beginEdit',e);//'beginEdit‘方法必须有一个参数
                }
			">
		<thead>
			<tr>
				<th data-options="field:'relation',width:19,formatter:function(value,row){
							return value=='and'?'并且':'或者';
						},editor:{
							type:'combobox',
							options:{
								valueField:'relationId',
								textField:'relationName',
								data:  
								[  
								{'relationId':'and','relationName':'并且'},  
								{'relationId':'or','relationName':'或者'}  
								],  
								required:true
							}}">关系</th>
				<th data-options="field:'field',width:30,formatter:function(value,row){
								var data=  
								[  
								{'fieldId':'officePhone','fieldName':'办公电话'},
								{'fieldId':'userName','fieldName':'用户名'},
								{'fieldId':'age','fieldName':'年龄'},
								{'fieldId':'email','fieldName':'邮箱'},
								{'fieldId':'mobilePhone','fieldName':'手机号'},
								{'fieldId':'createDate','fieldName':'创建日期'}
								];
							for(var i=0;i<data.length;i++){
								if(value == data[i]['fieldId']){
									return data[i]['fieldName'];
								}
							}
							return value;
						},editor:{
							type:'combobox',
							options:{
								valueField:'fieldId',
								textField:'fieldName',
								data:  
								[  
								{'fieldId':'officePhone','fieldName':'办公电话'},
								{'fieldId':'userName','fieldName':'用户名' },
								{'fieldId':'age','fieldName':'年龄',editor:'numberbox'},
								{'fieldId':'email','fieldName':'邮箱'},
								{'fieldId':'mobilePhone','fieldName':'手机号'},
								{'fieldId':'createDate','fieldName':'创建日期',editor:'datebox'}
								],  
								required:true
                                ,  onSelect : function(record) {
                                    	var opts = $('#tg').treegrid('getColumnOption','value');
										if(record.editor){
												opts.editor=record.editor;
										}else{
											return ;
										}
										var tr = $(this).closest('tr.datagrid-row');
										var index = parseInt(tr.attr('node-id'));
										$('#tg').treegrid('endEdit', index);
										$('#tg').treegrid('beginEdit', index);
                                    }
							}}">字段</th>
				<th data-options="field:'condition',width:20,align:'right',formatter:function(value,row){
								var data=  
								[  
								{'conditionId':'=','conditionName':'等于'},
								{'conditionId':'>','conditionName':'大于'},
								{'conditionId':'<','conditionName':'小于'},
								{'conditionId':'like','conditionName':'包含'},
								{'conditionId':'in','conditionName':'在其中'}
								];
							for(var i=0;i<data.length;i++){
								if(value == data[i]['conditionId']){
									return data[i]['conditionName'];
								}
							}
							return value;
						},editor:{
							type:'combobox',
							options:{
								valueField:'conditionId',
								textField:'conditionName',	
							data:  
								[  
								{'conditionId':'=','conditionName':'等于'},
								{'conditionId':'>','conditionName':'大于'},
								{'conditionId':'<','conditionName':'小于'},
								{'conditionId':'like','conditionName':'包含'},
								{'conditionId':'in','conditionName':'在其中'}
								],  
								required:true
							}}">条件</th>
				<th data-options="field:'value',width:30,editor:'text'">值</th>
					<th data-options="field:'opt',width:30,formatter:function(value,row){
							return '<a  onclick=\'removeIt('+row.id+')\' >删除</a>';
						}">操作</th>
			</tr>
		</thead>
	</table>
	
			</div>
			<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="javascript:queryBuilderSearch()">OK</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="javascript:$('#w').window('close')">Cancel</a>
			</div>
		</div>	
	</div>		
</div>
<div id="mm" class="easyui-menu" style="width:120px;">
		<div onclick="append()" data-options="iconCls:'icon-add'">添加</div>
		<div onclick="edit()" data-options="iconCls:'icon-edit'">编辑</div>
		<div onclick="save()" data-options="iconCls:'icon-save'">保存</div>
		<div onclick="removeIt()" data-options="iconCls:'icon-remove'">删除</div>
		<div class="menu-sep"></div>
		<div onclick="cancel()">取消编辑</div>
	</div>
<div id="mmTree" class="easyui-menu" style="width:100px;">
		<div onclick="editTree()" data-options="iconCls:'icon-edit'">编辑</div>
		<div onclick="deleteTree()" data-options="iconCls:'icon-remove'">删除</div>
	</div>
	<script type="text/javascript">
		var toolbar = [{
			text:'',
			iconCls:'icon-add',
			handler:function(){append();}
		},{
			text:'',
			iconCls:'icon-edit',
			handler:function(){edit();}
		},{
			text:'',
			iconCls:'icon-remove',
			handler:function(){removeIt();}
		},'-',{
			text:'',
			iconCls:'icon-save',
			handler:function(){save();}
		}];
		function onContextMenu(e,row){
			e.preventDefault();
			$(this).treegrid('select', row.id);
			$('#mm').menu('show',{
				left: e.pageX,
				top: e.pageY
			});
		}
		var idIndex = 100;
		function append(){
			idIndex++;
			var node = $('#tg').treegrid('getSelected');
			$('#tg').treegrid('append',{
				data: [{
					id: idIndex,
					field: 'userName',
					condition:'like',
					value: '%王%',
					relation: 'and'
				}]
			});
			$('#tg').treegrid('beginEdit',idIndex);
		}
		
		function removeIt( id){
			var node = $('#tg').treegrid('getSelected');
			if(id){
			$('#tg').treegrid('remove', id);
			}else if (node){
				$('#tg').treegrid('remove', node.id);
			}
			
			
		}
		function collapse(){
			var node = $('#tg').treegrid('getSelected');
			if (node){
				$('#tg').treegrid('collapse', node.id);
			}
		}
		function expand(){
			var node = $('#tg').treegrid('getSelected');
			if (node){
				$('#tg').treegrid('expand', node.id);
			}
		}
		var editingId;
		function edit(){
			var row = $('#tg').treegrid('getSelected');
			if (row){
				editingId = row.id
				$('#tg').treegrid('beginEdit', editingId);
			}
		}
		function save(){
				var t = $('#tg');
				var nodes = t.treegrid('getRoots');
				for (var i = 0; i < nodes.length; i++) {
					t.treegrid('endEdit',nodes[i].id);
					}

		}
		function cancel(){
			var nodes = t.treegrid('getRoots');
				for (var i = 0; i < nodes.length; i++) {
					t.treegrid('cancelEdit',nodes[i].id);
			}
		}
		var his=new Array();
	

		function view(){
			save();
			var t = $('#tg');
			var data = t.treegrid('getData');
			return   JSON.stringify(data) ;
		}
	</script><script type="text/javascript" src="plug-in/jquery/jquery.cookie.js" ></script>
		<script type="text/javascript" src="plug-in/jquery-plugs/storage/jquery.storageapi.min.js" ></script>

	<script type="text/javascript">

	$(document).ready(function(){append();
		$("input[name='createDate_begin']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
		$("input[name='createDate_end']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
		$("input[name='birthday']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
		storage=$.localStorage; 
		if(!storage)
			storage=$.cookieStorage;
		var h = storage.get('his');
		if(h){his=h;
			for(var i=0;i<his.length;i++){
				if(his[i])appendTree(i,his[i].name);
			}
  	 	}//restoreheader();
	});


function queryBuilder() {
	$('#w').window('open');
}
  function historyQuery(index) {
    	var data  = { rows:JSON.parse(his[index].json)};
   	 var t = $('#tg');
	var data = t.treegrid('loadData',data);
	$('#_sqlbuilder').val(his[index].json);   
	jeecgDemoList2search();
}
 function queryBuilderSearch() {
         var json =  view();var t = $('#tg');
	$('#_sqlbuilder').val(json);   
	var isnew=true;
	for(var i=0;i<his.length;i++){
		if(his[i]&&his[i].json==json){
			isnew=false;
		}
	}
	if(isnew){
		his.push({name:'Query'+his.length,json:json});
		saveHistory();
		var name= 'Query'+(his.length-1);
		appendTree(his.length-1,name);
	}

	jeecgDemoList2search();
 }
//查询历史操作
function saveHistory(){
	var history=new Array();
	for(var i=0;i<his.length;i++){
		if(his[i]){
			history.push(his[i]);
		}
	}
	storage.set( 'his',JSON.stringify(history));
}
function deleteTree(){
	var node = $('#tt').tree('getSelected');
	his[node.id]=null;saveHistory();
	$('#tt').tree('remove', node.target);
}
function editTree(){
	var node = $('#tt').tree('getSelected');
	$('#tt').tree('beginEdit',node.target);
		his[node.id].name=null;saveHistory();
}
function appendTree(id,name){
	$('#tt').tree('append',{
		data:[{
			id : id,
			text :name
		}]
         });
}
function saveHeader1(){
	var cols = storage.get( 'DemohiddenColumns');//alert(cols.length+cols);
	var init=true;
	if(cols){
		init =false;
	}
 //var columnsFields =$('#jeecgDemoList2').datagrid('getColumnFields');
 var columnsFields =$('#jeecgDemoList2').datagrid('getColumns');
 var hiddencolumns = [],  columsDetail;

   for (var i=0;i< columnsFields.length;i++) {i.hidable=true;
                      //  columsDetail = $('#jeecgDemoList2').datagrid("getColumnOption", columnsFields[i]);
			if(init&&columnsFields[i].hidden){
				hiddencolumns.push({field:columnsFields[i].field,hidden:columnsFields[i].hidden,visible:false});
			}else{hiddencolumns.push({field:columnsFields[i].field,hidden:columnsFields[i].hidden});
			}
   }//alert(JSON.stringify(hiddencolumns));
	storage.set( 'DemohiddenColumns',JSON.stringify(hiddencolumns));
}
function restoreheader1(){
	
	var cols = storage.get( 'DemohiddenColumns');//alert(cols.length+cols);
	if(!cols){
		return;
	}
	for(var i=0;i<cols.length;i++){
		try{
		if(cols.visible)$('#jeecgDemoList2').datagrid((cols[i].hidden==true?'hideColumn':'showColumn'),cols[i].field);
}catch(e){//alert(e+"-"+cols[i].field)
}

	}
}
</script>
