<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>订单列表</title>
    <style>
  .ui-button {
  	  display: inline-block;
	  padding: 2px 2px;
	  margin-bottom: 0;
	  font-size: 8px;
	  font-weight: normal;
	  line-height: 1.42857143;
	  text-align: center;
	  white-space: nowrap;
	  vertical-align: middle;
	  -ms-touch-action: manipulation;
      touch-action: manipulation;
	  cursor: pointer;
	  -webkit-user-select: none;
      -moz-user-select: none;
      -ms-user-select: none;
      user-select: none;
	  background-image: none;
	  border: 1px solid transparent;
	  border-radius: 4px;
  }
  </style>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript">
  $(document).ready(function(){
	$('#tt').tabs({
	   onSelect:function(title){
	       $('#tt .panel-body').css('width','auto');
		}
	});
	$(".tabs-wrap").css('width','100%');
  });
 </script>
 </head>
 <body style="overflow-x: hidden;">
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" tiptype="1" action="jfromOrderController.do?doUpdate" >
					<input id="id" name="id" type="hidden" value="${jfromOrderPage.id }"/>
	<table cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right">
				<label class="Validform_label">收货人:</label>
			</td>
			<td class="value">
		     	 <input id="receiverName" name="receiverName" type="text" style="width: 150px" class="inputxt"  ignore="ignore"  value='${jfromOrderPage.receiverName}'/>
				<span class="Validform_checktip"></span>
				<label class="Validform_label" style="display: none;">收货人</label>
			</td>
			<td align="right">
				<label class="Validform_label">联系电话:</label>
			</td>
			<td class="value">
		     	 <input id="receiverMobile" name="receiverMobile" type="text" style="width: 150px" class="inputxt"  ignore="ignore"  value='${jfromOrderPage.receiverMobile}'/>
				<span class="Validform_checktip"></span>
				<label class="Validform_label" style="display: none;">联系电话</label>
			</td>
		</tr>
		<tr>
			<td align="right">
				<label class="Validform_label">收货省:</label>
			</td>
			<td class="value">
		     	 <input id="receiverState" name="receiverState" type="text" style="width: 150px" class="inputxt"  ignore="ignore"  value='${jfromOrderPage.receiverState}'/>
				<span class="Validform_checktip"></span>
				<label class="Validform_label" style="display: none;">收货省</label>
			</td>
			<td align="right">
				<label class="Validform_label">收货市:</label>
			</td>
			<td class="value">
		     	 <input id="receiverCity" name="receiverCity" type="text" style="width: 150px" class="inputxt"  ignore="ignore"  value='${jfromOrderPage.receiverCity}'/>
				<span class="Validform_checktip"></span>
				<label class="Validform_label" style="display: none;">收货市</label>
			</td>
		</tr>
		<tr>
			<td align="right">
				<label class="Validform_label">收货区:</label>
			</td>
			<td class="value">
		     	 <input id="receiverDistrict" name="receiverDistrict" type="text" style="width: 150px" class="inputxt"  ignore="ignore"  value='${jfromOrderPage.receiverDistrict}'/>
				<span class="Validform_checktip"></span>
				<label class="Validform_label" style="display: none;">收货区</label>
			</td>
			<td align="right">
				<label class="Validform_label">收货地址:</label>
			</td>
			<td class="value">
		     	 <input id="receiverAddress" name="receiverAddress" type="text" style="width: 150px" class="inputxt"  ignore="ignore"  value='${jfromOrderPage.receiverAddress}'/>
				<span class="Validform_checktip"></span>
				<label class="Validform_label" style="display: none;">收货地址</label>
			</td>
		</tr>
	
			</table>
			<div style="width: auto;height: 200px;">
				<%-- 增加一个div，用于调节页面大小，否则默认太小 --%>
				<div style="width:800px;height:1px;"></div>
				<t:tabs id="tt" iframe="false" tabPosition="top" fit="false">
				 <t:tab href="jfromOrderController.do?jfromOrderLineList&id=${jfromOrderPage.id}" icon="icon-search" title="订单表体" id="jfromOrderLine"></t:tab>
				</t:tabs>
			</div> 
			</t:formvalid>
			<!-- 添加 附表明细 模版 -->
		<table style="display:none">
		<tbody id="add_jfromOrderLine_table_template">
			<tr>
			 <td align="center"><div style="width: 25px;" name="xh"></div></td>
			 <td align="center"><input style="width:20px;" type="checkbox" name="ck"/></td>
				  <td align="left">
					  		<input name="jfromOrderLineList[#index#].itemName" maxlength="128" type="text" class="inputxt"  style="width:120px;"  ignore="ignore" />
					  <label class="Validform_label" style="display: none;">商品名称</label>
				  </td>
				  <td align="left">
					  		<input name="jfromOrderLineList[#index#].qty" maxlength="32" type="text" class="inputxt"  style="width:120px;"  datatype="n"  ignore="ignore" />
					  <label class="Validform_label" style="display: none;">商品数量</label>
				  </td>
				  <td align="left">
					  		<input name="jfromOrderLineList[#index#].price" maxlength="32" type="text" class="inputxt"  style="width:120px;"  ignore="ignore" />
					  <label class="Validform_label" style="display: none;">商品价格</label>
				  </td>
				  <td align="left">
					  		<input name="jfromOrderLineList[#index#].amount" maxlength="32" type="text" class="inputxt"  style="width:120px;"  ignore="ignore" />
					  <label class="Validform_label" style="display: none;">金额</label>
				  </td>
			</tr>
		 </tbody>
		</table>
 </body>
 <script src = "webpage/com/jeecg/demo/jfromOrder.js"></script>	
