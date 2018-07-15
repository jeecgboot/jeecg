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
</head>
<body>
<t:formvalid formid="formobj" dialog="false" layout="div" callback="test" action="jeecgFormDemoController.do?testsubmit" beforeSubmit="setContentc">
	<fieldset>
	<legend>字典示例 | t:dictSelect </legend>
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
			<td class="value"><t:dictSelect field="name" defaultVal="1" dictTable="t_s_base_user" dictCondition="where delete_flag=0" dictField="username" dictText="realname" title="用户"></t:dictSelect> 
			<span class="Validform_checktip"></span>
			</td>
		</tr>
	</table>
	</fieldset>

	<fieldset>
	<legend>树</legend>
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

	<fieldset>
	<legend>自动补全 | t:autocomplete</legend>
	<table>
		<tr>
			<td align="center" width="100px"><label class="Validform_label">autocomplete:</label></td>
			<td class="value"><t:autocomplete entityName="TSUser" searchField="userName" name="userName"></t:autocomplete> 
			<span class="Validform_checktip"></span>
			</td>
		</tr>
	</table>
	</fieldset>

	<fieldset>
	<legend>选择控件 | t:choose</legend>
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
	<fieldset>
	<legend>国际化语言输出 | t:mutiLang</legend>
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

	<fieldset>
	<legend>通用POPUP选择用户\部门 </legend>
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
	
	<fieldset>
	<legend>文件上传 | t:webUploader </legend>
	<table>		
		<tr>
			<td>多文件上传：</td>
			<!-- 文件路径对应的参数name为‘fileName1’、业务类型是‘photosucai’、自动上传、上传文件扩展名限制doc,txt,jpg、按钮风格：绿色大号按钮 -->
			<td><t:webUploader name="fileName1" bizType="photosucai" auto="true" extensions="doc,txt,jpg" buttonStyle="btn-green btn-L" ></t:webUploader></td>
		</tr>
		<tr>
			<td>单文件上传：</td>
			<!-- 文件路径对应的参数name为‘fileName2’、单个文件大小限制为500kb、按钮风格：绿色中号按钮、上传文件数量限制为1 -->
			<td><t:webUploader name="fileName2" fileSingleSizeLimit="500" buttonStyle="btn-green btn-M mb20" fileNumLimit="1"></t:webUploader></td>
		</tr>
		<tr>
			<td>图片上传：</td>
			<!-- 文件路径对应的参数name为‘fileName3’、不显示上传文件列表、自动上传、上传按钮显示文字为‘选择图片’、按钮风格：蓝色小按钮、上传类型为图片上传、上传文件数量限制为3 -->
			<td><t:webUploader name="fileName3" displayTxt="false" auto="true" buttonText="选择图片" buttonStyle="btn-blue btn-S" type="image" fileNumLimit="3"></t:webUploader></td>
		</tr>
	</table>
	</fieldset>
	
	<fieldset>
	<legend>分类树标签  | t:treeSelectTag（CODE对应系统管理->分类管理） </legend>
	<table>		
		<tr>
			<td>进口汽车分类：</td>
			<td><t:treeSelectTag code="A03A02" field="sex" /> </td>
		</tr>
	</table>
	</fieldset>
</t:formvalid>
</body>
</html>
