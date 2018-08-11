<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>部门信息</title>
<t:base type="jquery,easyui,tools"></t:base>
<script type="text/javascript">
	$(function() {
		$('#cc').combotree({
			url : 'departController.do?setPFunction&selfId=${depart.id}',
            width: 155,
            onSelect : function(node) {

                changeOrgType(node.id);

            }
        });
		
		var parentId = $('#cc').val();
        if(!parentId) { // 第一级，只显示公司选择项
            var orgTypeSelect = $("#orgType");
            var companyOrgType = '<option value="1" <c:if test="${orgType=='1'}">selected="selected"</c:if>><t:mutiLang langKey="common.company"/></option>';
            orgTypeSelect.empty();
            orgTypeSelect.append(companyOrgType);
        } else { // 非第一级，不显示公司选择项
            $("#orgType option:first").remove();
        }
        
        if($("#id").val()) {
            $('#cc').combotree('disable');
        }
        if('${empty pid}' == 'false') { // 设置新增页面时的父级
            $('#cc').combotree('setValue', '${pid}');
        }
	});

    function changeOrgType(parentId) { // 处理组织类型，不显示公司选择项
        var orgTypeSelect = $("#orgType");
        if(parentId!=null && parentId!='') {
            var bumen = '<option value="2" <c:if test="${orgType=='2'}">selected="selected"</c:if>><t:mutiLang langKey="common.department"/></option>';
            var gangwei = '<option value="3" <c:if test="${orgType=='3'}">selected="selected"</c:if>><t:mutiLang langKey="common.position"/></option>';
            orgTypeSelect.empty();
            orgTypeSelect.append(bumen).append(gangwei);
        }else{
        	var orgTypeSelect = $("#orgType");
            var companyOrgType = '<option value="1" <c:if test="${orgType=='1'}">selected="selected"</c:if>><t:mutiLang langKey="common.company"/></option>';
            orgTypeSelect.empty();
            orgTypeSelect.append(companyOrgType);
        }
    }

</script>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" layout="div" dialog="true" callback="@Override callbackTreeLoad" action="systemController.do?saveDepart">
	<input id="id" name="id" type="hidden" value="${depart.id }">
	<fieldset class="step">
        <div class="form">
            <label class="Validform_label"> <t:mutiLang langKey="common.department.name"/>: </label>
            <input name="departname" class="inputxt" type="text" value="${depart.departname }"  datatype="s1-20">
            <span class="Validform_checktip"><t:mutiLang langKey="departmentname.rang1to20"/></span>
        </div>
        <div class="form">
            <label class="Validform_label"> <t:mutiLang langKey="position.desc"/>: </label>
            <input name="description" class="inputxt" value="${depart.description }">
        </div>
        <div class="form">
            <label class="Validform_label"> <t:mutiLang langKey="parent.depart"/>: </label>
            <input id="cc" name="TSPDepart.id" value="${depart.TSPDepart.id}">
        </div>
        <div class="form">
            <input type="hidden" name="orgCode" value="${depart.orgCode }">
            <label class="Validform_label"> <t:mutiLang langKey="common.org.type"/>: </label>
           <select name="orgType" id="orgType"> 
                 <option value="1" <c:if test="${orgType=='1'}">selected="selected"</c:if>><t:mutiLang langKey="common.company"/></option> 
                 <option value="2" <c:if test="${orgType=='2'}">selected="selected"</c:if>><t:mutiLang langKey="common.department"/></option> 
                 <option value="3" <c:if test="${orgType=='3'}">selected="selected"</c:if>><t:mutiLang langKey="common.position"/></option>
         </select> 
        </div>
        <div class="form">
            <label class="Validform_label"> <t:mutiLang langKey="common.mobile"/>: </label>
            <input name="mobile" class="inputxt" value="${depart.mobile }">
        </div>
        <div class="form">
            <label class="Validform_label"> <t:mutiLang langKey="common.fax"/>: </label>
            <input name="fax" class="inputxt" value="${depart.fax }">
        </div>
        <div class="form">
            <label class="Validform_label"> <t:mutiLang langKey="common.address"/>: </label>
            <input name="address" class="inputxt" value="${depart.address }">
            <span class="Validform_checktip"></span>
        </div>
        <!-- update--begin--author:zhangjiaqiang Date:20170223 for:TASk 1708-->
<!--          <div class="form"> -->
<!--             <label class="Validform_label"> 排序: </label> -->
<%--             <input name="departOrder" class="inputxt" value="${depart.departOrder }" datatype="n"> --%>
<!--             <span class="Validform_checktip">请输入排序号</span> -->
<!--         </div> -->
        <!-- update--end--author:zhangjiaqiang Date:20170112 for:TASK 1708-->
	</fieldset>
</t:formvalid>
<script type="text/javascript">
function callbackTreeLoad(data){
		var win = frameElement.api.opener;
		if (data.success == true) {
			frameElement.api.close();
			win.tip(data.msg);
		} else {
			if (data.responseText == ''
					|| data.responseText == undefined) {
				$.messager.alert('错误', data.msg);
				$.Hidemsg();
			} else {
				try {
					var emsg = data.responseText
							.substring(
									data.responseText
											.indexOf('错误描述'),
									data.responseText
											.indexOf('错误信息'));
					$.messager.alert('错误', emsg);
					$.Hidemsg();
				} catch (ex) {
					$.messager.alert('错误',
							data.responseText + "");
					$.Hidemsg();
				}
			}
			return false;
		}
		win.reloadTreeNode();
}
</script>
</body>
</html>
