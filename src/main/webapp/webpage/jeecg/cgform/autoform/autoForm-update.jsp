<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>表单设计器</title>
  <t:base type="jquery,easyui,tools"></t:base>
  <link rel="stylesheet" type="text/css" href="plug-in/ztree/css/zTreeStyle.css">
  <script type="text/javascript" src="plug-in/ztree/js/jquery.ztree.core-3.5.min.js"></script>
  <script type="text/javascript" src="plug-in/ztree/js/jquery.ztree.excheck-3.5.min.js"></script>
  <script src = "webpage/jeecg/cgform/autoform/autoForm.js"></script>	
  <script type="text/javascript">
	  
	  var setting = {
			  check: {
					enable: true
					//chkStyle: "radio",
					//radioType: "level"
				},
				data: {
					simpleData: {
						enable: true
					}
				}
		};
	  
	  var stylesetting = {
			check: {
				enable: true,
				chkStyle: "radio",
				radioType: "level"
			},
			data: {
				simpleData: {
					enable: true
				}
			}
		};
	  
	  function showIconForTree(treeId, treeNode) {
		return !treeNode.isParent;
	  }
	  //初始化主数据源
	  function initMainTableSourceSelect(){
		  var ztree = $.fn.zTree.getZTreeObj("dbSelect");
		  var node = ztree.getNodesByParam("pid", 0, null);
		  var data=new Array();
		  $.each(node,function(i,f){
			  var obj={}
			  obj["id"]= f.dbCode;
			  obj["text"]= f.name;
			  data.push(obj);
		  })
		  $("#mainTableSource").combobox("loadData",data);
		  $("#mainTableSource").combobox("select","${autoFormPage.mainTableSource}");
	  }
	 $(function(){
		 var dbDate = eval('${dbDate}');
		 $.fn.zTree.init($("#dbSelect"), setting, dbDate);
		 var styleDate = eval('${styleSelect}');
		 var iconPath = "plug-in/ztree/css/img/diy/2.png";
		 $(styleDate).each(function(i){
			this.icon = iconPath;
		 });
		 $.fn.zTree.init($("#styleSelect"), stylesetting, styleDate);
		 initMainTableSourceSelect();
		//自定义easyui表单验证规则
		/* var flag;
		 $.extend($.fn.validatebox.defaults.rules, {
			 uniqueNm: {
		          validator: function (value,param){
		        	$.post(
		        		'autoFormController.do?checkFormNm',
		        		{formName:value},
		        		function(data){
		        			var d = $.parseJSON(data);
		        			if(d.msg == '0' || d.msg == '1'){
		        				$("#formName").removeClass(); 
		        			} else{
		        				return false;
		        			}
		        		}
		            );
		          },
		          message: '表单名称重复，请重新输入'
		        }
		 }); */
		 
		//添加生成按钮的onclick事件
		 $("#createCode").click(function(){
			 var formdbId = getNodeId();
			 if(formdbId == ''){
				 tip('请选择表单数据源');
			 }
			 
			 var styleId = getStyleId();
			 if(styleId == ''){
				 tip('请选择自定义表单模板');
			 }
			 
			 $.post(
			    'autoFormController.do?docreateCode',
				{formdbId:formdbId,styleId:styleId},
				function(data) {
					var d = $.parseJSON(data);
					if (d.success) {
						var editor = UE.getEditor('content');
						editor.ready(
						function(){
							setContent();
							//editor.setContent($("#formContent").val()+d.msg.replace(new RegExp(/(&quot;)/g),"'"));
							editor.execCommand('inserthtml', d.msg.replace(new RegExp(/(&quot;)/g),"'"));
						});
					}
				});
		 });
	 });
	 
	 
	 function doAdd(){
		 var addurl = "autoFormDbController.do?goAdd&autoFormId=${autoFormPage.id}";
		 $.dialog({
			content: 'url:'+addurl,
			lock : true,
			//zIndex:1990,
			width: '100%',
			height: '100%',
			title: "<t:mutiLang langKey='common.add'/>",
			opacity : 0.3,
			cache:false,
			okVal: '<t:mutiLang langKey='common.confirm'/>',
		    ok: function(){
		    	var iframe = this.iframe.contentWindow;
		    	iframe.$('#formobj').form('submit', {
		    		url : 'autoFormDbController.do?doAdd',
		    		onSubmit : function() {
						iframe.setDataSourceVal();
						return ( iframe.$("#formobj").Validform({tiptype:3}).check());
		    		},
		    		success : function(data) {
		    			iframe.windowapi.close();
		    			var d = $.parseJSON(data);
						if (d.success) {
							tip(d.msg);
							doReload();
						}
		    		}
		    	});
				return false;
		    },
		    cancelVal: '<t:mutiLang langKey='common.cancel'/>',
		    cancel: true /*为true等价于function(){}*/
		}).max().zindex();
	 }
	 function doUpdate(){
		 //获取选中的父节点
		 var id = getNodeId();
		 if(id == null || id == ''){
			 alert('请选择需要编辑的表单数据源');
			 return false;
		 }
		 var addurl = "autoFormDbController.do?goUpdate&id="+id;
		  $.dialog({
			content: 'url:'+addurl,
			lock : true,
			//zIndex:1990,
			width: 700,
			height: 400,
			title: "<t:mutiLang langKey='common.edit'/>",
			opacity : 0.3,
			cache:false,
			okVal: '<t:mutiLang langKey='common.confirm'/>',
		    ok: function(){
		    	var iframe = this.iframe.contentWindow;
		    	iframe.$('#formobj').form('submit', {
		    		url : 'autoFormDbController.do?doUpdate',
		    		onSubmit : function() {
						iframe.setDataSourceVal();
						return ( iframe.$("#formobj").Validform({tiptype:3}).check(false));
		    		},
		    		success : function(data) {
		    			iframe.windowapi.close();
		    			var d = $.parseJSON(data);
						if (d.success) {
							tip(d.msg);
							doReload();
						}
		    		}
		    	});
				return false;
		    },
		    cancelVal: '<t:mutiLang langKey='common.cancel'/>',
		    cancel: true /*为true等价于function(){}*/
		}).max().zindex();
	 }
	 function doDelete(){
		 var id = getNodeId();
		 if(id == null || id == ''){
			 alert('请选择需要删除的表单数据源');
			 return false;
		 }
		 
		 $.dialog.confirm('你确定永久删除该数据吗?', function(){
			 $.post(
				'autoFormDbController.do?doBatchDel',
				{ids : id},
				function(data) {
					var d = $.parseJSON(data);
					if (d.success) {
						doReload();
					}
				});
		  });
	 }
	 
	 function doReload(){
		 $.post(
		 'autoFormController.do?treeReload',
		 {autoFormId: $("#id").val()},
		 function(data){
		    var d = $.parseJSON(data);
			if (d.success) {
				 var dbDate = eval(d.msg);
				 $.fn.zTree.init($("#dbSelect"), setting, dbDate);
				initMainTableSourceSelect();
			}
			
		 });
	 }
	 
	//改成多选时取得多个ID根据","分割
	   function getNodeId(){
			 var treeObj = $.fn.zTree.getZTreeObj("dbSelect");
			 var nodes = treeObj.getCheckedNodes(true);
			 if(nodes.length == 0){
				 return "";
			 }
			 var ids = [];
			 for(var i=0;i<nodes.length;i++){
				 if(nodes[i].pid == '0'){
					 ids.push(nodes[i].id);
				 }
			 }
			 return ids.join(',');
		 } 
		 
	   function getStyleId(){
			 var treeObj = $.fn.zTree.getZTreeObj("styleSelect");
			 var nodes = treeObj.getCheckedNodes(true);
			 if(nodes.length == 0){
				 return "";
			 }
			 var id = "";
			 for(var i=0;i<nodes.length;i++){
				 id = nodes[i].id;
				 break;
			 }
			 return id;
		 }
	 
   
   function doExit() {
	 	//document.location="autoFormController.do?autoForm";
	   var cur = window.top.$('#maintabs').tabs('getSelected');
	   var index = window.top.$('#maintabs').tabs('getTabIndex',cur);
	   window.top.$('#maintabs').tabs('close',index);
	}
   
   function doSubmit(){
	   
		 $('#formobj').form('submit', {
  		url : 'autoFormController.do?doUpdate',
  		onSubmit : function() {  			
  			if(leipiEditor.queryCommandState( 'source' ))
	            leipiEditor.execCommand('source');
  			
	        if(leipiEditor.hasContents()){
	            leipiEditor.sync();       
	         	
	           var parse_form = leipiFormDesign.parse_form(leipiEditor.getContent());
	           $("#formContent").val(parse_form);
	        } else {
	    	   $("#formContent").val('');
    	    }
  			 if(!$("#formobj").form('validate')){
				 tip("请输入必须字段！");
				 return false;
			 }else{
				 return true;
			 }
  		},
  		success : function(data) {
  			var d = $.parseJSON(data);
				if (d.success) {
					tip(d.msg);
				}else{
					tip(d.msg);
				}
  		}
	    });
 }
  </script>
  <style>
  		.menu{list-style:none;width:100%}
  		.menu li{float:left;}
  </style>
 </head>
 <body>

 	<div id="cc" class="easyui-layout" fit="true">
	  	<div data-options="region:'north',split:false,border:false" >
	  		<div class="panel-header">
	  		&nbsp;
	  		<a href="#" class="easyui-linkbutton" onclick="javascript:doExit();">关闭</a>
	  		&nbsp;&nbsp;
	  		<a href="#" class="easyui-linkbutton" onclick="javascript:doSubmit();">保存</a> 
			</div>
	  	</div>   
	  	<div data-options="region:'west',title:'表单数据源',split:true" style="width:200px;">
	       <div region="north" border="false" style="overflow: hidden;" fit="true">
				<div style="width:99.5%;height:300px;overflow-y:auto;">
					<ul class="menu" style="width:187px">
		  				<li style="width:15%;"><a href="#" onclick="javascript:doAdd();"><img src="plug-in/easyui/themes/icons/edit_add.png"/></a></li>
		  				<li style="width:15%;"><a href="#" onclick="javascript:doUpdate();"><img src="plug-in/easyui/themes/icons/pencil.png"/></a></li>
		  				<li style="width:15%;"><a href="#" onclick="javascript:doDelete();"><img src="plug-in/easyui/themes/icons/cancel.png"/></a></li>
		  				<li style="width:15%;"><a href="#" onclick="javascript:doReload();"><img src="plug-in/easyui/themes/icons/reload.png"/></a></li>
		  				<li><a href="#" class="easyui-linkbutton c1" id="createCode">生成</a></li>
		  			</ul>
			       	<ul id="dbSelect" class="ztree" style="margin-top:25px;"></ul>
			    </div>
			</div>
			<div region="south" border="false" style="overflow: hidden;">
				<div style="width:99.5%;overflow-y:auto;">
		       		<div class="panel-header">
			       		<div class="panel-title">选择默认模板样式</div>
			       		<!-- <div class="panel-tool">
			       			<a href="javascript:void(0)" class="layout-button-up"></a>
			       		</div> -->
		       		</div>
		       	    <ul id="styleSelect" class="ztree"></ul>
		       </div>
			</div>
	  	</div>  
	    <div data-options="region:'center',title:'表单内容'" style="padding:5px;background:#eee;">
	    	 <t:formvalid formid="formobj" dialog="false" beforeSubmit="setContent()" btnsub="btn" callback="test"  layout="table" action="autoFormController.do?doUpdate" tiptype="1">
				<input id="id" name="id" type="hidden" value="${autoFormPage.id }">
				<input id="createName" name="createName" type="hidden" value="${autoFormPage.createName }">
				<input id="createBy" name="createBy" type="hidden" value="${autoFormPage.createBy }">
				<input id="createDate" name="createDate" type="hidden" value="${autoFormPage.createDate }">
				<input id="updateName" name="updateName" type="hidden" value="${autoFormPage.updateName }">
				<input id="updateBy" name="updateBy" type="hidden" value="${autoFormPage.updateBy }">
				<input id="updateDate" name="updateDate" type="hidden" value="${autoFormPage.updateDate }">
				<input id="sysOrgCode" name="sysOrgCode" type="hidden" value="${autoFormPage.sysOrgCode }">
				<input id="sysCompanyCode" name="sysCompanyCode" type="hidden" value="${autoFormPage.sysCompanyCode }">
				<input id="formStyleId" name="formStyleId" type="hidden" value="${autoFormPage.formStyleId }">
				<table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
					<tr>
						<td align="right" style="width: 8%;"><label class="Validform_label"> 表单编码: </label></td>
						<td class="value" style="width: 20%;"><input id="formName" name="formName" type="text" style="width: 75%;" class="easyui-validatebox" required="true" missingMessage="表单名称必须填写" errorMsg="不能为中文" datatype="/^[A-Za-z\d-._]+$/"  ajaxurl="autoFormController.do?checkTbCode&cVal=${autoFormPage.formName}"  value='${autoFormPage.formName}'"> <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">表单编码</label></td>
						<td align="right" style="width: 8%;"><label class="Validform_label"> 表单名: </label></td>
						<td class="value" style="width: 20%;"><input id="formDesc" name="formDesc" type="text" style="width: 75%;" class="easyui-validatebox" required="true" value='${autoFormPage.formDesc}'> <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">表单名</label></td>
						<td align="right" style="width: 8%;"><label class="Validform_label"> 主数据源: </label></td>
						<td class="value" style="width: 20%;"><select id="mainTableSource" value='${autoFormPage.mainTableSource}' name="mainTableSource" required="true" data-options="valueField:'id',textField:'text'" style="width: 180%;" class="easyui-combobox"></select> <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;">表单名</label></td>
					</tr>
					<tr>
						<td class="value" colspan=6><input id="formContent" name="formContent" type="hidden"> <script id="content" type="text/plain" style="width:99%;">${autoFormPage.formContent == NULL || autoFormPage.formContent == '' ? '' : autoFormPage.formContent}</script></td>
					</tr>
				</table>
			</t:formvalid>
	    </div>
    </div>

 </body>
 <script>UEDITOR_HOME_URL='<%=path%>
	/plug-in/Formdesign/js/ueditor/';
