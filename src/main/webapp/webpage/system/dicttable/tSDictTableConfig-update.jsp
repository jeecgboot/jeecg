<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>字典表授权配置</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript">
  //编写自定义JS代码
  </script>
 </head>
 <body>
		<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="tSDictTableConfigController.do?doUpdate" >
					<input id="id" name="id" type="hidden" value="${tSDictTableConfigPage.id }"/>
		<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
					<tr>
						<td align="right">
							<label class="Validform_label">
								表名:
							</label>
						</td>
						<td class="value">
						    <input id="tableName" name="tableName" type="text" maxlength="100" style="width: 150px" class="inputxt"  datatype="*" ignore="checked"  value='${tSDictTableConfigPage.tableName}'/>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">表名</label>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label class="Validform_label">
								值字段名:
							</label>
						</td>
						<td class="value">
						    <input id="valueCol" name="valueCol" type="text" maxlength="50" style="width: 150px" class="inputxt"  datatype="*" ignore="checked"  value='${tSDictTableConfigPage.valueCol}'/>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">值字段名</label>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label class="Validform_label">
								文本字段名:
							</label>
						</td>
						<td class="value">
						    <input id="textCol" name="textCol" type="text" maxlength="50" style="width: 150px" class="inputxt"  datatype="*" ignore="checked"  value='${tSDictTableConfigPage.textCol}'/>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">文本字段名</label>
						</td>
					</tr>
					<tr>
					<%-- <td align="right">
						<label class="Validform_label">
							查询条件:
						</label>
					</td>
					<td class="value">
					     	 <input id="dictCondition" name="dictCondition" type="text" maxlength="255" style="width: 250px" class="inputxt" value='${tSDictTableConfigPage.dictCondition}'/>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">查询条件</label>
						</td>
				</tr> --%>
					<tr>
						<td align="right">
							<label class="Validform_label">
								是否启用:
							</label>
						</td>
						<td class="value">
									<t:dictSelect field="isvalid" type="radio"  datatype="*" typeGroupCode="sf_yn"   defaultVal="${tSDictTableConfigPage.isvalid}" hasLabel="false"  title="是否启用" ></t:dictSelect>     
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">是否启用</label>
						</td>
					</tr>
				
			</table>
		</t:formvalid>
 </body>
