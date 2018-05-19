<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<script type="text/javascript">
	$('#addJformGraphreportItemBtn').linkbutton({   
	    iconCls: 'icon-add'  
	});  
	$('#delJformGraphreportItemBtn').linkbutton({   
	    iconCls: 'icon-remove'  
	}); 
	$('#addJformGraphreportItemBtn').bind('click', function(){   
 		 var tr =  $("#add_jformGraphreportItem_table_template tr").clone();
	 	 $("#add_jformGraphreportItem_table").append(tr);
	 	 resetTrNum('add_jformGraphreportItem_table');
	 	 return false;
    });  
	$('#delJformGraphreportItemBtn').bind('click', function(){   
      	$("#add_jformGraphreportItem_table").find("input:checked").parent().parent().remove();   
        resetTrNum('add_jformGraphreportItem_table'); 
        return false;
    }); 
    $(document).ready(function(){
    	$(".datagrid-toolbar").parent().css("width","auto");
    	if(location.href.indexOf("load=detail")!=-1){
			$(":input").attr("disabled","true");
			$(".datagrid-toolbar").hide();
		}
		//将表格的表头固定
	    $("#jformGraphreportItem_table").createhftable({
	    	height:'300px',
			width:'auto',
			fixFooter:false
			});
    });
</script>
<div style="padding: 3px; height: 25px;width:auto;" class="datagrid-toolbar">
	<a id="addJformGraphreportItemBtn" href="#">添加</a> <a id="delJformGraphreportItemBtn" href="#">删除</a>
