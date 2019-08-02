<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<title><t:mutiLang langKey="jeect.platform"/></title>
		<meta name="keywords" content="<t:mutiLang langKey="jeect.platform"/>" />
		<meta name="description" content="<t:mutiLang langKey="jeect.platform"/>" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="stylesheet" href="plug-in/jquery/jquery.contextmenu.css"/>
		<link rel="shortcut icon" href="images/favicon.ico">
		<!-- basic styles -->
		<link href="plug-in/ace/assets/css/bootstrap.min.css" rel="stylesheet" />
		<link href="plug-in/hplus/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
		<link rel="stylesheet" href="plug-in/ace/assets/css/font-awesome.min.css" />

		<!--[if IE 7]>
		  <link rel="stylesheet" href="plug-in/ace/assets/css/font-awesome-ie7.min.css" />
		<![endif]-->

		<!-- page specific plugin styles -->

		<!-- fonts -->

		<!--  <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400,300" />  -->

		<!-- ace styles -->

		<link rel="stylesheet" href="plug-in/ace/assets/css/ace.min.css" />
		<link rel="stylesheet" href="plug-in/ace/assets/css/ace-rtl.min.css" />
		<link rel="stylesheet" href="plug-in/ace/assets/css/ace-skins.min.css" />

		<!--[if lte IE 8]>
		  <link rel="stylesheet" href="plug-in/ace/assets/css/ace-ie.min.css" />
		<![endif]-->

		<!-- inline styles related to this page -->

		<!-- ace settings handler -->

		<script src="plug-in/ace/assets/js/ace-extra.min.js"></script>
		<t:base type="tools,jquery"></t:base>
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

		<!--[if lt IE 9]>
		<script src="plug-in/ace/assets/js/html5shiv.js"></script>
		<script src="plug-in/ace/assets/js/respond.min.js"></script>
		<![endif]-->
		<style type="text/css">
		.dropdown-menu li a:hover, .dropdown-menu li a:focus, .dropdown-menu li a:active, .dropdown-menu li.active a, .dropdown-menu li.active a:hover, .dropdown-menu .dropdown-submenu:hover>a, .nav-tabs .dropdown-menu li>a:focus {
		    background: rgba(255,255,255,.15);
		    color: #428bca;
		}
		</style>
	</head>

	<body>
		<div class="navbar navbar-default" id="navbar">
			<script type="text/javascript">
				try{ace.settings.check('navbar' , 'fixed')}catch(e){}
			</script>

			<div class="navbar-container" id="navbar-container">
				<div class="navbar-header pull-left">
					<a href="#" class="navbar-brand">
						<small>
							<i class="icon-leaf"></i>
							JEECG 微云快速开发平台
						</small>
					</a><!-- /.brand -->
				</div><!-- /.navbar-header -->

				<div class="navbar-header pull-right" role="navigation">
					<ul class="nav ace-nav">
					<!-- 
						<li class="grey">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="icon-tasks"></i>
								<span class="badge badge-grey">4</span>
							</a>

							<ul class="pull-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header">
									<i class="icon-ok"></i>
									还有4个任务完成
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">软件更新</span>
											<span class="pull-right">65%</span>
										</div>

										<div class="progress progress-mini ">
											<div style="width:65%" class="progress-bar "></div>
										</div>
									</a>
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">硬件更新</span>
											<span class="pull-right">35%</span>
										</div>

										<div class="progress progress-mini ">
											<div style="width:35%" class="progress-bar progress-bar-danger"></div>
										</div>
									</a>
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">单元测试</span>
											<span class="pull-right">15%</span>
										</div>

										<div class="progress progress-mini ">
											<div style="width:15%" class="progress-bar progress-bar-warning"></div>
										</div>
									</a>
								</li>

								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">错误修复</span>
											<span class="pull-right">90%</span>
										</div>

										<div class="progress progress-mini progress-striped active">
											<div style="width:90%" class="progress-bar progress-bar-success"></div>
										</div>
									</a>
								</li>

								<li>
									<a href="#">
										查看任务详情
										<i class="icon-arrow-right"></i>
									</a>
								</li>
							</ul>
						</li>-->

						<li class="purple">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="icon-bell-alt icon-animated-bell"></i>
								<span class="badge badge-important" id="noticeCount">0</span>
							</a>

							<ul class="pull-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header" id="noticeTip">
									<i class="icon-warning-sign"></i>
									0条公告
								</li>
								<li >
									<ul id="noticeContent">
										ajax加载
									</ul>
								</li>

								<li>
									<a href="#" id="noticeContentLink">
									</a>
								</li>
								<li>
									<a href="javascript:goAllNotice();" id="noticeFooter">
										查看全部
										<i class="icon-arrow-right"></i>
									</a>
								</li>
							</ul>
						</li>

						<li class="green">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="icon-envelope icon-animated-vertical"></i>
								<span class="badge badge-success" id="messageCount">0</span>
							</a>

							<ul class="pull-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header" id="messageTip">
									<i class="icon-envelope-alt"></i>
									0条消息
								</li>

								<li>
									<a href="#" id="messageContent">
										
									</a>
								</li>

								

								<li>
									<a href="javascript:goAllMessage();" id="messageFooter">
										查看所有消息
										<i class="icon-arrow-right"></i>
									</a>
								</li>
							</ul>
						</li> 

						<li class="light-blue">
							<a data-toggle="dropdown" href="#" class="dropdown-toggle" onclick="bindFrameClick()">
								<img class="nav-user-photo" src="plug-in/ace/avatars/avatar2.png" alt="Jason's Photo" />
								<span class="user-info">
									<small>${userName }</small>
				                    <span style="color: #666633">${roleName }</span>
								</span>

								<i class="icon-caret-down"></i>
							</a>

							<ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
								<li>
									<a href="javascript:add('<t:mutiLang langKey="common.change.password"/>','userController.do?changepassword','',550,200)">
										<i class="icon-cog"></i>
										 <t:mutiLang langKey="common.change.password"/>
									</a>
								</li>

								<li>
									<a href="javascript:openwindow('<t:mutiLang langKey="common.profile"/>','userController.do?userinfo')">
										<i class="icon-user"></i>
										 <t:mutiLang langKey="common.profile"/>
									</a>
								</li>
								<li>
									<a href="javascript:openwindow('<t:mutiLang langKey="common.ssms.getSysInfos"/>','tSSmsController.do?getSysInfos')">
										<i class="icon-cog"></i>
										 <t:mutiLang langKey="common.ssms.getSysInfos"/>
									</a>
								</li>
								<li>
									<a href="javascript:add('<t:mutiLang langKey="common.change.style"/>','userController.do?changestyle','',550,270)">
										<i class="icon-cog"></i>
										 <t:mutiLang langKey="common.my.style"/>
									</a>
								</li>
								
								<li>
									<a href="http://www.jeecg.com" target="_blank">
										<i class="icon-cloud"></i>
										 JEECG官网
									</a>
								</li>
								
								<li>
									<a href="javascript:clearLocalstorage()">
										<i class="icon-cog"></i>
										<t:mutiLang langKey="common.clear.localstorage"/>
									</a>
								</li>
		
								<li class="divider"></li>

								<li>
									<a href="javascript:logout()">
										<i class="icon-off"></i>
										 <t:mutiLang langKey="common.logout"/>
									</a>
								</li>
							</ul>
						</li>
					</ul><!-- /.ace-nav -->
				</div><!-- /.navbar-header -->
			</div><!-- /.container -->
		</div>

		<div class="main-container" id="main-container">
			<script type="text/javascript">
				try{ace.settings.check('main-container' , 'fixed')}catch(e){}
			</script>

			<div class="main-container-inner">
				<a class="menu-toggler" id="menu-toggler" href="#">
					<span class="menu-text"></span>
				</a>

				<div class="sidebar" id="sidebar">
					<script type="text/javascript">
						try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
					</script>

					<div class="sidebar-shortcuts" id="sidebar-shortcuts">
						<div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
							<button class="btn btn-success">
								<i class="icon-signal"></i>
							</button>

							<button class="btn btn-info">
								<i class="icon-pencil"></i>
							</button>

							<button class="btn btn-warning">
								<i class="icon-group"></i>
							</button>

							<button class="btn btn-danger">
								<i class="icon-cogs"></i>
							</button>
						</div>

						<div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
							<span class="btn btn-success"></span>

							<span class="btn btn-info"></span>

							<span class="btn btn-warning"></span>

							<span class="btn btn-danger"></span>
						</div>
					</div><!-- #sidebar-shortcuts -->

					<ul class="nav nav-list">
						<li class="active">
							<a  href="javascript:addTabs({id:'home',title:'首页',close: false,url: 'loginController.do?hplushome'});">
								<i class="fa fa-tachometer"></i>
								<span class="menu-text"> 首页 </span>
							</a>
						</li>
						<t:menu style="ace" menuFun="${menuMap}"></t:menu>
					</ul><!-- /.nav-list -->

					<div class="sidebar-collapse" id="sidebar-collapse">
						<i class="icon-double-angle-left" data-icon1="icon-double-angle-left" data-icon2="icon-double-angle-right"></i>
					</div>

					<script type="text/javascript">
						try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
					</script>
				</div>

				<div class="main-content">
					<div class="page-content">
						<div class="row">
							<div class="col-xs-12" style="width: 99%;padding-left:2px;padding-right: 2px;" id="tabs">
	                            <ul class="nav nav-tabs" role="tablist">
	                                <!-- <li class="active"><a href="#Index" role="tab" data-toggle="tab">首页</a></li> -->
	                            </ul>
	                            <div class="tab-content">
	                                <div role="tabpanel" class="tab-pane active" id="Index">
	                                </div>
	                            </div>
	                        </div>
						</div><!-- /.row -->
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
				<div class="ace-settings-container" id="ace-settings-container" style="top:100px;">
					<div class="btn btn-app btn-xs btn-warning ace-settings-btn" id="ace-settings-btn">
						<i class="icon-cog bigger-150"></i>
					</div>

					<div class="ace-settings-box" id="ace-settings-box">
						<div>
							<div class="pull-left">
								<select id="skin-colorpicker" class="hide">
									<option data-skin="default" value="#438EB9">#438EB9</option>
									<option data-skin="skin-1" value="#222A2D">#222A2D</option>
									<option data-skin="skin-2" value="#C6487E">#C6487E</option>
									<option data-skin="skin-3" value="#D0D0D0">#D0D0D0</option>
								</select>
							</div>
							<span>&nbsp; 选择皮肤</span>
						</div>

						<div>
							<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-navbar" />
							<label class="lbl" for="ace-settings-navbar"> 固定导航条</label>
						</div>

						<div>
							<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-sidebar" />
							<label class="lbl" for="ace-settings-sidebar"> 固定滑动条</label>
						</div>

						<div>
							<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-breadcrumbs" />
							<label class="lbl" for="ace-settings-breadcrumbs">固定面包屑</label>
						</div>

						<div>
							<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-rtl" />
							<label class="lbl" for="ace-settings-rtl">切换到左边</label>
						</div>

						<div>
							<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-add-container" />
							<label class="lbl" for="ace-settings-add-container">
								切换窄屏
								<b></b>
							</label>
						</div>
					</div>
				</div><!-- /#ace-settings-container -->
			</div><!-- /.main-container-inner -->

			<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
				<i class="icon-double-angle-up icon-only bigger-110"></i>
			</a>
		</div><!-- /.main-container -->


