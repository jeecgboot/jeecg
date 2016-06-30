<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
	<div region="center" style="padding:0px;border:0px">
		<t:datagrid name="goodsList" checkbox="true" fitColumns="false" title="商品信息" actionUrl="goodsController.do?datagrid" idField="id" fit="true" queryMode="group" sortName="createDate" sortOrder="asc">
			<t:dgCol title="主键"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="创建人名称"  field="createName" hidden="true" queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="创建人登录名称"  field="createBy"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="创建日期"  field="createDate" formatter="yyyy-MM-dd"  hidden="true" queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="更新人名称"  field="updateName" hidden="true"   queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="更新人登录名称"  field="updateBy"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="更新日期"  field="updateDate" formatter="yyyy-MM-dd"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="所属部门"  field="sysOrgCode"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="所属公司"  field="sysCompanyCode"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="商品代码"  field="code"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="商品名称"  field="name"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="商品全称"  field="fullName"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="外部编码"  field="outsideCode"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="厂家货号"  field="manufacturersNo"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="供应商"  field="supplier"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="单位"  field="productUnit"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="货主"  field="productOwner"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="品牌"  field="brand"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="年度"  field="annual"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="季节"  field="season"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="商品分类"  field="productType"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="系列名称"  field="seriesName"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="长度"  field="sizeLength"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="宽度"  field="sizeWidth"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="高度"  field="sizeHeight"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="体积"  field="sizeVolume"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="上市时间"  field="timeToMarket" formatter="yyyy-MM-dd"   queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="成本价"  field="priceCost"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="吊牌价"  field="priceDrop"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="标准售价"  field="priceStandardSell"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="标准进价"  field="priceStandardBid"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="批发价"  field="priceTrade"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="代理价"  field="priceProxy"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="平台价"  field="pricePlatform"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="赠品"  field="gift"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="虚拟商品"  field="productVirtual"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="费用商品"  field="productCost"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="打包点数"  field="pointPack"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="销售点数"  field="pointSell"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="唯一码商品"  field="productUniquenessCode"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="批次管理"  field="batchManage"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="单码商品"  field="productSingleCode"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="保质期"  field="expirationDate"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="供货周期"  field="supplyOfMaterialRound"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="安全库存"  field="safetyInventory"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="国际码"  field="internationalCode"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="备注"  field="remark"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="商品状态"  field="productState"    queryMode="group"  width="120"></t:dgCol>
			<t:dgCol title="操作" field="opt" width="100"></t:dgCol>
			<t:dgDelOpt title="删除" url="goodsController.do?doDel&id={id}" />
			<t:dgToolBar title="录入" icon="icon-add" url="goodsController.do?goAdd" funname="add"></t:dgToolBar>
			<t:dgToolBar title="编辑" icon="icon-edit" url="goodsController.do?goUpdate" funname="update"></t:dgToolBar>
			<t:dgToolBar title="批量删除"  icon="icon-remove" url="goodsController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
			<t:dgToolBar title="查看" icon="icon-search" url="goodsController.do?goUpdate" funname="detail"></t:dgToolBar>
			<t:dgToolBar title="预览" icon="icon-search" url="goodsController.do?goInfo" funname="goInfo"></t:dgToolBar>
			<t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>
			<t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
			<t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar>
		</t:datagrid>
	</div>
</div>
<!-- 底部 -->
<div region="south" border="false" style="height: 300px; overflow: hidden;" id="southDiv">
	<t:tabs id="goodsTabs" iframe="false" tabPosition="top" fit="false">
		<t:tab title="商品信息" id=""  heigth="100%" width="100%" icon="" iframe=""></t:tab>
	</t:tabs>
</div>
<script src = "webpage/jeecg/demo/goods/goodsList.js"></script>		
<script type="text/javascript">
	$(document).ready(function(){
		//给时间控件加上样式
		$("#goodsListtb").find("input[name='createDate_begin']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
		$("#goodsListtb").find("input[name='createDate_end']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
		$("#goodsListtb").find("input[name='updateDate_begin']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
		$("#goodsListtb").find("input[name='updateDate_end']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
		$("#goodsListtb").find("input[name='timeToMarket_begin']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
		$("#goodsListtb").find("input[name='timeToMarket_end']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
		
		$('#goodsList').datagrid({
			onClickRow: function(rowIndex, rowData){
				var url = "goodsController.do?goInfo";
				if (rowData) {
					url += '&id=' + rowData.id;
					$("iframe").attr("src",url);
					$("iframe").attr("scrolling","auto");
				}else{
				}
			}
		});
	});
	
	function goInfo(title, url, id){
		var rowData = $('#goodsList').datagrid('getSelected');
		if (rowData) {
			url += '&id=' + rowData.id;
			$("iframe").attr("src",url);
			$("iframe").attr("scrolling","auto");
		}else{
		}
 	}
	 
	//导入
	function ImportXls() {
		openuploadwin('Excel导入', 'goodsController.do?upload', "goodsList");
	}
	
	//导出
	function ExportXls() {
		JeecgExcelExport("goodsController.do?exportXls","goodsList");
	}
	
	//模板下载
	function ExportXlsByT() {
		JeecgExcelExport("goodsController.do?exportXlsByT","goodsList");
	}
</script>