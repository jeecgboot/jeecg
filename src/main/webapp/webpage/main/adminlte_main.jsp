<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	<meta name="keywords" content="JEECG 企业级快速开发平台">
    <meta name="description" content="JEECG 企业级快速开发平台，她采用强大代码生成，在线开发能力">
	<title><t:mutiLang langKey="jeect.platform"/></title>
	<!-- Bootstrap 3.3.7 -->
	<link rel="stylesheet" href="plug-in/themes/adminlte/css/bootstrap.min.css">
	<!-- Font Awesome -->
	<link rel="stylesheet" href="plug-in/themes/adminlte/css/font-awesome.min.css">
	<!-- Ionicons -->
	<link rel="stylesheet" href="plug-in/themes/adminlte/css/ionicons.min.css">
	<!-- Theme style -->
	<link rel="stylesheet" href="plug-in/themes/adminlte/css/AdminLTE.css">
	<!-- AdminLTE Skins -->
	<link rel="stylesheet" href="plug-in/themes/adminlte/css/_all-skins.min.css">
	<t:base type="jquery,tools"></t:base>
	<style type="text/css">
		.active #menuAdmin li {
			background: #338fde;
		}
		#menuAdmin a {
			cursor:pointer;
		}
	</style>
</head>
<body class="hold-transition skin-blue sidebar-mini fixed" style="overflow-y:hidden;">
<div class="wrapper">

  <header class="main-header">
    <!-- Logo -->
    <a href="#" class="logo">
      <span class="logo-mini"><b>A</b>LT</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><img alt="image" width="190" height="68" style="margin: -9px 0px 0px -16px;" src="plug-in/login/images/jeecg-aceplus.png" /></span>
    </a>
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
      <!-- Sidebar toggle button-->
	   <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>
      
	  <div class="collapse navbar-collapse pull-left" id="navbar-collapse">
          <ul class="nav navbar-nav" id="menuAdmin">
          	<t:menu style="adminlte" menuFun="${menuMap}"></t:menu>
          </ul>
          
        </div>
	   
      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
        	<!-- 系统公共选项 -->
        	<li class="dropdown notifications-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-cog fa-fw"></i>
              <span class="label label-warning">5</span>
            </a>
            <ul class="dropdown-menu">
              <li>
                <!-- inner menu: contains the actual data -->
                <ul class="menu">
                  <li>
                    <a href="javascript:createdetailwindow('<t:mutiLang langKey="common.ssms.getSysInfos"/>','tSSmsController.do?goMySmsList',800,400)" title="系统消息">
                      <i class="fa fa-users text-aqua"></i> 系统消息
                    </a>
                  </li>
                  <li>
                    <a href="javascript:window.open('http://yun.jeecg.org')" title="云应用中心">
                      <i class="fa fa-warning text-yellow"></i> 云应用中心
                    </a>
                  </li>
                  <li>
                    <a href="javascript:clearLocalstorage()">
                      <i class="fa fa-users text-red"></i> <t:mutiLang langKey="common.clear.localstorage"/>
                    </a>
                  </li>
                  <li><a href="javascript:toSwagger()"><i class="fa fa-users text-red"></i> SwaggerUI</a></li>
                  <li> 
					<a href="javascript:add('首页风格','userController.do?changestyle','',550,270)" title="换肤">
						<i class="fa fa-shopping-cart text-green"></i>风格切换
					</a>
				  </li> 
                </ul>
              </li>
            </ul>
          </li>
          <!-- Messages: style can be found in dropdown.less-->
          <li class="dropdown messages-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-envelope-o"></i>
              <span class="label label-success" id="messageCount">0</span>
            </a>
            <ul class="dropdown-menu">
              <li class="header"  id="messageTip">0条消息</li>
              <li>
                <!-- inner menu: contains the actual data -->
                <ul class="menu" id="messageContent">
                </ul>
              </li>
              <li class="footer">
              	<a href="javascript:goAllMessage();" id="messageFooter">
              		查看所有消息
              		<i class="icon-arrow-right"></i>
              	</a>
              </li>
            </ul>
          </li>
          
          <!-- Notifications: style can be found in dropdown.less -->
          <li class="dropdown notifications-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-bell-o"></i>
              <span class="label label-warning" id="noticeCount">0</span>
            </a>
            <ul class="dropdown-menu">
              <li class="header"  id="noticeTip">0条公告</li>
              <li>
                <!-- inner menu: contains the actual data -->
                <ul class="menu" id="noticeContent">
                  <li>
                    <a href="#" id="noticeContentLink">
                    </a>
                  </li>
                  
                </ul>
              </li>
              <li class="footer">
              	<a  href="javascript:goAllNotice();" id="noticeFooter">
              		查看全部
              		<i class="icon-arrow-right"></i>
              	</a>
              </li>
            </ul>
          </li>
          <!-- Tasks: style can be found in dropdown.less -->
          <!-- <li class="dropdown tasks-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-flag-o"></i>
              <span class="label label-danger">9</span>
            </a>
            <ul class="dropdown-menu">
              <li class="header">You have 9 tasks</li>
              <li>
                inner menu: contains the actual data
                <ul class="menu">
                  <li>Task item
                    <a href="#">
                      <h3>
                        Design some buttons
                        <small class="pull-right">20%</small>
                      </h3>
                      <div class="progress xs">
                        <div class="progress-bar progress-bar-aqua" style="width: 20%" role="progressbar"
                             aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                          <span class="sr-only">20% Complete</span>
                        </div>
                      </div>
                    </a>
                  </li>
                  end task item
                  <li>Task item
                    <a href="#">
                      <h3>
                        Create a nice theme
                        <small class="pull-right">40%</small>
                      </h3>
                      <div class="progress xs">
                        <div class="progress-bar progress-bar-green" style="width: 40%" role="progressbar"
                             aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                          <span class="sr-only">40% Complete</span>
                        </div>
                      </div>
                    </a>
                  </li>
                  end task item
                  <li>Task item
                    <a href="#">
                      <h3>
                        Some task I need to do
                        <small class="pull-right">60%</small>
                      </h3>
                      <div class="progress xs">
                        <div class="progress-bar progress-bar-red" style="width: 60%" role="progressbar"
                             aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                          <span class="sr-only">60% Complete</span>
                        </div>
                      </div>
                    </a>
                  </li>
                  end task item
                  <li>Task item
                    <a href="#">
                      <h3>
                        Make beautiful transitions
                        <small class="pull-right">80%</small>
                      </h3>
                      <div class="progress xs">
                        <div class="progress-bar progress-bar-yellow" style="width: 80%" role="progressbar"
                             aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                          <span class="sr-only">80% Complete</span>
                        </div>
                      </div>
                    </a>
                  </li>
                  end task item
                </ul>
              </li>
              <li class="footer">
                <a href="#">View all tasks</a>
              </li>
            </ul>
          </li> -->

          <!-- User Account: style can be found in dropdown.less -->
          <li class="dropdown user user-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <img src="plug-in/themes/fineui/common/image/head.jpg" class="user-image" alt="User Image">
              <span class="hidden-xs">${userName}</span>
            </a>
            <ul class="dropdown-menu">
              <!-- User image -->
              <li class="user-header" style="height:175px;">
                <img src="plug-in/themes/fineui/common/image/head.jpg" class="img-circle" alt="User Image">
               	<p style="color: #ffffff;font-size:14px">
                <span><t:mutiLang langKey="common.user"/>:</span>
                <span>${userName }</span><br />
                <span><t:mutiLang langKey="current.org"/>:</span>
                <span>${currentOrgName }</span><br />
                <span><t:mutiLang langKey="common.role"/>:</span>
                <span>${roleName }</span>
                </p>
              </li>
              <!-- Menu Body -->
              <li class="user-body">
                <div class="row">
                  <div class="col-xs-4 text-center">
                    <a href="javascript:openwindow('个人信息','userController.do?userinfo')">个人信息</a>
                  </div>
                  <div class="col-xs-4 text-center">
                    <a href="javascript:add('<t:mutiLang langKey="common.change.password"/>','userController.do?changepassword','',550,200)">修改密码</a>
                  </div>
                  <div class="col-xs-4 text-center">
                  	<a href="javascript:logout()" >退出</a>
                  </div>
                </div>
                <!-- /.row -->
              </li>
              <!-- Menu Footer-->
              <!-- <li class="user-footer">
                <div class="pull-right">
                  <a href="javascript:logout()" class="btn btn-default btn-flat">退出</a>
                </div>
              </li> -->
            </ul>
          </li>
          <!-- Control Sidebar Toggle Button -->
          <!-- <li>
            <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
          </li> -->
        </ul>
      </div>
    </nav>
  </header>
  <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <!-- Sidebar user panel -->
      <!-- search form -->
      <!-- /.search form -->
      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu">
        
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper" id="content-wrapper" style="min-height: 600px;">
        <!--bootstrap tab风格 多标签页-->
        <div class="content-tabs">
            <button class="roll-nav roll-left tabLeft" onclick="scrollTabLeft()">
                <i class="fa fa-backward"></i>
            </button>
            <nav class="page-tabs menuTabs tab-ui-menu" id="tab-menu">
                <div class="page-tabs-content" style="margin-left: 0px;">

                </div>
            </nav>
            <button class="roll-nav roll-right tabRight" onclick="scrollTabRight()">
                <i class="fa fa-forward" style="margin-left: 3px;"></i>
            </button>
            <div class="btn-group roll-nav roll-right">
                <button class="dropdown tabClose" data-toggle="dropdown">
                    页签操作<i class="fa fa-caret-down" style="padding-left: 3px;"></i>
                </button>
                <ul class="dropdown-menu dropdown-menu-right" style="min-width: 128px;">
                    <li><a class="tabReload" href="javascript:refreshTab();">刷新当前</a></li>
                    <li><a class="tabCloseCurrent" href="javascript:closeCurrentTab();">关闭当前</a></li>
                    <li><a class="tabCloseAll" href="javascript:closeOtherTabs(true);">全部关闭</a></li>
                    <li><a class="tabCloseOther" href="javascript:closeOtherTabs();">除此之外全部关闭</a></li>
                </ul>
            </div>
            <button class="roll-nav roll-right fullscreen" onclick="App.handleFullScreen()"><i
                    class="fa fa-arrows-alt"></i></button>
        </div>
        <div class="content-iframe " style="background-color: #ffffff; ">
            <div class="tab-content " id="tab-content">

            </div>
        </div>
    </div>
    <!-- /.content-wrapper -->
  <footer class="main-footer">
    <div class="pull-right hidden-xs">
      <b>Version</b> <t:mutiLang langKey="system.version.number"/>
    </div>
    <t:mutiLang langKey="common.copyright"/>
    <a href="http://www.jeecg.org" title="JEECG Framework  <t:mutiLang langKey="system.version.number"/>">JEECG Framework  <t:mutiLang langKey="system.version.number"/></a>
           (推荐谷歌浏览器，获得更快响应速度) 技术支持:
           <a href="#" title="JEECG Framework  <t:mutiLang langKey="system.version.number"/>">JEECG Framework  <t:mutiLang langKey="system.version.number"/></a>
  </footer>

  <!-- Control Sidebar -->
  <aside id="control-sidebar" class="control-sidebar control-sidebar-dark">
    
  </aside>
  <!-- /.control-sidebar -->
  <!-- Add the sidebar's background. This div must be placed
       immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->
