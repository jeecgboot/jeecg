<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="jformOrderCustomerList" checkbox="true" fitColumns="true" title="" actionUrl="jformOrderMainController.do?customerDatagrid" 
  	idField="id" fit="true" queryMode="group" collapsible="true">
   <t:dgCol title="主键"  field="id"  hidden="true"  queryMode="single"  width="0"></t:dgCol>
   <t:dgCol title="外键"  field="fkId"  hidden="true"  queryMode="single"  width="0"></t:dgCol>
   <t:dgCol title="名称"  field="name"  extendParams="editor:'text'" queryMode="single"  width="100"></t:dgCol>
   <t:dgCol title="单价"  field="money" extendParams="editor:'numberbox'"  queryMode="single"  width="50"></t:dgCol>
   <t:dgCol title="性别"  field="sex" extendParams="editor:'combobox'" queryMode="single" dictionary="sex"  width="80"></t:dgCol>
   <t:dgCol title="电话"  field="telphone" extendParams="editor:{type:'validatebox',options:{validType:'phoneRex'}}"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="身份证扫描件"  field="sfPic"  queryMode="single"  width="120"></t:dgCol>
   
	<t:dgToolBar  title="编辑" icon="icon-edit"  funname="editRow"></t:dgToolBar>
	<t:dgToolBar  title="保存" icon="icon-save" url="jformOrderMainController.do?saveRows" funname="saveData"></t:dgToolBar>
	<t:dgToolBar  title="取消编辑" icon="icon-undo" funname="reject"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript" src="webpage/com/jeecg/demo/orderOne2Many/rowedit.js" ></script>
 <script type="text/javascript">

 var selectIframe;//iframe对象
 var iframeCloseFlag = 1;//避免多次创建弹框
 $(function(){
	  $('#jformOrderCustomerList').datagrid({
		  onDblClickCell: function(index,field,value){
				$(this).datagrid('beginEdit', index);
				var ed = $(this).datagrid('getEditor', {index:index,field:"name"});
			 	//点击弹框
			 	$(ed.target).bind('click', function(){
					if(iframeCloseFlag==1){
						var defaultval = $(ed.target).val();
						openSelect(defaultval,"树选择弹框测试demo",this);
						iframeCloseFlag=0;
						$(this).focus();
					}
				}); 
				//输入事件
				$(ed.target).bind('input propertychange', function(){
					var defaultval = $(ed.target).val();
					selectIframe.iframe.contentWindow.initSelectTree(defaultval);
				});
			}
		}); 

 });
function getCustomerList(id){
	$('#jformOrderCustomerList').datagrid('load',{
		fkId : id
	});
}
//打开选择框
function openSelect(dv,title,obj) {
	$.dialog.setting.zIndex = getzIndex(); 
	selectIframe = $.dialog({content: 'url:jformOrderMainController.do?departSelect&name='+dv, zIndex: getzIndex(),title: title, lock: false, width: '400px', height: '350px', opacity: 0.4, button: [
	   {name: '<t:mutiLang langKey="common.confirm"/>', callback: function (){callbackSelect(obj);}, focus: true}
	   /* ,
	   {name: '<t:mutiLang langKey="common.cancel"/>', callback: function (){iframeCloseFlag = 1;}} */
   ], cancel:function (){iframeCloseFlag = 1;}}).zindex();
}

//回调函数,把值赋值到对应的属性上
function callbackSelect(obj) {
	var iframe = selectIframe.iframe.contentWindow;
	var treeObj = iframe.$.fn.zTree.getZTreeObj("departSelect");
	var nodes = treeObj.getCheckedNodes(true);
	if(nodes.length>0){
		var ids='',names='',codes='';
		for(i=0;i<nodes.length;i++){
		   var node = nodes[i];
		   ids += node.id+',';
		   names += node.name+',';
		   codes += node.code+',';
		}
		$(obj).val(nodes[0].name);
		iframeCloseFlag = 1;
	}
}

 </script>