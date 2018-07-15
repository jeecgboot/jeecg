<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools"></t:base>
 <style type="text/css">
 	th{
 		text-align: center;
 		line-height: 25px;
 	}
 	.value{
 		padding: 10px auto 10px 10px;
 	}
 	.inputxt{
 		width: 150px;
 	}
 </style>
    <div title="Popup Demo" style="height:350px;" name="editPanel" id="editPanel" fit="true" class="easyui-panel">  	
		<t:formvalid formid="ff" dialog="true" layout="table" tiptype="4" action="jeecgListDemoController.do?saveRows">
			<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
				<thead>
					<tr><th>姓名</th><th>账号</th><th>生日</th><th>性别</th><th>工资</th><th>入职状态</th></tr>
				</thead>
				<tbody>
					<tr>
						<td class="value">							
							 <input name="demos[0].id" type="hidden" value="" /> 
						     <input onclick="popupClick(this,'account,realname','account,name','user_msg');" placeholder="点击选择用户" name="demos[0].name" type="text" style="cursor: pointer;" class="inputxt" value="">
						</td>
						<td class="value">
						     <input placeholder="←" name="demos[0].account" type="text" class="inputxt" value="">
						</td>
						<td class="value">
							<input class="easyui-datebox" type="text" name="demos[0].birthday" id="birthday"/>
						</td>
						<td class="value">
							<t:dictSelect field="demos[0].sex" typeGroupCode="sex" title="性别"></t:dictSelect>
						</td>
						<td class="value">
						     	 <input id="salary" name="demos[0].salary" type="text" class="inputxt" value="">
						</td>
						<td class="value">
							<t:dictSelect field="demos[0].status" typeGroupCode="sf_yn" title="入职状态"></t:dictSelect>
						</td>
					</tr>
					<tr>
						<td class="value">							
							 <input name="demos[1].id" type="hidden" value="" /> 
						     <input onclick="popupClick(this,'account,realname','account,name','user_msg');" placeholder="点击选择用户" name="demos[1].name" type="text" style="cursor: pointer;" class="inputxt" value="">
						</td>
						<td class="value">
						     <input placeholder="←" name="demos[1].account" type="text" class="inputxt" value="">
						</td>
						<td class="value">
							<input class="easyui-datebox" type="text" name="demos[1].birthday"/>
						</td>
						<td class="value">
							<t:dictSelect field="demos[1].sex" typeGroupCode="sex" title="性别"></t:dictSelect>
						</td>
						<td class="value">
						     	 <input id="salary" name="demos[1].salary" type="text" class="inputxt" value="">
						</td>
						<td class="value">
							<t:dictSelect field="demos[1].status" typeGroupCode="sf_yn" title="入职状态"></t:dictSelect>
						</td>
					</tr>
				</tbody>
			</table>		
		</t:formvalid>
    </div>