</script>
<script type="text/javascript" charset="utf-8" src="plug-in/Formdesign/js/ueditor/ueditor.config.js?2023"></script>
<script type="text/javascript" charset="utf-8" src="plug-in/Formdesign/js/ueditor/ueditor.all.js?2023"> </script>
<script type="text/javascript" charset="utf-8" src="plug-in/Formdesign/js/ueditor/lang/zh-cn/zh-cn.js?2023"></script>
<script type="text/javascript" charset="utf-8" src="plug-in/Formdesign/js/ueditor/formdesign/leipi.formdesign.v4.js?2023"></script>
<!--  <script type="text/javascript" charset="utf-8" src="plug-in/Formdesign/js/ueditor/formdesign/weixinplugs.js"></script>  -->
<script type="text/javascript">
var leipiEditor = UE.getEditor('content',{
    //allowDivTransToP: false,//阻止转换div 为p
    toolleipi:true,//是否显示，设计器的 toolbars
    textarea: 'design_content',   
    //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个            /*
    toolbars: [[
    'fullscreen', 'source', '|', 'undo', 'redo', '|',//'date', 'time',
    'fontfamily', 'fontsize', '|', 'indent', '|',
    //'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',
    //'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
    //'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|',
    //'directionalityltr', 'directionalityrtl', 'indent', '|',
    'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', //'touppercase', 'tolowercase', '|',
    //'link', 'unlink', 'anchor', '|', 'imagenone', 'imageleft', 'imageright', 'imagecenter', '|',
    //'simpleupload', 'insertimage', 'emotion', 'scrawl', 'insertvideo', 'music', 'attachment', 'map',  'insertframe', 'insertcode', 'webapp', 'pagebreak', 'template', 'background', '|',
    //'horizontal',  'spechars', 'snapscreen', 'wordimage', '|',
    'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', '|',
    //'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols', '|',//'charts', '|',
    //'print', 'preview', 'searchreplace', 'help', 'drafts'
    ]],
    wordCount:false,
    elementPathEnabled:false,
    initialFrameHeight:400
});