<div id="changestylePanel" style="display:none" >
	<form id="formobj"  action="userController.do?savestyle" name="formobj" method="post">
	<table style="width: 550px" cellpadding="0" cellspacing="1" class="formtable">
		<tr><td >风格</td></tr>
			<tr>
				<td class="value"><input type="radio" value="default" name="indexStyle" /> <span>经典风格</span></td>
			</tr>
			<!--
			<tr>
				<td class="value"><input type="radio" value="bootstrap" name="indexStyle" /> <span>BootStrap风格</span></td>
			</tr>
			-->
			<tr>
				<td class="value"><input type="radio" value="shortcut" name="indexStyle" /> <span>ShortCut风格</span></td>
			</tr>
			<tr>
				<td class="value"><input type="radio" value="sliding" name="indexStyle"  /><span>Sliding云桌面</span></td>
			</tr>
			<tr>
				<td class="value"><input type="radio" value="ace" name="indexStyle"  /><span>ACE平面风格</span></td>
			</tr>
	</table>
	</form>
</div>
<div id="changepassword" style="display:none">

<input id="id" type="hidden" value="${user.id }">
	<table style="width: 550px" cellpadding="0" cellspacing="1" class="formtable">
		<tbody>
			<tr>
				<td align="right" width="20%"><span class="filedzt">原密码:</span></td>
				<td class="value"><input id="password" type="password" value="" name="password" class="inputxt" datatype="*" errormsg="请输入原密码" /> <span class="Validform_checktip"> 请输入原密码 </span></td>
			</tr>
			<tr>
				<td align="right"><span class="filedzt">新密码:</span></td>
				<td class="value"><input  type="password" value="" name="newpassword" class="inputxt" plugin="passwordStrength" datatype="*6-18" errormsg="密码至少6个字符,最多18个字符！" /> <span
					class="Validform_checktip"> 密码至少6个字符,最多18个字符！ </span> <span class="passwordStrength" style="display: none;"> <b>密码强度：</b> <span>弱</span><span>中</span><span class="last">强</span> </span></td>
			</tr>
			<tr>
				<td align="right"><span class="filedzt">重复密码:</span></td>
				<td class="value"><input id="newpassword" type="password" recheck="newpassword" datatype="*6-18" errormsg="两次输入的密码不一致！"> <span class="Validform_checktip"></span></td>
			</tr>
		</tbody>
	</table>
