<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>用户信息</title>
<t:base type="jquery,easyui,tools"></t:base>
    <script>
<%-- //        update-start--Author:zhangguoming  Date:20140826 for：将combobox修改为combotree
        function setOrgIds() {
//            var orgIds = $("#orgSelect").combobox("getValues");
            var orgIds = $("#orgSelect").combotree("getValues");
            $("#orgIds").val(orgIds);
        }
        $(function() {
            $("#orgSelect").combotree({
                onChange: function(n, o) {
                    if($("#orgSelect").combotree("getValues") != "") {
                        $("#orgSelect option").eq(1).attr("selected", true);
                    } else {
                        $("#orgSelect option").eq(1).attr("selected", false);
                    }
                }
            });
            $("#orgSelect").combobox("setValues", ${orgIdList});
            $("#orgSelect").combotree("setValues", ${orgIdList});
        }); --%>


		function openDepartmentSelect() {
			$.dialog.setting.zIndex = getzIndex(); 
			var orgIds = $("#orgIds").val();

			$.dialog({content: 'url:organzationController.do?myDepartSelect&orgIds='+orgIds, zIndex: getzIndex(), title: '组织机构列表', lock: true, width: '400px', height: '350px', opacity: 0.4, button: [
			   {name: '<t:mutiLang langKey="common.confirm"/>', callback: callbackDepartmentSelect, focus: true},
			   {name: '<t:mutiLang langKey="common.cancel"/>', callback: function (){}}
		   ]}).zindex();

		}
			
		function callbackDepartmentSelect() {
			  var iframe = this.iframe.contentWindow;
			  var treeObj = iframe.$.fn.zTree.getZTreeObj("departSelect");
			  var nodes = treeObj.getCheckedNodes(true);
			  if(nodes.length>0){
			  var ids='',names='';
			  for(i=0;i<nodes.length;i++){
			     var node = nodes[i];
			     ids += node.id+',';
			    names += node.name+',';
			 }
			 $('#departname').val(names);
			 $('#departname').blur();		
			 $('#orgIds').val(ids);		
			}
		}
		
		function callbackClean(){
			$('#departname').val('');
			 $('#orgIds').val('');	
		}
		
		function setOrgIds() {}
		$(function(){
			$("#departname").prev().hide();
		});
    </script>
