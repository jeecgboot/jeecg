<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>jeecg_demo</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
 </head>
 <body>
		<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="jeecgListDemoController.do?doUpdate" >
		<input id="id" name="id" type="hidden" value="${jeecgDemoPage.id }">
		<table style="width: 90%;" cellpadding="0" cellspacing="1" class="formtable">
					<tr>
						<td align="right">
							<label class="Validform_label">
								名称:
							</label>
						</td>
						<td class="value">
						     	 <input id="name" name="name" type="text" style="width: 150px" class="inputxt" datatype="*" value='${jeecgDemoPage.name}'>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">名称</label>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label class="Validform_label">
								年龄:
							</label>
						</td>
						<td class="value">
						     	 <input id="age" name="age" type="text" style="width: 150px" class="inputxt" datatype="d" value='${jeecgDemoPage.age}'>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">年龄</label>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label class="Validform_label">
								生日:
							</label>
						</td>
						<td class="value">
									  <input id="birthday" name="birthday" type="text" style="width: 150px"  class="Wdate" onClick="WdatePicker()"  value='<fmt:formatDate value='${jeecgDemoPage.birthday}' type="date" pattern="yyyy-MM-dd"/>'>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">生日</label>
						</td>
					</tr>
					
					<tr>
						<td align="right">
							<label class="Validform_label">
								部门:
							</label>
						</td>
						<td class="value">
									<t:dictSelect field="depId" type="list"
										dictTable="t_s_depart" dictField="id" dictText="departname" defaultVal="${jeecgDemoPage.depId}" hasLabel="false"  title="部门" ></t:dictSelect>     
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">部门</label>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label class="Validform_label">
								邮箱:
							</label>
						</td>
						<td class="value">
						     	 <input id="email" name="email" type="text" style="width: 150px" class="inputxt" datatype="e" value='${jeecgDemoPage.email}'>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">邮箱</label>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label class="Validform_label">
								电话:
							</label>
						</td>
						<td class="value">
						     	 <input id="phone" name="phone" type="text" style="width: 150px" class="inputxt" datatype="m" value='${jeecgDemoPage.phone}'>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">电话</label>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label class="Validform_label">
								工资:
							</label>
						</td>
						<td class="value">
						     	 <input id="salary" name="salary" type="text" style="width: 150px" class="inputxt"  value='${jeecgDemoPage.salary}' datatype="d" />
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">工资</label>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label class="Validform_label">
								性别:
							</label>
						</td>
						<td class="value">
									<t:dictSelect field="sex" type="radio"
										typeGroupCode="sex" defaultVal="${jeecgDemoPage.sex}" hasLabel="false"  title="性别" ></t:dictSelect>     
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">性别</label>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label class="Validform_label">
								入职状态:
							</label>
						</td>
						<td class="value">
									<t:dictSelect field="status" type="list"
										typeGroupCode="sf_yn" defaultVal="${jeecgDemoPage.status}" hasLabel="false"  title="入职状态" ></t:dictSelect>     
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">入职状态</label>
						</td>
					</tr>
					<tr>
					<td align="right">
						<label class="Validform_label">
							图片:
						</label>
					</td>
					<td class="value">
						<t:webUploader type="image" displayTxt="false" bizType="photosucai" name="touxiang" auto="false" pathValues="${jeecgDemoPage.touxiang}" datatype="*" nullMsg="请选择头像(自定义提示信息)"></t:webUploader>
					</td>
				</tr>
				
				<tr>
					<td align="right">
						<label class="Validform_label">
							附件:
						</label>
					</td>
					<td class="value">
						<t:webUploader auto="true" pathValues="${jeecgDemoPage.fujian}" name="fujian" duplicate="true" fileNumLimit="3" datatype="*" nullMsg="请选择附件(自定义提示信息)"></t:webUploader>
					</td>
				</tr>
					<tr>
						<td align="right">
							<label class="Validform_label">
								个人介绍:
							</label>
						</td>
						<td class="value">
									<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.config.js"></script>
									<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.all.min.js"></script>
							    	<textarea name="content" readonly="true" id="content" style="width: 100%;height:300px">${jeecgDemoPage.content}</textarea>
								    <script type="text/javascript">
								        var editor = UE.getEditor('content');
								    </script>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">个人介绍</label>
						</td>
					</tr>
			</table>
		</t:formvalid>
 </body>