<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>师资介绍</title>
    <link rel="stylesheet" type="text/css" href="clzcontext/template/cms/rank/css/main.css">

	<style type="text/css">
		.l_left{ width:150px;}
		.l_left img{width:150px; height:150px; border-radius: 100px; -webkit-border-radius: 100px; -moz-border-radius : 100px; -o-border-radius : 100px;}
	</style>
</head>

<body>
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
    <div class="container" id="dd" style="padding-top: 30px;">
        <div >
		<ul>
			<li>
				<div class="l_left">
					<img style="margin-top: 30px;" src="${url}${teacher.imgSrc}">
				</div>
			</li>
			<li>
				<div class="l_left">
					<h2>${teacher.name}</h2>
					<time>${teacher.jionDate?string("yyyy-MM-dd")}</time>
				</div>

                    <div style="width: 90%" >
                        <p style=" margin-top: 10px;">${teacher.introduction}</p>
                    </div>


			</li>
		</ul>

            </div>
	</div>
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