</head>
<body >
<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="userController.do?saveUser" beforeSubmit="setOrgIds">
	<input id="id" name="id" type="hidden" value="${user.id }"/>
	<input id="devFlag" name="devFlag" type="hidden" value="0"/>
	<input id="activitiSync" name="activitiSync" type="hidden" value="1"/>
	<input id="userType" name="userType" type="hidden" value="1"/>
	<input id="orgIds" name="orgIds" type="hidden" value="${orgIds}"/>
	<table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">  <t:mutiLang langKey="common.username"/>:  </label>
            </td>
			<td class="value" width="85%">
                <c:if test="${user.id!=null }"> ${user.userName } </c:if>
                <c:if test="${user.id==null }">
                    <input id="userName" class="inputxt" name="userName" validType="t_s_base_user,userName,id" value="${user.userName }" datatype="s2-18" />
                    <span class="Validform_checktip"> <t:mutiLang langKey="username.rang2to18"/></span>
                </c:if>
            </td>
		</tr>
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label"> 所属组织机构:  </label>
            </td>
			<td class="value" width="85%">
                 ${departname}
            </td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap><label class="Validform_label"> <t:mutiLang langKey="common.real.name"/>: </label></td>
			<td class="value" width="10%">
                <input id="realName" class="inputxt" name="realName" value="${user.realName }" datatype="s2-10"/>
                <span class="Validform_checktip"><t:mutiLang langKey="fill.realname"/></span>
            </td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap><label class="Validform_label">英文名: </label></td>
			<td class="value" width="10%">
                <input id="userNameEn" class="inputxt" name="userNameEn" value="${user.userNameEn }"/>
                <span class="Validform_checktip">填写英文名</span>
            </td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap><label class="Validform_label">工号: </label></td>
			<td class="value" width="10%">
                <input id="empNo" class="inputxt" name="empNo" value="${user.empNo }" />
                <span class="Validform_checktip">填写工号</span>
            </td>
		</tr>
		 <%-- <tr>
            <td align="right"><label class="Validform_label"> 用户类型: </label></td>
            <td class="value">

                <t:dictSelect id="userType" field="userType" typeGroupCode="pms_usertype" hasLabel="false" defaultVal="${user.userType}"></t:dictSelect>
                <span class="Validform_checktip"></span>
            </td>
        </tr> --%>
        <%-- <tr>
            <td align="right"><label class="Validform_label"> 人员类型: </label></td>
            <td class="value">

                <t:dictSelect id="personType" field="personType" typeGroupCode="pms_persontype" hasLabel="false" defaultVal="${user.personType}"></t:dictSelect>
                <span class="Validform_checktip"></span>
            </td>
        </tr> --%>
        <tr>
            <td align="right"><label class="Validform_label"> 性别: </label></td>
            <td class="value">
                <t:dictSelect id="sex" field="sex" typeGroupCode="sex" hasLabel="false" defaultVal="${user.sex}" type="radio"></t:dictSelect>
                <span class="Validform_checktip"></span>
            </td>
        </tr>
        <tr>
			<td align="right" width="10%" nowrap><label class="Validform_label">身份证号: </label></td>
			<td class="value" width="10%">
                <input id="citizenNo" class="inputxt" name="citizenNo" value="${user.citizenNo }" />
                <span class="Validform_checktip">填写身份证号</span>
            </td>
		</tr>
		<c:if test="${user.id==null }">
			<tr>
				<td align="right"><label class="Validform_label"> <t:mutiLang langKey="common.password"/>: </label></td>
				<td class="value">
                    <input type="password" class="inputxt" value="" name="password" plugin="passwordStrength" datatype="*6-18" errormsg="" />
                    <span class="passwordStrength" style="display: none;">
                        <span><t:mutiLang langKey="common.weak"/></span>
                        <span><t:mutiLang langKey="common.middle"/></span>
                        <span class="last"><t:mutiLang langKey="common.strong"/></span>
                    </span>
                    <span class="Validform_checktip"> <t:mutiLang langKey="password.rang6to18"/></span>
                </td>
			</tr>
			<tr>
				<td align="right"><label class="Validform_label"> <t:mutiLang langKey="common.repeat.password"/>: </label></td>
				<td class="value">
                    <input id="repassword" class="inputxt" type="password" value="${user.password}" recheck="password" datatype="*6-18" errormsg="两次输入的密码不一致！"/>
                    <span class="Validform_checktip"><t:mutiLang langKey="common.repeat.password"/></span>
                </td>
			</tr>
		</c:if>
		<%-- <tr>
			<td align="right"><label class="Validform_label"> <t:mutiLang langKey="common.department"/>: </label></td>
			<td class="value">
				 update-start--Author:jg_renjie  Date:20160320 for：#942 【组件封装】组织机构弹出模式，目前是列表，得改造成树方式
                update-start--Author:zhangguoming  Date:20140826 for：将combobox修改为combotree
                <select class="easyui-combobox" data-options="multiple:true, editable: false" id="orgSelect" datatype="*">
                <select class="easyui-combotree" data-options="url:'departController.do?getOrgTree', multiple:true, cascadeCheck:false"
                        id="orgSelect" name="orgSelect" datatype="select1">
                update-end--Author:zhangguoming  Date:20140826 for：将combobox修改为combotree
                    <c:forEach items="${departList}" var="depart">
                        <option value="${depart.id }">${depart.departname}</option>
                    </c:forEach>
                </select>
                 <t:departSelect departId="${tsDepart.id }" departName="${tsDepart.departname }"></t:departSelect>
                
                <input id="departname" name="departname" type="text" readonly="readonly" class="inputxt" datatype="*" value="${departname}"/>
                <input id="orgIds" name="orgIds" type="hidden" value="${orgIds}"/>
                <a href="#" class="easyui-linkbutton" plain="true" icon="icon-search" id="departSearch" onclick="openDepartmentSelect()">选择</a>
                <a href="#" class="easyui-linkbutton" plain="true" icon="icon-redo" id="departRedo" onclick="callbackClean()">清空</a>
                <span class="Validform_checktip"><t:mutiLang langKey="please.muti.department"/></span>
            </td>
		</tr> --%>
		<%-- <tr>
			<td align="right"><label class="Validform_label"> <t:mutiLang langKey="common.role"/>: </label></td>
			<td class="value" nowrap>
                <input id="roleid" name="roleid" type="hidden" value="${id}"/>
                <input name="roleName" id="roleName" class="inputxt" value="${roleName }" readonly="readonly" datatype="*" />
                <t:choose hiddenName="roleid" hiddenid="id" textname="roleName" url="userController.do?roles" name="roleList" icon="icon-search" title="common.role.list" isclear="true" isInit="true"></t:choose>
                <span class="Validform_checktip"><t:mutiLang langKey="role.muti.select"/></span>
            </td>
		</tr> --%>
		<tr>
			<td align="right" nowrap><label class="Validform_label">  <t:mutiLang langKey="common.phone"/>: </label></td>
			<td class="value">
                <input class="inputxt" name="mobilePhone" value="${user.mobilePhone}" datatype="m" errormsg="手机号码不正确" ignore="ignore"/>
                <span class="Validform_checktip"></span>
            </td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> <t:mutiLang langKey="common.tel"/>: </label></td>
			<td class="value">
                <input class="inputxt" name="officePhone" value="${user.officePhone}" datatype="n" errormsg="办公室电话不正确" ignore="ignore"/>
                <span class="Validform_checktip"></span>
            </td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> <t:mutiLang langKey="common.common.mail"/>: </label></td>
			<td class="value">
				<!-- validType="t_s_user,email,id" -->
                <input class="inputxt" name="email" value="${user.email}"   datatype="e" errormsg="邮箱格式不正确!" />
                <span class="Validform_checktip"></span>
            </td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap><label class="Validform_label">传真: </label></td>
			<td class="value" width="10%">
                <input id="fax" class="inputxt" name="fax" value="${user.fax }" />
                <span class="Validform_checktip">填写传真</span>
            </td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap><label class="Validform_label">联系地址: </label></td>
			<td class="value" width="10%">
                <input id="address" class="inputxt" name="address" value="${user.address}" />
                <span class="Validform_checktip">填写联系地址</span>
            </td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap><label class="Validform_label">邮编: </label></td>
			<td class="value" width="10%">
                <input id="post" class="inputxt" name="post" value="${user.post}" />
                <span class="Validform_checktip">填写邮编</span>
            </td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap><label class="Validform_label">备注: </label></td>
			<td class="value" width="10%">
                <textarea id="memo" name="memo" rows="5" cols="80">${user.memo}</textarea>
                <span class="Validform_checktip">填写备注</span>
            </td>
		</tr>
        <%-- <tr>
            <td align="right"><label class="Validform_label"> <t:mutiLang langKey="common.common.dev"/>: </label></td>
            <td class="value">
					
                <t:dictSelect id="devFlag" field="devFlag" typeGroupCode="dev_flag" hasLabel="false" defaultVal="${user.devFlag}" type="radio"></t:dictSelect>
                <span class="Validform_checktip"></span>
            </td>
        </tr>
        <tr>
		     <td align="right">
		      <label class="Validform_label">
		       	工作流引擎:
		      </label>
		     </td>
		     <td class="value">
		      <input name="activitiSync" type="radio" datatype="min" min="1" <c:if test="${user.activitiSync eq 1}">checked="true"</c:if> value="1">
		     	 同步
		      <input name="activitiSync" type="radio" <c:if test="${user.activitiSync eq 0}">checked="true"</c:if> value="0">
		     	 不同步
		      <span class="Validform_checktip">是否同步工作流引擎</span>
		     </td>
    	</tr> --%>
	</table>
</t:formvalid>
</body>