<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>师资介绍</title>
    <link rel="stylesheet" type="text/css" href="clzcontext/template/cms/rank/css/main.css">
    <#--update-begin--Author:张忠亮  Date:20150709 for：新样式-->
    <link rel="stylesheet" type="text/css" href="clzcontext/template/cms/rank/css/bootstrap.css-osf_6.0.4.css">
    <link rel="stylesheet" type="text/css" href="clzcontext/template/cms/rank/css/common.css-osf_6.0.4.css">
    <link rel="stylesheet" type="text/css" href="clzcontext/template/cms/rank/css/bootstrap-extends.css-osf_6.0.4.css">
    <link rel="stylesheet" type="text/css" href="clzcontext/template/cms/rank/css/web.css-osf_6.0.4.css">
    <link rel="stylesheet" type="text/css" href="clzcontext/template/cms/rank/css/member.css-osf_6.0.4.css">
    <link rel="stylesheet" type="text/css" href="clzcontext/template/cms/rank/css/font-awesome.min.css-osf_6.0.4.css">
    <link rel="stylesheet" type="text/css" href="clzcontext/template/cms/rank/css/es-icon.css-osf_6.0.4.css">
    <link rel="stylesheet" type="text/css" href="clzcontext/template/cms/rank/css/main.css-osf_6.0.4.css">
    <#--update-end--Author:张忠亮  Date:20150709 for：新样式-->
    <style type="text/css">
       /* .l_left{ width:150px;  }
        .l_right{ width:150px;height: 50px;   }
        .l_left img{width:150px; height:150px; border-radius: 100px; -webkit-border-radius: 100px; -moz-border-radius : 100px; -o-border-radius : 100px;}
        .ellips{position:relative;width:120px;height:40px;line-height:20px;overflow:hidden;}
        .ellips .dot{position:absolute;right:0px;bottom:0px;height:20px;background:#fff}
        h2{margin-top: 10px;margin-bottom: 0px;}*/
	</style>
</head>
<body class="teacherpage">
    <nav class="site-navbar" style="background-color: #363e45;">
        <div class="container">
            <div class="row">
                <div style="width: 25%;">
                    <div class="navbar-header ptm">
                        <a class="navbar-brand-logo" href="http://www.jeecg.org/">
                            <img class="img-responsive" src="http://www.jeecg.org/static/image/common/logo.png">
                        </a>
                    </div>
                </div>
                <div style="width:33.33333333%"></div>
                <div style="width: 75%;">
                    <div class="navbar-right navbar-collapse collapse in" style="height: auto;">
                        <ul class="nav navbar-nav">
                            <li class=""><a href="http://www.jeecg.org/" class="">首页</a></li>
                            <li class=""><a href="${url}tSTeamPersonController.do?getTeacherList" class="">红人榜</a></li>
                            <li class=""><a href="${url}tSTeamPersonController.do?introduce" class="">社区介绍</a></li>
                            <#--<li class=""><a href="javascript:void(0)" class="">师资力量</a></li>-->
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </nav>
    <#--update-begin--Author:张忠亮  Date:20150709 for：新样式-->
    <div id="content-container" class="container">
        <div class="es-section">
            <div class="teacher-list row">
            <#list teachers as teacher>
                <div class="col-lg-3 col-md-4 col-sm-6">
                    <div class="teacher-item">
                        <div class="teacher-top">
                            <a class="teacher-img" href="${url}tSTeamPersonController.do?getTeacher&id=${teacher.id}" >
                                <img class="avatar-lg" src="${url}${teacher.imgSrc}" >
                            </a>
                            <h3 class="title">
                                <a class="link-light" href="${url}tSTeamPersonController.do?getTeacher&id=${teacher.id}" >${teacher.name}</a>
                            </h3>
                            <div class="position">
                            ${teacher.jionDate?string("yyyy-MM-dd")}
                            </div>
                        </div>
                        <div class="teacher-bottom">
                            <#if teacher.introduction?length gt 40>
                            ${teacher.introduction?substring(0,40)}...
                            <#else>
                            ${teacher.introduction}
                            </#if>


                        </div>
                    </div>
                </div>
            </#list>
            </div>
        </div>
    </div>
    <#--update-end--Author:张忠亮  Date:20150709 for：新样式-->
   <#--<div class="container" id="dd" style="padding-top: 30px;min-height:800px;">
		<ul>
			<#list teachers as teacher>
				<li style="height: 270px;width: 200px;">
                        <div class="l_left">
                            <img style="margin-top: 30px;" src="${url}${teacher.imgSrc}">
                        </div>
                        <div class="l_right">
                            <h2 style="text-align: center">${teacher.name}</h2>
                            <div  style="text-align: center">${teacher.jionDate?string("yyyy-MM-dd")}</div>
                            <div class="ellips"><div class="dot"><a href="${url}tSTeamPersonController.do?getTeacher&id=${teacher.id}">[详细]</a></div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${teacher.introduction}</div>
                        </div>
				</li>
			</#list>
		</ul>
	</div>-->
    <div class="footer-autumn-primary">
        <div class="container">
            <div>
                <ul style="padding-left: 0;list-style: none;">
                    <li>
						<span>Powered by <a href="http://www.jeecg.org/" target="_blank">JEECG微云快速开发平台</a> Support by 国炬IT培训©2015 </span>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</body>

</html>