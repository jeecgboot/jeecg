<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta charset="utf-8" />
    <title><t:mutiLang langKey="jeect.platform"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
    <link rel="stylesheet" href="plug-in/jquery/jquery.contextmenu.css"/>
    <!-- bootstrap & fontawesome -->
    <link rel="stylesheet" href="plug-in/ace/css/bootstrap.css" />
    <link rel="stylesheet" href="plug-in/ace/css/font-awesome.css" />
    <link rel="stylesheet" type="text/css" href="plug-in/accordion/css/accordion.css">
    <!-- text fonts -->
    <link rel="stylesheet" href="plug-in/ace/css/ace-fonts.css" />

    <%--<link rel="stylesheet" href="plug-in/ace/css/jquery-ui.css" />--%>
    <!-- ace styles -->
    <link rel="stylesheet" href="plug-in/ace/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />

    <!--[if lte IE 9]>
    <link rel="stylesheet" href="plug-in/ace/css/ace-part2.css" class="ace-main-stylesheet" />
    <![endif]-->

    <!--[if lte IE 9]>
    <link rel="stylesheet" href="plug-in/ace/css/ace-ie.css" />
    <![endif]-->
    <!-- ace settings handler -->
    <script src="plug-in/ace/js/ace-extra.js"></script>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

    <!--[if lte IE 8]>
    <script src="plug-in/ace/js/html5shiv.js"></script>
    <script src="plug-in/ace/js/respond.js"></script>
    <![endif]-->
    <style>
        .shortcut{
            margin-left: 5px;
            margin-right: 15px;
            margin-top: 8px;
            height: 62px;
            float: right;
        }
        .shortcut li{
            float: left;
            list-style: none;
            margin-right: 10px;
            cursor: pointer;
        }
        i[class='fa fa-times']{
            margin-left:2px;
            margin-right: -6px;
            cursor: pointer;
        }
        .ace-nav > li.light-blue > a{
            background-color:#438EB9;
        }
    </style>
</head>

<body class="no-skin">
<!-- #section:basics/navbar.layout -->
<div id="navbar" class="navbar navbar-default">
    <script type="text/javascript">
        try{ace.settings.check('navbar' , 'fixed')}catch(e){}
    </script>

    <div class="navbar-container" id="navbar-container">
        <%--<img src="plug-in/pdmis/images/head.jpg" alt="">--%>
        <!-- #section:basics/sidebar.mobile.toggle -->
        <button type="button" class="navbar-toggle menu-toggler pull-left" id="menu-toggler" data-target="#sidebar">
            <span class="sr-only">Toggle sidebar</span>

            <span class="icon-bar"></span>

            <span class="icon-bar"></span>

            <span class="icon-bar"></span>
        </button>

        <!-- /section:basics/sidebar.mobile.toggle -->
        <div class="navbar-header pull-left" style="margin-top: 10px;">
            <!-- #section:basics/navbar.layout.brand -->
            <a href="#" class="navbar-brand">
                <small>
                    <!-- <i class="fa fa-leaf"></i> -->
                    <t:mutiLang langKey="jeect.platform"/>
                </small>
            </a>
            <!-- /section:basics/navbar.layout.brand -->

            <!-- #section:basics/navbar.toggle -->

            <!-- /section:basics/navbar.toggle -->
        </div>

        <!-- #section:basics/navbar.dropdown -->
        <div class="navbar-buttons navbar-header pull-right" role="navigation">
            <ul class="nav ace-nav">
                <!-- #section:basics/navbar.user_menu -->
                <li class="light-blue" style="margin-top: 16px;">
                    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                        <%--<img class="nav-user-photo" src="plug-in/ace/avatars/user.jpg" alt="Jason's Photo" />--%>
								<span class="user-info">
									<small style="color:#D50001;">欢迎,${userName }</small>
									<span style="color: #CC33FF">
                    <span style="color: #000000"><t:mutiLang langKey="common.role"/>:</span>
                    <span style="color: #000000">${roleName }</span>
								</span>

								<i class="ace-icon fa fa-caret-down"></i>
                    </a>

                    <ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
                        <li>
                            <a href="javascript:add('<t:mutiLang langKey="common.change.password"/>','userController.do?changepassword','',550,200)">
                                <i class="ace-icon fa fa-cog"></i>
                                <t:mutiLang langKey="common.change.password"/>
                            </a>
                        </li>

                        <li>
                            <a href="javascript:openwindow('<t:mutiLang langKey="common.profile"/>','userController.do?userinfo')">
                                <i class="ace-icon fa fa-user"></i>
                                <t:mutiLang langKey="common.profile"/>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:openwindow('<t:mutiLang langKey="common.ssms.getSysInfos"/>','tSSmsController.do?getSysInfos')">
                                <i class="ace-icon fa fa-user"></i>
                                <t:mutiLang langKey="common.ssms.getSysInfos"/>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:add('<t:mutiLang langKey="common.change.style"/>','userController.do?changestyle','',550,200)">
                                <i class="ace-icon fa fa-user"></i>
                                <t:mutiLang langKey="common.my.style"/>
                            </a>
                        </li>

                        <li>
                            <a href="javascript:clearLocalstorage()">
                                <i class="ace-icon fa fa-warning"></i>
                                <t:mutiLang langKey="common.clear.localstorage"/>
                            </a>
                        </li>

                        <li class="divider"></li>

                        <li>
                            <a href="javascript:logout()">
                                <i class="ace-icon fa fa-power-off"></i>
                                <t:mutiLang langKey="common.logout"/>
                            </a>
                        </li>
                    </ul>
                </li>

                <!-- /section:basics/navbar.user_menu -->
            </ul>
        </div>
        <div>
            <tr style="height: 80px;">
                <td colspan="2">
                    <ul class="shortcut">
                        <!-- 动态生成并赋值过来 -->
                    </ul>
                </td>
            </tr>
        </div>
        <!-- /section:basics/navbar.dropdown -->
    </div><!-- /.navbar-container -->
