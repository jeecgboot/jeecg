<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>添加一级岗位</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript">
  //编写自定义JS代码
  </script>
 </head>
 <body>
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" callback="@Override callbackOrg" action="systemController.do?saveDepart" >
					<input id="id" name="id" type="hidden" />
					<input id="cc" type="hidden" name="TSPDepart.id" value="${pid }">
		<table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td align="right">
						<label class="Validform_label">
							岗位名称:
						</label>
					</td>
					<td class="value">
					     	 <input id="departname" name="departname" type="text" style="width: 150px" class="inputxt"  ignore="ignore" />
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">岗位名称</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							岗位描述:
						</label>
					</td>
					<td class="value">
					     	 <textarea id="description" name="description" rows="5" cols="80"></textarea>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">岗位描述</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							机构类型:
						</label>
					</td>
					<td class="value">
					     	 <%-- <select name="orgType" id="orgType"> 
					                 <option value="1" <c:if test="${orgType=='1'}">selected="selected"</c:if>>公司</option> 
					                 <option value="2" <c:if test="${orgType=='2'}">selected="selected"</c:if>>部门</option> 
					                <option value="3" <c:if test="${orgType=='3'}">selected="selected"</c:if>>岗位</option> 
					         </select> --%>
					        <input name="orgType" id="orgType" type="radio" value="3" checked="checked"/> 岗位
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">机构类型</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							电话:
						</label>
					</td>
					<td class="value">
					     	 <input id="mobile" name="mobile" type="text" style="width: 150px" class="inputxt"  ignore="ignore" />
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
					     	 <input id="fax" name="fax" type="text" style="width: 150px" class="inputxt"  ignore="ignore" />
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
					     	 <input id="address" name="address" type="text" style="width: 150px" class="inputxt"  ignore="ignore" />
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
		parent.tip(data.msg);
		parent.loadTree();
		location.reload();
		/* parent.layer.alert(data.msg, {
	        icon: 1,
	        shadeClose: false,
	        title: '提示'
	    },function(index){
	    	parent.loadTree();
			location.reload();
	    	parent.layer.close(index);
	    }); */
	}else{
		parent.tip(data.msg);
		/* parent.layer.alert(data.msg, {
	        icon: 0,
	        shadeClose: false,
	        title: '提示'
	    },function(index){
	    	parent.layer.close(index);
	    }); */
	}

	//tip(data.msg);
}
</script>