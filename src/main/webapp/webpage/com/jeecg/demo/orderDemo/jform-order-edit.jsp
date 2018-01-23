<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">    
    <title>更新订单</title>	
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
  	<div id="wrap0"></div>
    <br />
    <div id="wrap1"></div>
    <br />
    <div id="wrap2"></div>
    <br />
        <script>
     	
     	function initOrderDate(){
     		if('${order.orderDate}' == ''){
     			return new Date();
     		}else{
     			return '${order.orderDate}';
     		}
     	}
        
        F.ready(function () {
            F.ui({
                type: 'form', id: 'form1', renderTo: '#wrap0', layout: 'anchor', bodyPadding: 5, collapsible: true, title: '表单', header: false,
                fieldDefaults: {
                	 labelWidth: 100, labelAlign: 'right'
                },
                items: [{
					type: 'panel', layout: 'column', border: false, header: false
				    ,items: [{
				    	type: 'textbox', name: 'orderCode', id: 'orderCode', columnWidth: 0.5, redStar: true, fieldLabel: '订单编号', required: true, marginRight: 20, value: '${order.orderCode}'
					}, {
						 type: 'datepicker', name: 'orderDate', id: 'orderDate', columnWidth: 0.5, redStar: true, fieldLabel: '订单日期', required: true, marginRight: 20, value: initOrderDate()
                    }, {
                    	type: 'textbox', name: 'id', id: 'id', hidden: true, value: '${order.id}'
                    }]
				},{
                    type: 'panel', layout: 'column', border: false, header: false,
                    items: [{
                        type: 'numberbox', name:'orderMoney', id:'orderMoney', columnWidth: 0.5, fieldLabel: '订单金额', redStar: true, required: true, marginRight: 20, value: '${order.orderMoney}'
                    }, {
                    	type: 'fileupload', name:'ctype', id:'ctype', columnWidth: 0.482, fieldLabel: '订单扫描件', emptyText: '请选择一张图片', value: '${order.ctype}'
                        ,buttonConfig: {
                            icon: 'plug-in/FineUI4.0/res/icon/add.png'
                        }
                    }]
                },{
                    type: 'panel', layout: 'column', border: false, header: false,
                    items: [ {
                        type: 'textarea', name:'content', id:'content', columnWidth: 1, fieldLabel: '备注', marginRight: 20, value: '${order.content}'
                    }]
                },{
                    type: 'tabstrip', id: 'tabstrip1', renderTo: '#wrap1', height: 350, tabPosition: 'top', activeTabIndex: 0
                    ,items:[{
                        type: 'tab', layout: 'fit', bodyPadding: 5, title: '客户信息'
                        ,items: [{
                        	type: 'grid', id: 'customerGrid', renderTo: '#wrap2', collapsible: true, header: false, checkboxSelect: true, showSelectedCell: true, cellEditing: true, cellEditingClicks: 2
                        	,columns:[{
                                columnType: 'rownumberfield'
                            }, {
                            	field: 'id', hidden: true
                            }, {
                            	text: '客戶名', field: 'name', width: 100, editable: true,
                                editor: {
                                    type: 'textbox', required: true
                                }
                            },{
                            	text: '单价', field: 'money', width: 100, editable: true,
                                editor: {
                                    type: 'textbox', required: true
                                }
                            },{
                            	text: '性别', field: 'sex', fieldType: 'int', width: 80, editable: true,
                                renderer: function (value) {
                                    if(value == 1) return '男';
                                    if(value == 0) return '女';
                                    return '';
                                },
                                editor: {
                                    type: 'dropdownlist', required: true,
                                    data: [['1', '男'], ['0', '女']]
                                }
                            },{
                            	text: '电话', field: 'telphone', width: 150, editable: true,
                                editor: {
                                    type: 'textbox', required: true
                                }
                            },{
                            	text: '身份证扫描件', field: 'sfPic', width: 250, editable: true
                                ,editor: {
                                    type: 'fileupload', required: true
                                }
                            }, {
                                width: 50,flex:1, renderer: function () {
                                    return '<a class="action-btn delete" id="delCustomer" href="javascript:;"><img src="plug-in/FineUI4.0/res/icon/delete.png" alt="Delete"/></a>';
                                }
                            }],
                            idField: 'id',
                            textField: 'name',
                            dataUrl: 'jformOrderMainController.do?customerList&fkId=${order.id}'
                            ,dataFilter: function (data, dataType) {	
			                	//data = JSON.parse(data); 			                	
			                	//console.info(data);
			                	return data;
			                }
	                        ,bars: [{
	                            type: 'toolbar', align: 'left',
	                            items: [{
	                                type: 'button', text: '新增数据', icon: 'plug-in/FineUI4.0/res/icon/add.png',
	                                handler: function () {
	                                    F.ui.customerGrid.addNewRecord({name:'Jack',money:'99.9',sex:'0'}, true);
	                                }
	                            }, {
	                                type: 'button', text: '删除选中行', icon: 'plug-in/FineUI4.0/res/icon/delete.png',
	                                handler: function () {
	                                    if (!F.ui.customerGrid.hasSelection()) {
	                                        F.alert('没有选中项！');
	                                        return false;
	                                    };
	                                    F.ui.customerGrid.deleteSelectedRows();
	                                    /* F.confirm({
	                                        message: '删除选中行？',
	                                        ok: function () {
	                                            F.ui.customerGrid.deleteSelectedRows();
	                                        }
	                                    }); */
	                                }
	                            }, '->', {
	                                type: 'button', text: '重置表格数据',
	                                handler: function () {
	                                    F.confirm({
	                                        message: '确定要重置表格数据？',
	                                        ok: function () {
	                                            F.ui.customerGrid.rejectChanges();
	                                        }
	                                    });
	                                }
	                            }]
	                        }]
                        }]
                    
                    },{
                    	type: 'tab', layout: 'fit', bodyPadding: 5, title: '机票信息'
                        ,items:[{
                        	type: 'grid', id: 'ticketGrid', renderTo: '#wrap1', collapsible: true, header: false, checkboxSelect: true, showSelectedCell: true, cellEditing: true, cellEditingClicks: 2
                            ,columns: [{
                                columnType: 'rownumberfield'
                            }, {
                            	field: 'id', hidden: true
                            }, {
                                text: '航班号', field: 'ticketCode', width: 100, editable: true,
                                editor: {
                                    type: 'textbox', required: true
                                }
                            }, {
                                text: '登机时间', field: 'tickectDate', width: 200, fieldType: 'date', fieldFormat: 'yyyy-MM-dd HH:mm:ss', editable: true,
                                editor: {
                                    type: 'datepicker', required: true
                                }
                            }, {
                                width: 50,flex:1, renderer: function () {
                                    return '<a class="action-btn delete" id="delTicket" href="javascript:;"><img src="plug-in/FineUI4.0/res/icon/delete.png" alt="Delete"/></a>';
                                }
                            }],
                            idField: 'id',
                            textField: 'name',
                            dataUrl: 'jformOrderMainController.do?ticketList&fckId=${order.id}'
                           	,bars: [{
                                   type: 'toolbar', align: 'left',
                                   items: [{
                                       type: 'button', text: '新增数据', icon: 'plug-in/FineUI4.0/res/icon/add.png',
                                       handler: function () {
                                           F.ui.ticketGrid.addNewRecord({
                                        	   ticketCode: 'AU001',
                                               tickectDate: '2017-10-18 18:18:18'
                                           }, true);
                                       }
                                   }, {
                                       type: 'button', text: '删除选中行', icon: 'plug-in/FineUI4.0/res/icon/delete.png',
                                       handler: function () {
                                           if (!F.ui.ticketGrid.hasSelection()) {
                                               F.alert('没有选中项！');
                                               return false;
                                           };
                                           F.ui.ticketGrid.deleteSelectedRows();
                                           /*F.confirm({
                                               message: '删除选中行？',
                                               ok: function () {
                                                   F.ui.ticketGrid.deleteSelectedRows();
                                               }
                                           });*/
                                       }
                                   }, '->', {
                                       type: 'button', text: '重置表格数据',
                                       handler: function () {
                                           F.confirm({
                                               message: '确定要重置表格数据？',
                                               ok: function () {
                                                   F.ui.ticketGrid.rejectChanges();
                                               }
                                           });
                                       }
                                   }]
                               }]
                        }]
                    	
                    }]
                	    
                },{
                    type: 'button', id:'subBtn', text: '保存订单', validateForm: 'form1', iconFont: 'f-iconfont-save', style: 'top:5px;left:1060px;',
                    handler: function () {
                        /* var oData = new FormData(document.forms.namedItem("fileinfo" ));  
                        oData.append( "CustomField", "This is some extra data" );  
                        var oReq = new XMLHttpRequest();  
                        oReq.open( "POST", "stash.php" , true );  
                        oReq.onload = function(oEvent) {  
                              if (oReq.status == 200) {  
                                  oOutput.innerHTML = "Uploaded!" ;  
                             } else {  
                                  oOutput.innerHTML = "Error " + oReq.status + " occurred uploading your file.<br \/>";  
                             }  
                        };  
                        oReq.send(oData);  */ 
                        
                        var formData = new FormData();
                        formData.append("id",F.ui.id.getValue());
                        formData.append("orderCode",F.ui.orderCode.getValue());
                        formData.append("orderDate",F.ui.orderDate.getText());
                        formData.append("orderMoney",F.ui.orderMoney.getValue());
                        formData.append("file",F.ui.ctype.getValue());
                        
                        //封装jformOrderMainPage.jformOrderCustomerList
                        var customerList = new Array();
                        $(customerGrid.data).each(function (i,obj){
                        	if(obj.status!='deleted'){
                            	var customer = obj.values;
                            	for(var name in customer){   
                            		formData.append("jformOrderCustomerList["+customerList.length+"]."+name,customer[name]);
                                } 
                            	customerList.push(customer);
                        	}  
                        });
                      	//封装jformOrderMainPage.jformOrderTicketList 
                        var ticketList = new Array();
                        $(ticketGrid.data).each(function (i,obj){
                        	if(obj.status!='deleted'){
                            	var ticket = obj.values;
                            	if(ticket['tickectDate']!=""){
                            		var date = new Date(ticket['tickectDate']);
                            		date = F.formatDate('yyyy-MM-dd HH:mm:ss', date);
                            		ticket['tickectDate'] = date;
                            	}
                            	for(var name in ticket){
                                    formData.append("jformOrderTicketList["+ticketList.length+"]."+name,ticket[name]);
                            	}
                            	ticketList.push(ticket);
                        	}
                        });
                        
                        $.ajax({ 
	                        url : 'jformOrderMainController.do?doUpdate', 
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
	                        		F.activeWindow.hideExecuteScript('F.ui.grid1.loadDataUrl();F.ui.grid3.loadDataUrl();');
	                        	}	                        	
	                        }, 
	                        error : function(responseStr) { 
	                        	console.log("error");
	                        } 
                        }); 
                        /* customerGrid.commitChanges();
                        ticketGrid.commitChanges(); */
                    }
                }]
            });
            
            
            // 初始化表格内删除按钮事件
            var ticketGrid = F.ui.ticketGrid;
            ticketGrid.el.on('click', '#delTicket', function () {
                var targetEl = $(this);
                var rowEl = targetEl.parents('.f-grid-row');
                var rowData = ticketGrid.getRowData(rowEl);
                ticketGrid.deleteRow(rowData.id); 
                /* F.confirm({
                    message: '删除选中行？',
                    ok: function () {
            		 	ticketGrid.deleteRow(rowData.id); 
                    }
                }); */
            });
            
         	// 初始化表格内删除按钮事件
            var customerGrid = F.ui.customerGrid;
            customerGrid.el.on('click', '#delCustomer', function () {
                var targetEl = $(this);
                var rowEl = targetEl.parents('.f-grid-row');
                var rowData = customerGrid.getRowData(rowEl);
                customerGrid.deleteRow(rowData.id);
                /* F.confirm({
                    message: '删除选中行？',
                    ok: function () {
                    	customerGrid.deleteRow(rowData.id);
                    }
                }); */
            });


        });
    </script>
  </body>
</html>
