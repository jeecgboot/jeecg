<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<script type="text/javascript">
	$('#addCgDynamGraphConfigItemBtn').linkbutton({   
	    iconCls: 'icon-add'  
	});  
	$('#delCgDynamGraphConfigItemBtn').linkbutton({   
	    iconCls: 'icon-remove'  
	}); 
	$('#addCgDynamGraphConfigItemBtn').bind('click', function(){   
 		 var tr =  $("#add_cgDynamGraphConfigItem_table_template tr").clone();
	 	 $("#add_cgDynamGraphConfigItem_table").append(tr);
	 	 resetTrNum('add_cgDynamGraphConfigItem_table');
    });  
	$('#delCgDynamGraphConfigItemBtn').bind('click', function(){   
      	$("#add_cgDynamGraphConfigItem_table").find("input:checked").parent().parent().remove();   
        resetTrNum('add_cgDynamGraphConfigItem_table'); 
    }); 
    $(document).ready(function(){
    	$(".datagrid-toolbar").parent().css("width","auto");
    	if(location.href.indexOf("load=detail")!=-1){
			$(":input").attr("disabled","true");
			$(".datagrid-toolbar").hide();
		}
    });
</script>
<div style="padding: 3px; height: 25px; width: auto;" class="datagrid-toolbar"><a id="addCgDynamGraphConfigItemBtn" href="javascript:void(0);">添加</a> <a id="delCgDynamGraphConfigItemBtn" href="javascript:void(0);">删除</a></div>
<div style="width: auto; height: 300px; overflow-y: auto; overflow-x: scroll;">
<table border="0" cellpadding="2" cellspacing="0" id="cgDynamGraphConfigItem_table">
	<tr bgcolor="#E6E6E6">
		<td align="center" bgcolor="#EEEEEE"><label class="Validform_label"><t:mutiLang langKey="common.code"/></label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label"> <t:mutiLang langKey="common.name"/> </label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label"> <t:mutiLang langKey="common.order"/> </label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label"> <t:mutiLang langKey="common.text"/> </label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label"> <t:mutiLang langKey="common.type"/> </label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label"> <t:mutiLang langKey="common.isshow"/>  </label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">  <t:mutiLang langKey="common.href"/>  </label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">  <t:mutiLang langKey="common.query.module"/>  </label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">  取值表达式 </label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">  <t:mutiLang langKey="dict.code"/>  </label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">  <t:mutiLang langKey="common.isquery"/>  </label></td>
	</tr>
	<tbody id="add_cgDynamGraphConfigItem_table">
		<c:if test="${fn:length(cgDynamGraphConfigItemList)  <= 0 }">
			<tr>
				<td align="center"><input style="width: 20px;" type="checkbox" name="ck" />
				<input name="cgDynamGraphConfigItemList[0].id" type="hidden" />
				<input name="cgDynamGraphConfigItemList[0].cgrheadId" type="hidden" />
				</td>
				<td align="left"><input name="cgDynamGraphConfigItemList[0].fieldName" maxlength="36" type="text" class="inputxt" style="width: 120px;"></td>
				<td align="left"><input name="cgDynamGraphConfigItemList[0].orderNum" maxlength="3" type="text" class="inputxt" style="width: 30px;"></td>
				<td align="left"><input name="cgDynamGraphConfigItemList[0].fieldTxt" maxlength="1000" type="text" class="inputxt" style="width: 120px;"></td>
				<td align="left"><t:dictSelect field="cgDynamGraphConfigItemList[0].fieldType"  extendJson="{style:'width:80px'}" type="list" typeGroupCode="fieldtype" defaultVal="${cgDynamGraphConfigItemPage.fieldType}" hasLabel="false" title="common.text.type"></t:dictSelect></td>
				<td align="left"><select name="cgDynamGraphConfigItemList[0].isShow" style="width: 60px;">
					<option value="Y"> <t:mutiLang langKey="common.show"/></option>
					<option value="N"> <t:mutiLang langKey="common.hide"/></option>
				</select></td>
				<td align="left"><input name="cgDynamGraphConfigItemList[0].fieldHref" maxlength="100" type="text" class="inputxt" style="width: 120px;"></td>
				<td align="left"><t:dictSelect field="cgDynamGraphConfigItemList[0].SMode" type="list"  extendJson="{style:'width:90px'}" typeGroupCode="searchmode" defaultVal="${cgDynamGraphConfigItemPage.sMode}" hasLabel="false" title="common.query.module"></t:dictSelect></td>
				<td align="left"><input name="cgDynamGraphConfigItemList[0].replaceVa" maxlength="36" type="text" class="inputxt" style="width: 120px;"></td>
				<td align="left"><input name="cgDynamGraphConfigItemList[0].dictCode" maxlength="36" type="text" class="inputxt" style="width: 120px;"></td>
				<td align="left"><t:dictSelect field="cgDynamGraphConfigItemList[0].SFlag"  extendJson="{style:'width:90px'}" divClass="STYLE_LEG" type="list" typeGroupCode="yesorno" defaultVal="${cgDynamGraphConfigItemPage.sFlag}" hasLabel="false" title="common.isquery"></t:dictSelect></td>
			</tr>
		</c:if>
		<c:if test="${fn:length(cgDynamGraphConfigItemList)  > 0 }">
			<c:forEach items="${cgDynamGraphConfigItemList}" var="poVal" varStatus="stuts">
				<tr>
					<td align="center"><input style="width: 20px;" type="checkbox" name="ck" />
					<input name="cgDynamGraphConfigItemList[${stuts.index }].id" type="hidden" value="${poVal.id }" />
					<input name="cgDynamGraphConfigItemList[${stuts.index }].cgrheadId" type="hidden" value="${poVal.cgrheadId }" />
					</td>
					<td align="left"><input name="cgDynamGraphConfigItemList[${stuts.index }].fieldName" maxlength="36" type="text" class="inputxt" style="width: 120px;" value="${poVal.fieldName }"></td>
					<td align="left"><input name="cgDynamGraphConfigItemList[${stuts.index }].orderNum" maxlength="10" type="text" class="inputxt" style="width: 30px;" value="${poVal.orderNum }"></td>
					<td align="left"><input name="cgDynamGraphConfigItemList[${stuts.index }].fieldTxt" maxlength="1000" type="text" class="inputxt" style="width: 120px;" value="${poVal.fieldTxt }"></td>
					<td align="left"><t:dictSelect field="cgDynamGraphConfigItemList[${stuts.index }].fieldType" type="list" extendJson="{style:'width:80px'}" typeGroupCode="fieldtype" defaultVal="${poVal.fieldType}" hasLabel="false" title="common.text.type"></t:dictSelect>
					</td>
					<td align="left"><select id="isShow" name="cgDynamGraphConfigItemList[${stuts.index}].isShow"  style="width: 60px;">
						<option value="N" <c:if test="${poVal.isShow eq 'N'}"> selected="selected"</c:if>><t:mutiLang langKey="common.hide"/></option>
						<option value="Y" <c:if test="${poVal.isShow eq 'Y'}"> selected="selected"</c:if>><t:mutiLang langKey="common.show"/></option>
					</select></td>
					<td align="left"><input name="cgDynamGraphConfigItemList[${stuts.index }].fieldHref" maxlength="120" type="text" class="inputxt" style="width: 120px;" value="${poVal.fieldHref}"></td>
					<td align="left"><t:dictSelect field="cgDynamGraphConfigItemList[${stuts.index }].SMode"  extendJson="{style:'width:90px'}" type="list" typeGroupCode="searchmode" defaultVal="${poVal.SMode}" hasLabel="false" title="common.query.module"></t:dictSelect></td>
					<td align="left"><input name="cgDynamGraphConfigItemList[${stuts.index }].replaceVa" maxlength="36" type="text" class="inputxt" style="width: 120px;" value="${poVal.replaceVa }"></td>
					<td align="left"><input name="cgDynamGraphConfigItemList[${stuts.index }].dictCode" maxlength="36" type="text" class="inputxt" style="width: 120px;" value="${poVal.dictCode }"></td>
					<td align="left"><t:dictSelect field="cgDynamGraphConfigItemList[${stuts.index }].SFlag" extendJson="{style:'width:90px'}" type="list" typeGroupCode="yesorno" defaultVal="${poVal.SFlag}" hasLabel="false" title="common.isquery"></t:dictSelect></td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
</table>
</div>