<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>JEECG 微云快速开发平台</title>
<t:base type="jquery,easyui,tools,DatePicker,autocomplete"></t:base>
<link rel="shortcut icon" href="images/favicon.ico">
<style type="text/css">
a {
	color: Black;
	text-decoration: none;
}

a:hover {
	color: black;
	text-decoration: none;
}
</style>
<SCRIPT type="text/javascript">

	$(function() {
		$('#layout_jeecg_onlineDatagrid').datagrid({
			url : 'systemController.do?datagridOnline&field=ip,logindatetime,user.userName,',
			title : '',
			iconCls : '',
			fit : true,
			fitColumns : true,
			pagination : true,
			pageSize : 10,
			pageList : [ 10 ],
			nowarp : false,
			border : false,
			idField : 'id',
			sortName : 'logindatetime',
			sortOrder : 'desc',
			frozenColumns : [ [ {
				title : '编号',
				field : 'id',
				width : 150,
				hidden : true
			} ] ],
			columns : [ [ {
				title : '登录名',
				field : 'user.userName',
				width : 100,
				align : 'center',
				sortable : true,
				formatter : function(value, rowData, rowIndex) {
					return formatString('<span title="{0}">{1}</span>', value, value);
				}
			}, {
				title : 'IP',
				field : 'ip',
				width : 150,
				align : 'center',
				sortable : true,
				formatter : function(value, rowData, rowIndex) {
					return formatString('<span title="{0}">{1}</span>', value, value);
				}
			}, {
				title : '登录时间',
				field : 'logindatetime',
				width : 150,
				sortable : true,
				formatter : function(value, rowData, rowIndex) {
					return formatString('<span title="{0}">{1}</span>', value, value);
				},
				hidden : true
			} ] ],
			onClickRow : function(rowIndex, rowData) {
			},
			onLoadSuccess : function(data) {
				$('#layout_jeecg_onlinePanel').panel('setTitle', '( ' + data.total + ' )人在线');
			}
		}).datagrid('getPager').pagination({
			showPageList : false,
			showRefresh : false,
			beforePageText : '',
			afterPageText : '/{pages}',
			displayMsg : ''
		});		
		
		$('#layout_jeecg_onlinePanel').panel({
			tools : [ {
				iconCls : 'icon-reload',
				handler : function() {
					$('#layout_jeecg_onlineDatagrid').datagrid('load', {});
				}
			} ]
		});
		
		$('#layout_east_calendar').calendar({
			fit : true,
			current : new Date(),
			border : false,
			onSelect : function(date) {
				$(this).calendar('moveTo', new Date());
			}
		});
		$(".layout-expand").click(function(){
			$('#layout_east_calendar').css("width","auto");
			$('#layout_east_calendar').parent().css("width","auto");
			$("#layout_jeecg_onlinePanel").find(".datagrid-view").css("max-height","200px");
			$("#layout_jeecg_onlinePanel .datagrid-view .datagrid-view2 .datagrid-body").css("max-height","180px").css("overflow-y","auto");
		});
	});
	var onlineInterval;
	
	function easyPanelCollapase(){
		window.clearTimeout(onlineInterval);
	}
	function easyPanelExpand(){
		onlineInterval = window.setInterval(function() {
			$('#layout_jeecg_onlineDatagrid').datagrid('load', {});
		}, 1000 * 20);
	}
	
