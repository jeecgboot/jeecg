<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,autocomplete"></t:base>
<!--add-start--Author:luobaoli  Date:20150607 for：增加表单树型列表-->
 <script type="text/javascript">

</script>
<div class="easyui-layout" fit="true">
<div region="center" style="padding:0px;border:0px">
<t:datagrid queryBuilder="true" sortName="createDate" sortOrder="desc" name="tablePropertyList" title="smart.form.config"
            fitColumns="false" actionUrl="cgFormHeadController.do?configDatagrid&id=${physiceId}" idField="id" fit="true" 
            queryMode="group" checkbox="true" >
	<t:dgCol title="common.id" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="table.type" field="jformType" replace="single.table_1,master.table_2,slave.table_3" query="true"></t:dgCol>
	<t:dgCol title="table.name" field="tableName"  query="true" autocomplete="true" />
	<t:dgCol title="form.category" field="jformCategory" dictionary="bdfl"></t:dgCol>
	<t:dgCol title="table.description" field="content"></t:dgCol>
	<t:dgCol title="版本" field="tableVersion" ></t:dgCol>
	<t:dgCol title="is.tree" field="isTree" hidden="true" replace="common.yes_Y,common.no_N"></t:dgCol>
	<t:dgCol title="is.page" field="isPagination" hidden="true" replace="common.yes_Y,common.no_N"></t:dgCol>
	<t:dgCol title="show.checkbox" field="isCheckbox" hidden="true" replace="common.yes_Y,common.no_N"></t:dgCol>
	<t:dgCol title="common.query.module" field="querymode" hidden="true"></t:dgCol>
	<t:dgCol title="common.createby" field="createBy" hidden="true"></t:dgCol>
	<t:dgCol title="common.createtime" field="createDate" formatter="yyyy/MM/dd" hidden="true"></t:dgCol>
	<t:dgCol title="common.updateby" field="updateBy" hidden="true"></t:dgCol>
	<t:dgCol title="common.updatetime" field="updateDate" formatter="yyyy/MM/dd" hidden="true"></t:dgCol>
	<t:dgCol title="配置表版本" field="physiceId" hidden="true"></t:dgCol>
	<t:dgCol title="common.operation" field="opt"></t:dgCol>
	  <!-- 	//update-begin--Author:zhangjq  Date:20160904 for：1332 【系统图标统一调整】讲{系统管理模块}{在线开发}的链接按钮，改成ace风格 -->
	<t:dgFunOpt funname="remCgForm(id)" title="common.remove"  urlclass="ace_button"  urlfont="fa-remove"></t:dgFunOpt>
	<t:dgFunOpt funname="importFields(id,content)" title="导入字段"  urlclass="ace_button"  urlfont="fa-download"></t:dgFunOpt>
	<t:dgFunOpt funname="addbytab(id,content)" title="form.template"  urlclass="ace_button"  urlfont="fa-plus"></t:dgFunOpt>
	<t:dgFunOpt funname="addlisttab(tableName,content,id)" title="function.test"  urlclass="ace_button"  urlfont="fa-gavel"></t:dgFunOpt>
	<t:dgFunOpt funname="popMenuLink(tableName,content)" title="config.place"  urlclass="ace_button"  urlfont="fa-cog"></t:dgFunOpt>
	  <!-- 	//update-end--Author:zhangjq  Date:20160904 for：1332 【系统图标统一调整】讲{系统管理模块}{在线开发}的链接按钮，改成ace风格 -->
	<t:dgToolBar title="edit.form" icon="icon-edit" width="900" height="600" url="cgFormHeadController.do?addorupdate" funname="updateForm"></t:dgToolBar>
	<t:dgToolBar title="custom.button" icon="icon-edit" url="cgformButtonController.do?cgformButton" funname="cgFormButton"></t:dgToolBar>
	<t:dgToolBar title="js.enhance" icon="icon-edit" url="cgformEnhanceJsController.do?addorupdate" funname="enhanceJs"></t:dgToolBar>
	<t:dgToolBar title="sql.enhance" icon="icon-edit" url="cgformButtonSqlController.do?addorupdate" funname="cgFormButtonSql"></t:dgToolBar>
	<t:dgToolBar title="java.enhance" icon="icon-edit" url="cgformEnhanceJavaController.do?addorupdate" funname="javaEnhance"></t:dgToolBar>
	<t:dgToolBar title="form.export" icon="icon-putout" url="cgformSqlController.do?doMigrateOut" funname="doMigrateOut"></t:dgToolBar>
	<t:dgToolBar title="form.import" icon="icon-put" url="cgformSqlController.do?inSqlFile" funname="toCgformMigrate"></t:dgToolBar>
	<t:dgToolBar title="code.generate" icon="icon-add" url="generateController.do?gogenerate" funname="generate"></t:dgToolBar>
	<t:dgToolBar title="form.generate" icon="icon-add" url="cgformTransController.do?trans" funname="addToData"></t:dgToolBar>
</t:datagrid></div>
</div>

