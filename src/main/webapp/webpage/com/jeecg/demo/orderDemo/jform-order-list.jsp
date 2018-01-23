<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">    
    <title>订单管理</title>
    <link rel="stylesheet" href="plug-in/FineUI4.0/f/f.css" type="text/css">
    <style type="text/css">
    body {
	    font-family: "Helvetica Neue",Helvetica,Arial,sans-serif !important;
	    font-size: 13px !important;
	    padding: 0;
	    margin: 0;
	    background-attachment: fixed;
	    -webkit-font-smoothing: subpixel-antialiased !important;
	}
	table {
	    white-space: normal;
	    line-height: normal;
	    font-weight: normal;
	    font-size: 13px !important;
	    font-style: normal;
	    color: -internal-quirk-inherit;
	    text-align: start;
	    font-variant: normal normal;
	}
    </style>   
    <link rel="stylesheet" href="plug-in/FineUI4.0/res/css/common.css" type="text/css">
	<script src="plug-in/jquery/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="plug-in/FineUI4.0/f/f.js"></script>
	<script type="text/javascript" src="plug-in/FineUI4.0/res/js/common.js"></script>
  </head>
  
  <body>
    <div id="wrap1"></div>
    <br />
    <div id="wrap2"></div>
    <br />
    <div id="wrap3"></div>
    <script>

	    // 打开窗体
	    function openWindow(rowData,iframeUrl) {
	        F.ui.window1.show(iframeUrl, '详细信息 - ' + rowData.text);
	    }
	    

     F.ready(function () {  
    	 
         F.ui({
             type: 'window', id: 'window1', renderTo: '#wrap2', hidden: true, width: 1200, height: 680, iframe: true, title: '编辑', modal: false, target: '_self',
             listeners: {
                 close: function () {
                     showNotify('窗体关闭了！');
                 }
             }
         });
    	 
    	 
         F.ui({
             type: 'panel', renderTo: document.body, isViewPort: true, layout: "region", border: false, header: false, title: '面板一（layout=region）',
             defaults: {
                 splitWidth: 3
             },
			items: 
			[
			      {
			      	 /*update-begin author:xuelin date:20171101 for:TASK #2403 【bug】【UI】fineui效果改进和参考*/
	                 type: 'panel', layout: "region", flex: 1, bodyPadding: 5, height: 430, title: '订单列表', region: 'top', collapsible: true, split: true, collapsible: true
	                 /*update-end author:xuelin date:20171101 for:TASK #2403 【bug】【UI】fineui效果改进和参考*/
	                 ,items:
	                 [
						{
							/*update-begin author:xuelin date:20171101 for:TASK #2403 【bug】【UI】fineui效果改进和参考*/
			                type: 'form', region: 'top', id: 'form1', layout: 'column', bodyPadding: 5, collapsible: true, title: '订单列表', header: false,
			                /*update-end author:xuelin date:20171101 for:TASK #2403 【bug】【UI】fineui效果改进和参考*/
			                fieldDefaults: {
			                    labelWidth: 70, labelAlign: 'right'
			                },
			                items: [{
			                    type: 'textbox',width: 230, id: 'orderCode', fieldLabel: '订单号', marginRight: 10
			                },{
			                    type: 'datepicker',width: 230, id: 'orderDate', fieldLabel: '订单日期', marginRight: 10
			                }, {
			                    type: 'textbox',width: 230, id: 'orderMoney', fieldLabel: '订单金额', marginRight: 10
			                }, {
			                    type: 'textbox',width: 230, id: 'content', fieldLabel: '备注', marginRight: 10
			                }, {
			                    type: 'button',width: 70, text: '查询', validateForm: 'form1',
			                    handler: function () {
			                        F.ui.grid1.loadDataUrl(getQueryString(),{});
			                    }
			                }]
			            },{
			            	 /*update-begin author:xuelin date:20171101 for:TASK #2403 【bug】【UI】fineui效果改进和参考*/
							 type: 'grid', region: 'center', id: 'grid1', renderTo: '#wrap1', collapsible: true, header: false, emptyText: '没有数据！', sorting: true
							 /*update-end author:xuelin date:20171101 for:TASK #2403 【bug】【UI】fineui效果改进和参考*/
							 , checkboxSelect: true, paging: true, databasePaging: true, pageSize: 8
							 ,bars: [{
				                    type: 'toolbar', align: 'left',
				                    items: [{
				                        type: 'button', text: '新增订单', icon: 'plug-in/FineUI4.0/res/icon/add.png',
				                        handler: function () {
				                        	F.ui.window1.show('jformOrderMainController.do?goAddOrder', '新订单');
				                            //F.ui.grid1.addNewRecord({orderCode: '新用户'}, true);
                                            F.ui.grid3.loadDataUrl();
				                        }
				                    }, {
				                        type: 'button', text: '删除选中行', icon: 'plug-in/FineUI4.0/res/icon/delete.png',
				                        handler: function () {
				                            if (!F.ui.grid1.hasSelection()) {
				                                F.alert('没有选中项！');
				                                return false;
				                            };
				                            var ids = F.ui.grid1.getSelectedRows().join(',');
				                            F.confirm({
				                                message: '删除选中行？',
				                                ok: function () {
				                                	$.ajax({
				                                 		url:'jformOrderMainController.do?doBatchDel',
				                                 		data:{ids:ids},
				                                 		type: "POST",
				                                 		success:function(data){	
				                                        	data = JSON.parse(data);
				                                            if (data.success) {
				                                                F.ui.grid1.deleteSelectedRows();
				                                                F.ui.grid3.loadDataUrl();
				                                                F.alert(data.msg);
				                							}
				                                 		}         		
				                                 	}); 
				                                }
				                            });
				                        }
				                    }, {
				                        type: 'fileupload',name:'inputFile', buttonText: '导入', buttonOnly: true, accept: 'application/vnd.ms-excel',
				                        buttonConfig: {
				                        	icon: 'plug-in/FineUI4.0/res/icon/table_row_insert.png'
				                        },
				                        listeners: {
				                            change: function () {
				                            	var formData = new FormData();
				                            	formData.append("file",$("input[name='inputFile']")[0].files[0]);				                            	
				                            	$.ajax({ 
				                            		url : 'jformOrderMainController.do?importExcel', 
				                            		type : 'POST', 
				                            		data : formData, 
				                            		// 告诉jQuery不要去处理发送的数据
				                            		processData : false, 
				                            		// 告诉jQuery不要去设置Content-Type请求头
				                            		contentType : false,
				                            		beforeSend:function(){
				                            			console.log("正在进行，请稍候");
				                            		},
				                            		success : function(data) {
						                            	data = JSON.parse(data); 
				                            			F.alert(data.msg);	
					                            		if(data.success){
					                            			$("input[name='orderCode']").val("");
					                                        $("input[name='orderDate']").val("");
					                                        $("input[name='orderMoney']").val("");
					                                        $("input[name='content']").val("");
					                            			F.ui.grid1.loadDataUrl(getQueryString(),{});
			                                                F.ui.grid3.loadDataUrl();
					                            		}
				                            		}, 
				                            		error : function(responseStr) { 
				                            			console.log("responseStr");
				                            		} 
				                            	});
				                            }
				                        }
				                    }, {
				                        type: 'button', text: '导出', icon: 'plug-in/FineUI4.0/res/icon/application_side_expand.png',
				                        handler: function () {
				                        	window.location.href = 'jformOrderMainController.do?exportXls';
				                        }
				                    }, {
				                        type: 'button', text: '模版下载', icon: 'plug-in/FineUI4.0/res/icon/page_white_excel.png',
				                        handler: function () {
				                        	window.location.href = 'jformOrderMainController.do?exportXlsByT';
				                        }
				                    }/*, '->', {
				                        type: 'button', text: '重置表格数据',
				                        handler: function () {
				                            F.confirm({
				                                message: '确定要重置表格数据？',
				                                ok: function () {
				                                    F.ui.grid1.rejectChanges();

				                                    F.ui.grid3.loadDataUrl();
				                                }
				                            });
				                        }
				                    }*/]
				                }]
				             , columns: [{
				                    columnType: 'rownumberfield'
				                }, {
				                /*update-begin author:xuelin date:20171101 for:TASK #2403 【bug】【UI】fineui效果改进和参考*/
				                    text: '订单号', field: 'orderCode', width: 150, sortable: true 
				                }, {
				                    text: '订单日期', field: 'orderDate', width: 220, sortable: true 
				                }, {
				                    text: '订单金额', field: 'orderMoney', width: 120, sortable: true 
				                /*update-end author:xuelin date:20171101 for:TASK #2403 【bug】【UI】fineui效果改进和参考*/
				                }, /*{
				                    text: '缩略图', field: 'ctype', width: 70, 
				                    renderer: function (value, params) {
				                        return '<img width="30" src="' + encodeURIComponent(value) + '" target="_blank" />';
				                    }
				                }, */{
				                    text: '描述', field: 'content', flex:1
				                },{
				                    text: '编辑', width: 60,
				                    renderer: function (value, params) {
				                        return '<a href="javascript:" id="editOrder" class="mywindowfield"><img src="plug-in/FineUI4.0/res/icon/application_edit.png" alt="Edit"/></a>';
				                    }
				                },{
				                	text: '删除', width: 60, renderer: function () {
				                        return '<a class="action-btn delete" id="delOrder" href="javascript:;"><img src="plug-in/FineUI4.0/res/icon/decline.png" alt="Delete"/></a>';
				                    }
				                }],
				                idField: 'id', textField: 'orderCode',
				                dataUrl: getQueryString(),
				                listeners: {
				                    rowclick: function (event, rowId) {
				                        var rowData = this.getRowData(rowId);
				                        F.ui.grid3.loadDataUrl('jformOrderMainController.do?customerDataGrid&rows=8&fkId='+rowId,{});
				                    }
				                },
				                // 模拟服务器返回的数据（真实环境中请删除此函数）也可以在这里进行数据封装操作
				                dataFilter: function (data, dataType) {	
				                	//data = JSON.parse(data); 
				                	//console.info(data);
				                	return data;
				                }, 
				                pagingbar: {
				                    type: 'pagingtoolbar',
				                    items: ['-', {
				                        type: 'button', text: '刷新数据', icon: 'plug-in/FineUI4.0/res/icon/reload.png',
				                        handler: function () {
				                            F.ui.grid1.loadDataUrl();
				                        }
				                    }]
				                }
	               		}
	               ]
				},
				{
                 	type: 'grid', region: 'center', id: 'grid3', renderTo: '#wrap3', collapsible: true, title: '客户列表', emptyText: '没有数据！'
					, checkboxSelect: true, paging: true, databasePaging: true, pageSize: 8, showSelectedCell: true, cellEditing: true, cellEditingClicks: 2
					, idField: 'id', textField: 'orderCode'
	                , dataUrl: ''
	                ,listeners: {
	                    /*datachange: function () {
	                        var grid3 = F.ui.grid3;
	                        var button1 = F.ui.button1;

	                        // 如果没有删除行，没有新增行，没有修改的数据
	                        if (!grid1.getModifiedData().length) {
	                            button1.disable();
	                        } else {
	                            button1.enable();
	                        }
	                    }*/
	                }
	                , columns: [{
	                    columnType: 'rownumberfield'
	                }, {
                    	field: 'id', hidden: true
                    },{
                    	field: 'fkId', hidden: true
                    }, {
	                    text: '姓名', field: 'name', width: 100, editable: true,
                        editor: {
                            type: 'textbox', required: true
                        }
	                }, {
	                    text: '性别', field: 'sex', width: 60, editable: true,
                        renderer: function (value) {
                            return value == 1 ? '男' : '女';
                        },
                        editor: {
                            type: 'dropdownlist', required: true, editable: true,
                            data: [['1', '男'], ['0', '女']]
                        }
	                }, {
	                    text: '电话', field: 'telphone', width: 120, editable: true,
                        editor: {
                            type: 'textbox', required: true
                        }
	                }, {
	                    text: '金额', field: 'money', width: 150, flex:1, editable: true,
                        editor: {
                            type: 'textbox', required: true
                        }
	                }, {
	                    text: '证件预览', field: 'sfPic', hidden: true
	                }/*,{//子表数据操作部分，随主表操作同时进行，省去该部分功能，若有特殊需要放开
	                    text: '编辑', width: 60,
	                    renderer: function (value, params) {
	                        return '<a href="javascript:;" id="editCustomer" class="mywindowfield"><img src="plug-in/FineUI4.0/res/icon/application_edit.png" alt="Edit"/></a>';
	                    }
	                },{
	                	text: '删除', width: 60, renderer: function () {
	                        return '<a id="delCustomer" class="action-btn delete" href="javascript:;"><img src="plug-in/FineUI4.0/res/icon/decline.png" alt="Delete"/></a>';
	                    }
	                }*/]
	                ,pagingbar: {
	                    type: 'pagingtoolbar',
	                    items: ['-', {
	                        type: 'button', id: 'commitBtn', text: '提交修改', 
	                        handler: function () {
	                            var grid3 = F.ui.grid3;
	                            if (grid3.getModifiedData().length>0) {
	                            	
	                            	var formData = new FormData();	                                
	                                //封装jformOrderMainPage.jformOrderCustomerList
	                                var customerList = new Array();
	                                $(grid3.getModifiedData()).each(function (i,obj){
                                    	var customer = grid3.getRowValue(obj.id);
                                    	for(var name in customer){
                                    		formData.append("jformOrderCustomerList["+customerList.length+"]."+name,customer[name]);
                                        }   
                                    	customerList.push(customer); 
	                                });
	                                $.ajax({ 
	        	                        url : 'jformOrderMainController.do?doUpdateCustomer', 
	        	                        type : 'POST', 
	        	                        data : formData, 
	        	                        processData : false, 
	        	                        contentType : false,
	        	                        beforeSend:function(){
	        	                        	//console.log("正在进行，请稍候");
	        	                        },
	        	                        success : function(data) {	
	        	                        	data = JSON.parse(data); 
	        	                        	F.alert(data.msg);
	        	                        	if(data.success){
	        		                            grid3.commitChanges();
	        	                        	}	                        	
	        	                        }, 
	        	                        error : function(responseStr) { 
	        	                        	console.log("error");
	        	                        } 
	                                }); 
	                            	
	                            }else{
	                            	F.alert("未修改任何数据");
	                            }
	                            /* if (!grid1.getModifiedData().length) {
	                                button1.disable();
	                            } else {
	                                button1.enable();
	                            } */
	                            //"status": "modified",
	                            // 提交数据后，重新禁用提交按钮
	                            //F.ui.commitBtn.disable();
	                        }
	                    }]
	                }
	                /*,bars: [{
	                    type: 'toolbar', align: 'left',
	                    items: [{
	                        type: 'button', text: '新增数据', icon: 'plug-in/FineUI4.0/res/icon/add.png',
	                        handler: function () {
	                            //F.ui.grid3.addNewRecord({name: '新用户'}, true);
	                        }
	                    }, {
	                        type: 'button', text: '删除选中行', icon: 'plug-in/FineUI4.0/res/icon/delete.png',
	                        handler: function () {
	                            if (!F.ui.grid3.hasSelection()) {
	                                F.alert('没有选中项！');
	                                return false;
	                            };

	                            F.confirm({
	                                message: '删除选中行？',
	                                ok: function () {
	                                    F.ui.grid3.deleteSelectedRows();
	                                }
	                            });
	                        }
	                    }, '->', {
	                        type: 'button', text: '重置表格数据',
	                        handler: function () {
	                            F.confirm({
	                                message: '确定要重置表格数据？',
	                                ok: function () {
	                                    F.ui.grid3.rejectChanges();
	                                }
	                            });
	                        }
	                    }]
	                }]*/
            	}/*, 
            	{
                 	type: 'panel', bodyPadding: 5, title: '', region: 'bottom', collapsible: true, split: true, html: ''
            	}*/
          ]
         });
         
         var grid1 = F.ui.grid1;
         // 点击表格行中的编辑按钮
         grid1.el.on('click', '#editOrder', function (event) {
             var rowEl = $(this).closest('.f-grid-row');
             var rowData = grid1.getRowData(rowEl);
 	         var iframeUrl = 'jformOrderMainController.do?goEditOrder&id='+rowData.id;
             openWindow(rowData,iframeUrl);
         });
         
      	// 初始化表格内删除按钮事件
         grid1.el.on('click', '#delOrder', function () {
             var targetEl = $(this);
             var rowEl = targetEl.parents('.f-grid-row');
             var rowData = grid1.getRowData(rowEl);

             F.confirm({
                 message: '删除选中行？',
                 ok: function () {                	 
                 	$.ajax({
                 		url:'jformOrderMainController.do?doDel',
                 		data:{id:rowData.id},
                 		type: "POST",
                 		success:function(data){	
                        	data = JSON.parse(data);
                            if (data.success) {
                                grid1.deleteRow(rowData.id);
                                F.ui.grid3.loadDataUrl();
                                F.alert(data.msg);
							}
                 		}         		
                 	}); 
                 }
             });
         });
      	
      	
       //子表数据操作部分，随主表操作同时进行，省去该部分功能，若有特殊需要放开
/*        var grid3 = F.ui.grid3;
         // 点击表格行中的编辑按钮
         grid3.el.on('click', '#editCustomer', function (event) {
             var rowEl = $(this).closest('.f-grid-row');
             var rowData = grid3.getRowData(rowEl);
             var iframeUrl = 'jformOrderMainController.do?goUpdate';
             openWindow(rowData,iframeUrl);
         });
         
      	// 初始化表格内删除按钮事件
         grid3.el.on('click', '#delCustomer', function () {
             var targetEl = $(this);
             var rowEl = targetEl.parents('.f-grid-row');
             var rowData = grid3.getRowData(rowEl);

             F.confirm({
                 message: '删除选中行？',
                 ok: function () {
                     grid3.deleteRow(rowData.id);
                 }
             });
         });
      	 */
 
      	 /**
      	 * 生成查询url
      	 */
       	 function getQueryString(){
      		 //因页面加载时FineUI并未完成，这里采用jquery选择器
    		 var orderCode = $("input[name='orderCode']").val();
             var orderDate = $("input[name='orderDate']").val();
             var orderMoney = $("input[name='orderMoney']").val();
             var content = $("input[name='content']").val();
            
             var url = 'jformOrderMainController.do?orderDataGrid&rows=8';//为配合原系统的datagrid对象，手动传参row = 每页显示行数
             url += "&orderCode="+orderCode+"&orderDate="+orderDate+"&orderMoney="+orderMoney+"&content="+content;
             url = url.replace(/=undefined/g,"=");
             return url;
    	 }

     });
    </script>
  </body>
</html>