</div>

<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
    <script type="text/javascript">
        try{ace.settings.check('main-container' , 'fixed')}catch(e){}
    </script>

    <!-- #section:basics/sidebar -->
    <div id="sidebar" class="sidebar                  responsive">
        <script type="text/javascript">
            try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
        </script>

        <%--<div class="sidebar-shortcuts" id="sidebar-shortcuts">
			<div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
				<button class="btn btn-success">
					<i class="ace-icon fa fa-signal"></i>
				</button>

				<button class="btn btn-info">
					<i class="ace-icon fa fa-pencil"></i>
				</button>

				<!-- #section:basics/sidebar.layout.shortcuts -->
				<button class="btn btn-warning">
					<i class="ace-icon fa fa-users"></i>
				</button>

				<button class="btn btn-danger">
					<i class="ace-icon fa fa-cogs"></i>
				</button>

				<!-- /section:basics/sidebar.layout.shortcuts -->
			</div>

			<div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
				<span class="btn btn-success"></span>

				<span class="btn btn-info"></span>

				<span class="btn btn-warning"></span>

				<span class="btn btn-danger"></span>
			</div>
		</div>--%><!-- /.sidebar-shortcuts -->

        <ul class="nav nav-list">
            <li class="">
                <a  href="javascript:loadModule('首页','loginController.do?home')">
                    <i class="menu-icon fa fa-home"></i>
                    <span class="menu-text"> 首页 </span>
                </a>

                <b class="arrow"></b>
            </li>
            <t:menu style="diy" menuFun="${menuMap}"></t:menu>
        </ul><!-- /.nav-list -->

        <!-- #section:basics/sidebar.layout.minimize -->
        <div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
            <i class="ace-icon fa fa-angle-double-left" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
        </div>

        <!-- /section:basics/sidebar.layout.minimize -->
        <script type="text/javascript">
            try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
        </script>
    </div>
    <div class="main-content" >
        <!-- /section:basics/sidebar -->
        <!-- #section:basics/content.breadcrumbs -->
        <div class="breadcrumbs" id="breadcrumbs" style="display:none">
            <script type="text/javascript">
                try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
            </script>

            <ul class="breadcrumb">
                <li>
                    <i class="ace-icon fa fa-home home-icon"></i>
                    <a href="#">首页</a>
                </li>
            </ul><!-- /.breadcrumb -->

            <!-- #section:basics/content.searchbox -->
            <div class="nav-search" id="nav-search">
                <form class="form-search">
							<span class="input-icon">
								<input type="text" placeholder="Search ..." class="nav-search-input" id="nav-search-input" autocomplete="off" />
								<i class="ace-icon fa fa-search nav-search-icon"></i>
							</span>
                </form>
            </div><!-- /.nav-search -->

            <!-- /section:basics/content.searchbox -->
        </div>

        <!-- /section:basics/content.breadcrumbs -->
        <div class="page-content" style="padding:0px" >
            <!-- #section:settings.box -->
            <%--<div class="ace-settings-container" id="ace-settings-container">
				<div class="btn btn-app btn-xs btn-warning ace-settings-btn" id="ace-settings-btn">
					<i class="ace-icon fa fa-cog bigger-130"></i>
				</div>

				<div class="ace-settings-box clearfix" id="ace-settings-box">
					<div class="pull-left width-50">
						<!-- #section:settings.skins -->
						<div class="ace-settings-item">
							<div class="pull-left">
								<select id="skin-colorpicker" class="hide">
									<option data-skin="no-skin" value="#438EB9">#438EB9</option>
									<option data-skin="skin-1" value="#222A2D">#222A2D</option>
									<option data-skin="skin-2" value="#C6487E">#C6487E</option>
									<option data-skin="skin-3" value="#D0D0D0">#D0D0D0</option>
								</select>
							</div>
							<span>&nbsp; Choose Skin</span>
						</div>

						<!-- /section:settings.skins -->

						<!-- #section:settings.navbar -->
						<div class="ace-settings-item">
							<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-navbar" />
							<label class="lbl" for="ace-settings-navbar"> Fixed Navbar</label>
						</div>

						<!-- /section:settings.navbar -->

						<!-- #section:settings.sidebar -->
						<div class="ace-settings-item">
							<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-sidebar" />
							<label class="lbl" for="ace-settings-sidebar"> Fixed Sidebar</label>
						</div>
