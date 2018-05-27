<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title><t:mutiLang langKey="common.department.list"/></title>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<style type="text/css">
	.datagrid-cell{
		text-align: center;
	}
	.datagrid-cell-c1-text{
		padding-top: 11px;
		text-align: left;
	}
	.departId{
		vertical-align:middle; 
		margin-top:0;
		height:14px;
		width:14px;
	}
	.departName{	
		font-size:15px;
	}
	/*update-begin--Author:xuelin  Date:20170409 for：[#1814]【标签】弹出组织机构选择，树列表方式，自适应窗体缩放-------------------- */
	.datagrid-cell-c1-fieldMap-address{
		/*地址列文字靠左对齐*/
		text-align: left;
	}
	/*update-end--Author:xuelin  Date:20170409 for：[#1814]【标签】弹出组织机构选择，树列表方式，自适应窗体缩放---------------------- */
</style>
<script type="text/javascript">
	
	var orgIds = '${orgIds}'.split(',');	
		
	function formatName(value, row, index) {
		//console.info(row);
		if (row.iconStyle != null) {
			//Set nodes icon , if has
			row.iconCls = row.iconStyle;
		}
		var checkStr = '';
		$.each(orgIds, function(i, oid) {
			if (oid === row.id) {
				checkStr += 'checked=true';
			}            
        });
		return '<span class="departName"><input id="cb_' + row.id + '" class="departId" name="' 
				+ row.text + '" type="checkbox" ' + checkStr + ' value="' + row.id + '"/>' 
				+ '<span>'+value+'</span></span>';
	}
	
	function formatType(value, row, index){
		var orgTyps = ['<t:mutiLang langKey="common.company"/>'
						,'<t:mutiLang langKey="common.department"/>'
						,'<t:mutiLang langKey="common.position"/>'];
		return orgTyps[value-1];
	} 
</script>
</head>
<body style="overflow: hidden;" scroll="no" data-options="fit:true,border:false" class="easyui-layout">
	<div region="center" style="padding: 1px;" data-options="fit:true,border:true">
		<table id="orgSelect" class="easyui-treegrid"
		        data-options="url:'departController.do?departgrid',idField:'id',treeField:'text',toolbar:'#tb',border:false,fitColumns:true,fit:true">
		    <thead>
		        <tr>
		            <th data-options="field:'text',width:200,formatter:formatName"><t:mutiLang langKey="common.department.name"/></th>
		            <th data-options="field:'fieldMap.orgCode',width:80"> <t:mutiLang langKey="common.org.code"/></th>
		            <th data-options="field:'fieldMap.orgType',width:80,formatter:formatType"><t:mutiLang langKey="common.org.type"/></th>
		            <th data-options="field:'fieldMap.mobile',width:90"><t:mutiLang langKey="common.mobile"/></th>
		            <th data-options="field:'fieldMap.address',width:200"><t:mutiLang langKey="common.address"/></th>
		        </tr>
		    </thead>
		</table>
		<div id="tb"><div class="panel-title"><t:mutiLang langKey="please.select.department"/></div></div>
	</div>
</body>
</html>