<script type="text/javascript">
	function addbytab(id,content) {
		addOneTab('<t:mutiLang langKey="form.template"/>['+content+']' , "cgformFtlController.do?cgformFtl2&formid="+id);
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
		    cancelVal: '<t:mutiLang langKey="common.close"/>',
		    cancel: true,
            drag:false,max:false,min:false
		});
	}
	function delCgForm(id,name){
		$.dialog.confirm('<t:mutiLang langKey="confirm.delete.record"/>', function(){
			checkIsExit(id,name);
		}, function(){
		}).zindex();
	}
	//检查这个表是否已经存在了
	function checkIsExit(id,name){
		$.post("cgFormHeadController.do?checkIsExit&&name="+name,function(data){
			var d = $.parseJSON(data);
			if (d.success) {
				$.dialog.confirm('<t:mutiLang langKey="table.exit.in.db.confirm"/>', function(){
					delThis(id);
				}, function(){
				}).zindex();
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
		$.dialog.confirm('<t:mutiLang langKey="confirm.delete.record"/>', function(){
			removeThis(id);
		}, function(){
		}).zindex();
	}
	
	function removeThis(id){
		doSubmit("cgFormHeadController.do?rem&id="+id,"tablePropertyList");
	}
//修改痕迹
	function addlisttab(tableName,content,id){
		addOneTab( '<t:mutiLang langKey="form.datalist"/>' + "["+content+"]", "cgAutoListController.do?list&id="+tableName);
	}
	
	function addForm(title,url,id){
		gridname=id;
		createwindow(title,url,900,520);
	}
	function updateForm(title,url,id){
		gridname=id;
		var rowsData = $('#'+id).datagrid('getSelections');
		if (!rowsData || rowsData.length==0) {
			tip('<t:mutiLang langKey="common.please.select.edit.item"/>');
			return;
		}
		if (rowsData.length>1) {
			tip('<t:mutiLang langKey="common.please.select.one.record.to.edit"/>');
			return;
		}
		createwindow(title,url + '&id='+rowsData[0].id,900,520);

	}
	function jsPlugin(title,url,id){
		var rowsData = $('#'+id).datagrid('getSelections');
		if (!rowsData || rowsData.length==0) {
			tip('<t:mutiLang langKey="common.please.select.edit.item"/>');
			return;
		}
		if (rowsData.length>1) {
			tip('<t:mutiLang langKey="common.please.select.one.record.to.edit"/>');
			return;
		}
		url += '&id='+rowsData[0].id;
  		$.dialog({
			content: "url:"+url,
			lock : true,
			title:'<t:mutiLang langKey="js.enhance"/>' + "["+rowData.content+"]",
			opacity : 0.3,
			width:900,
			height:500,
			cache:false,
		    ok: function(){
		    	iframe = this.iframe.contentWindow;
		    	iframe.goForm();
				return false;
		    },
		    cancelVal: '<t:mutiLang langKey="common.close"/>',
		    cancel: true /*为true等价于function(){}*/
		});
	}
	
	/**
	*	弹出菜单链接
	*/
	function popMenuLink(tableName,content){
        $.dialog({
			content: "url:cgFormHeadController.do?popmenulink&url=cgAutoListController.do?list&title="+tableName,
			drag :false,
			lock : true,
			title:'<t:mutiLang langKey="common.menu.link"/>' + '['+content+']',
			opacity : 0.3,
			width:400,
			height:80,drag:false,min:false,max:false
		}).zindex();
	}

	//自定义按钮
	function cgFormButton(title,url,id){
		var rowsData = $('#'+id).datagrid('getSelections');
		if (!rowsData || rowsData.length==0) {
			tip('<t:mutiLang langKey="common.please.select.edit.item"/>');
			return;
		}
		if (rowsData.length>1) {
			tip('<t:mutiLang langKey="common.please.select.one.record.to.edit"/>');
			return;
		}
		url += '&formId='+rowsData[0].id+"&tableName="+rowsData[0].tableName;
		addOneTab('<t:mutiLang langKey="custom.button"/>', url);
	}

	//sql增强
	function cgFormButtonSql(title,url,id){
		var rowsData = $('#'+id).datagrid('getSelections');
		if (!rowsData || rowsData.length==0) {
			tip('<t:mutiLang langKey="common.please.select.edit.item"/>');
			return;
		}
		if (rowsData.length>1) {
			tip('<t:mutiLang langKey="common.please.select.one.record.to.edit"/>');
			return;
		}
		url += '&formId='+rowsData[0].id+"&tableName="+rowsData[0].tableName;
		//addOneTab("按钮sql增强", url);
		$.dialog({
			content: "url:"+url,
			lock : true,
			title: '<t:mutiLang langKey="sql.enhance"/>' + "["+rowsData[0].content+"]",
			opacity : 0.3,
			width:900,
			height:500,
			cache:false,
		    ok: function(){
				iframe = this.iframe.contentWindow;
				saveObj();
				return false;
		    },
		    cancelVal: '<t:mutiLang langKey="common.close"/>',
		    cancel: true /*为true等价于function(){}*/
		});
	}

	
	//js增强
	function enhanceJs(title,url,id){
		var rowsData = $('#'+id).datagrid('getSelections');
		if (!rowsData || rowsData.length==0) {
			tip('<t:mutiLang langKey="common.please.select.edit.item"/>');
			return;
		}
		if (rowsData.length>1) {
			tip('<t:mutiLang langKey="common.please.select.one.record.to.edit"/>');
			return;
		}
		url += '&formId='+rowsData[0].id+"&tableName="+rowsData[0].tableName;
		$.dialog({
			content: "url:"+url,
			lock : true,
			title: '<t:mutiLang langKey="js.enhance"/>' + "["+rowsData[0].content+"]",
			opacity : 0.3,
			width:900,
			height:500,
			cache:false,
		    ok: function(){
				iframe = this.iframe.contentWindow;
				saveObj();
				return false;
		    },
		    cancelVal: '<t:mutiLang langKey="common.close"/>',
		    cancel: true /*为true等价于function(){}*/
		});
	}
	
	//java增强
	function javaEnhance(title,url,id){
		var rowsData = $('#'+id).datagrid('getSelections');
		if (!rowsData || rowsData.length==0) {
			tip('<t:mutiLang langKey="common.please.select.edit.item"/>');
			return;
		}
		if (rowsData.length>1) {
			tip('<t:mutiLang langKey="common.please.select.one.record.to.edit"/>');
			return;
		}
		url += '&formId='+rowsData[0].id+"&tableName="+rowsData[0].tableName;
		$.dialog({
			content: "url:"+url,
			lock : true,
			title: '<t:mutiLang langKey="java.enhance"/>' + "["+rowsData[0].content+"]",
			opacity : 0.3,
			width:500,
			height:300,
			cache:false,
		    ok: function(){
				iframe = this.iframe.contentWindow;
				saveObj();
				return false;
		    },
		    cancelVal: '<t:mutiLang langKey="common.close"/>',
		    cancel: true /*为true等价于function(){}*/
		});
	}

	//表单 sql导出
	function doMigrateOut(title,url,id){
		var rowData = $('#'+id).datagrid('getSelected');
		if (!rowData) {
			tip('<t:mutiLang langKey="common.please.select.edit.item"/>');
			return;
		}
		url += '&ids='+ getListSelections();
		window.location.href= url;
	}

	//表单  sql导入
	function toCgformMigrate(){
		openuploadwin('<t:mutiLang langKey="form.sqlimport"/>', 'cgformSqlController.do?toCgformMigrate', "tablePropertyList");
	}
	//代码生成
	function generate(title,url,id){
		var rowsData = $('#'+id).datagrid('getSelections');
		if (!rowsData || rowsData.length==0) {
			tip('<t:mutiLang langKey="common.please.select.edit.item"/>');
			return;
		}
		if (rowsData.length>1) {
			tip('<t:mutiLang langKey="common.please.select.one.record.to.edit"/>');
			return;
		}
		//附表不能生成代码
		if("3" == rowsData[0].jformType){
			tip('<t:mutiLang langKey="slave.table.can.not.generate.code"/>');
			return;
		}

		//未激活的表，不允许生成代码
		if("N" == rowsData[0].isDbSynch){
			tip('<t:mutiLang langKey="please.syncdb"/>');
			return;
		}
				
		
		url += '&id='+rowsData[0].id;
		$.dialog({
			content: "url:"+url,
			lock : true,
			title: '<t:mutiLang langKey="code.generate"/>' + " ["+rowsData[0].content+"]",
			opacity : 0.3,
			width:1100,
			height:500,
			cache:false,
		    ok: function(){
				iframe = this.iframe.contentWindow;
				saveObj();
				return false;
		    },
		    cancelVal: '<t:mutiLang langKey="common.close"/>',
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
			title: '<t:mutiLang langKey="sync.db"/>' + '['+content+']',
			opacity : 0.3,
			width:400,
			height:100,
			cache:false,
		    cancelVal: '<t:mutiLang langKey="common.close"/>',
		    cancel: function(){},
		    button : [{
		    	id : "okBtn",
		    	name : '<t:mutiLang langKey="common.confirm"/>',
		    	callback : function () {
		    		iframe = this.iframe.contentWindow;
		    		var synchoice = iframe.getSynChoice();
		    		if(synchoice){
						var submitUrl = 'cgFormHeadController.do?doDbSynch&id='+id+'&synMethod='+synchoice;
						doSubmit(submitUrl,'tablePropertyList');
				    }else{
						alert('<t:mutiLang langKey="please.select.sync.method"/>');
						return false;
					}
		    	}
		    }]
		}).zindex();
	}
	
	function importFields(id,content) {
		openuploadwin('【'+content+'】Excel导入Online字段', 'cgFormHeadController.do?upload&id='+id, "tablePropertyList");
	}
	
	function copyOnline(id){
		$.post("cgFormHeadController.do?copyOnline",function(data){
			var d = $.parseJSON(data);
			if (d.success) {
				addOneTab( '智能表单配置表配置', "cgFormHeadController.do?copyList&id="+d.obj);
			}else{
				tip(d.mag);
			}
		});
	}
	
</script>