fa fa-times
						<!-- /section:settings.sidebar -->

						<!-- #section:settings.breadcrumbs -->
						<div class="ace-settings-item">
							<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-breadcrumbs" />
							<label class="lbl" for="ace-settings-breadcrumbs"> Fixed Breadcrumbs</label>
						</div>

						<!-- /section:settings.breadcrumbs -->

						<!-- #section:settings.rtl -->
						<div class="ace-settings-item">
							<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-rtl" />
							<label class="lbl" for="ace-settings-rtl"> Right To Left (rtl)</label>
						</div>

						<!-- /section:settings.rtl -->

						<!-- #section:settings.container -->
						<div class="ace-settings-item">
							<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-add-container" />
							<label class="lbl" for="ace-settings-add-container">
								Inside
								<b>.container</b>
							</label>
						</div>

						<!-- /section:settings.container -->
					</div><!-- /.pull-left -->

					<div class="pull-left width-50">
						<!-- #section:basics/sidebar.options -->
						<div class="ace-settings-item">
							<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-hover" />
							<label class="lbl" for="ace-settings-hover"> Submenu on Hover</label>
						</div>

						<div class="ace-settings-item">
							<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-compact" />
							<label class="lbl" for="ace-settings-compact"> Compact Sidebar</label>
						</div>

						<div class="ace-settings-item">
							<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-highlight" />
							<label class="lbl" for="ace-settings-highlight"> Alt. Active Item</label>
						</div>

						<!-- /section:basics/sidebar.options -->
					</div><!-- /.pull-left -->
				</div><!-- /.ace-settings-box -->
			</div>--%><!-- /.ace-settings-container -->

            <!-- /section:settings.box -->
            <div class="page-content-area" data-ajax-content="false"  >
                <div id="tabs">
                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs" role="tablist" style="height: 35px;">
                        <li role="presentation" class="active"><a href="#tabs-1" aria-controls="tabs-1" role="tab" data-toggle="tab">首页<i class="fa fa-times"></i></a></li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div id="tabs-1" style="padding:0px" role="tabpanel" class="tab-pane active">
                            <iframe style="width:100%;height:700px;margin:0px;padding:0px" scrolling="auto" frameborder="0" id="center"  src="loginController.do?home" ></iframe>
                        </div>
                    </div>
                </div>
            </div>
            <%--<div class="bs-example bs-example-tabs" data-example-id="togglable-tabs">
                <ul id="myTabs" class="nav nav-tabs" role="tablist" style="height: 35px;">
                    <li role="presentation" class="active"><a href="#home" id="home-tab" role="tab" data-toggle="tab" aria-controls="home" aria-expanded="true">Home</a></li>
                    <li role="presentation" class=""><a href="#profile" role="tab" id="profile-tab" data-toggle="tab" aria-controls="profile" aria-expanded="false">Profile</a></li>
                    <li role="presentation" class="dropdown">
                        <a href="#" id="myTabDrop1" class="dropdown-toggle" data-toggle="dropdown" aria-controls="myTabDrop1-contents">Dropdown <span class="caret"></span></a>
                        <ul class="dropdown-menu" aria-labelledby="myTabDrop1" id="myTabDrop1-contents">
                            <li><a href="#dropdown1" role="tab" id="dropdown1-tab" data-toggle="tab" aria-controls="dropdown1">@fat</a></li>
                            <li><a href="#dropdown2" role="tab" id="dropdown2-tab" data-toggle="tab" aria-controls="dropdown2">@mdo</a></li>
                        </ul>
                    </li>
                </ul>
                <div id="myTabContent" class="tab-content">
                    <div role="tabpanel" class="tab-pane active in" id="home" aria-labelledby="home-tab">
                        <p>Raw denim you probably haven't heard of them jean shorts Austin. Nesciunt tofu stumptown aliqua, retro synth master cleanse. Mustache cliche tempor, williamsburg carles vegan helvetica. Reprehenderit butcher retro keffiyeh dreamcatcher synth. Cosby sweater eu banh mi, qui irure terry richardson ex squid. Aliquip placeat salvia cillum iphone. Seitan aliquip quis cardigan american apparel, butcher voluptate nisi qui.</p>
                    </div>
                    <div role="tabpanel" class="tab-pane" id="profile" aria-labelledby="profile-tab">
                        <p>Food truck fixie locavore, accusamus mcsweeney's marfa nulla single-origin coffee squid. Exercitation +1 labore velit, blog sartorial PBR leggings next level wes anderson artisan four loko farm-to-table craft beer twee. Qui photo booth letterpress, commodo enim craft beer mlkshk aliquip jean shorts ullamco ad vinyl cillum PBR. Homo nostrud organic, assumenda labore aesthetic magna delectus mollit. Keytar helvetica VHS salvia yr, vero magna velit sapiente labore stumptown. Vegan fanny pack odio cillum wes anderson 8-bit, sustainable jean shorts beard ut DIY ethical culpa terry richardson biodiesel. Art party scenester stumptown, tumblr butcher vero sint qui sapiente accusamus tattooed echo park.</p>
                    </div>
                    <div role="tabpanel" class="tab-pane fade" id="dropdown1" aria-labelledby="dropdown1-tab">
                        <p>Etsy mixtape wayfarers, ethical wes anderson tofu before they sold out mcsweeney's organic lomo retro fanny pack lo-fi farm-to-table readymade. Messenger bag gentrify pitchfork tattooed craft beer, iphone skateboard locavore carles etsy salvia banksy hoodie helvetica. DIY synth PBR banksy irony. Leggings gentrify squid 8-bit cred pitchfork. Williamsburg banh mi whatever gluten-free, carles pitchfork biodiesel fixie etsy retro mlkshk vice blog. Scenester cred you probably haven't heard of them, vinyl craft beer blog stumptown. Pitchfork sustainable tofu synth chambray yr.</p>
                    </div>
                    <div role="tabpanel" class="tab-pane fade" id="dropdown2" aria-labelledby="dropdown2-tab">
                        <p>Trust fund seitan letterpress, keytar raw denim keffiyeh etsy art party before they sold out master cleanse gluten-free squid scenester freegan cosby sweater. Fanny pack portland seitan DIY, art party locavore wolf cliche high life echo park Austin. Cred vinyl keffiyeh DIY salvia PBR, banh mi before they sold out farm-to-table VHS viral locavore cosby sweater. Lomo wolf viral, mustache readymade thundercats keffiyeh craft beer marfa ethical. Wolf salvia freegan, sartorial keffiyeh echo park vegan.</p>
                    </div>
                </div>
            </div>--%>
        </div>
    </div>


    <div class="footer">
        <div class="footer-inner">
            <!-- #section:basics/footer -->
            <div class="footer-content">
						<span class="bigger-120">
							<span class="blue bolder">JEECG</span>
							 Application &copy; <t:mutiLang langKey="system.version.number"/>
						</span>

                &nbsp; &nbsp;
						<span class="action-buttons">
							<a href="#">
                                <i class="ace-icon fa fa-twitter-square light-blue bigger-150"></i>
                            </a>

							<a href="#">
                                <i class="ace-icon fa fa-facebook-square text-primary bigger-150"></i>
                            </a>

							<a href="#">
                                <i class="ace-icon fa fa-rss-square orange bigger-150"></i>
                            </a>
						</span>
            </div>

            <!-- /section:basics/footer -->
        </div>
    </div>

    <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
        <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
    </a>
