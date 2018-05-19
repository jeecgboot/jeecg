<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title><t:mutiLang langKey="jeect.platform"/></title>
<t:base type="jquery,easyui,tools,DatePicker,autocomplete"></t:base>
<script type="text/javascript" src="plug-in/easyui/portal/jquery.portal.js"></script>
<link rel="stylesheet" type="text/css" href="plug-in/easyui/portal/portal.css">
<!--add-start--Author:wangkun Date:20160813 for:内部聊天修改-->
<%@include file="/context/layui.jsp"%>
<!--add-end--Author:wangkun Date:20160813 for:内部聊天修改-->
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
/*update-start--Author:zhangguoming  Date:20140622 for：左侧树调整：加大宽度、更换节点图标、修改选中颜色*/
.tree-node-selected{
    background: #eaf2ff;
}
/*update-end--Author:zhangguoming  Date:20140622 for：左侧树调整：加大宽度、更换节点图标、修改选中颜色*/
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
				title : '<t:mutiLang langKey="common.code"/>',
				field : 'id',
				width : 150,
				hidden : true
			} ] ],
			columns : [ [ {
				title : '<t:mutiLang langKey="common.login.name"/>',
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
				title : '<t:mutiLang langKey="common.login.time"/>',
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
				$('#layout_jeecg_onlinePanel').panel('setTitle', '( ' + data.total + ' )' + ' <t:mutiLang langKey="lang.user.online"/>');
			},
			onLoadError : function(data) {
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
<div region="north" border="false" title=" JEECG Framework  <t:mutiLang langKey="system.version.number"/>" style="BACKGROUND: #E6E6FA; height: 85px; padding: 1px; overflow: hidden;">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
    <td align="left" style="vertical-align: text-bottom;"><img src="plug-in/login/images/head.png;"> <img src="plug-in/login/images/foot.png"></td>
    <td align="right" nowrap>
        <table>
            <tr>
                <td valign="top" height="50">
                    <span style="color: #CC33FF"><t:mutiLang langKey="common.user"/>:</span>
                    <span style="color: #666633">${userName }</span>
                    <span style="color: #CC33FF"><t:mutiLang langKey="current.org"/>:</span>
                    <span style="color: #666633">${currentOrgName }</span>
                    <span style="color: #CC33FF"><t:mutiLang langKey="common.role"/>:</span>
                    <span style="color: #666633">${roleName }</span>
                </td>
            </tr>
            <tr>
                <div style="position: absolute; right: 0px; bottom: 0px;">
                    <a href="javascript:void(0);" class="easyui-menubutton" menu="#layout_north_kzmbMenu" iconCls="icon-help">
                        <t:mutiLang langKey="common.control.panel"/>
                    </a>
                    <a href="javascript:void(0);" class="easyui-menubutton" menu="#layout_north_zxMenu" iconCls="icon-back">
                        <t:mutiLang langKey="common.logout"/>
                    </a>
                </div>
                <div id="layout_north_kzmbMenu" style="width: 100px; display: none;">
                    <div onclick="openwindow('<t:mutiLang langKey="common.profile"/>','userController.do?userinfo')">
                        <t:mutiLang langKey="common.profile"/>
                    </div>
                    <div class="menu-sep"></div>
                    <div onclick="add('<t:mutiLang langKey="common.change.password"/>','userController.do?changepassword','', 550, 200)">
                        <t:mutiLang langKey="common.change.password"/>
                    </div>
					<div class="menu-sep"></div>
                    <div onclick="openwindow('<t:mutiLang langKey="common.ssms.getSysInfos"/>','tSSmsController.do?getSysInfos')">
                        <t:mutiLang langKey="common.ssms.getSysInfos"/>
                    </div>
                    <div class="menu-sep"></div>
                    <div onclick="add('<t:mutiLang langKey="common.change.style"/>','userController.do?changestyle','',550,200)">
                        <t:mutiLang langKey="common.my.style"/>
                    </div>
                    
                    <div class="menu-sep" ></div>
                    <div onclick="window.open('http://yun.jeecg.org')">
                         	云应用中心
                    </div>
                    
                    <div onclick="clearLocalstorage()">
                        <t:mutiLang langKey="common.clear.localstorage"/>
                    </div>
                </div>
                <div id="layout_north_zxMenu" style="width: 100px; display: none;">
                    <div class="menu-sep"></div>
                    <div onclick="exit('loginController.do?logout','<t:mutiLang langKey="common.exit.confirm"/>',1);"><t:mutiLang langKey="common.exit"/></div>
                </div>
            </tr>
        </table>
    </td>
    <td align="right">&nbsp;&nbsp;&nbsp;</td>
</tr>
</table>
</div>
<!-- 左侧-->
<div region="west" split="true" href="loginController.do?left" title="<t:mutiLang langKey="common.navegation"/>" style="width: 200px; padding: 1px;"></div>
<!-- 中间-->
<div id="mainPanle" region="center" style="overflow: hidden;">
	<style type="text/css">  
	<!--  
	.proccess{display:none;background-color:#f2f2f2;border:0px solid;border-color:#009900;height:100%;line-height:600px;width:100%;text-align:center;margin:100;position:absolute;top:0;left:0;}  
	.proccess b{vertical-align:middle;background:url(plug-in/layer/skin/default/loading-2.gif) no-repeat 0 center;padding-left:55px;display:inline-block;}  
	-->  
	</style> 
	<div class="proccess" id="panelloadingDiv"><b>&nbsp;</b></div>
    <div id="maintabs" class="easyui-tabs" fit="true" border="false">
    <div class="easyui-tab" title="<t:mutiLang langKey="common.dash_board"/>" href="loginController.do?home" style="padding: 2px; overflow: hidden;"></div>
        <c:if test="${map=='1'}">
            <div class="easyui-tab" title="<t:mutiLang langKey="common.map"/>" style="padding: 1px; overflow: hidden;">
                <iframe name="myMap" id="myMap" scrolling="no" frameborder="0" src="mapController.do?map" style="width: 100%; height: 99.5%;"></iframe>
            </div>
        </c:if>
    </div>
</div>
<!-- 右侧 -->
<div collapsed="true" region="east" iconCls="icon-reload" title="<t:mutiLang langKey="common.assist.tools"/>" split="true" style="width: 190px;"
	data-options="onCollapse:function(){easyPanelCollapase()},onExpand:function(){easyPanelExpand()}">
    <!--<div id="tabs" class="easyui-tabs" border="false" style="height: 240px">
        <div title="<t:mutiLang langKey="common.calendar"/>" style="padding: 0px; overflow: hidden; color: red;">
            <div id="layout_east_calendar"></div>
        </div>
    </div>
    <div id="layout_jeecg_onlinePanel" data-options="fit:true,border:false" title=<t:mutiLang langKey="common.online.user"/>>
        <table id="layout_jeecg_onlineDatagrid"></table>
    </div>
    -->
    
    <div class="easyui-layout" fit="true" border="false">
		<div region="north" border="false" style="height:180px;overflow: hidden;">
			<div id="tabs" class="easyui-tabs" border="false" style="height: 240px">
				<div title='<t:mutiLang langKey="common.calendar"/>' style="padding: 0px; overflow: hidden; color: red;">
					<div id="layout_east_calendar"></div>
				</div>
			</div>
		</div>
		<div region="center" border="false" style="overflow: hidden;">
			<div id="layout_jeecg_onlinePanel" fit="true" border="false" title='<t:mutiLang langKey="common.online.user"/>'>
				<table id="layout_jeecg_onlineDatagrid"></table>
			</div>
		</div>
	</div>
</div>
<!-- 底部 -->
<div region="south" border="false" style="height: 25px; overflow: hidden;">
    <div align="center" style="color: #CC99FF; padding-top: 2px">&copy;
        <t:mutiLang langKey="common.copyright"/>
        <span class="tip">
            <a href="http://www.jeecg.org" title=" JEECG Framework  <t:mutiLang langKey="system.version.number"/>"> JEECG Framework  <t:mutiLang langKey="system.version.number"/></a>
            <t:mutiLang langKey="common.copyright"/>:
            <a href="#" title=" JEECG Framework  <t:mutiLang langKey="system.version.number"/>">JEECG Framework  <t:mutiLang langKey="system.version.number"/></a>
        </span>
    </div>
</div>
<div id="mm" class="easyui-menu" style="width: 150px;">
    <div id="mm-tabupdate"><t:mutiLang langKey="common.refresh"/></div>
    <div id="mm-tabclose"><t:mutiLang langKey="common.close"/></div>
    <div id="mm-tabcloseall"><t:mutiLang langKey="common.close.all"/></div>
    <div id="mm-tabcloseother"><t:mutiLang langKey="common.close.all.but.this"/></div>
    <div class="menu-sep"></div>
    <div id="mm-tabcloseright"><t:mutiLang langKey="common.close.all.right"/></div>
    <div id="mm-tabcloseleft"><t:mutiLang langKey="common.close.all.left"/></div>
</div>

</body>
</html>