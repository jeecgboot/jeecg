<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<title><t:mutiLang langKey="common.datasource.manage"/></title>
	<t:base type="jquery,easyui,tools"></t:base>
	<script type="text/javascript">

		var sourceType = '${dbSourcePage.dbType}';
		var sourceURL = '${dbSourcePage.url}';
		$(function(){
			$('#dbType').change(function(){
				var dbType = $("#dbType").val();
				$.ajax({
					type: "POST",
					url: "dynamicDataSourceController.do?getDynamicDataSourceParameter",
					data: "dbType=" + dbType,
					success: function(msg){

						$('#driverClass').val(jQuery.parseJSON(msg).obj.driverClass);

						if(dbType != sourceType){
							$.ajax({
								type: "POST",
								url: "dynamicDataSourceController.do?getDynamicDataSourceParameter",
								data: "dbType=" + dbType,
								success: function(msg){
									$('#url').val(jQuery.parseJSON(msg).obj.url);
								}
							});
						}else{
							$('#url').val(sourceURL);
						}
					}
				});
			});
		});
	</script>
</head>
 <body style="overflow-y: hidden" scroll="no">
	<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="dynamicDataSourceController.do?save">
		<input id="id" name="id" type="hidden" value="${dbSourcePage.id }">
			<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td align="right">
						<label class="Validform_label">
							<t:mutiLang langKey="common.dbtype"/>:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="dbKey" name="dbKey"
							   value="${dbSourcePage.dbKey}" datatype="*">
						<span class="Validform_checktip"></span>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							<t:mutiLang langKey="common.description"/>:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="description" name="description"
							   value="${dbSourcePage.description}" datatype="*">
						<span class="Validform_checktip"></span>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							<t:mutiLang langKey="common.dbtype"/>:
						</label>
					</td>
					<td class="value">
						<t:dictSelect id="dbType" field="dbType" typeGroupCode="dbtype" hasLabel="false" defaultVal="${dbSourcePage.dbType}"></t:dictSelect>
						<span class="Validform_checktip"></span>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							<t:mutiLang langKey="common.driverclass"/>:
						</label>
					</td>
					<td class="value">
						<textarea id="driverClass" name="driverClass" rows="2" cols="50" datatype="*" readonly="readonly">${dbSourcePage.driverClass}</textarea>
						<span class="Validform_checktip"></span>
					</td>
				</tr>

				<tr>
					<td align="right">
						<label class="Validform_label">
							<t:mutiLang langKey="common.datasrouce.url"/>:
						</label>
					</td>
					<td class="value">
						<textarea id="url" name="url" rows="3" cols="50" datatype="*">${dbSourcePage.url}</textarea>
						<span class="Validform_checktip"></span>
					</td>
				</tr>

				<tr>
					<td align="right">
						<label class="Validform_label">
							<t:mutiLang langKey="common.dbname"/>:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="dbName" name="dbName"
							   value="${dbSourcePage.dbName}" datatype="*">
						<span class="Validform_checktip"></span>
					</td>
				</tr>

				<tr>
					<td align="right">
						<label class="Validform_label">
							<t:mutiLang langKey="common.dbuser"/>:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="dbUser" name="dbUser"
							   value="${dbSourcePage.dbUser}" datatype="*">
						<span class="Validform_checktip"></span>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							<t:mutiLang langKey="common.dbpassword"/>:
						</label>
					</td>
					<td class="value">
						<!-- update-begin--Author:xuelin  Date:20170329 for：[#1821]【bug】多数据源管理，密码采用加密方式存储，加密解密总报错-------------------- -->
						<input type="password" class="inputxt" id="dbPassword" name="dbPassword" ignore="ignore"
							   value="${showDbPassword}">
						<!-- update-end--Author:xuelin  Date:20170329 for：[#1821]【bug】多数据源管理，密码采用加密方式存储，加密解密总报错---------------------- -->
						<span class="Validform_checktip"></span>
						<!-- //---update-begin------author:chenj-----date:20160801----for:TASK #1246 【改进】多数据源增加测试有效功能 -->
						<a href="#"  id="dbtest" >
						[<label class="Validform_label">测试</label>]
						</a>
						<span class="Validform_checktip"  id="dbmsg"></span>
						
						
						<!-- //---update-end------author:chenj-----date:20160801----for:TASK #1246 【改进】多数据源增加测试有效功能 -->
					</td>
					
				</tr>
			</table>
		</t:formvalid>
		<script type="text/javascript">
			$(function(){

				var formobj=$("#formobj").Validform();
				$('#dbtest').click(function(){//点击测试
					formobj.config({
					    //url:"dynamicDataSourceController.do?testConnection",
					    ajaxpost:{
					        //可以传入$.ajax()能使用的，除dataType外的所有参数;
					    	success:function(data,object){
					            //data是返回的json数据;
					            //obj是当前表单的jquery对象;
					            //alert(data.obj.msg);
					            $("#dbmsg").html("<font color='red'>"+data.obj.msg+"</font>");
					            formobj.config({
					            	ajaxpost:{url:"dynamicDataSourceController.do?save"}
					            });
					        }
					    }
					}); 
					formobj.ajaxPost(false,false,"dynamicDataSourceController.do?testConnection");
				});

			});
		</script>
 </body>