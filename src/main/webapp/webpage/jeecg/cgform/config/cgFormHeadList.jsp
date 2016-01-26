<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,autocomplete"></t:base>
<!--add-start--Author:luobaoli  Date:20150607 for：增加表单树型列表-->
<script type="text/javascript">
	$(function() {
		$('#formtree').tree({
			animate : true,
			url : 'systemController.do?formTree&typegroupCode=bdfl',
			onClick : function(node) {
				if ($('#formtree').tree('isLeaf', node.target)) {
					loadFormByType(node.id);
				} else {
					$('#formtree').tree('expand', node.target);
				}
			}
		});
	});
	
	
	function loadFormByType(jformCategory){
		var url = 'cgFormHeadController.do?datagrid';
		$("#tablePropertyList").datagrid('reload',{jformCategory:jformCategory});
	}
</script>
<!--add-end--Author:luobaoli  Date:20150607 for：增加表单树型列表-->
<div class="easyui-layout" fit="true">
<div region="west" style="width: 150px;" title="表单分类" split="true" collapsed="true">
<div class="easyui-panel" style="padding: 1px;" fit="true" border="false">
<ul id="formtree">
</ul>
</div>
</div>
<div region="center" style="padding: 1px;">
<t:datagrid sortName="createDate" sortOrder="desc" name="tablePropertyList" title="smart.form.config" 
            fitColumns="false" actionUrl="cgFormHeadController.do?datagrid" idField="id" fit="true" 
            queryMode="group" checkbox="true" >
	<t:dgCol title="common.id" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="table.type" field="jformType" replace="single.table_1,master.table_2,slave.table_3" query="true"></t:dgCol>
	<t:dgCol title="table.name" field="tableName" query="true" autocomplete="true" />
	<!--add-start--Author:luobaoli  Date:20150607 for：增加表单分类展现-->
	<t:dgCol title="form.category" field="jformCategory" dictionary="bdfl"></t:dgCol>
	<!--add-end--Author:luobaoli  Date:20150607 for：增加表单分类展现-->
	<t:dgCol title="table.description" field="content"></t:dgCol>
	<t:dgCol title="common.version" field="jformVersion"></t:dgCol>
	<t:dgCol title="is.tree" field="isTree" replace="common.yes_Y,common.no_N"></t:dgCol>
	<t:dgCol title="is.page" field="isPagination" replace="common.yes_Y,common.no_N"></t:dgCol>
	<t:dgCol title="sync.db" field="isDbSynch" replace="has.sync_Y,have.nosync_N" style="background:red;_N" query="true"></t:dgCol>
	<t:dgCol title="show.checkbox" field="isCheckbox" replace="common.yes_Y,common.no_N"></t:dgCol>
	<t:dgCol title="common.query.module" field="querymode"></t:dgCol>
	<t:dgCol title="common.createby" field="createBy" hidden="false"></t:dgCol>
	<t:dgCol title="common.createtime" field="createDate" formatter="yyyy/MM/dd" hidden="false"></t:dgCol>
	<t:dgCol title="common.updateby" field="updateBy" hidden="false"></t:dgCol>
	<t:dgCol title="common.updatetime" field="updateDate" formatter="yyyy/MM/dd" hidden="false"></t:dgCol>
	<t:dgCol title="common.operation" field="opt"></t:dgCol>
	<t:dgFunOpt funname="delCgForm(id,tableName)" title="common.delete"></t:dgFunOpt>
	<t:dgFunOpt funname="remCgForm(id)" title="common.remove"></t:dgFunOpt>
	<t:dgFunOpt exp="isDbSynch#eq#N" title="sync.db" funname="doDbsynch(id,content)" />
	<t:dgFunOpt exp="isDbSynch#eq#Y&&jformType#ne#3" funname="addbytab(id,content)" title="form.template"></t:dgFunOpt>
	<t:dgFunOpt exp="isDbSynch#eq#Y&&jformType#ne#3" funname="addlisttab(tableName,content)" title="function.test"></t:dgFunOpt>
	<t:dgFunOpt exp="isDbSynch#eq#Y&&jformType#ne#3" funname="popMenuLink(tableName,content)" title="config.place"></t:dgFunOpt>
	<t:dgToolBar title="create.form" icon="icon-add" width="900" height="600" url="cgFormHeadController.do?addorupdate" funname="addForm"></t:dgToolBar>
	<t:dgToolBar title="edit.form" icon="icon-edit" width="900" height="600" url="cgFormHeadController.do?addorupdate" funname="updateForm"></t:dgToolBar>
	<t:dgToolBar title="custom.button" icon="icon-edit" url="cgformButtonController.do?cgformButton" funname="cgFormButton"></t:dgToolBar>
	<t:dgToolBar title="js.enhance" icon="icon-edit" url="cgformEnhanceJsController.do?addorupdate" funname="enhanceJs"></t:dgToolBar>
	<t:dgToolBar title="sql.enhance" icon="icon-edit" url="cgformButtonSqlController.do?addorupdate" funname="cgFormButtonSql"></t:dgToolBar>
	<!--add-begin--Author:luobaoli  Date:20150630 for：新增java增强按钮 -->
	<t:dgToolBar title="java.enhance" icon="icon-edit" url="cgformEnhanceJavaController.do?addorupdate" funname="javaEnhance"></t:dgToolBar>
	<!--add-end--Author:luobaoli  Date:20150630 for：新增java增强按钮 -->
	<t:dgToolBar title="form.export" icon="icon-putout" url="cgformSqlController.do?doMigrateOut" funname="doMigrateOut"></t:dgToolBar>
	<t:dgToolBar title="form.import" icon="icon-put" url="cgformSqlController.do?inSqlFile" funname="toCgformMigrate"></t:dgToolBar>
	<t:dgToolBar title="code.generate" icon="icon-add" url="generateController.do?gogenerate" funname="generate"></t:dgToolBar>
	<t:dgToolBar title="form.generate" icon="icon-add" url="cgformTransController.do?trans" funname="addToData"></t:dgToolBar>
</t:datagrid></div>
</div>

<script type="text/javascript">
	function addbytab(id,content) {
		addOneTab('<t:mutiLang langKey="form.template"/>' , "cgformFtlController.do?cgformFtl2&formid="+id);
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

	function addlisttab(tableName,content){
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
    <%--   update-end--Author:duanqilu  Date:20130910 for#211 升级SQL导入导出--%>	
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
	
	$(function(){
		if($.cookie("JEECGINDEXSTYLE") == "ace"){
			$("#tablePropertyListtb").css("height","125");
		}
	})
</script>
