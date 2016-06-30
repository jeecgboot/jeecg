<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<title>商品信息</title>
		<t:base type="jquery,easyui,tools,DatePicker"></t:base>
		<script src = "webpage/jeecg/demo/goods/goods.js"></script>		
		<script type="text/javascript">
			//编写自定义JS代码
			$(function(){
				$("input[type='text']").attr("readonly","readonly")
			})
		</script>
	</head>
	<body style="width: 100%; padding-bottom: 30px;">
		<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="goodsController.do?doUpdate" tiptype="1" >
			<input id="id" name="id" type="hidden" value="${goodsPage.id }">
			<table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td align="right">
						<label class="Validform_label">商品代码:</label>
					</td>
					<td class="value">
						<input id="code" name="code" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.code}'>
					</td>
					<td align="right">
						<label class="Validform_label">商品名称:</label>
					</td>
					<td class="value">
						<input id="name" name="name" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.name}'>
					</td>
					<td align="right">
						<label class="Validform_label">商品全称:</label>
					</td>
					<td class="value">
						<input id="fullName" name="fullName" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.fullName}'>
					</td>
					<td align="right">
						<label class="Validform_label">外部编码:</label>
					</td>
					<td class="value">
						<input id="outsideCode" name="outsideCode" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.outsideCode}'>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">厂家货号:</label>
					</td>
					<td class="value">
						<input id="manufacturersNo" name="manufacturersNo" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.manufacturersNo}'>
					</td>
					<td align="right">
						<label class="Validform_label">供应商:</label>
					</td>
					<td class="value">
						<input id="supplier" name="supplier" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.supplier}'>
					</td>
					<td align="right">
						<label class="Validform_label">单位:</label>
					</td>
					<td class="value">
						<input id="units" name="productUnit" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.productUnit}'>
					</td>
					<td align="right">
						<label class="Validform_label">货主:</label>
					</td>
					<td class="value">
						<input id="owner" name="productOwner" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.productOwner}'>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">品牌:</label>
					</td>
					<td class="value">
						<input id="brand" name="brand" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.brand}'>
					</td>
					<td align="right">
						<label class="Validform_label">年度:</label>
					</td>
					<td class="value">
						<input id="annual" name="annual" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.annual}'>
					</td>
					<td align="right">
						<label class="Validform_label">季节:</label>
					</td>
					<td class="value">
						<input id="season" name="season" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.season}'>
					</td>
					<td align="right">
						<label class="Validform_label">商品分类:</label>
					</td>
					<td class="value">
						<input id="productType" name="productType" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.productType}'>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">系列名称:</label>
					</td>
					<td class="value">
						<input id="seriesName" name="seriesName" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.seriesName}'>
					</td>
					<td align="right">
						<label class="Validform_label">长度:</label>
					</td>
					<td class="value">
						<input id="sizeLength" name="sizeLength" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.sizeLength}'>
					</td>
					<td align="right">
						<label class="Validform_label">宽度:</label>
					</td>
					<td class="value">
						<input id="sizeWidth" name="sizeWidth" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.sizeWidth}'>
					</td>
					<td align="right">
						<label class="Validform_label">高度:</label>
					</td>
					<td class="value">
						<input id="sizeHeight" name="sizeHeight" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.sizeHeight}'>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">体积:</label>
					</td>
					<td class="value">
						<input id="sizeVolume" name="sizeVolume" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.sizeVolume}'>
					</td>
					<td align="right">
						<label class="Validform_label">上市时间:</label>
					</td>
					<td class="value">
						<input id="timeToMarket" name="timeToMarket" type="text" style="width: 150px" value='<fmt:formatDate value='${goodsPage.timeToMarket}' type="date" pattern="yyyy-MM-dd"/>'>
					</td>
					<td align="right">
						<label class="Validform_label">成本价:</label>
					</td>
					<td class="value">
						<input id="priceCost" name="priceCost" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.priceCost}'>
					</td>
					<td align="right">
						<label class="Validform_label">吊牌价:</label>
					</td>
					<td class="value">
						<input id="priceDrop" name="priceDrop" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.priceDrop}'>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">标准售价:</label>
					</td>
					<td class="value">
						<input id="priceStandardSell" name="priceStandardSell" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.priceStandardSell}'>
					</td>
					<td align="right">
						<label class="Validform_label">标准进价:</label>
					</td>
					<td class="value">
						<input id="priceStandardBid" name="priceStandardBid" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.priceStandardBid}'>
					</td>
					<td align="right">
						<label class="Validform_label">批发价:</label>
					</td>
					<td class="value">
						<input id="priceTrade" name="priceTrade" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.priceTrade}'>
					</td>
					<td align="right">
						<label class="Validform_label">代理价:</label>
					</td>
					<td class="value">
				     	 <input id="priceProxy" name="priceProxy" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.priceProxy}'>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">平台价:</label>
					</td>
					<td class="value">
						<input id="pricePlatform" name="pricePlatform" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.pricePlatform}'>
					</td>
					<td align="right">
						<label class="Validform_label">赠品:</label>
					</td>
					<td class="value">
				     	 <input id="gift" name="gift" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.gift}'>
					</td>
					<td align="right">
						<label class="Validform_label">虚拟商品:</label>
					</td>
					<td class="value">
						<input id="productVirtual" name="productVirtual" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.productVirtual}'>
					</td>
					<td align="right">
						<label class="Validform_label">费用商品:</label>
					</td>
					<td class="value">
				     	 <input id="productCost" name="productCost" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.productCost}'>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">打包点数:</label>
					</td>
					<td class="value">
						<input id="pointPack" name="pointPack" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.pointPack}'>
					</td>
					<td align="right">
						<label class="Validform_label">销售点数:</label>
					</td>
					<td class="value">
				     	 <input id="pointSell" name="pointSell" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.pointSell}'>
					</td>
					<td align="right">
						<label class="Validform_label">唯一码商品:</label>
					</td>
					<td class="value">
						<input id="productUniquenessCode" name="productUniquenessCode" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.productUniquenessCode}'>
					</td>
					<td align="right">
						<label class="Validform_label">批次管理:</label>
					</td>
					<td class="value">
				     	 <input id="batchManage" name="batchManage" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.batchManage}'>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">单码商品:</label>
					</td>
					<td class="value">
						<input id="productSingleCode" name="productSingleCode" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.productSingleCode}'>
					</td>
					<td align="right">
						<label class="Validform_label">保质期:</label>
					</td>
					<td class="value">
				     	 <input id="expirationDate" name="expirationDate" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.expirationDate}'>
					</td>
					<td align="right">
						<label class="Validform_label">供货周期:</label>
					</td>
					<td class="value">
						<input id="supplyOfMaterialRound" name="supplyOfMaterialRound" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.supplyOfMaterialRound}'>
					</td>
					<td align="right">
						<label class="Validform_label">安全库存:</label>
					</td>
					<td class="value">
				     	 <input id="safetyInventory" name="safetyInventory" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.safetyInventory}'>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">国际码:</label>
					</td>
					<td class="value">
						<input id="internationalCode" name="internationalCode" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.internationalCode}'>
					</td>
					<td align="right">
						<label class="Validform_label">备注:</label>
					</td>
					<td class="value">
						<input id="remark" name="remark" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.remark}'>
					</td>
					<td align="right">
						<label class="Validform_label">商品状态:</label>
					</td>
					<td class="value">
						<input id="productState" name="productState" type="text" style="width: 150px" class="inputxt"  value='${goodsPage.productState}'>
					</td>
					<td align="right">
						<label class="Validform_label"></label>
					</td>
					<td class="value"></td>
				</tr>
			</table>
		</t:formvalid>
	</body>