</div>
<table border="0" cellpadding="2" cellspacing="0" id="jformGraphreportItem_table">
	<tr bgcolor="#E6E6E6">
		<td align="center" bgcolor="#EEEEEE"><label class="Validform_label">序号</label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">操作</label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">字段名</label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">字段文本</label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">排序</label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">字段类型</label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">是否显示</label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">是否查询</label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">查询模式</label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">字典Code</label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">显示图表</label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">图表类型</label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">图表名称</label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">标签名称</label></td>
	</tr>
	<tbody id="add_jformGraphreportItem_table">
	<c:if test="${fn:length(jformGraphreportItemList)  <= 0 }">
			<tr>
				<td align="center"><div style="width: 25px;" name="xh">1</div></td>
				<td align="center"><input style="width:20px;"  type="checkbox" name="ck"/>
					<input name="jformGraphreportItemList[0].id" type="hidden"/>
					<input name="jformGraphreportItemList[0].fieldHref" type="hidden"/>
					<input name="jformGraphreportItemList[0].replaceVa" type="hidden"/>
					<input name="jformGraphreportItemList[0].cgreportHeadId" type="hidden"/>
					</td>
				  <td align="left">
					  	<input name="jformGraphreportItemList[0].fieldName" maxlength="36" 
					  		type="text" class="inputxt"  style="width:120px;" />
					  <label class="Validform_label" style="display: none;">字段名</label>
					</td>
				  <td align="left">
					  	<input name="jformGraphreportItemList[0].fieldTxt" maxlength="1000" 
					  		type="text" class="inputxt"  style="width:120px;" />
					  <label class="Validform_label" style="display: none;">字段文本</label>
					</td>
				  <td align="left">
					  	<input name="jformGraphreportItemList[0].orderNum" maxlength="5" 
					  		type="text" class="inputxt"  style="width:40px;" />
					  <label class="Validform_label" style="display: none;">排序</label>
					</td>
				  <td align="left" style="width: 120px;">
							<t:dictSelect field="fieldType" extendJson="{style:'width:100px'}"
										typeGroupCode="fieldtype" defaultVal="${jformGraphreportItemPage.fieldType}" hasLabel="false"  title="字段类型"></t:dictSelect>     
					  <label class="Validform_label" style="display: none;">字段类型</label>
					</td>
				  <td align="left">
							<t:dictSelect field="isShow" type="list" extendJson="{style:'width:100px'}"
										typeGroupCode="sf_yn" defaultVal="${jformGraphreportItemPage.isShow}" hasLabel="false"  title="是否显示"></t:dictSelect>     
					  <label class="Validform_label" style="display: none;">是否显示</label>
					</td>
				  <td align="left">
							<t:dictSelect field="searchFlag" type="list" extendJson="{style:'width:100px'}"
										typeGroupCode="sf_yn" defaultVal="${jformGraphreportItemPage.searchFlag}" hasLabel="false"  title="是否查询"></t:dictSelect>     
					  <label class="Validform_label" style="display: none;">是否查询</label>
					</td>
				  <td align="left">
							<t:dictSelect field="searchMode" type="list" extendJson="{style:'width:100px'}"
										typeGroupCode="searchmode" defaultVal="${jformGraphreportItemPage.searchMode}" hasLabel="false"  title="查询模式"></t:dictSelect>     
					  <label class="Validform_label" style="display: none;">查询模式</label>
					</td>
				  <td align="left">
					  	<input name="jformGraphreportItemList[0].dictCode" maxlength="500" 
					  		type="text" class="inputxt"  style="width:120px;" />
					  <label class="Validform_label" style="display: none;">字典Code</label>
					</td>
				  <td align="left">
							<t:dictSelect field="isGraph" type="list" extendJson="{style:'width:100px'}"
										typeGroupCode="sf_yn" defaultVal="${jformGraphreportItemPage.isGraph}" hasLabel="false"  title="显示图表"></t:dictSelect>     
					  <label class="Validform_label" style="display: none;">显示图表</label>
					</td>
				  <td align="left">
							<t:dictSelect field="graphType" type="list" extendJson="{style:'width:100px'}"
										typeGroupCode="tblx" defaultVal="${jformGraphreportItemPage.graphType}" hasLabel="false"  title="图表类型"></t:dictSelect>     
					  <label class="Validform_label" style="display: none;">图表类型</label>
					</td>
				  <td align="left">
					  	<input name="jformGraphreportItemList[0].graphName" maxlength="100" 
					  		type="text" class="inputxt"  style="width:120px;" />
					  <label class="Validform_label" style="display: none;">图表名称</label>
					</td>
				  <td align="left">
					  	<input name="jformGraphreportItemList[0].tabName" maxlength="50" 
					  		type="text" class="inputxt"  style="width:120px;" />
					  <label class="Validform_label" style="display: none;">标签名称</label>
					</td>
   			</tr>
	</c:if>
	<c:if test="${fn:length(jformGraphreportItemList)  > 0 }">
		<c:forEach items="${jformGraphreportItemList}" var="poVal" varStatus="stuts">
			<tr>
				<td align="center"><div style="width: 25px;" name="xh">${stuts.index+1 }</div></td>
				<td align="center"><input style="width:20px;"  type="checkbox" name="ck" />
					<input name="jformGraphreportItemList[${stuts.index }].id" type="hidden" value="${poVal.id }"/>
					<input name="jformGraphreportItemList[${stuts.index }].fieldHref" type="hidden" value="${poVal.fieldHref }"/>
					<input name="jformGraphreportItemList[${stuts.index }].replaceVa" type="hidden" value="${poVal.replaceVa }"/>
					<input name="jformGraphreportItemList[${stuts.index }].cgreportHeadId" type="hidden" value="${poVal.cgreportHeadId }"/>
					</td>
				   <td align="left">
					  	<input name="jformGraphreportItemList[${stuts.index }].fieldName" maxlength="36" 
					  		type="text" class="inputxt"  style="width:120px;" value="${poVal.fieldName }">
					  <label class="Validform_label" style="display: none;">字段名</label>
				   </td>
				   <td align="left">
					  	<input name="jformGraphreportItemList[${stuts.index }].fieldTxt" maxlength="1000" 
					  		type="text" class="inputxt"  style="width:120px;" value="${poVal.fieldTxt }">
					  <label class="Validform_label" style="display: none;">字段文本</label>
				   </td>
				   <td align="left">
					  	<input name="jformGraphreportItemList[${stuts.index }].orderNum" maxlength="10" 
					  		type="text" class="inputxt"  style="width:40px;" value="${poVal.orderNum }">
					  <label class="Validform_label" style="display: none;">排序</label>
				   </td>
				   <td align="left" >
							<t:dictSelect field="jformGraphreportItemList[${stuts.index }].fieldType" extendJson="{style:'width:100px'}"
										typeGroupCode="fieldtype" defaultVal="${poVal.fieldType }" hasLabel="false"  title="字段类型"></t:dictSelect>
					  <label class="Validform_label" style="display: none;">字段类型</label>
				   </td>
				   <td align="left">
							<t:dictSelect field="jformGraphreportItemList[${stuts.index }].isShow" type="list" extendJson="{style:'width:100px'}"
										typeGroupCode="sf_yn" defaultVal="${poVal.isShow }" hasLabel="false"  title="是否显示"></t:dictSelect>     
					  <label class="Validform_label" style="display: none;">是否显示</label>
				   </td>
				   <td align="left">
							<t:dictSelect field="jformGraphreportItemList[${stuts.index }].searchFlag" type="list" extendJson="{style:'width:100px'}"
										typeGroupCode="sf_yn" defaultVal="${poVal.searchFlag }" hasLabel="false"  title="是否查询"></t:dictSelect>     
					  <label class="Validform_label" style="display: none;">是否查询</label>
				   </td>
				   <td align="left">
							<t:dictSelect field="jformGraphreportItemList[${stuts.index }].searchMode" type="list" extendJson="{style:'width:100px'}"
										typeGroupCode="searchmode" defaultVal="${poVal.searchMode }" hasLabel="false"  title="查询模式"></t:dictSelect>     
					  <label class="Validform_label" style="display: none;">查询模式</label>
				   </td>
				   <td align="left">
					  	<input name="jformGraphreportItemList[${stuts.index }].dictCode" maxlength="500" 
					  		type="text" class="inputxt"  style="width:120px;"
					               
					                value="${poVal.dictCode }">
					  <label class="Validform_label" style="display: none;">字典Code</label>
				   </td>
				   <td align="left">
							<t:dictSelect field="jformGraphreportItemList[${stuts.index }].isGraph" type="list" extendJson="{style:'width:100px'}"
										typeGroupCode="sf_yn" defaultVal="${poVal.isGraph }" hasLabel="false"  title="显示图表"></t:dictSelect>     
					  <label class="Validform_label" style="display: none;">显示图表</label>
				   </td>
				   <td align="left">
							<t:dictSelect field="jformGraphreportItemList[${stuts.index }].graphType" type="list" extendJson="{style:'width:100px'}"
										typeGroupCode="tblx" defaultVal="${poVal.graphType }" hasLabel="false"  title="图表类型"></t:dictSelect>     
					  <label class="Validform_label" style="display: none;">图表类型</label>
				   </td>
				   <td align="left">
					  	<input name="jformGraphreportItemList[${stuts.index }].graphName" maxlength="100" 
					  		type="text" class="inputxt"  style="width:120px;"
					               
					                value="${poVal.graphName }">
					  <label class="Validform_label" style="display: none;">图表名称</label>
				   </td>
				   <td align="left">
					  	<input name="jformGraphreportItemList[${stuts.index }].tabName" maxlength="50" 
					  		type="text" class="inputxt"  style="width:120px;"
					               
					                value="${poVal.tabName }">
					  <label class="Validform_label" style="display: none;">标签名称</label>
				   </td>
   			</tr>
		</c:forEach>
	</c:if>	
	</tbody>
</table>
