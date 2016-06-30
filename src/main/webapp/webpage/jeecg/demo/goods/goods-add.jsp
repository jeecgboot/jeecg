<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>商品信息</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript">
  //编写自定义JS代码
  </script>
 </head>
 <body>
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="goodsController.do?doAdd" tiptype="1" >
					<input id="id" name="id" type="hidden" value="${goodsPage.id }">
		<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td align="right">
						<label class="Validform_label">
							商品代码:
						</label>
					</td>
					<td class="value">
					     	 <input id="code" name="code" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">商品代码</label>
						</td>
					<td align="right">
						<label class="Validform_label">
							商品名称:
						</label>
					</td>
					<td class="value">
					     	 <input id="name" name="name" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">商品名称</label>
						</td>
					</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							商品全称:
						</label>
					</td>
					<td class="value">
					     	 <input id="fullName" name="fullName" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">商品全称</label>
						</td>
					<td align="right">
						<label class="Validform_label">
							外部编码:
						</label>
					</td>
					<td class="value">
					     	 <input id="outsideCode" name="outsideCode" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">外部编码</label>
						</td>
					</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							厂家货号:
						</label>
					</td>
					<td class="value">
					     	 <input id="manufacturersNo" name="manufacturersNo" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">厂家货号</label>
						</td>
					<td align="right">
						<label class="Validform_label">
							供应商:
						</label>
					</td>
					<td class="value">
					     	 <input id="supplier" name="supplier" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">供应商</label>
						</td>
					</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							单位:
						</label>
					</td>
					<td class="value">
					     	 <input id="productUnit" name="productUnit" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">单位</label>
						</td>
					<td align="right">
						<label class="Validform_label">
							货主:
						</label>
					</td>
					<td class="value">
					     	 <input id="productOwner" name="productOwner" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">货主</label>
						</td>
					</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							品牌:
						</label>
					</td>
					<td class="value">
					     	 <input id="brand" name="brand" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">品牌</label>
						</td>
					<td align="right">
						<label class="Validform_label">
							年度:
						</label>
					</td>
					<td class="value">
					     	 <input id="annual" name="annual" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">年度</label>
						</td>
					</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							季节:
						</label>
					</td>
					<td class="value">
					     	 <input id="season" name="season" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">季节</label>
						</td>
					<td align="right">
						<label class="Validform_label">
							商品分类:
						</label>
					</td>
					<td class="value">
					     	 <input id="productType" name="productType" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">商品分类</label>
						</td>
					</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							系列名称:
						</label>
					</td>
					<td class="value">
					     	 <input id="seriesName" name="seriesName" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">系列名称</label>
						</td>
					<td align="right">
						<label class="Validform_label">
							长度:
						</label>
					</td>
					<td class="value">
					     	 <input id="sizeLength" name="sizeLength" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">长度</label>
						</td>
					</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							宽度:
						</label>
					</td>
					<td class="value">
					     	 <input id="sizeWidth" name="sizeWidth" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">宽度</label>
						</td>
					<td align="right">
						<label class="Validform_label">
							高度:
						</label>
					</td>
					<td class="value">
					     	 <input id="sizeHeight" name="sizeHeight" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">高度</label>
						</td>
					</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							体积:
						</label>
					</td>
					<td class="value">
					     	 <input id="sizeVolume" name="sizeVolume" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">体积</label>
						</td>
					<td align="right">
						<label class="Validform_label">
							上市时间:
						</label>
					</td>
					<td class="value">
							   <input id="timeToMarket" name="timeToMarket" type="text" style="width: 150px" 
					      						class="Wdate" onClick="WdatePicker()"
