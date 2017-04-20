<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>uitags</title>
<t:base type="jquery,easyui,tools,autocomplete"></t:base>
<style>
<!--
.ac_over {
	background: #E0ECFF;
	cursor: pointer;
	color: #416AA3;
}

.ac_results {
	border: 1px solid rgb(172, 216, 236);
}
-->
</style>
<t:formvalid formid="formobj" dialog="false" layout="div" callback="test" action="jeecgFormDemoController.do?testsubmit" beforeSubmit="setContentc">
	<legend>字典示例 | t:dictSelect </legend>
	<fieldset>
	<table>
		<tr>
			<td align="center" width="100px"><label class="Validform_label">radio:</label></td>
			<td class="value"><t:dictSelect field="sex" type="radio" typeGroupCode="sex" hasLabel="false" title="性别" defaultVal="1"></t:dictSelect> 
			<span class="Validform_checktip"></span>
			</td>
		</tr>

		<tr>
			<td align="center" width="100px"><label class="Validform_label">select:</label></td>
			<td class="value"><t:dictSelect field="sex" type="select" typeGroupCode="sex" hasLabel="false" title="性别" defaultVal="1"></t:dictSelect> 
			<span class="Validform_checktip"></span>
			</td>
		</tr>
		<tr>
			<td align="center" width="100px"><label class="Validform_label">checkbox:</label></td>
			<td class="value"><t:dictSelect field="dbtype" type="checkbox" typeGroupCode="dbtype" hasLabel="false" title="数据库类型" defaultVal="oracle,mysql"></t:dictSelect> 
			<span class="Validform_checktip"></span>
			</td>
		</tr>
		<tr>
			<td align="center" width="100px"><label class="Validform_label">数据表字典:</label></td>
			<td class="value"><t:dictSelect field="name" defaultVal="1" dictTable="t_s_base_user" dictField="username" dictText="realname" title="用户"></t:dictSelect> 
			<span class="Validform_checktip"></span>
			</td>
		</tr>
	</table>
	</fieldset>

	<legend>树</legend>
	<fieldset>
	<table>
		<tr>
			<td align="center" width="100px"><label class="Validform_label">comboTree:</label></td>
			<td class="value"><t:comboTree url="jeecgFormDemoController.do?getComboTreeData" value="402880e447e99cf10147e9a03b320003" name="depid" id="depid" width="200"></t:comboTree>
			<span class="Validform_checktip"></span></td>
		</tr>

		<tr>
			<td align="center" width="100px"><label class="Validform_label">ztree 树控件:</label></td>
			<td class="value"><t:selectZTree id="citySel" url="jeecgFormDemoController.do?getTreeData" windowWidth="400px"></t:selectZTree> <span class="Validform_checktip"></span></td>
		</tr>


	</table>
	</fieldset>

	<legend>自动补全 | t:autocomplete</legend>
	<fieldset>
	<table>
		<tr>
			<td align="center" width="100px"><label class="Validform_label">autocomplete:</label></td>
			<td class="value"><t:autocomplete entityName="TSUser" searchField="userName" name="userName"></t:autocomplete> 
			<span class="Validform_checktip"></span>
			</td>
		</tr>
	</table>
	</fieldset>

	<legend>选择控件 | t:choose</legend>
	<fieldset>
	<table>
		<tr>
			<td align="center" width="100px"><label class="Validform_label">choose:</label></td>
			<td class="value">
				<input id="roleid" name="roleid" type="hidden" value="" /> 
				<input name="roleName" class="inputxt" value="" id="roleName" readonly="readonly" datatype="*" /> 
				<t:choose hiddenName="roleid" hiddenid="id" url="userController.do?roles" name="roleList" icon="icon-search" title="选择操作标签" textname="roleName" isclear="true" isInit="true"></t:choose>
			 <span class="Validform_checktip"></span>
			 </td>
		</tr>
	</table>
	</fieldset>
	<legend>国际化语言输出 | t:mutiLang</legend>
	<fieldset>
	<table>
		<tr>
			<td align="center" width="100px"><label>国际化:</label></td>
			<td class="value">
			<c:out value="<t:mutiLang langKey='common.add' />" />   <br>
			翻译结果：<t:mutiLang langKey='common.add' /><br>
			<c:out value="<t:mutiLang langKey='common.rang' langArg='请输入,6,10' />" /> <br>
			翻译结果： <t:mutiLang langKey='common.rang' langArg="请输入,6,10" /><br>
			</td>
		</tr>
	</table>
	</fieldset>

	<legend>通用POPUP选择用户\部门 </legend>
	<fieldset>
	<table>		
		<tr>
			<td>选择部门：</td><td><t:departSelect selectedNamesInputId="orgNames" selectedIdsInputId="orgIds" departIdsDefalutVal="8a8ab0b246dc81120146dc8180ba0017," departNamesDefalutVal="JEECG开源社区,"></t:departSelect></td>
		</tr>
		<tr>
			<td>选择部门：</td>
			<td><t:orgSelect selectedNamesInputId="orgName" selectedIdsInputId="orgId" departIdsDefalutVal="8a8ab0b246dc81120146dc8180ba0017," departNamesDefalutVal="JEECG开源社区," ></t:orgSelect>(树列表)</td>
		</tr>
		<tr>
			<td>选择用户：</td><td><t:userSelect title="用户名称" selectedNamesInputId="userNames" selectedIdsInputId="userIds" windowWidth="1000px" windowHeight="600px"></t:userSelect></td>
		</tr>
	</table>
	</fieldset>
	
	<legend>文件上传 | t:webUploader </legend>
	<fieldset>
	<table>		
		<tr>
			<td>多文件上传：</td>
			<td><t:webUploader auto="true" name="fileName1" extensions="doc,txt,jpg" buttonStyle="btn-green btn-L" ></t:webUploader></td>
		</tr>
		<tr>
			<td>单文件上传：</td>
			<td><t:webUploader name="fileName2" fileSingleSizeLimit="1" buttonStyle="btn-green btn-M mb20" fileNumLimit="1"></t:webUploader></td>
		</tr>
		<tr>
			<td>图片上传：</td>
			<td><t:webUploader auto="true" buttonText="选择图片" name="fileName3" buttonStyle="btn-blue btn-S" type="image" fileNumLimit="3"></t:webUploader></td>
		</tr>
	</table>
	</fieldset>
</t:formvalid>