/* 1.传入函数,命令里执行该函数得到参数表,添加到已有参数表里 */
leipiEditor.ready(function() {
	leipiEditor.execCommand('serverparam', 'id', '${autoFormPage.id}');
});

/**
 leipiEditor.ready(function() {
 	console.debug(leipiEditor.queryCommandValue('serverparam')); //返回参数值键值对的对象
 });
 */

var leipiFormDesign = {
	   exec : function (method) {
	        leipiEditor.execCommand(method);
	    },
	   parse_form:function(template,fields)
	    {
		   //正则  radios|checkboxs|select 匹配的边界 |--|  因为当使用 {} 时js报错 (plugins|fieldname|fieldflow)
	        var preg =  /(\|-<span(((?!<span).)*plugins=\"(radios|checkboxs|select)\".*?)>(.*?)<\/span>-\||<(img|input|textarea|select).*?(<\/select>|<\/textarea>|\/>))/gi,preg_attr =/(\w+)=\"(.?|.+?)\"/gi,preg_group =/<input.*?\/>/gi;
	        if(!fields) fields = 0;

	        var template_parse = template,template_data = new Array(),add_fields=new Object(),checkboxs=0;

	        var pno = 0;
	        template.replace(preg, function(plugin,p1,p2,p3,p4,p5,p6){
	            var parse_attr = new Array(),attr_arr_all = new Object(),name = '', select_dot = '' , is_new=false;
	            var p0 = plugin;
	            var tag = p6 ? p6 : p4;
	            //alert(tag + " \n- t1 - "+p1 +" \n-2- " +p2+" \n-3- " +p3+" \n-4- " +p4+" \n-5- " +p5+" \n-6- " +p6);

	            if(tag == 'radios' || tag == 'checkboxs')
	            {
	                plugin = p2;
	            }else if(tag == 'select')
	            {
	                plugin = plugin.replace('|-','');
	                plugin = plugin.replace('-|','');
	            }
	            plugin.replace(preg_attr, function(str0,attr,val) {
	                if(attr=='name')
	                {
	                    if(val=='NEWFIELD')
	                    {
	                        is_new=true;
	                        fields++;
	                        val = 'data_'+fields;
	                    }
	                    name = val;
	                }

	                if(tag=='select' && attr=='value')
	                {
	                    if(!attr_arr_all[attr]) attr_arr_all[attr] = '';
	                    attr_arr_all[attr] += select_dot + val;
	                    select_dot = ',';
	                }else
	                {
	                    attr_arr_all[attr] = val;
	                }
	                var oField = new Object();
	                oField[attr] = val;
	                parse_attr.push(oField);
	            })
	            /*alert(JSON.stringify(parse_attr));return;*/
	            if(tag =='checkboxs') /*复选组  多个字段 */
	            {
	                plugin = p0;
	                plugin = plugin.replace('|-','');
	                plugin = plugin.replace('-|','');
	                var name = 'checkboxs_'+checkboxs;
	                attr_arr_all['parse_name'] = name;
	                attr_arr_all['name'] = '';
	                attr_arr_all['value'] = '';
	                attr_arr_all['content'] = '<span leipiplugins="checkboxs"  selector="'+attr_arr_all['selector']+'"   autofield="'+attr_arr_all['autofield']+'" title="'+attr_arr_all['title']+'">';
	                var dot_name ='', dot_value = '';
	                p5.replace(preg_group, function(parse_group) {
	                    var is_new=false,option = new Object();
	                    parse_group.replace(preg_attr, function(str0,k,val) {
	                        if(k=='name')
	                        {
	                        	if(val=='NEWFIELD')
	                            {
	                                is_new=true;
	                                fields++;
	                                val = 'data_'+fields;
	                            }

	                            attr_arr_all['name'] += dot_name + val;
	                            dot_name = ',';

	                        }
	                        else if(k=='value')
	                        {
	                            attr_arr_all['value'] += dot_value + val;
	                            dot_value = ',';

	                        }
	                        option[k] = val;
	                    });
	                    if(!attr_arr_all['options']) attr_arr_all['options'] = new Array();
	                    attr_arr_all['options'].push(option);
	                    if(!option['checked']) option['checked'] = '';
	                    var checked = option['checked'] ? 'checked="checked"' : '';
						var checkedtext=option['checkedtext'] ? option['checkedtext'] :option['value'];
	                    attr_arr_all['content'] +='<input type="checkbox" name="'+option['name']+'" checkedtext="'+checkedtext+'"  selector="'+attr_arr_all['selector']+'"   value="'+option['value']+'" fieldname="' + attr_arr_all['fieldname'] + option['fieldname'] + '" fieldflow="' + attr_arr_all['fieldflow'] + '" '+checked+'/>'+checkedtext+'&nbsp;';

	                    if(is_new)
	                    {
	                        var arr = new Object();
	                        arr['name'] = option['name'];
	                        arr['plugins'] = attr_arr_all['plugins'];
	                        arr['fieldname'] = attr_arr_all['fieldname'] + option['fieldname'];
	                        arr['fieldflow'] = attr_arr_all['fieldflow'];
	                        add_fields[option['name']] = arr;
	                    }

	                });
	                attr_arr_all['content'] += '</span>';

	                //parse
	                template = template.replace(plugin,attr_arr_all['content']);
	                template_parse = template_parse.replace(plugin,'{'+name+'}');
	                template_parse = template_parse.replace('{|-','');
	                template_parse = template_parse.replace('-|}','');
	                template_data[pno] = attr_arr_all;
	                checkboxs++;

	            }else if(name)
	            {
	                if(tag =='radios') /*单选组  一个字段*/
	                {
	                    plugin = p0;
	                    plugin = plugin.replace('|-','');
	                    plugin = plugin.replace('-|','');
	                    attr_arr_all['value'] = '';
	                    attr_arr_all['content'] = '<span leipiplugins="radios" name="'+attr_arr_all['name']+'"  selector="'+attr_arr_all['selector']+'"  autofield="'+attr_arr_all['autofield']+'" title="'+attr_arr_all['title']+'">';
	                    var dot='';
	                    p5.replace(preg_group, function(parse_group) {
	                        var option = new Object();
	                        parse_group.replace(preg_attr, function(str0,k,val) {
	                            if(k=='value')
	                            {
	                                attr_arr_all['value'] += dot + val;
	                                dot = ',';
	                            }
	                            option[k] = val;
	                        });
	                        option['name'] = attr_arr_all['name'];
	                        if(!attr_arr_all['options']) attr_arr_all['options'] = new Array();
	                        attr_arr_all['options'].push(option);
	                        if(!option['checked']) option['checked'] = '';
	                        var checked = option['checked'] ? 'checked="checked"' : '';
							var checkedtext=option['checkedtext'] ? option['checkedtext'] :option['value'];
	                        attr_arr_all['content'] +='<input type="radio" name="'+attr_arr_all['name']+'" checkedtext="'+checkedtext+'" value="'+option['value']+'"  '+checked+'/>'+checkedtext+'&nbsp;';

	                    });
	                    attr_arr_all['content'] += '</span>';

	                }else
	                {
	                    attr_arr_all['content'] = is_new ? plugin.replace(/NEWFIELD/,name) : plugin;
	                }
	                //attr_arr_all['itemid'] = fields;
	                //attr_arr_all['tag'] = tag;
	                template = template.replace(plugin,attr_arr_all['content']);
	                template_parse = template_parse.replace(plugin,'{'+name+'}');
	                template_parse = template_parse.replace('{|-','');
	                template_parse = template_parse.replace('-|}','');
	                if(is_new)
	                {
	                    var arr = new Object();
	                    arr['name'] = name;
	                    arr['plugins'] = attr_arr_all['plugins'];
	                    arr['title'] = attr_arr_all['title'];
	                    arr['orgtype'] = attr_arr_all['orgtype'];
	                    arr['fieldname'] = attr_arr_all['fieldname'];
	                    arr['fieldflow'] = attr_arr_all['fieldflow'];
	                    add_fields[arr['name']] = arr;
	                }
	                template_data[pno] = attr_arr_all;


	            }
	            pno++;
	        })
	        var view = template.replace(/{\|-/g,'');
	        view = view.replace(/-\|}/g,'');
	        var parse_form = new Object({
	            'fields':fields,//总字段数
	            'template':template,//完整html
	            'parse':view,
	            'data':template_data,//控件属性
	            'add_fields':add_fields//新增控件
	        });
	        return JSON.stringify(parse_form);
	    },
	    /*type  =  save 保存设计 versions 保存版本  close关闭 */
	    fnCheckForm : function ( type ) {
	        if(formEditor.queryCommandState( 'source' ))
	            formEditor.execCommand('source');//切换到编辑模式才提交，否则有bug

	        if(formEditor.hasContents()){
	            formEditor.sync();/*同步内容*/

	            //--------------以下仅参考-----------------------------------------------------------------------------------------------------
	            var type_value='',formid=0,fields=$("#fields").val(),formeditor='';

	            if( typeof type!=='undefined' ){
	                type_value = type;
	            }
	            //获取表单设计器里的内容
	            formeditor=formEditor.getContent();
	            //解析表单设计器控件
	            var parse_form = this.parse_form(formeditor,fields);
	            //alert(parse_form);
	            //异步提交数据
	            $.ajax({
	                type: 'POST',
	                url : '${ctx}/config/form/processor',
	                //dataType : 'json',
	                data : {'type' : type_value,'formid':'${form.id}','parse_form':parse_form},
	                success : function(data){
						if(data == true) {
							alert('表单保存成功');
							window.location.href='${ctx}/config/form';
						} else {
							alert('表单保存失败');
						}
	                }
	            });

	        } else {
	            alert('表单内容不能为空！')
	            $('#submitbtn').button('reset');
	            return false;
	        }
	    } ,
	   // 预览表单
	    fnReview : function (){
	        if(leipiEditor.queryCommandState( 'source' ))
	            leipiEditor.execCommand('source');
	            
	        if(leipiEditor.hasContents()){
	            leipiEditor.sync();       
	         	
	           var parse_form = this.parse_form(leipiEditor.getContent());
	           $("#formContent").val(parse_form);
	            document.formobj.target="mywin";
	            window.open('','mywin',"menubar=0,toolbar=0,status=0,resizable=1,left=0,top=0,scrollbars=1,width=" +(screen.availWidth-10) + ",height=" + (screen.availHeight-50) + "\"");

	            document.formobj.action="autoFormController.do?review";
	            document.formobj.submit(); //提交表单
	           
	        } else {
	            alert('表单内容不能为空！');
	            return false;
	        }
	    }
	};
	function setContent(){
	    if(leipiEditor.queryCommandState( 'source' ))
	            leipiEditor.execCommand('source');//切换到编辑模式才提交，否则有bug
	            
	    if(leipiEditor.hasContents()){
	        leipiEditor.sync();
		    $("#formContent").val(leipiEditor.getContent());
		}
	}
</script>		