</div><!-- /.main-container -->
<!-- basic scripts -->

<!--[if !IE]> -->
<script type="text/javascript">
    window.jQuery || document.write("<script src='plug-in/ace/js/jquery.js'>"+"<"+"/script>");
</script>

<!-- <![endif]-->
<div id="changestylePanel" style="display:none" ><form id="formobj"  action="userController.do?savestyle" name="formobj" method="post">
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
        <!-- update-end--Author:longjb  Date:2013-03-15 for:新增首页风格  -->
        <tr>
            <td class="value"><input type="radio" value="ace" name="indexStyle"  /><span>ACE平面风格</span></td>
        </tr>
    </table></form>
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
<!--[if IE]>
<script type="text/javascript">
    window.jQuery || document.write("<script src='plug-in/ace/js/jquery1x.js'>"+"<"+"/script>");
</script>
<![endif]-->
<script type="text/javascript">


    if('ontouchstart' in document.documentElement) document.write("<script src='plug-in/ace/js/jquery.mobile.custom.js'>"+"<"+"/script>");

    function loadModule(title,url,target){

        var tabs = $("#tabs");
        //TODO addTab(title,url);
        //判断当前选中的菜单tab中是否已经打开，如果已经打开，就直接跳转到那页，如果没有打开，则在最后打开
        var flag = 0;
        $("#tabs>ul>li>a").each(function(){
            if(title.trim()==$(this).text().trim()){
                var existing = tabs.find("[id='" + $(this).attr("id") + "']");
                existing.tab('show');
                flag=1;
                //激活当前tab
                //tabs.tabs("refresh");
                /*var existing = tabs.find("[aria-labelledby='" + $(this).attr("id") + "']");
                 var index = tabs.find(".ui-tabs-nav li").index(existing);//不知道哪里脑残了，为什么index总是-1?
                 tabs.tabs("option", "active", index);
                 flag = 1;*/
            }
        })
        if(flag==0){
            //得到count的方式要改成得到最后那个tab的计数+1，因为删除后会出问题的
            var id = $("#tabs>div>div:last").attr("id");
            var index = null;
            var nowcount = null;
            if(id==null){
                var ids="tabs-0";
                index = ids.indexOf("-");
                nowcount = ids.substr(index+1,ids.length);
            }else{
                index = id.indexOf("-");
                nowcount = id.substr(index+1,id.length);
            }
            var count = parseInt(nowcount) + 1;
            var tab = "tabs-"+count;
            var maintitle = "mainTitle"+count;
            //var li = "<li><a href='#"+tab+"' id='"+maintitle+"'>"+title+"</a></li>";
            var li = "<li role='presentation' class='active'><a href='#"+tab+"' id='"+tab+"-tab' role='tab' data-toggle='tab' aria-controls='"+tab+"' aria-expanded='true'>"+title+"<i class='fa fa-times'></i></a></li>";
            var div = "<div role='tabpanel' class='tab-pane active in' id='"+tab+"' aria-labelledby='"+tab+"-tab'><iframe style='width:100%;height:700px;margin:0px;padding:0px' scrolling='auto' frameborder='0' id='center1' src='"+url+"'></iframe></div>";
            $("#tabs>ul>li").removeClass("active");
            $("#tabs>div>div").removeClass("active");
            if(id==null){
                $("#tabs>ul").append(li);
                $("#tabs>div").append(div);
            }else{
                $("#tabs>ul>li:last").after(li);
                $("#tabs>div>div:last").after(div);
            }
            $('#tabs>ul>li:last>a').tab('show');
            //tabs.tabs("refresh");
            //tabs.tabs("enable","#"+tab);
            /*var existing = tabs.find("[id='" + tab + "']");
             var index = tabs.find(".ui-tabs-nav li").index(existing);//不知道哪里脑残了，为什么index总是-1?
             tabs.tabs("option", "active", index);*/

            var last = $("#tabs>ul>li:last");
            /*$(".contextMenuPlugin").mouseout(function(){
             $(".contextMenuPlugin").remove();
             })
             $(".contextMenuPlugin").mouseup(function(){
             alert("aaa");
             })*/
            last.contextPopup({
                title: '菜单',
                items: [
                    {
                        label:'刷新缓存',icon:'plug-in/diy/icons/shopping-basket.png',action:function(){
                        //last就是当前选中的元素
                        var tab = last.children("a").attr("aria-controls").toString();
                        //$("#tabs").find("li[aria-controls='"+tab+"']").remove();
                        var div = $("#tabs").find("div[id='"+tab+"']");
                        div.find("iframe").attr("src",url);
                        //tabs.tabs("refresh");
                    }
                    },
                    {
                        label:'关闭',icon:'plug-in/diy/icons/shopping-basket.png',action:function(){
                        //last就是当前选中的元素
                        var closeText = last.children("a").text().trim();
                        var nowText = $("#tabs").find("li[class='active']").children("a").text().trim();
                        if(closeText==nowText){
                            //关闭的是当前页的时候，显示前一页，如果没有前一页了，就提示
                            var prevCount = last.prevAll().size();
                            if(prevCount==0){
                                var tab = last.children("a").attr("aria-controls").toString();
                                last.remove();
                                $("#tabs").find("div[id='"+tab+"']").remove();
                            }else{
                                //显示前一个tab
                                var tab = last.children("a").attr("aria-controls").toString();
                                var prev = last.prevAll().first();
                                last.remove();
                                $("#tabs").find("div[id='"+tab+"']").remove();
                                prev.addClass("active");
                                var id = prev.children("a").attr("aria-controls").toString();
                                $("#tabs").find("div[id='"+id+"']").addClass("active");
                            }
                        }else{
                            //关闭的不是当前页，关闭就好了╮(╯_╰)╭
                            var tab = last.children("a").attr("aria-controls").toString();
                            last.remove();
                            $("#tabs").find("div[id='"+tab+"']").remove();
                        }
                    }
                    },
                    {
                        label:'全部关闭',icon:'plug-in/diy/icons/shopping-basket.png',action:function(){
                        $("#tabs>ul>li").remove();
                        $("#tabs>div>div").remove();
                        //tabs.tabs("refresh");
                    }
                    },
                    {
                        label:'除此之外全部关闭',icon:'plug-in/diy/icons/shopping-basket.png',action:function(){
                        var closeText = last.children("a").text().trim();
                        var nowText = $("#tabs").find("li[class='active']").children("a").text().trim();
                        //此是当前页则关闭，如果不是当前页面，要激活选择页面
                        if(closeText==nowText){
                            //此是当前页面
                            var tab = last.children("a").attr("aria-controls").toString();
                            $("#tabs>ul>li").not(last).remove();
                            $("#tabs>div>div").not($("#tabs").find("div[id='"+tab+"']")).remove();
                        }else{
                            var tab = last.children("a").attr("aria-controls").toString();
                            $("#tabs>ul>li").not(last).remove();
                            $("#tabs>div>div").not($("#tabs").find("div[id='"+tab+"']")).remove();
                            last.addClass("active");
                            var id = last.children("a").attr("aria-controls").toString();
                            $("#tabs").find("div[id='"+id+"']").addClass("active");
                        }
                        //tabs.tabs("refresh");
                    }
                    },
                    null,
                    {
                        label:'当前页右侧全部关闭',icon:'plug-in/diy/icons/shopping-basket.png',action:function(){
                        var closeText = last.children("a").text().trim();
                        var nowText = $("#tabs").find("li[class='active']").children("a").text().trim();
                        if(closeText==nowText){
                            //当前页面
                            var nextAll = last.nextAll();
                            if(nextAll.length!=0){
                                nextAll.remove();
                                var tab = last.children("a").attr("aria-controls").toString();
                                //$("#tabs>ul>li").not(shouye).remove();
                                $("#tabs>div").find("div[id='"+tab+"']").nextAll().remove();
                                //tabs.tabs("refresh");
                            }else{
                                layer.msg('<b>右侧没有啦</b>');
                            }
                        }else{
                            //不是当前页，当前页的active去掉
                            var now = $("#tabs").find("li[class='active']");
                            var nowid = now.children("a").attr("aria-controls").toString();
                            now.removeClass("active");
                            $("#tabs").find("div[id='"+nowid+"']").removeClass("active");
                            var nextAll = last.nextAll();
                            if(nextAll.length!=0){
                                nextAll.remove();
                                var tab = last.children("a").attr("aria-controls").toString();
                                //$("#tabs>ul>li").not(shouye).remove();
                                $("#tabs>div").find("div[id='"+tab+"']").nextAll().remove();
                                last.addClass("active");
                                var id = last.children("a").attr("aria-controls").toString();
                                $("#tabs").find("div[id='"+id+"']").addClass("active");
                                //tabs.tabs("refresh");
                            }else{
                                layer.msg('<b>右侧没有啦</b>');
                            }
                        }
                    }
                    },
                    {
                        label:'当前页左侧全部关闭',icon:'plug-in/diy/icons/shopping-basket.png',action:function(){
                        var closeText = last.children("a").text().trim();
                        var nowText = $("#tabs").find("li[class='active']").children("a").text().trim();
                        if(closeText==nowText){
                            //当前页面
                            var prevAll = last.prevAll();
                            if(prevAll.length!=0){
                                prevAll.remove();
                                var tab = last.children("a").attr("aria-controls").toString();
                                //$("#tabs>ul>li").not(shouye).remove();
                                $("#tabs>div").find("div[id='"+tab+"']").prevAll().remove();
                                //tabs.tabs("refresh");
                            }else{
                                layer.msg('<b>左侧没有啦</b>');
                            }
                        }else{
                            //不是当前页，当前页的active去掉
                            var now = $("#tabs").find("li[class='active']");
                            var nowid = now.children("a").attr("aria-controls").toString();
                            now.removeClass("active");
                            $("#tabs").find("div[id='"+nowid+"']").removeClass("active");
                            var prevAll = last.prevAll();
                            if(prevAll.length!=0){
                                prevAll.remove();
                                var tab = last.children("a").attr("aria-controls").toString();
                                //$("#tabs>ul>li").not(shouye).remove();
                                $("#tabs>div").find("div[id='"+tab+"']").prevAll().remove();
                                last.addClass("active");
                                var id = last.children("a").attr("aria-controls").toString();
                                $("#tabs").find("div[id='"+id+"']").addClass("active");
                                //tabs.tabs("refresh");
                            }else{
                                layer.msg('<b>左侧没有啦</b>');
                            }
                        }
                        /*var prevAll = last.prevAll();
                         if(prevAll.length!=0){
                         prevAll.remove();
                         }else{
                         layer.msg('<b>左侧没有啦</b>');
                         }
                         var tab = last.attr("aria-controls").toString();
                         //$("#tabs>ul>li").not(shouye).remove();
                         $("#tabs>div").find("div[id='"+tab+"']").prevAll().remove();*/
                        //tabs.tabs("refresh");
                    }
                    }
                ]
            });
            //给关闭按钮绑定事件
            last.find("i[class*='fa fa-times']").on("click",function(){
                //last就是当前选中的元素
                var closeText = last.children("a").text().trim();
                var nowText = $("#tabs").find("li[class='active']").children("a").text().trim();
                if(closeText==nowText){
                    //关闭的是当前页的时候，显示前一页，如果没有前一页了，就提示
                    var prevCount = last.prevAll().size();
                    if(prevCount==0){
                        var tab = last.children("a").attr("aria-controls").toString();
                        last.remove();
                        $("#tabs").find("div[id='"+tab+"']").remove();
                    }else{
                        //显示前一个tab
                        var tab = last.children("a").attr("aria-controls").toString();
                        var prev = last.prevAll().first();
                        last.remove();
                        $("#tabs").find("div[id='"+tab+"']").remove();
                        prev.addClass("active");
                        var id = prev.children("a").attr("aria-controls").toString();
                        $("#tabs").find("div[id='"+id+"']").addClass("active");
                    }
                }else{
                    //关闭的不是当前页，关闭就好了╮(╯_╰)╭
                    var tab = last.children("a").attr("aria-controls").toString();
                    last.remove();
                    $("#tabs").find("div[id='"+tab+"']").remove();
                }
            })
            //鼠标移除当前这个li，下拉菜单关闭
            /*$("#tabs>ul>li").on("mouseout",function(){
             $(".contextMenuPlugin").remove();
             })*/
            /*$("ul[class='contextMenuPlugin']").mouseout(function(){
             alert("aaa");
             });*/
            //tabClose();
        }
        //$("#mainTitle").text(title);
        //$("#center").attr("src",url);

    }


    function  reloadParentTab(url){
        var last = $("#tabs>ul>li.active");
        var tab = last.children("a").attr("aria-controls").toString();
        //$("#tabs").find("li[aria-controls='"+tab+"']").remove();
        var div = $("#tabs").find("div[id='"+tab+"']");
        div.find("iframe").attr("src",url);
    }
    //用户子页面调用关闭tab
    function closeParentTab(){
        var last = $("#tabs>ul>li.active");
        var closeText = last.children("a").text().trim();
        var nowText = $("#tabs").find("li[class='active']").children("a").text().trim();
        if(closeText==nowText){
            //关闭的是当前页的时候，显示前一页，如果没有前一页了，就提示
            var prevCount = last.prevAll().size();
            if(prevCount==0){
                var tab = last.children("a").attr("aria-controls").toString();
                last.remove();
                $("#tabs").find("div[id='"+tab+"']").remove();
            }else{
                //显示前一个tab
                var tab = last.children("a").attr("aria-controls").toString();
                var prev = last.prevAll().first();
                last.remove();
                $("#tabs").find("div[id='"+tab+"']").remove();
                prev.addClass("active");
                var id = prev.children("a").attr("aria-controls").toString();
                $("#tabs").find("div[id='"+id+"']").addClass("active");
            }
        }else{
            //关闭的不是当前页，关闭就好了╮(╯_╰)╭
            var tab = last.children("a").attr("aria-controls").toString();
            last.remove();
            $("#tabs").find("div[id='"+tab+"']").remove();
        }
    }

    function tabClose() {
        /* 双击关闭TAB选项卡 */
        /*$(".ui-state-default").dblclick(function() {
         var existing = tabs.find("[aria-labelledby='" + $(this).attr("id") + "']");
         var index = tabs.find(".ui-tabs-nav li").index(existing);//不知道哪里脑残了，为什么index总是-1?
         tabs.tabs("option", "remove", index);
         })*/
        /* 为选项卡绑定右键 */
        /*$(".ui-state-default").on('contextmenu', function(e) {

         //想调用的是jquery ui的menu()方法，不过jquery ui应该就用了这次，重命名这个方法名吧
         //$("#menu").menu();
         /!*e.preventDefault();
         $('#mm').menu('show', {
         left : e.pageX,
         top : e.pageY
         });

         var subtitle = $(this).children(".tabs-closable").text();

         $('#mm').data("currtab", subtitle);
         // $('#maintabs').tabs('select',subtitle);
         return false;*!/
         });*/
        $('.ui-state-default').contextPopup({
            title: 'My Popup Menu',
            items: [
                {label:'Some Item',     icon:'plug-in/diy/icons/shopping-basket.png',             action:function() { alert('clicked 1') } },
                {label:'Another Thing', icon:'plug-in/diy/icons/receipt-text.png',                action:function() { alert('clicked 2') } },
                {label:'Blah Blah',     icon:'plug-in/diy/icons/book-open-list.png',              action:function() { alert('clicked 3') } },
                null, // divider
                {label:'Sheep',         icon:'plug-in/diy/icons/application-monitor.png',         action:function() { alert('clicked 4') } },
                {label:'Cheese',        icon:'plug-in/diy/icons/bin-metal.png',                   action:function() { alert('clicked 5') } },
                {label:'Bacon',         icon:'plug-in/diy/icons/magnifier-zoom-actual-equal.png', action:function() { alert('clicked 6') } },
                null, // divider
                {label:'Onwards',       icon:'plug-in/diy/icons/application-table.png',           action:function() { alert('clicked 7') } },
                {label:'Flutters',      icon:'plug-in/diy/icons/cassette.png',                    action:function() { alert('clicked 8') } }
            ]
        });
    }

    function logout(){
        /*bootbox.confirm("确定注销?",function(result) {
         if(result)
         location.href="loginController.do?logout";
         });*/
        bootbox.dialog({
            message: "确定注销?",
            title: "注销提示",
            buttons: {
                /*success: {
                 label: "烦烦烦!",
                 className: "btn-success",
                 callback: function() {
                 Example.show("great success");
                 }
                 },*/
                danger: {
                    label: "取 消",
                    className: "btn-danger",
                    callback: function() {
                        return;
                    }
                },
                main: {
                    label: "确 认",
                    className: "btn-primary",
                    callback: function() {
                        location.href="loginController.do?logout";
                    }
                }
            }
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
</script>
<script src="plug-in/ace/js/bootstrap.js"></script>
<script src="plug-in/ace/js/bootbox.js"></script>

<%--<script src="plug-in/ace/js/jquery-ui.js"></script>
<script src="plug-in/ace/js/jquery.ui.touch-punch.js"></script>--%>

<script src="plug-in/jquery/jquery.contextmenu.js"></script>

<script src="plug-in/layer/layer.js"></script>
<!-- ace scripts -->
<script src="plug-in/ace/js/ace/elements.scroller.js"></script>
<script src="plug-in/ace/js/ace/elements.colorpicker.js"></script>
<script src="plug-in/ace/js/ace/elements.fileinput.js"></script>
<script src="plug-in/ace/js/ace/elements.typeahead.js"></script>
<script src="plug-in/ace/js/ace/elements.wysiwyg.js"></script>
<script src="plug-in/ace/js/ace/elements.spinner.js"></script>
<script src="plug-in/ace/js/ace/elements.treeview.js"></script>
<script src="plug-in/ace/js/ace/elements.wizard.js"></script>
<script src="plug-in/ace/js/ace/elements.aside.js"></script>
<script src="plug-in/ace/js/ace/ace.js"></script>
<script src="plug-in/ace/js/ace/ace.ajax-content.js"></script>
<script src="plug-in/ace/js/ace/ace.touch-drag.js"></script>
<script src="plug-in/ace/js/ace/ace.sidebar.js"></script>
<script src="plug-in/ace/js/ace/ace.sidebar-scroll-1.js"></script>
<script src="plug-in/ace/js/ace/ace.submenu-hover.js"></script>
<script src="plug-in/ace/js/ace/ace.widget-box.js"></script>
<script src="plug-in/ace/js/ace/ace.settings.js"></script>
<script src="plug-in/ace/js/ace/ace.settings-rtl.js"></script>
<script src="plug-in/ace/js/ace/ace.settings-skin.js"></script>
<script src="plug-in/ace/js/ace/ace.widget-on-reload.js"></script>
<script src="plug-in/ace/js/ace/ace.searchbox-autocomplete.js"></script>
<t:base type="tools"></t:base>
<script src="plug-in/jquery-plugs/storage/jquery.storageapi.min.js"></script>
<script>jQuery(function($) {
    $.ajax({
        url: "loginController.do?primaryMenuDiy",
        async:false,
        success: function (data) {
//            update-begin--Author:zhangguoming  Date:20140429 for：一级菜单右侧有双引号，且在ie下样式错位
//            $(".shortcut").html(data);
            $(".shortcut").html(data.replace(/\"/g,""));
//            update-end--Author:zhangguoming  Date:20140429 for：一级菜单右侧有双引号，且在ie下样式错位
        }
    });
    // update-start--Author:Peak  Date:2014-01-09：新增首页风格,初始化第一个菜单的内容显示
    $(".shortcut li").eq(0).trigger("click");
    //update-end--Author:Peak  Date:2014-01-09：新增首页风格,初始化第一个菜单的内容显示
    $("#nav").show();
    //var tabs = $( "#tabs" ).tabs();

    /*layer.config({
     extend: 'extend/layer.ext.js'
     });*/
    layer.config({
        extend: ['skin/moon/style.css']
    });

    var shouye = $("#tabs>ul>li:last");
    shouye.contextPopup({
        title: '菜单',
        items: [
            {
                label:'刷新缓存',icon:'plug-in/diy/icons/shopping-basket.png',action:function(){
                //last就是当前选中的元素
                var tab = shouye.children("a").attr("aria-controls").toString();
                //$("#tabs").find("li[aria-controls='"+tab+"']").remove();
                var div = $("#tabs").find("div[id='"+tab+"']");
                div.find("iframe").attr("src","loginController.do?home");
                //tabs.tabs("refresh");
            }
            },
            {
                label:'关闭',icon:'plug-in/diy/icons/shopping-basket.png',action:function(){
                //last就是当前选中的元素
                var closeText = shouye.children("a").text().trim();
                var nowText = $("#tabs").find("li[class='active']").children("a").text().trim();
                if(closeText==nowText){
                    //关闭的是当前页的时候，显示前一页，如果没有前一页了，就提示
                    var prevCount = shouye.prevAll().size();
                    if(prevCount==0){
                        var tab = shouye.children("a").attr("aria-controls").toString();
                        shouye.remove();
                        $("#tabs").find("div[id='"+tab+"']").remove();
                    }else{
                        //显示前一个tab
                        var tab = shouye.children("a").attr("aria-controls").toString();
                        var prev = shouye.prevAll().first();
                        shouye.remove();
                        $("#tabs").find("div[id='"+tab+"']").remove();
                        prev.addClass("active");
                        var id = prev.children("a").attr("aria-controls").toString();
                        $("#tabs").find("div[id='"+id+"']").addClass("active");
                    }
                }else{
                    //关闭的不是当前页，关闭就好了╮(╯_╰)╭
                    var tab = shouye.children("a").attr("aria-controls").toString();
                    shouye.remove();
                    $("#tabs").find("div[id='"+tab+"']").remove();
                }
            }
            },
            {
                label:'全部关闭',icon:'plug-in/diy/icons/shopping-basket.png',action:function(){
                $("#tabs>ul>li").remove();
                $("#tabs>div>div").remove();
                //tabs.tabs("refresh");
            }
            },
            {
                label:'除此之外全部关闭',icon:'plug-in/diy/icons/shopping-basket.png',action:function(){
                var closeText = shouye.children("a").text().trim();
                var nowText = $("#tabs").find("li[class='active']").children("a").text().trim();
                //此是当前页则关闭，如果不是当前页面，要激活选择页面
                if(closeText==nowText){
                    //此是当前页面
                    var tab = shouye.children("a").attr("aria-controls").toString();
                    $("#tabs>ul>li").not(shouye).remove();
                    $("#tabs>div>div").not($("#tabs").find("div[id='"+tab+"']")).remove();
                }else{
                    var tab = shouye.children("a").attr("aria-controls").toString();
                    $("#tabs>ul>li").not(shouye).remove();
                    $("#tabs>div>div").not($("#tabs").find("div[id='"+tab+"']")).remove();
                    last.addClass("active");
                    var id = shouye.children("a").attr("aria-controls").toString();
                    $("#tabs").find("div[id='"+id+"']").addClass("active");
                }
                //tabs.tabs("refresh");
            }
            },
            null,
            {
                label:'当前页右侧全部关闭',icon:'plug-in/diy/icons/shopping-basket.png',action:function(){
                var closeText = shouye.children("a").text().trim();
                var nowText = $("#tabs").find("li[class='active']").children("a").text().trim();
                if(closeText==nowText){
                    //当前页面
                    var nextAll = shouye.nextAll();
                    if(nextAll.length!=0){
                        nextAll.remove();
                        var tab = shouye.children("a").attr("aria-controls").toString();
                        //$("#tabs>ul>li").not(shouye).remove();
                        $("#tabs>div").find("div[id='"+tab+"']").nextAll().remove();
                        //tabs.tabs("refresh");
                    }else{
                        layer.msg('<b>右侧没有啦</b>');
                    }
                }else{
                    //不是当前页，当前页的active去掉
                    var now = $("#tabs").find("li[class='active']");
                    var nowid = now.children("a").attr("aria-controls").toString();
                    now.removeClass("active");
                    $("#tabs").find("div[id='"+nowid+"']").removeClass("active");
                    var nextAll = shouye.nextAll();
                    if(nextAll.length!=0){
                        nextAll.remove();
                        var tab = shouye.children("a").attr("aria-controls").toString();
                        //$("#tabs>ul>li").not(shouye).remove();
                        $("#tabs>div").find("div[id='"+tab+"']").nextAll().remove();
                        last.addClass("active");
                        var id = shouye.children("a").attr("aria-controls").toString();
                        $("#tabs").find("div[id='"+id+"']").addClass("active");
                        //tabs.tabs("refresh");
                    }else{
                        layer.msg('<b>右侧没有啦</b>');
                    }
                }
            }
            },
            {
                label:'当前页左侧全部关闭',icon:'plug-in/diy/icons/shopping-basket.png',action:function(){
                var closeText = shouye.children("a").text().trim();
                var nowText = $("#tabs").find("li[class='active']").children("a").text().trim();
                if(closeText==nowText){
                    //当前页面
                    var prevAll = shouye.prevAll();
                    if(prevAll.length!=0){
                        prevAll.remove();
                        var tab = shouye.children("a").attr("aria-controls").toString();
                        //$("#tabs>ul>li").not(shouye).remove();
                        $("#tabs>div").find("div[id='"+tab+"']").prevAll().remove();
                        //tabs.tabs("refresh");
                    }else{
                        layer.msg('<b>左侧没有啦</b>');
                    }
                }else{
                    //不是当前页，当前页的active去掉
                    var now = $("#tabs").find("li[class='active']");
                    var nowid = now.children("a").attr("aria-controls").toString();
                    now.removeClass("active");
                    $("#tabs").find("div[id='"+nowid+"']").removeClass("active");
                    var prevAll = shouye.prevAll();
                    if(prevAll.length!=0){
                        prevAll.remove();
                        var tab = shouye.children("a").attr("aria-controls").toString();
                        //$("#tabs>ul>li").not(shouye).remove();
                        $("#tabs>div").find("div[id='"+tab+"']").prevAll().remove();
                        last.addClass("active");
                        var id = shouye.children("a").attr("aria-controls").toString();
                        $("#tabs").find("div[id='"+id+"']").addClass("active");
                        //tabs.tabs("refresh");
                    }else{
                        layer.msg('<b>左侧没有啦</b>');
                    }
                }
                /*var prevAll = last.prevAll();
                 if(prevAll.length!=0){
                 prevAll.remove();
                 }else{
                 layer.msg('<b>左侧没有啦</b>');
                 }
                 var tab = last.attr("aria-controls").toString();
                 //$("#tabs>ul>li").not(shouye).remove();
                 $("#tabs>div").find("div[id='"+tab+"']").prevAll().remove();*/
                //tabs.tabs("refresh");
            }
            }
        ]
    });
    //给关闭按钮绑定事件
    shouye.find("i[class*='fa fa-times']").on("click",function(){
        //last就是当前选中的元素
        var closeText = shouye.children("a").text().trim();
        var nowText = $("#tabs").find("li[class='active']").children("a").text().trim();
        if(closeText==nowText){
            //关闭的是当前页的时候，显示前一页，如果没有前一页了，就提示
            var prevCount = shouye.prevAll().size();
            if(prevCount==0){
                var tab = shouye.children("a").attr("aria-controls").toString();
                shouye.remove();
                $("#tabs").find("div[id='"+tab+"']").remove();
            }else{
                //显示前一个tab
                var tab = shouye.children("a").attr("aria-controls").toString();
                var prev = shouye.prevAll().first();
                shouye.remove();
                $("#tabs").find("div[id='"+tab+"']").remove();
                prev.addClass("active");
                var id = prev.children("a").attr("aria-controls").toString();
                $("#tabs").find("div[id='"+id+"']").addClass("active");
            }
        }else{
            //关闭的不是当前页，关闭就好了╮(╯_╰)╭
            var tab = shouye.children("a").attr("aria-controls").toString();
            shouye.remove();
            $("#tabs").find("div[id='"+tab+"']").remove();
        }
    })

    //点击导航栏打开
    $(".shortcut div").each(function(){
        var title = $(this).text().trim();
        if(title=="用户管理"){
            $(this).parent().on("click",function(){
                loadModule('用户管理','userController.do?user&clickFunctionId=8a8ab0b246dc81120146dc8180df001f','default');
            })
        }else if(title=="角色管理"){
            $(this).parent().on("click",function(){
                loadModule('角色管理','roleController.do?role&clickFunctionId=8a8ab0b246dc81120146dc8180e30021','default');
            })
        }else if(title=="组织机构"){
            $(this).parent().on("click",function(){
                loadModule('组织机构','departController.do?depart&clickFunctionId=8a8ab0b246dc81120146dc8180f60028','default');
            })
        }else if(title=="菜单管理"){
            $(this).parent().on("click",function(){
                loadModule('菜单管理','functionController.do?function&clickFunctionId=8a8ab0b246dc81120146dc8180e70023','default');
            })
        }
    })
});</script>

</body>
</html>