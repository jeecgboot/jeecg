<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/context/mytags.jsp"%>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">

    <title><t:mutiLang langKey="jeect.platform"/></title>

    <meta name="keywords" content="JEECG 企业级快速开发平台">
    <meta name="description" content="JEECG 企业级快速开发平台，她采用强大代码生成，在线开发能力">

    <link rel="shortcut icon" href="images/favicon.ico">
    <link href="plug-in/hplus/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="plug-in/hplus/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link rel="stylesheet" href="plug-in/ace/assets/css/font-awesome.min.css" />
    <!--[if IE 7]>
    <link rel="stylesheet" href="plug-in/ace/assets/css/font-awesome-ie7.min.css" />
    <![endif]-->
    <!-- Sweet Alert -->
    <link href="plug-in/hplus/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <link href="plug-in/hplus/css/animate.css" rel="stylesheet">
    <link href="plug-in/hplus/css/style.css?v=4.1.0" rel="stylesheet">
    <!--右键菜单-->
    <link href="plug-in/hplus/smartMenu.css" rel="stylesheet">
</head>

<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">
<div id="wrapper">
    <!--左侧导航开始-->
    <nav class="navbar-default navbar-static-side" role="navigation" style="z-index: 1991;">
        <div class="nav-close"><i class="fa fa-times-circle"></i>
        </div>
        <div class="sidebar-collapse">
            <ul class="nav" id="side-menu">
                <li class="nav-header" style="padding:0;">
                    <div class="dropdown profile-element">
                                <span><img alt="image" width="180" height="61" src="plug-in/login/images/jeecg-aceplus.png" /></span>
                    </div>
                    <div class="logo-element">JEECG
                    </div>
                </li>

                <t:menu style="hplus" menuFun="${menuMap}"></t:menu>

            </ul>
        </div>
    </nav>
    <!--左侧导航结束-->
    <!--右侧部分开始-->
    <div id="page-wrapper" class="gray-bg dashbard-1">
        <div class="row border-bottom">
            <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                <div class="navbar-header" style="height: 60px;"><a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="#"><i class="fa fa-bars"></i> </a>
                    <form role="search" class="navbar-form-custom" method="post" action="search_results.html">
                        <div class="form-group">
                            <input type="text" placeholder="欢迎使用Jeecg快速开发平台 …" class="form-control" name="top-search" id="top-search">
                        </div>
                    </form>
                </div>
                
                
                <ul class="nav navbar-top-links navbar-right">
                    <li class="dropdown" onfocus="bindFrameClick()">
                    	<a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">
                                <span ><strong class="font-bold">${userName }</strong></span>
                                <span >${roleName }<b class="caret"></b></span>
                        </a>
                        <ul class="dropdown-menu dropdown-alerts">
                            <li>
                                <a href="javascript:add('<t:mutiLang langKey="common.change.password"/>','userController.do?changepassword','',550,200)">
                                    <t:mutiLang langKey="common.change.password"/>
                                </a>
                            </li>
                            <li><a href="javascript:openwindow('<t:mutiLang langKey="common.profile"/>','userController.do?userinfo')"><t:mutiLang langKey="common.profile"/></a></li>
                           <%--  <li><a href="javascript:openwindow('<t:mutiLang langKey="common.ssms.getSysInfos"/>','tSSmsController.do?getSysInfos')"><t:mutiLang langKey="common.ssms.getSysInfos"/></a></li> --%>
                            <li><a href="javascript:add('<t:mutiLang langKey="common.change.style"/>','userController.do?changestyle','',550,270)"><t:mutiLang langKey="common.my.style"/></a></li>
                            <li><a href="javascript:clearLocalstorage()"><t:mutiLang langKey="common.clear.localstorage"/></a></li>
                            <li><a href="javascript:toSwagger()">Swagger接口</a></li>
                           <%-- <li><a href="javascript:toJeecgYun()">云应用中心</a></li>--%>
                        </ul>
                    </li>
                    
                     
                    <li class="dropdown hidden-xs">
                        <a class="right-sidebar-toggle" aria-expanded="false">
                            <i class="fa fa-tasks"></i> 通知
                        </a>
                    </li>
                      <li class="dropdown">
                     <a href="javascript:logout()" class="roll-nav roll-right J_tabExit"><i class="fa fa fa-sign-out"></i> 退出</a>
                     </li>
                </ul>
            </nav>
        </div>
        <div class="row content-tabs">
            <button class="roll-nav roll-left J_tabLeft"><i class="fa fa-backward"></i>
            </button>
            <nav class="page-tabs J_menuTabs">
                <div class="page-tabs-content">
                    <a href="javascript:;" class="active J_menuTab" data-id="loginController.do?hplushome">首页</a>
                </div>
            <button class="roll-nav roll-right J_tabRight"><i class="fa fa-forward"></i>
            </button>
            <div class="btn-group roll-nav roll-right">
                <button class="dropdown J_tabClose" data-toggle="dropdown">关闭操作<span class="caret"></span>

                </button>
                <ul role="menu" class="dropdown-menu dropdown-menu-right">
                    <li class="J_tabShowActive"><a>定位当前选项卡</a>
                    </li>
                    <li class="divider"></li>
                    <li class="J_tabCloseAll"><a>关闭全部选项卡</a>
                    </li>
                    <li class="J_tabCloseOther"><a>关闭其他选项卡</a>
                    </li>
                </ul>
            </div>
            
        </div>
        <style type="text/css">  
		<!--  
		.proccess{display:none;background-color:#f2f2f2;border:0px solid;border-color:#009900;height:100%;line-height:600px;width:100%;text-align:center;margin:100;position:absolute;top:0;left:0;}  
		.proccess b{vertical-align:middle;background:url(plug-in/layer/skin/default/loading-0.gif) no-repeat 0 center;padding-left:55px;display:inline-block;}  
		-->  
		</style> 
        <div class="row J_mainContent" id="content-main" style="margin-left:-13px;">
            <div class="proccess" id="panelloadingDiv"><b>&nbsp;</b></div> 
            <iframe class="J_iframe" name="iframe0" width="100%" height="100%" src="loginController.do?hplushome" frameborder="0" data-id="loginController.do?hplushome" seamless></iframe>
        </div>
        <div class="footer" style="border-top:none;">
            <div class="pull-right">&copy; <t:mutiLang langKey="system.version.number"/> <a href="http://www.jeecg.org/" target="_blank">jeecg</a>
            </div>
        </div>        
    </div>
    <!--右侧部分结束-->
    <!--右侧边栏开始-->
    <div id="right-sidebar">
        <div class="sidebar-container">

            <ul class="nav nav-tabs navs-3">

                <li class="active">
                    <a data-toggle="tab" href="#tab-1">
                        <i class="fa fa-gear"></i> 主题
                    </a>
                </li>
               <li class=""><a data-toggle="tab" href="#tab-2">
                   <i class="fa fa-comments-o" aria-hidden="true"></i>通知
                </a>
                </li>
                <li><a data-toggle="tab" href="#tab-3">
                    <i class="fa fa-info-circle" aria-hidden="true"></i>公告
                </a>
                </li>
            </ul>

            <div class="tab-content">
                <div id="tab-1" class="tab-pane active">
                    <div class="sidebar-title">
                        <h3> <i class="fa fa-comments-o"></i> 主题设置</h3>
                        <small><i class="fa fa-tim"></i> 你可以从这里选择和预览主题的布局和样式，这些设置会被保存在本地，下次打开的时候会直接应用这些设置。</small>
                    </div>
                    <div class="skin-setttings">
                        <div class="title">主题设置</div>
                        <div class="setings-item">
                            <span>收起左侧菜单</span>
                            <div class="switch">
                                <div class="onoffswitch">
                                    <input type="checkbox" name="collapsemenu" class="onoffswitch-checkbox" id="collapsemenu">
                                    <label class="onoffswitch-label" for="collapsemenu">
                                        <span class="onoffswitch-inner"></span>
                                        <span class="onoffswitch-switch"></span>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="setings-item">
                            <span>固定顶部</span>

                            <div class="switch">
                                <div class="onoffswitch">
                                    <input type="checkbox" name="fixednavbar" class="onoffswitch-checkbox" id="fixednavbar">
                                    <label class="onoffswitch-label" for="fixednavbar">
                                        <span class="onoffswitch-inner"></span>
                                        <span class="onoffswitch-switch"></span>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="setings-item">
                                <span>
                        	固定宽度
                    </span>

                            <div class="switch">
                                <div class="onoffswitch">
                                    <input type="checkbox" name="boxedlayout" class="onoffswitch-checkbox" id="boxedlayout">
                                    <label class="onoffswitch-label" for="boxedlayout">
                                        <span class="onoffswitch-inner"></span>
                                        <span class="onoffswitch-switch"></span>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="title">皮肤选择</div>
                        <div class="setings-item default-skin nb">
                                <span class="skin-name ">
                         <a href="#" class="s-skin-0">
                             	默认皮肤
                         </a>
                    </span>
                        </div>
                        <div class="setings-item blue-skin nb">
                                <span class="skin-name ">
                        <a href="#" class="s-skin-1">
                            	蓝色主题
                        </a>
                    </span>
                        </div>
                        <div class="setings-item yellow-skin nb">
                                <span class="skin-name ">
                        <a href="#" class="s-skin-3">
                           	 黄色/紫色主题
                        </a>
                    </span>
                        </div>
                    </div>
                </div>
                <div id="tab-2" class="tab-pane">
                    <div class="sidebar-title">
                        <h3> <i class="fa fa-comments-o"></i> 系统消息 <small id="messageCount"><i class="fa fa-tim"></i> 您当前有0条未读通知</small></h3>
                    </div>
                    <ul class="sidebar-list">
                        <li id="messageContent">

                        </li>

                        <li>
                            <a href="javascript:goAllMessage();" id="messageFooter">
                              	  查看全部
                                <i class="icon-arrow-right"></i>
                            </a>
                        </li>
                    </ul>
                </div>
                <div id="tab-3" class="tab-pane">
                    <div class="sidebar-title">
                        <h3> <i class="fa fa-cube"></i> 最新公告<small id="noticeCount"><i class="fa fa-tim"></i> 您当前有0个公告</small></h3>

                    </div>
                    <ul class="sidebar-list">
                        <li id="noticeContent">

                        </li>
                        <li>
                            <a href="javascript:goAllNotice();" id="noticeFooter">
                                	查看所有公告
                                <i class="icon-arrow-right"></i>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

        </div>
    </div>
</div>
<!-- 全局js -->
<script src="plug-in/hplus/js/jquery.min.js?v=2.1.4"></script>
<script src="plug-in/hplus/js/bootstrap.min.js?v=3.3.6"></script>
<script src="plug-in/hplus/js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="plug-in/hplus/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script src="plug-in/hplus/js/plugins/layer/layer.min.js"></script>

<!-- 自定义js -->
<script src="plug-in/hplus/js/hplus.js?v=4.1.0"></script>
<!--右键菜单-->
<script type="text/javascript" src="plug-in/hplus/jquery-smartMenu.js"></script>
<script type="text/javascript" src="plug-in/hplus/contabs.js"></script>
<script type="text/javascript" src="plug-in/jquery-plugs/i18n/jquery.i18n.properties.js"></script>
<t:base type="tools"></t:base>
<!-- 第三方插件 -->
<script src="plug-in/hplus/js/plugins/pace/pace.min.js"></script>
<!-- Sweet alert -->
<script src="plug-in/hplus/js/plugins/sweetalert/sweetalert.min.js"></script>
<script src="plug-in/jquery-plugs/storage/jquery.storageapi.min.js"></script>

<!-- 弹出TAB -->
<script type="text/javascript" src="plug-in/hplus/hplus-tab.js"></script>
<!-- 在线聊天 -->
<%@include file="/context/layui.jsp"%>
<script>
	//初始化国际化配置
	initI18nConfig();
    function logout(){
        layer.confirm('您确定要注销吗？', {
            btn: ['确定','取消'], //按钮
            shade: false //不显示遮罩
        }, function(){
            location.href="loginController.do?logout";
        }, function(){
            return;
        });
    }
    function clearLocalstorage(){
        var storage=$.localStorage;
        if(!storage)
            storage=$.cookieStorage;
        storage.removeAll();
        //bootbox.alert( "浏览器缓存清除成功!");
        layer.msg("浏览器缓存清除成功!");
    }
    function toJeecgYun(){
    	window.open("http://yun.jeecg.org","_blank");
    }
    function toSwagger(){
    	window.open("swagger/index.html","_blank");
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
                if(data.success){
                    var noticeList = data.attributes.noticeList;
                    var noticeCount = data.obj;
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
                            messageContent +="<i class='btn btn-xs btn-primary fa fa-user'></i>";
                            messageContent +="<span class='msg-body'><span class='msg-title'> ";
                            messageContent += messageList[i].esTitle + "</span>";
                            messageContent +=" <span class='blue'>From:"+messageList[i].esSender+"</span>";
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
        createdetailwindow("通知", addurl, 800, 400);
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
		$(".count-info").attr("aria-expanded","false").parent().removeClass("open");
	}
    //新增iframe中绑定click事件回调父级函数
    function bindFrameClick(){
    	$(".J_iframe").contents().find("body").attr("onclick", "parent.frameBodyClick()"); 
    }

    /**
     * i18n国际化配置
     */
    function initI18nConfig() {
    	var i18n_browser_Lang = getCookie("i18n_browser_Lang");
    	if(i18n_browser_Lang == 'zh-cn'){
    		i18n_browser_Lang = 'zh';
    	}
//    	console.log(i18n_browser_Lang);
        $.i18n.properties({
            name:'jeecgs',    		//属性文件名     命名格式： 文件名_国家代号.properties
            path:'plug-in/i18n/',   //注意这里路径是你属性文件的所在文件夹
            mode:'map',
            language:i18n_browser_Lang,//这就是国家代号 name+language刚好组成属性文件名：strings+zh -> strings_zh.properties
            callback:function(){
           	
            }
        });
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