>    
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">上市时间</label>
						</td>
					</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							成本价:
						</label>
					</td>
					<td class="value">
					     	 <input id="priceCost" name="priceCost" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">成本价</label>
						</td>
					<td align="right">
						<label class="Validform_label">
							吊牌价:
						</label>
					</td>
					<td class="value">
					     	 <input id="priceDrop" name="priceDrop" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">吊牌价</label>
						</td>
					</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							标准售价:
						</label>
					</td>
					<td class="value">
					     	 <input id="priceStandardSell" name="priceStandardSell" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">标准售价</label>
						</td>
					<td align="right">
						<label class="Validform_label">
							标准进价:
						</label>
					</td>
					<td class="value">
					     	 <input id="priceStandardBid" name="priceStandardBid" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">标准进价</label>
						</td>
					</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							批发价:
						</label>
					</td>
					<td class="value">
					     	 <input id="priceTrade" name="priceTrade" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">批发价</label>
						</td>
					<td align="right">
						<label class="Validform_label">
							代理价:
						</label>
					</td>
					<td class="value">
					     	 <input id="priceProxy" name="priceProxy" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">代理价</label>
						</td>
					</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							平台价:
						</label>
					</td>
					<td class="value">
					     	 <input id="pricePlatform" name="pricePlatform" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">平台价</label>
						</td>
					<td align="right">
						<label class="Validform_label">
							赠品:
						</label>
					</td>
					<td class="value">
					     	 <input id="gift" name="gift" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">赠品</label>
						</td>
					</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							虚拟商品:
						</label>
					</td>
					<td class="value">
					     	 <input id="productVirtual" name="productVirtual" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">虚拟商品</label>
						</td>
					<td align="right">
						<label class="Validform_label">
							费用商品:
						</label>
					</td>
					<td class="value">
					     	 <input id="productCost" name="productCost" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">费用商品</label>
						</td>
					</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							打包点数:
						</label>
					</td>
					<td class="value">
					     	 <input id="pointPack" name="pointPack" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">打包点数</label>
						</td>
					<td align="right">
						<label class="Validform_label">
							销售点数:
						</label>
					</td>
					<td class="value">
					     	 <input id="pointSell" name="pointSell" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">销售点数</label>
						</td>
					</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							唯一码商品:
						</label>
					</td>
					<td class="value">
					     	 <input id="productUniquenessCode" name="productUniquenessCode" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">唯一码商品</label>
						</td>
					<td align="right">
						<label class="Validform_label">
							批次管理:
						</label>
					</td>
					<td class="value">
					     	 <input id="batchManage" name="batchManage" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">批次管理</label>
						</td>
					</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							单码商品:
						</label>
					</td>
					<td class="value">
					     	 <input id="productSingleCode" name="productSingleCode" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">单码商品</label>
						</td>
					<td align="right">
						<label class="Validform_label">
							保质期:
						</label>
					</td>
					<td class="value">
					     	 <input id="expirationDate" name="expirationDate" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">保质期</label>
						</td>
					</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							供货周期:
						</label>
					</td>
					<td class="value">
					     	 <input id="supplyOfMaterialRound" name="supplyOfMaterialRound" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">供货周期</label>
						</td>
					<td align="right">
						<label class="Validform_label">
							安全库存:
						</label>
					</td>
					<td class="value">
					     	 <input id="safetyInventory" name="safetyInventory" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">安全库存</label>
						</td>
					</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							国际码:
						</label>
					</td>
					<td class="value">
					     	 <input id="internationalCode" name="internationalCode" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">国际码</label>
						</td>
					<td align="right">
						<label class="Validform_label">
							备注:
						</label>
					</td>
					<td class="value">
					     	 <input id="remark" name="remark" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">备注</label>
						</td>
					</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							商品状态:
						</label>
					</td>
					<td class="value">
					     	 <input id="productState" name="productState" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">商品状态</label>
						</td>
				<td align="right">
					<label class="Validform_label">
					</label>
				</td>
				<td class="value">
				</td>
					</tr>
			</table>
		</t:formvalid>
 </body>
  <script src = "webpage/jeecg/demo/goods/goods.js"></script>		