</div>
		<!-- basic scripts -->
		<script type="text/javascript">
			window.jQuery || document.write("<script src='plug-in/ace/assets/js/jquery-2.0.3.min.js'>"+"<"+"script>");
		</script>

		<!--[if IE]>
		<script type="text/javascript">
		 window.jQuery || document.write("<script src='plug-in/ace/assets/js/jquery-1.10.2.min.js'>"+"<"+"script>");
		</script>
		<![endif]-->

		<script type="text/javascript">
			if("ontouchend" in document) document.write("<script src='plug-in/ace/assets/js/jquery.mobile.custom.min.js'>"+"<"+"script>");
		</script>
		<script src="plug-in/ace/assets/js/jquery-ui-1.10.3.custom.min.js"></script>
		<script src="plug-in/ace/assets/js/bootstrap.min.js"></script>
		<script src="plug-in/ace/assets/js/typeahead-bs2.min.js"></script>

		<!-- page specific plugin scripts -->

		<!--[if lte IE 8]>
		  <script src="plug-in/ace/assets/js/excanvas.min.js"></script>
		<![endif]-->
		<!-- ace scripts -->
		<script src="plug-in/jquery-plugs/storage/jquery.storageapi.min.js"></script>
		<script src="plug-in/ace/assets/js/ace-elements.min.js"></script>
		<script src="plug-in/ace/assets/js/ace.min.js"></script>
		<script type="text/javascript" src="plug-in/ace/assets/js/bootstrap-tab.js"></script>
		<script src="plug-in/jquery/jquery.contextmenu.js"></script>
		<script src="plug-in/layer/layer.js"></script>
	    <script src="plug-in/ace/js/bootbox.js"></script>
		<!--add-start--Author:wangkun Date:20160813 for:内部聊天修改-->
		<%@include file="/context/layui.jsp"%>
		<!--add-end--Author:wangkun Date:20160813 for:内部聊天修改-->
		<!-- inline scripts related to this page -->
		<script>
		jQuery(function($) {
			//$( "#tabs" ).tabs();
			addTabs({id:'home',title:'首页',close: false,url: 'loginController.do?hplushome'});
			$('.theme-poptit .close').click(function(){
	    		$('.theme-popover-mask').fadeOut(100);
	    		$('.theme-popover').slideUp(200);
	    	});
	    	$('#closeBtn').click(function(){
	    		$('.theme-popover-mask').fadeOut(100);
	    		$('.theme-popover').slideUp(200);
	    	});
	    	//$('#ace-settings-sidebar').click();
	    	//$('#sidebar').addClass('compact');
			$('#sidebar li').addClass('hover').filter('.open').removeClass('open').find('> .submenu').css('display', 'none');
		});
		</script>

		<script type="text/javascript">
			jQuery(function($) {
				$('.easy-pie-chart.percentage').each(function(){
					var $box = $(this).closest('.infobox');
					var barColor = $(this).data('color') || (!$box.hasClass('infobox-dark') ? $box.css('color') : 'rgba(255,255,255,0.95)');
					var trackColor = barColor == 'rgba(255,255,255,0.95)' ? 'rgba(255,255,255,0.25)' : '#E2E2E2';
					var size = parseInt($(this).data('size')) || 50;
					$(this).easyPieChart({
						barColor: barColor,
						trackColor: trackColor,
						scaleColor: false,
						lineCap: 'butt',
						lineWidth: parseInt(size/10),
						animate: /msie\s*(8|7|6)/.test(navigator.userAgent.toLowerCase()) ? false : 1000,
						size: size
					});
				})
			
				$('.sparkline').each(function(){
					var $box = $(this).closest('.infobox');
					var barColor = !$box.hasClass('infobox-dark') ? $box.css('color') : '#FFF';
					$(this).sparkline('html', {tagValuesAttribute:'data-values', type: 'bar', barColor: barColor , chartRangeMin:$(this).data('min') || 0} );
				});
				
			
				$('#tasks').sortable({
					opacity:0.8,
					revert:true,
					forceHelperSize:true,
					placeholder: 'draggable-placeholder',
					forcePlaceholderSize:true,
					tolerance:'pointer',
					stop: function( event, ui ) {//just for Chrome!!!! so that dropdowns on items don't appear below other items after being moved
						$(ui.item).css('z-index', 'auto');
					}
					}
				);
				$('#tasks').disableSelection();
				$('#tasks input:checkbox').removeAttr('checked').on('click', function(){
					if(this.checked) $(this).closest('li').addClass('selected');
					else $(this).closest('li').removeClass('selected');
				});
				
			
			})
		</script>
		
		<script type="text/javascript">

		function loadModule(title,url,target){
			//TODO addTab(title,url);
			    $("#mainTitle").text(title);
      			$("#center").attr("src",url);
      	}
		

	  	function logout(){
	  		bootbox.confirm("<t:mutiLang langKey="common.exit.confirm"/>", function(result) {
	  			if(result)
		  			location.href="loginController.do?logout";
	  		});
  		}
		function opendialog(title,url,target){
			//$("#dialog").attr("src",url);
			bootbox.dialog({
				message:$("#changestylePanel").html(),
				title:title,
				buttons:{
				OK:{
				label: "OK", 
				callback:function(){
					    var indexStyle = $('input[name="indexStyle"]:checked').val();
					    if(indexStyle==undefined||indexStyle==""){
					    	indexStyle = "ace";
					    }
					    var cssTheme = $('input[name="cssTheme"]:checked').val();
					    if(cssTheme==undefined){
					    	cssTheme = "";
					    }
						var form = $("#formobj");//取iframe里的form
						$.ajax({
		        			url:form.attr('action'),
		        			type:form.attr('method'),
		        			data:"indexStyle="+indexStyle,//+"&cssTheme="+cssTheme,
		        			success:function(data){
								var d = $.parseJSON(data);
								if (d.success) {
									var msg = d.msg;
									bootbox.alert(msg);
								}else{
									bootbox.alert(d.msg);
								}
		        			},
		        			error:function(e){
		        				bootbox.alert("出错了哦");
		        			}
						});
					}
			},Cancel: {label: "CLOSE", 
				callback:function() {
						//alert('close');//$("#dialog").dialog("close");
					}
				}
			}});
  			
  	}
		function changepass(title,url,target){
			//$("#dialog").attr("src",url);
			bootbox.dialog({
				message:'<form id="formobj2"  action="userController.do?savenewpwd" name="formobj2" method="post">'
					+$("#changepassword").html()+'</form>',
				title:title,
				buttons:{
				OK:{
				label: "OK", 
				callback:function(){
					//alert('not implement');
						$.ajax({
		        			url:"userController.do?savenewpwd",
		        			type:"post",
		        			data:$('#formobj2').serialize(),// 要提交的表单 ,
		        			success:function(data){
								var d = $.parseJSON(data);
								if (d.success) {
									var msg = d.msg;
									bootbox.alert(msg);
								}else{
									bootbox.alert(d.msg);
									}
		        			},
		        			error:function(e){
		        				bootbox.alert("出错了哦");
		        			}
						});
					}
			},Cancel: {label: "CLOSE", 
				callback:function() {
						alert('close');//$("#dialog").dialog("close");
					}
				}
			}});
  			
  	}
		function profile(title,url,target){
			//$("#dialog").attr("src",url);
			bootbox.dialog({
				message:'<iframe width="100%" height="300px" src="'+url+'" style="border:1px #fff solid; background:#CCC;"></iframe>',
				title:title,
				buttons:{
				OK:{
				label: "OK"},Cancel: {label: "CLOSE"
				}
			}});
  			
  	}

			function clearLocalstorage(){
				var storage=$.localStorage;
				if(!storage)
					storage=$.cookieStorage;
				storage.removeAll();
				//bootbox.alert( "浏览器缓存清除成功!");
				alertTipTop("浏览器缓存清除成功!","10%");
			}



	$(document).ready(function(){
		loadNotice();
		loadSms();
	});
	
	function loadNotice(){
		//加载公告
		var url = "noticeController.do?getNoticeList";
		jQuery.ajax({
    		url:url,
    		type:"GET",
    		dataType:"JSON",
    		async: false,
    		success:function(data){
    			//console.log(data);
    			if(data.success){
    				var noticeList = data.attributes.noticeList;
    				var noticeCount = noticeList.length;
    				//加载公告条数
    				if(noticeCount>99){
    					$("#noticeCount").html("99+");
    				}else{
    					$("#noticeCount").html(noticeCount);
    				}
    				//加载公告提示
    				var noticeTip = "";
    				noticeTip += "<i class='icon-warning-sign'></i>";
    				noticeTip += noticeCount+" "+data.attributes.tip;
    				$("#noticeTip").html(noticeTip);
    				
    				//加载公告条目
    				var noticeContent = "";
    				if(noticeList.length > 0){
    					for(var i=0;i<noticeList.length;i++){
    						noticeContent +="<li><a href='javascript:goNotice(&quot;"+noticeList[i].id+"&quot;)' ";
    						noticeContent +="style='word-break:keep-all;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;'>";
    						noticeContent +="<i class='btn btn-xs btn-primary fa fa-user'></i>";
    						noticeContent +="&nbsp;"+noticeList[i].noticeTitle + "</a></li></ul></li>";
        				}
    				}
    				//alert(noticeContent);
    				$("#noticeContent").html(noticeContent);
    				
    				//加载公告底部文字
    				var noticeSeeAll = data.attributes.seeAll +"<i class='ace-icon fa fa-arrow-right'></i>";
    				$("#noticeFooter").html(noticeSeeAll);
    			}
    		}
    	});
	}
	
	function loadSms(){
		//加载消息
		var url = "tSSmsController.do?getMessageList";
		$.ajax({
    		url:url,
    		type:"GET",
    		dataType:"JSON",
    		async: false,
    		success:function(data){
    			if(data.success){
    				var messageList = data.attributes.messageList;
    				var messageCount = data.obj;
    				//加载消息条数
    				if(messageCount>99){
    					$("#messageCount").html("99+");
    				}else{
    					$("#messageCount").html(messageCount);
    				}
    				//加载消息tip提示
    				var messageTip = "";
					messageTip += "<i class='ace-icon fa fa-envelope-o'></i>";
					messageTip += messageCount+" "+data.attributes.tip;
    				$("#messageTip").html(messageTip);
    				
    				//加载消息条目（有限）
    				var messageContent = "";
    				if(messageList.length > 0){
    					for(var i=0;i<messageList.length;i++){
    						messageContent +="<li><a href='javascript:goMessage(&quot;"+messageList[i].id+"&quot;)' class='clearfix'>";
    						messageContent +="<img src='plug-in/ace/avatars/avatar3.png' class='msg-photo' alt='Alex’s Avatar' />";
    						messageContent +="<span class='msg-body'><span class='msg-title'>";
    						messageContent +="<span class='blue'>"+messageList[i].esSender+":</span>";
    						messageContent += messageList[i].esTitle + "</span>";
    						messageContent +="<span class='msg-time'><i class='ace-icon fa fa-clock-o'></i><span>"+messageList[i].esSendtimeTxt+"</span></span>";
    						messageContent +="</span></a><input id='"+messageList[i].id+"_title' type='hidden' value='"+messageList[i].esTitle+"'>";
    						messageContent +="<input id='"+messageList[i].id+"_status' type='hidden' value='"+messageList[i].esStatus+"'>";
    						messageContent +="<input id='"+messageList[i].id+"_content' type='hidden' value='"+messageList[i].esContent+"'></li>";
        				}
    				}
    				$("#messageContent").html(messageContent);
    				
    				//加载消息底部文字
    				var messageSeeAll = data.attributes.seeAll +"<i class='ace-icon fa fa-arrow-right'></i>";
    				$("#messageFooter").html(messageSeeAll);
    			}
    		}
    	});
	}

    function goAllNotice(){
    	var addurl = "noticeController.do?noticeList";
  		createdetailwindow("公告", addurl, 800, 400);
    }

    function goNotice(id){
  		var addurl = "noticeController.do?goNotice&id="+id;
		createdetailwindow("通知公告详情", addurl, 750, 600);
		loadNotice();
    }
    
    function goAllMessage(){
    	var addurl = "tSSmsController.do?goMySmsList";
  		createdetailwindow("消息", addurl, 800, 400);
    }
    
    function goMessage(id){
    	var addurl = "tSSmsController.do?goSmsDetail&id="+id;
		createdetailwindow("通知详情", addurl, 750, 600);
		loadSms();
    }
    
    function readMessage(){
    	var msgId = $("#msgId").val();
  		  var url = "tSSmsController.do?readMessage";
  			$.ajax({
  	    		url:url,
  	    		type:"GET",
  	    		dataType:"JSON",
  	    		data:{
  	    			messageId:msgId
  	    		},
  	    		success:function(data){
  	    			if(data.success){
  	    				$("#msgStatus").html("已读");
  	    				$("#"+msgId+"_status").val('2');
  	    			}
  	    		}
  	    	});
    }

    //个人信息弹出层回缩
    function frameBodyClick(){ 
		$(".user-menu").parent().removeClass("open");
	}
    //新增iframe中绑定click事件回调父级函数
    function bindFrameClick(){
    	$("iframe").contents().find("body").attr("onclick", "parent.frameBodyClick()"); 
    }

		</script>
<script>
var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "https://hm.baidu.com/hm.js?098e6e84ab585bf0c2e6853604192b8b";
  var s = document.getElementsByTagName("script")[0]; 
  s.parentNode.insertBefore(hm, s);
})();
</script>
</body>
</html>

