<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker,autocomplete"></t:base>
<div>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
	  <t:datagrid name="jeecgrowList" pagination="true" fitColumns="true" title="数据列表" actionUrl="jeecgListDemoController.do?datagrid" pageSize="5" idField="id" queryMode="group">
		<t:dgCol title="id"  field="id"   hidden="true"   queryMode="group"  width="140"></t:dgCol>
	    <t:dgCol title="名称"  field="name" query="true" extendParams="editor:'text'" width="150"></t:dgCol>
	    <t:dgCol title="年龄"  field="age"  query="true" extendParams="editor:'numberbox'" width="80"></t:dgCol>
	    <t:dgCol title="生日"  field="birthday" formatter="yyyy-MM-dd"  extendParams="editor:'datebox'" width="150"></t:dgCol>
	    <t:dgCol title="性别"  field="sex"  query="true" dictionary="sex" extendParams="editor:'combobox'" width="100"></t:dgCol>
	    <t:dgCol title="工资"  field="salary"  queryMode="group" extendParams="editor:'numberbox'" width="100"></t:dgCol>
	    <t:dgCol title="入职状态"  field="status" query="true" dictionary="sf_yn" extendParams="editor:'combobox'" width="100"></t:dgCol>
	    <t:dgCol title="个人介绍"  field="content"  hidden="true"   queryMode="group"  width="500" extendParams="editor:'text'" ></t:dgCol>
	  
	   		<t:dgCol title="操作" field="opt" width="100"></t:dgCol>
			<t:dgFunOpt funname="deleteDialog(id)" title="common.delete" urlclass="ace_button"  urlfont="fa-trash-o"></t:dgFunOpt>
			<%-- <t:dgFunOpt funname="showEdit(id,name)" title="common.edit" urlclass="ace_button"  urlfont="fa-trash-o"></t:dgFunOpt> --%>
			
	  </t:datagrid>
  </div>
</div>
 <script type="text/javascript">
	
	function deleteDialog(id){
		//提示框
		$.messager.confirm("确认", "确定要删除这条数据？", function (r) {
	        if (r) {	            
				var url = "jeecgListDemoController.do?doBatchDel&ids=" + id;
				$.ajax({
					url:url,
					type:"get",
					dataType:"json",
					success:function(data){
						top.tip(data.msg);
						if(data.success){							
							$("#jeecgrowList").datagrid('reload');
						}
					}
				})
	        }
	    });
	}

 	function fillData(rowData){ 
 		//清空表单	
 		$("#ff").form('clear');
 		//填充数据
 		for(var d in rowData){
			$("#"+d).val(rowData[d]);
		}
		//处理特殊控件
 		var birthday = rowData["birthday"];
		if(birthday != undefined){
			birthday = birthday.replace(" 00:00:00.0","");
		}else{
			birthday = "";
		}		
		$("#birthday").datebox("setValue", birthday); 
 	}

 	$(function(){
 	
 		 $("#jeecgrowList").datagrid({
			onClickRow: function(rowIndex, rowData){
				fillData(rowData);
				$("#editPanel").panel({title:"编辑数据"});	
			}
		});	

		//隐藏滚动条，固定高度，可根据表单字段数量调整
		$("body").css({"overflow": "hidden","height": "600px"});
		 
		 $("#ff").Validform({
			tiptype:1, 
			dragonfly:false,
			tipSweep:false,
			showAllError:false,
			postonce:true,
			ajaxPost:true
		}); 
 	})
	
	//保存数据
	function saveData(){
		//var demo=$(".formsub").Validform(); 
		$("#ff").Validform({
			callback:function(data){
				top.tip(data.msg);
				if(data.success){
					clearData();
					$("#jeecgrowList").datagrid('reload');
				}
			}
		}).ajaxPost(false,true);
	}
	
	function cancelEdit(){		
		var rowData = $("#jeecgrowList").datagrid("getSelected");
		if (rowData != null) {
			fillData(rowData);
			$("#editPanel").panel({title:"编辑数据"});		
		}else{
			clearData();			
		}
	}
	
	function clearData(){
		var rowData = {};
		fillData(rowData);	
		$("#editPanel").panel({title:"新增数据"});
		$("#jeecgrowList").datagrid('clearChecked');
	}
 
 </script>
 <style type="text/css">
 	.value{
 		padding: 10px auto 10px 10px;
 	}
 </style>
 	</div>
    <div title="新增数据" style="height:350px;" name="editPanel" id="editPanel" fit="true" class="easyui-panel"> 
    	<div class="datagrid-toolbar" style="float:left;width: 100%;">
		    <a href="#" class="easyui-linkbutton l-btn l-btn-plain" plain="true" icon="icon-add" onclick="clearData()">
			  	 清空表单
		    </a>
		    <a href="#" class="easyui-linkbutton l-btn l-btn-plain" plain="true" icon="icon-undo" onclick="cancelEdit()">
				重置表单
		    </a>
		    <a href="#" class="easyui-linkbutton l-btn l-btn-plain" plain="true" icon="icon-save" id="btn_sub" onclick="saveData()"><!-- onclick="saveData()" -->
		    	提交数据
		    </a>
    	</div>
		<t:formvalid formid="ff" dialog="true" layout="table" tiptype="4" action="jeecgListDemoController.do?saveRows">
			<input name="demos[0].id" id="id" type="hidden" value="" /> 
			<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
					<tbody><tr>
						<td align="right">
							<label class="Validform_label">
								名称:
							</label>
						</td>
						<td class="value">
						     <input id="name" name="demos[0].name" type="text" style="width: 150px;" class="inputxt" datatype="*" value="">
						</td>
						<td align="right">
							<label class="Validform_label">
								年龄:
							</label>
						</td>
						<td class="value">
						     <input id="age" name="demos[0].age" type="text" style="width: 150px;" class="inputxt" datatype="d" value="">
						</td>
						<td align="right">
							<label class="Validform_label">
								生日:
							</label>
						</td>
						<td class="value">
							<input class="easyui-datebox" type="text" name="demos[0].birthday" id="birthday"/>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label class="Validform_label">
								性别:
							</label>
						</td>
						<td class="value">
							<t:dictSelect field="demos[0].sex" typeGroupCode="sex" id="sex" title="性别"></t:dictSelect>
						</td>
						<td align="right">
							<label class="Validform_label">
								工资:
							</label>
						</td>
						<td class="value">
						     	 <input id="salary" name="demos[0].salary" type="text" style="width: 150px;" class="inputxt" value="">
						</td>
						<td align="right">
							<label class="Validform_label">
								入职状态:
							</label>
						</td>
						<td class="value">
							<t:dictSelect field="demos[0].status" id="status" typeGroupCode="sf_yn" title="入职状态"></t:dictSelect>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label class="Validform_label">
								个人介绍:
							</label>
						</td>
						<td class="value" colspan="5">
							<textarea name="demos[0].content" id="content" style="width: 600px;height:120px"></textarea>
						</td>
					</tr>
			</tbody>
			</table>
		
		</t:formvalid>
    </div>