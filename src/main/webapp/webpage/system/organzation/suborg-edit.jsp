<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>添加一级部门</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript">
  //编写自定义JS代码
  </script>
 </head>
 <body>
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" callback="@Override callbackOrg" action="systemController.do?saveDepart" >
					<input id="id" name="id" type="hidden" value="${depart.id }" />
					<input id="cc" type="hidden" name="TSPDepart.id" value="${depart.TSPDepart.id }" >
		<table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td align="right" style="width: 30%;height:30px">
						<label class="Validform_label">
							上级编码:
						</label>
					</td>
					<td class="value">
					         ${depart.TSPDepart.orgCode }
						</td>
				</tr>
				<tr>
					<td align="right" style="width: 30%;height:30px">
						<label class="Validform_label">
							上级名称:
						</label>
					</td>
					<td class="value">
					         ${depart.TSPDepart.departname }
						</td>
				</tr>
				<tr>
					<td align="right" style="width: 30%;height:30px">
						<label class="Validform_label">
							编码:
						</label>
					</td>
					<td class="value">
					         ${depart.orgCode }
					         <input id="orgCode" name="orgCode" value="${depart.orgCode }" type="hidden" />
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							部门名称:
						</label>
					</td>
					<td class="value">
					     	 <input id="departname" name="departname" value="${depart.departname }" type="text" style="width: 150px" class="inputxt"  ignore="ignore" />
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">部门名称</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							部门描述:
						</label>
					</td>
					<td class="value">
					     	 <textarea id="description" name="description" rows="5" cols="80">${depart.description }</textarea>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">部门描述</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							机构类型:
						</label>
					</td>
					<td class="value">
					     	<%--  <select name="orgType" id="orgType"> 
					                 <option value="1" >公司</option> 
					                 <option value="2" >部门</option> 
					                 <option value="3" >岗位</option>
					         </select> --%>
					         <input name="orgType" id="orgType" type="radio" value="2" checked="checked"/> 部门
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">职务名称</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							电话:
						</label>
					</td>
					<td class="value">
					     	 <input id="mobile" name="mobile" value="${depart.mobile }" type="text" style="width: 150px" class="inputxt"  ignore="ignore" />
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">电话</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							传真:
						</label>
					</td>
					<td class="value">
					     	 <input id="fax" name="fax" type="text" value="${depart.fax }" style="width: 150px" class="inputxt"  ignore="ignore" />
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">传真</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							地址:
						</label>
					</td>
					<td class="value">
					     	 <input id="address" name="address" value="${depart.address }" type="text" style="width: 150px" class="inputxt"  ignore="ignore" />
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">地址</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
						</label>
					</td>
					<td class="value">
					     	<button type="button" class="blueButton" style="width:80px;height:30px" onclick="formSubmit();">保存 </button>
						</td>
				</tr>
			</table>
		</t:formvalid>
 </body>
  <script src = "webpage/system/position/tSCompanyPositionList.js"></script>		
<script type="text/javascript">
function formSubmit(){
	$('#btn_sub').click();
}

function callbackOrg(data){
	if(data.success==true){
		parent.layer.alert(data.msg, {
	        icon: 1,
	        shadeClose: false,
	        title: '提示'
	    },function(index){
	    	parent.loadTree();
			location.reload();
	    	parent.layer.close(index);
	    });
	}else{
		parent.layer.alert(data.msg, {
	        icon: 0,
	        shadeClose: false,
	        title: '提示'
	    },function(index){
	    	parent.layer.close(index);
	    });
	}
	//tip(data.msg);
}
</script>