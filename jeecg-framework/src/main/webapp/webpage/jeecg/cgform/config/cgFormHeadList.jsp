<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<SCRIPT type=text/javascript src="plug-in/clipboard/ZeroClipboard.js"></SCRIPT>
<div class="easyui-layout" fit="true">
<div region="center" style="padding: 1px;"><t:datagrid sortName="createDate" sortOrder="desc" name="tablePropertyList" title="智能表单配置" fitColumns="false"
	actionUrl="cgFormHeadController.do?datagrid" idField="id" fit="true" queryMode="group" checkbox="true">
	<t:dgCol title="编号" field="id" hidden="false"></t:dgCol>
	<t:dgCol title="表类型" field="jformType" replace="单表_1,主表_2,附表_3" query="true"></t:dgCol>
	<t:dgCol title="表名" field="tableName" query="true" autocomplete="true" />
	<t:dgCol title="表描述" field="content"></t:dgCol>
	<t:dgCol title="版本" field="jformVersion"></t:dgCol>
	<t:dgCol title="是否树形" field="isTree" replace="是_Y,否_N"></t:dgCol>
	<t:dgCol title="是否分页" field="isPagination" replace="是_Y,否_N"></t:dgCol>
	<t:dgCol title="同步数据库" field="isDbSynch" replace="已同步_Y,未同步_N" style="background:red;_N" query="true"></t:dgCol>
	<t:dgCol title="显示复选框" field="isCheckbox" replace="是_Y,否_N"></t:dgCol>
	<t:dgCol title="查询模式" field="querymode"></t:dgCol>
	<t:dgCol title="创建人" field="createBy" hidden="false"></t:dgCol>
	<t:dgCol title="创建时间" field="createDate" formatter="yyyy/MM/dd"></t:dgCol>
	<t:dgCol title="修改人" field="updateBy" hidden="false"></t:dgCol>
	<t:dgCol title="修改时间" field="updateDate" formatter="yyyy/MM/dd"></t:dgCol>
	<t:dgCol title="操作" field="opt"></t:dgCol>
	<t:dgFunOpt funname="delCgForm(id,tableName)" title="删除"></t:dgFunOpt>
	<t:dgFunOpt funname="remCgForm(id)" title="移除"></t:dgFunOpt>
	<t:dgFunOpt exp="isDbSynch#eq#N" title="同步数据库" funname="doDbsynch(id,content)" />
	<t:dgFunOpt exp="isDbSynch#eq#Y&&jformType#ne#3" funname="addbytab(id,content)" title="表单模板"></t:dgFunOpt>
	<t:dgFunOpt exp="isDbSynch#eq#Y&&jformType#ne#3" funname="addlisttab(tableName,content)" title="功能测试"></t:dgFunOpt>
	<t:dgFunOpt exp="isDbSynch#eq#Y&&jformType#ne#3" funname="popMenuLink(tableName,content)" title="配置地址"></t:dgFunOpt>
	<t:dgToolBar title="创建表单" icon="icon-add" width="900" height="600" url="cgFormHeadController.do?addorupdate" funname="addForm"></t:dgToolBar>
	<t:dgToolBar title="编辑表单" icon="icon-edit" width="900" height="600" url="cgFormHeadController.do?addorupdate" funname="updateForm"></t:dgToolBar>
	<t:dgToolBar title="自定义按钮" icon="icon-edit" url="cgformButtonController.do?cgformButton" funname="cgFormButton"></t:dgToolBar>
	<t:dgToolBar title="JS增强" icon="icon-edit" url="cgformEnhanceJsController.do?addorupdate" funname="enhanceJs"></t:dgToolBar>
	<t:dgToolBar title="SQL增强" icon="icon-edit" url="cgformButtonSqlController.do?addorupdate" funname="cgFormButtonSql"></t:dgToolBar>
	<t:dgToolBar title="表单组件导出" icon="icon-putout" url="cgformSqlController.do?doMigrateOut" funname="doMigrateOut"></t:dgToolBar>
	<t:dgToolBar title="表单组件导入" icon="icon-put" url="cgformSqlController.do?inSqlFile" funname="toCgformMigrate"></t:dgToolBar>
	<t:dgToolBar title="代码生成" icon="icon-add" url="generateController.do?gogenerate" funname="generate"></t:dgToolBar>
	<t:dgToolBar title="数据库表生成表单" icon="icon-add" url="cgformTransController.do?trans" funname="addToData"></t:dgToolBar>
</t:datagrid></div>
</div>