<!-- jQuery 3 -->
<script src="plug-in/jquery/jquery-1.9.1.js"></script>
<script src="plug-in/jquery-plugs/i18n/jquery.i18n.properties.js"></script>
<script src="plug-in/lhgDialog/lhgdialog.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="plug-in/themes/adminlte/js/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 3.3.7 -->
<script src="plug-in/themes/adminlte/js/bootstrap.min.js"></script>
<!-- Slimscroll -->
<script src="plug-in/themes/adminlte/js/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="plug-in/themes/adminlte/js/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="plug-in/themes/adminlte/js/adminlte.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="plug-in/themes/adminlte/js/demo.js"></script>
<!-- AdminLTE App -->
<script src="plug-in/themes/adminlte/js/app.js"></script>

<!--tabs-->
<script src="plug-in/themes/adminlte/js/app_iframe.js"></script>
<script src="plug-in/jquery-plugs/storage/jquery.storageapi.min.js"></script>
<script type="text/javascript">

	//i18n前段国际化
	initI18nConfig();
	
    /**
     * 本地搜索菜单
     */
    function search_menu() {
        //要搜索的值
        var text = $('input[name=q]').val();

        var $ul = $('.sidebar-menu');
        $ul.find("a.nav-link").each(function () {
            var $a = $(this).css("border", "");

            //判断是否含有要搜索的字符串
            if ($a.children("span.menu-text").text().indexOf(text) >= 0) {

                //如果a标签的父级是隐藏的就展开
                $ul = $a.parents("ul");

                if ($ul.is(":hidden")) {
                    $a.parents("ul").prev().click();
                }

                //点击该菜单
                $a.click().css("border", "1px solid");
            }
        });
    }
    
    $(function () {
    	$("#menuAdmin li").eq(0).find('a').click();
        App.setbasePath("<%=basePath%>/");
        App.setGlobalImgPath("plug-in/themes/adminlte/images/");

        addTabs({
            id: '10008',
            title: '首页',
            close: false,
            url: 'loginController.do?adminlteHome',
            urlType: "relative"
        });
        
        App.fixIframeCotent();
        
        loadSms();
        loadNotice();
    });
    
    function logout(){
		location.href="loginController.do?logout";
	}
    
    //SwaggerUI
    function toSwagger(){
    	window.open("swagger/index.html","_blank");
    }
    
    //点击主菜单后触发左侧菜单
    function onSelectTree(functionId) {
    	$.ajax({
       		type: "POST",
        	url: "loginController.do?getPrimaryMenuForAdminlte",
        	data: {
        		functionId : functionId
        	},
        	success: function(data){
        		var d = JSON.parse(data);
        		var menus = d.obj;
        		$('.sidebar-menu').html("");
        		$('.sidebar-menu').sidebarMenu({data: menus});
          	}
         }); 
    }
    
    //主菜单颜色变化
    $('#menuAdmin').on('click', 'li', function(e){
    	$(this).addClass("active").siblings().removeClass("active");
    });
    
    //清除缓存
    function clearLocalstorage(){
        var storage=$.localStorage;
        if(!storage)
            storage=$.cookieStorage;
        storage.removeAll();
        layer.msg("浏览器缓存清除成功!");
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
    						messageContent +="&nbsp;&nbsp;<span class='msg-time'><i class='ace-icon fa fa-clock-o'></i><span>"+messageList[i].esSendtimeTxt+"</span></span>";
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
    
    function loadNotice(){
		//加载公告
		var url = "noticeController.do?getNoticeList";
		jQuery.ajax({
    		url:url,
    		type:"GET",
    		dataType:"JSON",
    		async: false,
    		success:function(data){
    			if(data.success){
    				//<!--update--begin--author:zhangjiaqiang date:20170314 for: 修订公告信息显示异常 -->
    				var noticeList = data.attributes.noticeList;
    				var noticeCount = noticeList.length;
    				//<!--update--begin--author:zhangjiaqiang date:20170314 for: 修订公告信息显示异常 -->
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
    				$("#noticeContent").html(noticeContent);
    				
    				//加载公告底部文字
    				var noticeSeeAll = data.attributes.seeAll +"<i class='ace-icon fa fa-arrow-right'></i>";
    				$("#noticeFooter").html(noticeSeeAll);
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
    
    
</script>
</body>
</html>
