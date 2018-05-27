<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>职务管理</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript">
  //编写自定义JS代码
  </script>
 </head>
 <body>
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="tSCompanyPositionController.do?doAdd" >
					<input id="id" name="id" type="hidden" value="${tSCompanyPositionPage.id }"/>
					<input type="hidden" id="companyId"  name="companyId" value="${tSCompanyPositionPage.companyId }"  />
		<table style="width:100%;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td align="right">
						<label class="Validform_label">
							职务编码:
						</label>
					</td>
					<td class="value">
					     	 <input id="positionCode" name="positionCode" type="text" style="width: 250px" class="inputxt"  ignore="ignore" />
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">职务编码</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							职务名称:
						</label>
					</td>
					<td class="value">
					     	 <input id="positionName" name="positionName" type="text" style="width: 250px" class="inputxt"  ignore="ignore" />
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">职务名称</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							职务英文名:
						</label>
					</td>
					<td class="value">
					     	 <input id="positionNameEn" name="positionNameEn" type="text" style="width: 250px" class="inputxt"  ignore="ignore" />
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">职务英文名</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							职务缩写:
						</label>
					</td>
					<td class="value">
					     	 <input id="positionNameAbbr" name="positionNameAbbr" type="text" style="width: 250px" class="inputxt"  ignore="ignore" />
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">职务缩写</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							职务级别:
						</label>
					</td>
					<td class="value">
					     	 <!-- <input id="positionLevel" name="positionLevel" type="text" style="width: 250px" class="inputxt"  ignore="ignore" /> -->
					     	 <t:dictSelect field="positionLevel" type="list" extendJson="{class:'form-control',style:'width:250px'}"    typeGroupCode="job_level"  hasLabel="false"  title="职务级别"></t:dictSelect>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">职务级别</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							备注:
						</label>
					</td>
					<td class="value">
					         <textarea id="memo" name="memo" rows="5" cols="80"></textarea>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">备注</label>
						</td>
				</tr>
			</table>
		</t:formvalid>
 </body>
  <script src = "webpage/com/jeecg/test/tSCompanyPosition.js"></script>		