<SCRIPT type="text/javascript">
 	var clip;
	function addbytab(id,content) {
		addOneTab("表单模板", "cgformFtlController.do?cgformFtl2&formid="+id);
	}

	//数据库表生成表单
	function addToData(title,url,id,a,b){
  		$.dialog({
			content: "url:"+url,
			lock : true,
			title: title,
			opacity : 0.3,
			width:400,
			height:500,
			cache:false,
		    cancelVal: '关闭',
		    cancel: true 
		});
	}
	function delCgForm(id,name){
		$.dialog.confirm("确认删除该记录", function(){
			checkIsExit(id,name);
		}, function(){
		});
	}
	//检查这个表是否已经存在了
	function checkIsExit(id,name){
		$.post("cgFormHeadController.do?checkIsExit&&name="+name,function(data){
			var d = $.parseJSON(data);
			if (d.success) {
				$.dialog.confirm("表在数据库中已存在\n确认删除", function(){
					delThis(id);
				}, function(){
				});
			}else{
				delThis(id);
			}
		});
	}
	//删除这个配置
	function delThis(id){
		doSubmit("cgFormHeadController.do?del&id="+id,"tablePropertyList");
	}

	function remCgForm(id){
		$.dialog.confirm("确认移除该记录", function(){
			removeThis(id);
		}, function(){
		});
	}
	
	function removeThis(id){
		doSubmit("cgFormHeadController.do?rem&id="+id,"tablePropertyList");
	}

	function addlisttab(tableName,content){
		addOneTab("表单数据列表 ["+content+"]", "cgAutoListController.do?list&id="+tableName);
	}
	
	function addForm(title,url,id){
		gridname=id;
		createwindow(title,url,900,500);
	}
	function updateForm(title,url,id){
		gridname=id;
		var rowsData = $('#'+id).datagrid('getSelections');
		if (!rowsData || rowsData.length==0) {
			tip('请选择编辑项目');
			return;
		}
		if (rowsData.length>1) {
			tip('请选择一条记录再编辑');
			return;
		}
		createwindow(title,url + '&id='+rowsData[0].id,900,500);

	}
	function jsPlugin(title,url,id){
		var rowsData = $('#'+id).datagrid('getSelections');
		if (!rowsData || rowsData.length==0) {
			tip('请选择编辑项目');
			return;
		}
		if (rowsData.length>1) {
			tip('请选择一条记录再编辑');
			return;
		}
		url += '&id='+rowsData[0].id;
  		$.dialog({
			content: "url:"+url,
			lock : true,
			title:"JS增强["+rowData.content+"]",
			opacity : 0.3,
			width:900,
			height:500,
			cache:false,
		    ok: function(){
		    	iframe = this.iframe.contentWindow;
		    	iframe.goForm();
				return false;
		    },
		    cancelVal: '关闭',
		    cancel: true /*为true等价于function(){}*/
		});
	}
	
	/**
	*	弹出菜单链接
	*/
	function popMenuLink(tableName,content){
		var url = "<input type='text' style='width:380px;' disabled=\"disabled\" id='menuLink' title='cgAutoListController.do?list&id=${tableName}' value='cgAutoListController.do?list&id="+tableName+"' />";
		$.dialog({
			content: url,
			drag :false,
			lock : true,
			title:'菜单链接['+content+']',
			opacity : 0.3,
			width:400,
			height:50,
			cache:false,
		    cancelVal: '关闭',
		    cancel: function(){clip.destroy();},
		    button : [{
		    	id : "coptyBtn",
		    	name : "复制",
		    	callback : function () {
		    	}
		    }],
		    init : function () {
				clip = new ZeroClipboard.Client();
				clip.setHandCursor( true );
				
				clip.addEventListener('mouseOver', function(client){
					clip.setText( document.getElementById("menuLink").value );
				});
				clip.addEventListener('complete', function(client, text){
					alert("复制成功");
				});
				var menuLink = $("#menuLink").val();
				$($("input[type=button]")[0]).attr("id","coptyBtn");
				clip.setText(menuLink);
				clip.glue("coptyBtn");
		    }
		});  
	}

	//自定义按钮
	function cgFormButton(title,url,id){
		var rowsData = $('#'+id).datagrid('getSelections');
		if (!rowsData || rowsData.length==0) {
			tip('请选择编辑项目');
			return;
		}
		if (rowsData.length>1) {
			tip('请选择一条记录再编辑');
			return;
		}
		url += '&formId='+rowsData[0].id+"&tableName="+rowsData[0].tableName;
		addOneTab("自定义按钮", url);
	}

	//sql增强
	function cgFormButtonSql(title,url,id){
		var rowsData = $('#'+id).datagrid('getSelections');
		if (!rowsData || rowsData.length==0) {
			tip('请选择编辑项目');
			return;
		}
		if (rowsData.length>1) {
			tip('请选择一条记录再编辑');
			return;
		}
		url += '&formId='+rowsData[0].id+"&tableName="+rowsData[0].tableName;
		//addOneTab("按钮sql增强", url);
		$.dialog({
			content: "url:"+url,
			lock : true,
			title:"SQL增强["+rowsData[0].content+"]",
			opacity : 0.3,
			width:900,
			height:500,
			cache:false,
		    ok: function(){
				iframe = this.iframe.contentWindow;
				saveObj();
				return false;
		    },
		    cancelVal: '关闭',
		    cancel: true /*为true等价于function(){}*/
		});
	}

	
	//js增强
	function enhanceJs(title,url,id){
		var rowsData = $('#'+id).datagrid('getSelections');
		if (!rowsData || rowsData.length==0) {
			tip('请选择编辑项目');
			return;
		}
		if (rowsData.length>1) {
			tip('请选择一条记录再编辑');
			return;
		}
		url += '&formId='+rowsData[0].id+"&tableName="+rowsData[0].tableName;
		$.dialog({
			content: "url:"+url,
			lock : true,
			title:"JS增强["+rowsData[0].content+"]",
			opacity : 0.3,
			width:900,
			height:500,
			cache:false,
		    ok: function(){
				iframe = this.iframe.contentWindow;
				saveObj();
				return false;
		    },
		    cancelVal: '关闭',
		    cancel: true /*为true等价于function(){}*/
		});
	}

	//表单 sql导出
	function doMigrateOut(title,url,id){
		var rowData = $('#'+id).datagrid('getSelected');
		if (!rowData) {
			tip('请选择编辑项目');
			return;
		}
		url += '&ids='+ getListSelections();
		window.location.href= url;
	}

	//表单  sql导入
	function toCgformMigrate(){
		openuploadwin('表单SQL导入', 'cgformSqlController.do?toCgformMigrate', "tablePropertyList");
	}
    <%--   update-end--Author:duanqilu  Date:20130910 for#211 升级SQL导入导出--%>	
	//代码生成
	function generate(title,url,id){
		var rowsData = $('#'+id).datagrid('getSelections');
		if (!rowsData || rowsData.length==0) {
			tip('请选择编辑项目');
			return;
		}
		if (rowsData.length>1) {
			tip('请选择一条记录再编辑');
			return;
		}
		//附表不能生成代码
		if("3" == rowsData[0].jformType){
			tip('附表不能代码生成');
			return;
		}

		//未激活的表，不允许生成代码
		if("N" == rowsData[0].isDbSynch){
			tip('请先同步数据库！');
			return;
		}
				
		
		url += '&id='+rowsData[0].id;
		$.dialog({
			content: "url:"+url,
			lock : true,
			title:"代码生成["+rowsData[0].content+"]",
			opacity : 0.3,
			width:1100,
			height:500,
			cache:false,
		    ok: function(){
				iframe = this.iframe.contentWindow;
				saveObj();
				return false;
		    },
		    cancelVal: '关闭',
		    cancel: true /*为true等价于function(){}*/
		});
	}

	/**
	 * 获取列表中选中行的数据（多行）
	 * @param field 数据中字段名-不传此参数则获取全部数据
	 * @return 选中行的给定字段值，以逗号分隔
	 */
	function getListSelections(){
		var ids = '';
		var rows = $("#tablePropertyList").datagrid("getSelections");
		for(var i=0;i<rows.length;i++){
			ids+=rows[i].id;
			ids+=',';
		}
		ids = ids.substring(0,ids.length-1);
		return ids;
	}	
	
	/**
	 * 以多种方式同步数据库
	 * @param id 表单id
	 */
	function doDbsynch(id,content){
		var url = "url:cgFormHeadController.do?goCgFormSynChoice";
		$.dialog({
			content: url,
			drag :false,
			lock : true,
			title:'同步数据库['+content+']',
			opacity : 0.3,
			width:400,
			height:100,
			cache:false,
		    cancelVal: '关闭',
		    cancel: function(){},
		    button : [{
		    	id : "okBtn",
		    	name : "确定",
		    	callback : function () {
		    		iframe = this.iframe.contentWindow;
		    		var synchoice = iframe.getSynChoice();
		    		if(synchoice){
						var submitUrl = 'cgFormHeadController.do?doDbSynch&id='+id+'&synMethod='+synchoice;
						doSubmit(submitUrl,'tablePropertyList');
				    }else{
						alert('请选择同步方式');
						return false;
					}
		    	}
		    }]
		}); 
	}
	</SCRIPT>
