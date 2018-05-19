<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<meta http-equiv="X-UA-Compatible" content="chrome=1, IE=edge">
<head>
	<t:base type="jquery,easyui"></t:base>
    <script>
    	var select1 = 0;
    	var select2 = 0;
    	var data = "";

    	$(function(){
			var tableName = getPar("tableName");
			var dataId = getPar("dataId");
			var id1 = getPar("id1");
			var id2 = getPar("id2");
			var versionNumber1 = getPar("versionNumber1");
			var versionNumber2 = getPar("versionNumber2");

			$("#tableName").val(tableName);
			$("#dataId").val(dataId);
			data = [{}];
			data.unshift({id: id1,versionNumber: versionNumber1});
			data.unshift({id: id2,versionNumber: versionNumber2});
			data.unshift({id: '0',versionNumber: '---请选择---'});
			$('#versionNumber1').combobox({
				valueField:'id',
				textField:'versionNumber',
				panelHeight: 70,
				editable: false,
				data: data,
				onSelect: function(record){
					select1 = versionNumber1;
				}
			});

			$('#versionNumber2').combobox({
				valueField:'id',
				textField:'versionNumber',
				panelHeight: 70,
				editable: false,
				data: data,
				onSelect: function(record){
					select2 = versionNumber2;
				}
			});

			$('#versionNumber1').combobox("select",id1);
			$('#versionNumber2').combobox("select",id2);

    		$("#tableName").change(function(){
        		var tableNameVal = jQuery.trim($(this).val());
        		var dataIdVal = jQuery.trim($("#dataId").val());

        		if(tableNameVal != "" && dataIdVal != ""){
        			$.ajax({
						type: "POST",
						url: "systemController.do?getDataVersion",
						data: "tableName=" + tableNameVal + "&dataId=" + dataIdVal,
						success: function(msg){
							data = jQuery.parseJSON(msg).obj;
							if(jQuery.isEmptyObject(data)){
								data = [{}];
								data.unshift({id: '0',versionNumber: '---无数据---'});
							}else{
								data.unshift({id: '0',versionNumber: '---请选择---'});
							}

							$('#versionNumber1').combobox({
								valueField:'id',
								textField:'versionNumber',
								panelHeight: 70,
								editable: false,
								data: data,
								onSelect: function(record){
									select1 = record.versionNumber;
								}
				        	});

							$('#versionNumber2').combobox({
								valueField:'id',
								textField:'versionNumber',
								panelHeight: 70,
								editable: false,
								data: data,
								onSelect: function(record){
									select2 = record.versionNumber;
								}
				        	});

							$('#versionNumber1').combobox("select","0");
							$('#versionNumber2').combobox("select","0");
						}
					});
        		}
        	});

        	$("#dataId").change(function(){
        		var dataIdVal = jQuery.trim($(this).val());
        		var tableNameVal = jQuery.trim($("#tableName").val());
        		if(tableNameVal != "" && dataIdVal != ""){
        			$.ajax({
						type: "POST",
						url: "systemController.do?getDataVersion",
						data: "tableName=" + tableNameVal + "&dataId=" + dataIdVal,
						success: function(msg){
							data = jQuery.parseJSON(msg).obj;
							if(jQuery.isEmptyObject(data)){
								data = [{}];
								data.unshift({id: '0',versionNumber: '---无数据---'});
							}else{
								data.unshift({id: '0',versionNumber: '---请选择---'});
							}

							$('#versionNumber1').combobox({
								valueField:'id',
								textField:'versionNumber',
								panelHeight: 70,
								editable: false,
								data: data,
								onSelect: function(record){
									select1 = record.versionNumber;
								}
				        	});

							$('#versionNumber2').combobox({
								valueField:'id',
								textField:'versionNumber',
								panelHeight: 70,
								editable: false,
								data: data,
								onSelect: function(record){
									select2 = record.versionNumber;
								}
				        	});

							$('#versionNumber1').combobox("select","0");
							$('#versionNumber2').combobox("select","0");
						}
					});
        		}
        	});
			$('#btn').click(function(){
				var id1 = $('#versionNumber1').combobox("getValue");
				var id2 = $('#versionNumber2').combobox("getValue");
				var url = "systemController.do?diffDataVersion&id1=" + id1 + "&id2=" + id2;
				frameElement.api.opener.diffDataVersion(url);
			});
    	})

		//得到get url请求参数
		function getPar(par){
			//获取当前URL
			var local_url = document.location.href;
			//获取要取得的get参数位置
			var get = local_url.indexOf(par +"=");
			if(get == -1){
				return false;
			}
			//截取字符串
			var get_par = local_url.slice(par.length + get + 1);
			//判断截取后的字符串是否还有其他get参数
			var nextPar = get_par.indexOf("&");
			if(nextPar != -1){
				get_par = get_par.slice(0, nextPar);
			}
			return get_par;
		}
    </script>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" layout="table" dialog="false" action="">
	<table cellpadding="0" width="100%" cellspacing="1" class="formtable">
		<tr>
			<td align="right" height="40" width="15%"><span class="filedzt">数据库表名:</span></td>
			<td class="value" width="30%">
				<input type="text" class="inuptxt" name="tableName" id="tableName" datatype="*">
				<span class="Validform_checktip"></span>
			</td>

			<td align="right" height="40" width="15%"><span class="filedzt">数据ID:</span></td>
			<td class="value" width="30%">
				<input type="text" class="inuptxt" name="dataId" id="dataId" datatype="*">
				<span class="Validform_checktip"></span>
			</td>
		</tr>
		<tr>
			<td align="right" height="40" width="15%"><span class="filedzt">版本号1:</span></td>
			<td class="value" width="30%">
				<input type="text" class="inuptxt" id="versionNumber1" readonly="readonly"/>
				<span class="Validform_checktip"></span>
			</td>

			<td align="right" height="40" width="15%"><span class="filedzt">版本号2:</span></td>
			<td class="value" width="30%">
				<input type="text" class="inuptxt" id="versionNumber2" readonly="readonly"/>
				<span class="Validform_checktip"></span>
			</td>
		</tr>
		<tr height="40">
			<td class="upload" colspan="4">
				<a href="#" class="easyui-linkbutton" id="btn" iconCls="icon-search" style="float: right; margin-right: 10px;"> 数据比较 &nbsp;&nbsp; </a>
			</td>
		</tr>
	</table>
</t:formvalid>
</html>