</SCRIPT>
</head>
<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
<!-- 顶部-->
<div region="north" border="false" title="" style="BACKGROUND: #A8D7E9; height: 105px; padding: 1px; overflow: hidden;">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align="left" style="vertical-align: text-bottom"><img src="plug-in/login/images/logo.jpg"> <!--
		        <img src="plug-in/login/images/toplogo.png" width="550" height="52" alt="">-->
		<div style="position: absolute; top: 78px; left: 33px;">JEECG Framework <span style="letter-spacing: -1px;">3.4.3 GA</span></div>
		</td>
		<td align="right" nowrap>
		<table border="0" cellpadding="0" cellspacing="0">
			<tr style="height: 25px;" align="right">
				<td style="" colspan="2">
				<div style="background: url(plug-in/login/images/top_bg.jpg) no-repeat right center; float: right;">
				<div style="float: left; line-height: 25px; margin-left: 70px;"><span style="color: #386780">当前用户:</span> <span style="color: #FFFFFF">${userName }</span>&nbsp;&nbsp;&nbsp;&nbsp; <span
					style="color: #386780">职务:</span> <span style="color: #FFFFFF">${roleName }</span></div>
				<div style="float: left; margin-left: 18px;">
				<div style="right: 0px; bottom: 0px;"><a href="javascript:void(0);" class="easyui-menubutton" menu="#layout_north_kzmbMenu" iconCls="icon-comturn" style="color: #FFFFFF">控制面板</a>&nbsp;&nbsp;<a
					href="javascript:void(0);" class="easyui-menubutton" menu="#layout_north_zxMenu" iconCls="icon-exit" style="color: #FFFFFF">注销</a></div>
				<div id="layout_north_kzmbMenu" style="width: 100px; display: none;">
					<div onclick="openwindow('用户信息','userController.do?userinfo')">个人信息</div>
					<div class="menu-sep"></div>
					<div onclick="add('修改密码','userController.do?changepassword')">修改密码</div>
					<div class="menu-sep"></div>	
					<div onclick="add('修改首页风格','userController.do?changestyle')">首页风格</div>
				</div>
				<div id="layout_north_zxMenu" style="width: 100px; display: none;">
					<div class="menu-sep"></div>
					<div onclick="exit('loginController.do?logout','确定退出该系统吗 ?',1);">退出系统</div>
				</div>	
				</div>
				</div>
				</td>
			</tr>
			<tr style="height: 80px;">
				<td colspan="2">
				<ul class="shortcut">
					<!-- 动态生成并赋值过来 -->
					${primaryMenuList }
				</ul>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
<!-- 左侧-->
<div region="west" split="true" href="loginController.do?shortcut_top" title="导航菜单" style="width: 150px; padding: 1px;"></div>
<!-- 中间-->
<div id="mainPanle" region="center" style="overflow: hidden;">
<div id="maintabs" class="easyui-tabs" fit="true" border="false">
<div class="easyui-tab" title="首页" href="loginController.do?home" style="padding: 2px; overflow: hidden;"></div>
<c:if test="${map=='1'}">
	<div class="easyui-tab" title="地图" style="padding: 1px; overflow: hidden;"><iframe name="myMap" id="myMap" scrolling="no" frameborder="0" src="mapController.do?map"
		style="width: 100%; height: 99.5%;"></iframe></div>
</c:if></div>
</div>
<!-- 右侧 -->
<div collapsed="true" region="east" iconCls="icon-reload" title="辅助工具" split="true" style="width: 190px;"
	data-options="onCollapse:function(){easyPanelCollapase()},onExpand:function(){easyPanelExpand()}">
<div id="tabs" class="easyui-tabs" border="false" style="height: 240px">
<div title="日历" style="padding: 0px; overflow: hidden; color: red;">
<div id="layout_east_calendar"></div>
</div>
</div>
<div id="layout_jeecg_onlinePanel" data-options="fit:true,border:false" title="用户在线列表">
<table id="layout_jeecg_onlineDatagrid"></table>
</div>
</div>
<!-- 底部 -->
<div region="south" border="false" style="height: 25px; overflow: hidden;">
<div align="center" style="color: #1fa3e5; padding-top: 2px">&copy; 版权所有 <span class="tip"><a href="http://www.jeecg.org" title="JEECG Framework 3.4.3 GA版本">JEECG Framework 3.4.3GA</a> (推荐谷歌浏览器，获得更快响应速度) 技术支持:<a href="#" title="JEECG Framework 3.4.3 GA版本">JEECG Framework 3.4.3 GA</a> </span></div>
</div>
<div id="mm" class="easyui-menu" style="width: 150px;">
<div id="mm-tabupdate">刷新</div>
<div id="mm-tabclose">关闭</div>
<div id="mm-tabcloseall">全部关闭</div>
<div id="mm-tabcloseother">除此之外全部关闭</div>
<div class="menu-sep"></div>
<div id="mm-tabcloseright">当前页右侧全部关闭</div>
<div id="mm-tabcloseleft">当前页左侧全部关闭</div>

</div>
<script type="text/javascript">

</script>
</body>
</html>