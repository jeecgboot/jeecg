<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!--360浏览器优先以webkit内核解析-->
    <title>Jeecg 微云快速开发平台</title>
    <link rel="shortcut icon" href="images/favicon.ico">
    <link href="plug-in/hplus/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="plug-in/hplus/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="plug-in/hplus/css/animate.css" rel="stylesheet">
    <link href="plug-in/hplus/css/style.css?v=4.1.0" rel="stylesheet">
    <link rel="stylesheet" href="plug-in/themes/fineui/main/iconfont.css">
	<script src="plug-in/laydate/laydate.js"></script> 
    <style type="text/css">
	.gray-bg{
		background-color: #e9ecf3;
	}
	.col-sm-2 {
	    width: 10%;
		padding-left: 5px;
		padding-right: 5px;
		float: left;
	}
	.p-lg{
		padding:0px 0px 10px 0px;
	}
	.widget{
		margin-top: 0px;
	}
	.iconfont{
		font-size: 30px;
		color: white;
	}
	h2 {
        font-size: 19px;
    }
    .echart_div{
    	height:240px;width:100%;
    }
	.ibtn{
		cursor: pointer;
	}
	.flot-chart{
		height:400px;
	}
   /*  .top-navigation .wrapper.wrapper-content{padding:20px 5px !important;}
	.container {
    	 width:99% !important; margin:10px;
    	 padding-right: 1px !important;
    	 padding-left: 1px !important;
	}
	.color_red{color:#e55555;}
	.col-cs-2 {
	    width: 10%;
		padding-left: 5px;
		padding-right: 5px;
		float: left;
	}*/
	
	@media (min-width: 992px){
		.col-cs-2 {
		    width: 11.11%;
			padding-left: 5px;
			padding-right: 5px;
			float: left;
		}
	}

    </style>
</head>
 <body class="gray-bg">
        <div class="wrapper wrapper-content">
           
			<div class="row">
                <div class="col-md-1 col-cs-2 col-xs-4">
					<div class="widget  p-lg text-center" style="background: #cfa972;">
						<div><!-- class="ibtn" -->
                            <i class="iconfont icon-zhihuizhongxin" style="font-size: 30px;"></i>
                            <h3 class="font-bold no-margins"></h3>
                            <small>功能1</small>
                        </div>
                    </div>
                </div>
                <div class="col-md-1 col-cs-2 col-xs-4">
					<div class="widget  p-lg text-center" style="background: #f29b76;">
						<div>
                            <i class="iconfont icon-yujing" style="font-size: 30px;"></i>
                            <h3 class="font-bold no-margins"></h3>
                            <small>功能2</small>
                        </div>
                    </div>
                </div>
                <div class="col-md-1 col-cs-2 col-xs-4">
					<div class="widget  p-lg text-center" style="background: #acd598;">
						<div>
                            <i class="iconfont icon-ln-" style="font-size: 30px;"></i>
                            <h3 class="font-bold no-margins"></h3>
                            <small>功能3</small>
                        </div>
                    </div>
                </div>
                <div class="col-md-1 col-cs-2 col-xs-4">
					<div class="widget  p-lg text-center" style="background: #84ccc9;">
						<div>
                            <i class="iconfont icon-wuliu" style="font-size: 30px;"></i>
                            <h3 class="font-bold no-margins"></h3>
                            <small>功能4</small>
                        </div>
                    </div>
                </div>
                <div class="col-md-1 col-cs-2 col-xs-4">
					<div class="widget  p-lg text-center" style="background: #89c997;">
						<div>
                            <i class="iconfont icon-quanshengmingzhouqiguanli" style="font-size: 30px;"></i>
                            <h3 class="font-bold no-margins"></h3>
                            <small>功能5</small>
                        </div>
                    </div>
                </div>
                <div class="col-md-1 col-cs-2 col-xs-4">
					<div class="widget  p-lg text-center" style="background: #88abda;">
						<div>
                            <i class="iconfont icon-jixiao" style="font-size: 30px;"></i>
                            <h3 class="font-bold no-margins"></h3>
                            <small>功能6</small>
                        </div>
                    </div>
                </div>
				<div class="col-md-1 col-cs-2 col-xs-4">
					<div class="widget  p-lg text-center" style="background: #8c97cb;">
						<div>
                            <i class="iconfont icon-fangdajing-copy" style="font-size: 30px;"></i>
                            <h3 class="font-bold no-margins"></h3>
                            <small>功能7</small>
                        </div>
                    </div>
                </div>
				<div class="col-md-1 col-cs-2 col-xs-4">
					<div class="widget  p-lg text-center" style="background: #c490bf;">
						<div>
                            <i class="iconfont icon--youhuajieduan" style="font-size: 30px;"></i>
                            <h3 class="font-bold no-margins"></h3>
                            <small>功能8</small>
                        </div>
                    </div>
                </div>
				<div class="col-md-1 col-cs-2 col-xs-4">
					<div class="widget  p-lg text-center" style="background: #f19ec2;">
						<div>
                            <i class="iconfont icon-duoren" style="font-size: 30px;"></i>
                            <h3 class="font-bold no-margins"></h3>
                            <small>功能9</small>
                        </div>
                    </div>
                </div>
                
            </div>
            <div class="row  border-bottom white-bg dashboard-header">
    <div class="col-sm-12">
        <blockquote class="text-warning" style="font-size:14px">您是否需要一款企业级J2EE快速开发平台，提高开发效率，缩短项目周期…
            <br>您是否一直在苦苦寻找一款强大的代码生成器，节省码农的繁琐重复工作…
            <br>您是否想拥有移动报表能力、自定义表单设计能力、插件开发能力(可插拔)、工作流配置能力…
            <br>…………
            <h4 class="text-danger">那么，现在Jeecg来了</h4>
        </blockquote>
        <hr>
    </div>
    <div class="col-sm-3">
        <h2>Hello,Guest</h2>
        <small>移动设备访问请扫描以下二维码：</small>
        <br>
        <br>
        <img src="plug-in/login/images/jeecg.jpg" width="100%" style="max-width:264px;">
        <br>
    </div>
    <div class="col-sm-5">
        <h2>
            Jeecg 微云快速开发平台
        </h2>
        <p>JEECG是一款基于代码生成器的J2EE快速开发平台，开源界“小普元”超越传统商业企业级开发平台。引领新的开发模式(Online Coding模式(自定义表单)->代码生成器模式->手工MERGE智能开发)， 可以帮助解决Java项目60%的重复工作，让开发更多关注业务逻辑。既能快速提高开发效率，帮助公司节省人力成本，同时又不失灵活性。她可以用于所有的Web应用程序，如:<b>MIS</b>，<b>CRM</b>，<b>OA</b>，<b>ERP</b>，<b>CMS</b>，<b>网站后台</b>，<b>微信管家</b>，等等，当然，您也可以对她进行深度定制，以做出更强系统。</p>
        <p>
            <b>当前版本：</b>v_4.0
        </p>
        <p>
            <span class="label label-warning">开源     &nbsp; | &nbsp; 免费  | &nbsp; 更多插件</span>
        </p>
        <br>
        <p>
        	<a class="btn btn-success btn-outline" href="http://www.jeecg.com" target="_blank">
                <i class="fa fa-cloud"></i> JEECG官网
            </a>
            <a class="btn btn-white btn-bitbucket" href="http://www.guojusoft.com" target="_blank">
                <i class="fa fa-qq"> </i> 联系我们
            </a>
            <a class="btn btn-white btn-bitbucket" href="http://jeecg3.mydoc.io" target="_blank">
                <i class="fa fa-home"></i> 在线文档
            </a>
        </p>
    </div>
    <div class="col-sm-4">
        <h4>Jeecg具有以下特点：</h4>
        <ol>
            <li>采用主流J2EE框架，容易上手;</li>
            <li>强大的代码生成器，一键生成</li>
            <li>提供5套不同风格首页</li>
            <li>开发效率很高，节省80%重复工作</li>
            <li>使用最流行的的扁平化设计</li>
            <li>在线开发能力，通过在线配置实现功能，零代码</li>
            <li>在线报表配置能力，一次配置七种报表风格，支持移动报表</li>
            <li>移动平台支持，采用Bootstrap技术，移动OA，移动报表</li>
            <li>强大数据权限，访问级，按钮级、数据行级，列级，字段级</li>
            <li>国际化能力，支持多语言</li>
            <li>多数据源，跨数据源操作，便捷集成第三方系统</li>
            <li>简易Excel、Word 导入导出,满足企业需求</li>
            <li>插件开发，可插拔开发模式，集成第三方组件</li>
            <li>流程定义，在线画流程，流程挂表单，符合国情流程</li>
            <li>自定义表单，可视化拖拽布局，自定义表单风格</li>
            <li>更多……</li>
        </ol>
    </div>

</div>
			<div class="row">

                <div class="col-sm-5">
                    <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>待办事项</h5>
                            <div class="ibox-tools">
                                <a class="collapse-link">
                                    <i class="fa fa-chevron-up"></i>
                                </a>
                            </div>
                        </div>
                        <div class="ibox-content">
                            <table class="table table-hover no-margins">
                                <thead>
                                    <tr>
                                        <th>序号</th>
                                        <th>类型</th>
                                        <th>任务</th>
                                        <th>数量</th></tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td>
                                            <span class="label label-warning">站内信</span></td>
                                        <td>会议</td>
                                        <td class="text-navy">5</td></tr>
                                    <tr>
                                        <td>2</td>
                                        <td>
                                            <span class="label label-primary">通知</span></td>
                                        <td>任务7</td>
                                        <td class="text-navy">4</td></tr>
                                    <tr>
                                        <td>3</td>
                                        <td>
                                            <span class="label label-warning">类型1</span></td>
                                        <td>任务六</td>
                                        <td class="text-navy">2</td></tr>
                                    <tr>
                                        <td>4</td>
                                        <td>
                                            <span class="label label-primary">类型2</span></td>
                                        <td>任务5</td>
                                        <td class="text-navy">0</td></tr>
                                    <tr>
                                        <td>5</td>
                                        <td>
                                            <span class="label label-warning">类型3</span></td>
                                        <td>任务4</td>
                                        <td class="text-navy">16</td></tr>
                                    <tr>
                                        <td>6</td>
                                        <td>
                                            <span class="label label-primary">类型4</span></td>
                                        <td>任务3</td>
                                        <td class="text-navy">3</td></tr>
                                    <tr>
                                        <td>7</td>
                                        <td>
                                            <span class="label label-warning">类型5</span></td>
                                        <td>任务2</td>
                                        <td class="text-navy">7</td></tr>
                                    <tr>
                                        <td>8</td>
                                        <td>
                                            <span class="label label-primary">类型6</span></td>
                                        <td>任务1</td>
                                        <td class="text-navy">2</td></tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
					<div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>用户浏览器比例分析</h5>
                            <div class="pull-right">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-xs btn-white active">天</button>
                                    <button type="button" class="btn btn-xs btn-white">月</button>
                                    <button type="button" class="btn btn-xs btn-white">年</button></div>
                            </div>
                        </div>
                        <div class="ibox-content">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="flot-chart" style="height:315px;">
                                        <div class="flot-chart-content" id="chart4"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
				<div class="col-sm-3" style="padding-left: 10px;">
					<!-- <iframe src="http://tianqi.5ikfc.com:90/plugin-code/?style=1&dy=1&fs=12" frameborder="0" scrolling="no" width="300" height="60" id="weather_frame"></iframe> -->
					<iframe name="weather_inc" src="http://i.tianqi.com/index.php?c=code&id=7" style="border:solid 1px #7ec8ea" width="105%" height="90" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>
					<div id="calendar"></div>
				</div>
			</div>
			<div class="row">
                <div class="col-sm-4">
                    <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>用户浏览器分析</h5>
                            <div class="pull-right">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-xs btn-white active">天</button>
                                    <button type="button" class="btn btn-xs btn-white">月</button>
                                    <button type="button" class="btn btn-xs btn-white">年</button></div>
                            </div>
                        </div>
                        <div class="ibox-content">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="flot-chart">
                                        <div class="flot-chart-content" id="chart1"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>浏览器分析</h5>
                            <div class="pull-right">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-xs btn-white active">天</button>
                                    <button type="button" class="btn btn-xs btn-white">月</button>
                                    <button type="button" class="btn btn-xs btn-white">年</button></div>
                            </div>
                        </div>
                        <div class="ibox-content">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="flot-chart">
                                        <div class="flot-chart-content" id="chart2"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
					<div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>仪表盘</h5>
                            <div class="pull-right">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-xs btn-white active">天</button>
                                    <button type="button" class="btn btn-xs btn-white">月</button>
                                    <button type="button" class="btn btn-xs btn-white">年</button>
                                 </div>
                            </div>
                        </div>
                        <div class="ibox-content">
                         	<div class="row">
                                <div class="col-sm-12">
                                    <div class="flot-chart">
                                        <div class="flot-chart-content" id="chart3"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
				
			</div>
            
            <div class="wrapper wrapper-content">
    <div class="row">
        <div class="col-sm-4">

            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>商业支持</h5>
                </div>
                <div class="ibox-content">
                    <p>我们提供基于Jeecg的二次开发服务，具体费用请联系官方。</p>
                    <p>同时，我们也提供以下服务：</p>
                    <ol>
                        <li>Jeecg工作流开发平台 (商业版)</li>
                        <li>Jeewx微信管家 (商业版)</li>
                        <li>OA办公系统 (商业版)</li>
                        <li>专业H5活动开发</li>
                    </ol>
                </div>
            </div>
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>联系信息</h5>

                </div>
                <div class="ibox-content">
                    <p><i class="fa fa-send-o"></i> 官网：<a href="http://www.jeecg.com" target="_blank">http://www.jeecg.com</a>
                    </p>
                    <p><i class="fa fa-qq"></i> QQ群：<a href="javascript:;">190866569</a>
                    </p>
                    <p><i class="fa fa-weixin"></i>微信公众号：<a href="javascript:;">jeecg</a>
                    </p>
                    <p><i class="fa fa-credit-card"></i> 邮箱：<a href="javascript:;" class="邮箱">jeecgceo@163.com</a>
                    </p>
                </div>
            </div>
        </div>
        <div class="col-sm-4">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>版本升级日志</h5>
                </div>
                <div class="ibox-content no-padding">
                    <div class="panel-body">
                        <div class="panel-group" id="version">
                        <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h5 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#version" href="#v58">v4.0</a><code class="pull-right">2019.08.05</code>
                                    </h5>
                                </div>
                                <div id="v58" class="panel-collapse collapse in">
                                    <div class="panel-body">
                                        <div class="alert alert-warning">此版本针对系统数据库兼容问题做了优化，AdminLTE风格首页增加更多菜单功能，UI标签、树形列表分页代码生成BUG修正以及论坛相关问题修正，系统更稳定更快；</div>
                                        <ol>
											<li>【新功能】一套新的代码生成器模板，Bootstrap表单+EasyUI列表（单表、一对多）;</li>
											<li>【新功能】一套新的代码生成器模板，Bootstrap表单+EasyUI原生列表（单表、一对多）;</li>
											<li>【新功能】一套新的代码生成器模板， Boostrap表单+BootstapTable原生列表（单表、一对多）;</li>
											<li>【新功能】一套新的代码生成器模板，Boostrap表单+BootstapTable标签列表（单表、一对多）;</li>
											<li>【新功能】AdminLTE风格首页增加更多菜单功能;</li>
											<li>【新功能】上传组件Plupload优化;</li>
											<li>【新功能】Minidao 代码生成工具;</li>
											<li>【bug】多数据源配置的SQL Server2008无法获取分页问题修正;</li>
											<li>【bug】组织机构录入一级机构，oracle兼容问题修正;</li>
											<li>【bug】easyUI界面，多次点击查询按钮，界面的列表间隔逐渐缩小问题修正;</li>
											<li>【bug】[UI标签] 折叠标签之未铺满问题修正;</li>
											<li>【bug】macbook无法切换风格问题修正;</li>
											<li>【bug】树形列表分类功能失效问题修正;</li>
											<li>【bug】树形列表分页问题修正;</li>
											<li>【bug】online图表配置 饼图无文字提示 全部显示slice问题修正;</li>
											<li>【bug】online报表范围查询不生效;</li>
											<li>【改进】UI标签 采用extend属性设置查询框样式;</li>
											<li>【改进】Online单表移动模板，删除图片不需要确认;</li>
											<li>【改进】Online单表移动模板，文件上传格式优化;</li>
											<li>【改进】ERP风格生成的代码，边线样式优化;</li>
											<li>【改进】时间输入框的高度，跟普通文本框不一致;</li>
											<li>【改进】用户选择标签readonly属性改造，若为readonly/true则无click事件;</li>
											<li>【改进】黑名单管理下的高级查询构造器图表样式问题;</li>
											<li>【改进】session性能问题优化;</li>
                                        </ol>
                                    </div>
                                </div>
                        </div>
                        <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h5 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#version" href="#v57">v3.8</a><code class="pull-right">2018.10.24</code>
                                    </h5>
                                </div>
                                <div id="v57" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <div class="alert alert-warning">此版本系统安全性能得到大幅提升，代码重构优化，上传组件使用plupload重构，提升浏览器兼容性，新增adminlte风格支持一级菜单导航，极大提升美感和代码可控性，降低了表单的开发成本；</div>
                                        <ol>
											<li>【新功能】一套新的代码生成器模板，Bootstrap表单+EasyUI列表（单表、一对多）;</li>
											<li>【新功能】一套新的代码生成器模板，Bootstrap表单+EasyUI原生列表（单表、一对多）;</li>
											<li>【新功能】一套新的代码生成器模板， Boostrap表单+BootstapTable原生列表（单表、一对多）;</li>
											<li>【新功能】一套新的代码生成器模板，Boostrap表单+BootstapTable标签列表（单表、一对多）;</li>
											<li>【新功能】adminlte首页风格，一级菜单导航;</li>
											<li>【新功能】新增上传组件Plupload;</li>
											<li>【新功能】Minidao 代码生成工具;</li>
											<li>【bug】popup配置影响了导出excel功能;</li>
											<li>【bug】自定义表单的问题  控件id的赋值;</li>
											<li>【bug】解决代码生成器，生成空指针问题;</li>
											<li>【bug】Java增强,异常时 事物回滚报错;</li>
											<li>【bug】Online开发,主从表单的主表单后台数据库触发器错误无法抛出;</li>
											<li>【bug】Online模板列表页不支持下载txt文件;</li>
											<li>【bug】EasyPOI 新版本的bootstrap 界面 导出excle 未带查询参数;</li>
											<li>【bug】从表删除记录时resetTrNum方法未加validtype;</li>
											<li>【bug】 二级管理员部门角色管理中设置权限出现问题;</li>
											<li>【bug】oralce环境批量插入出错问题;</li>
											<li>【bug】oracle保留关键字问题;</li>
											<li>【改进】新版代码生成器bootstrap表单页面支持popup控件;</li>
											<li>【改进】online行编辑模式支持 文件上传;</li>
											<li>【改进】增删改树节点刷新问题;</li>
											<li>【改进】easyui原生态列表promise语法 替换成jquery的deferred;</li>
											<li>【改进】菜单管理和部门管理删除时提示信息国际化问题;</li>
											<li>【改进】删除接口数据时接口权限角色关联表数据删除;</li>
											<li>【改进】组织机构管理--成员录入;</li>
											<li>【改进】列表页对于字典的值的展示没有匹配到字典项的展示原值而不是空;</li>
											<li>【改进】模板消息字段截取;</li>
											<li>【改进】Online在线模板图片支持打进jar中;</li>
											<li>【改进】bootstrap 共通的js封装;</li>
											<li>【改进】我的组织机构增删改，树展开问题;</li>
											<li>【改进】自定义表单的增强放到表单设计上面;</li>
											<li>【改进】我的组织机构，用户列表，展示出用户的职务;</li>
											<li>【改进】组织机构默认展示用户信息列表;</li>
											<li>【改进】老版代码生成器新机制，没有模板文件则不生成，不再报错;</li>
											<li>【改进】取消Gzip压缩，IE11下tomcat开启压缩，多次压缩会导致页面列表数据请求失败;</li>
											<li>【改进】解除机构关系将分配的角色、职务全部删除后删除该用户与机构关系;</li>
											<li>【改进】java增强弹框和清空处理;</li>
											<li>【改进】代码生成rest接口 list获取改造,新版;</li>
											<li>【改进】通过online表单开发，需要在新增前、编辑前、删除前做业务逻辑;</li>
											<li>【改进】新版风格echart报表页面首次加载不能自适应页面;</li>
											<li>【改进】列表页面多文件支持弹窗查看列表;</li>
											<li>【优化】UI：自定义表单设计器,我的组织机构,黑名单管理;</li>
											<li>【优化】页面扩展js文件不生成，把逻辑直接写在页面里面;</li>
											<li>【优化】H+其他皮肤切换左上角LOGO变大,ACE风格右侧设置图标靠上遮挡隐藏按钮;</li>
											<li>【优化】bootstraptable列表删除成功提示信息图标不显示;</li>
											<li>【优化】Online EASY默认表单样式不显示序号问题，Online报表生成表格无法对齐问题;</li>
											<li>【demo】下拉支持多选demo;</li>
											<li>【demo】拖拽面板做一个demo;</li>
											<li>【demo】使用模板语言导出word/Excel;</li>
                                        </ol>
                                    </div>
                                </div>
                        </div>
                        <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h5 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#version" href="#v56">v3.7.8</a><code class="pull-right">2018.08.06</code>
                                    </h5>
                                </div>
                                <div id="v56" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <div class="alert alert-warning">此版本主要目标是努力消灭BUG，让大家既有鱼丸也有粗面，多样化话主题UI满足你不同的需求，新增加5套Bootstrap风格代码生成器模板，极大提升美感和代码可控性，降低了表单的开发成本；</div>
                                        <ol>
											<li>【新功能】一套新的代码生成器模板，Bootstrap表单+EasyUI列表（单表、一对多）;</li>
											<li>【新功能】一套新的代码生成器模板，Bootstrap表单+EasyUI原生列表（单表、一对多）;</li>
											<li>【新功能】一套新的代码生成器模板， Boostrap表单+BootstapTable原生列表（单表、一对多）;</li>
											<li>【新功能】一套新的代码生成器模板，Boostrap表单+BootstapTable标签列表（单表、一对多）;</li>
											<li>【新功能】Datagrid列表按钮折叠功能;</li>
											<li>【新功能】webuploader上传组件支持openoffice格式转换控制;</li>
											<li>【新功能】validform标签验证提示效果扩展tiptype="6";</li>
											<li>【新功能】xml模板导出word格式数据;</li>
											<li>【bug】树形列表dgFunOpt funname函数设置列表字段参数取不到值问题;</li>
											<li>【bug】Online表单类型点击根节点不能查询所有表单信息问题修正;</li>
											<li>【bug】在Tomcat的https模式下，录入、编辑、查看的样式丢失;</li>
											<li>【bug】TreeSelectTag获取值多一个undefined问题;</li>
											<li>【bug】online表单导入bug修正;</li>
											<li>【bug】公用上传页面，加个上传刷新遮罩, 防止没上传完，用户点击确认按钮，导致出问题;</li>
											<li>【bug】树控件报错问题;</li>
											<li>【bug】针对curd*.js没引用国际化js的问题处理;</li>
											<li>【bug】新版代码生成器编辑页面多行文本值未初始化问题;</li>
											<li>【bug】常用示例 erp风格 ，点击折叠，按钮跑位问题;</li>
											<li>【bug】bootstrap标签列表查询区域字段，popup未实现;</li>
											<li>【样式问题】icheck样式优化;</li>
											<li>【升级】升级jeasypoi，支持逗号分隔多值替换字典文本;</li>
											<li>【改进】弹出窗口大小控制问题优化;</li>
											<li>【改进】上传增加进度条显示问题;</li>
											<li>【改进】Base标签命名修改;</li>
											<li>【改进】Layui 全局弹出表单窗口,支持刷新列表页面;</li>
											<li>【改进】popup弹出遮挡问题;</li>
											<li>【优化】常用示例优化;</li>
											<li>【优化】table模式字典性能，优化列表支持ajax异步处理数据值转换;</li>
											<li>【demo】minidao 列表，按照字段排序demo;</li>
											<li>【demo】bootstrap-table 树形列表demo;</li>
											<li>【demo】下拉输入框demo;</li>
											<li>【demo】plupload上传插件demo;</li>
											<li>【demo】页面打印 demo;</li>
                                        </ol>
                                    </div>
                                </div>
                        </div>
                        <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h5 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#version" href="#v55">v3.7.7</a><code class="pull-right">2018.07.16</code>
                                    </h5>
                                </div>
                                <div id="v55" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <div class="alert alert-warning">此版本为性能和表单UI深化加强版本，简称闪电版本 （闪电般的速度，主流的Bootstrap表单风格）。平台性能访问速度提升至少3倍；表单提供Bootstrap风格极大提升美感和代码可控性，降低了表单的开发成本；</div>
                                        <ol>
											<li>【新功能】一套新的代码生成器模板，Bootstrap表单+EasyUI列表（单表、一对多）;</li>
											<li>【新功能】一套新的代码生成器模板，Bootstrap表单+EasyUI原生列表（单表、一对多）;</li>
											<li>【新功能】一套新的代码生成器模板， Boostrap表单+BootstapTable原生列表（单表、一对多）;</li>
											<li>【新功能】一套新的代码生成器模板，Boostrap表单+BootstapTable标签列表（单表、一对多）;</li>
											<li>【新功能】Online代码生成器，支持生成word模板方式生成 ;</li>
											<li>【新功能】代码生成器优化，Restful接口代码生成，可选择;</li>
											<li>【新功能】Jeasypoi提供例子，支持自定义导入字段转换规则;</li>
											<li>【新功能】fineui风格首页，菜单支持折叠功能;</li>
											<li>【新功能】字典值不支持排序，增加一个排序字段;</li>
											<li>【新功能】UploadTag标签 ，支持自定义上传按钮高度宽度;</li>
											<li>【bug】online 开发，自定义按钮显示表达式问题;</li>
											<li>【bug】Online移动报表功能演示导出Excel报错;</li>
											<li>【bug】新版代码生成器乱码问题;</li>
											<li>【bug】SystemService.addLog( )的调用，第二个参数和第三个参数搞错了;</li>
											<li>【bug】Online word 布局模板唯一值校验问题;</li>
											<li>【bug】 一对多全tab、一对多带子表明细模板，不支持唯一校验处理;</li>
											<li>【bug】online 数据库表导入功能,SqlServer下 字段类型生成错误、精度和小数点不正确、加载的表清单有多余系统表;</li>
											<li>【bug】系统管理-二级管理员模块代码中SQL语法不兼容ORACLE;</li>
											<li>【bug】字典组名带有空格情况下，点击查看字典值，js无效问题处理;</li>
											<li>【bug】 basepath 问题 始终是127.0.0.1的错误bug;</li>
											<li>【bug】Excel导出问题typecode 如果 带有下划线 就不能正确的检索数据字典表;</li>
											<li>【bug】新版代码生成器没有处理js增强的生成 ;</li>
											<li>【bug】新版代码生成器java增强逻辑的生成 ;</li>
											<li>【bug】生成器生成去掉无用代码的生成，java增强，sql增强没有配置时不做生成相应代码 ;</li>
											<li>【bug】Online报表配置 oracle时间处理bug</li>
											<li>【bug】Online表单字段默认值，循环加了很多单引号问题;</li>
											<li>【样式问题】Online table风格一对多，输入框上下太宽;</li>
											<li>【样式问题】shortcut风格下表单时间控件高度兼容;</li>
											<li>【样式问题】修改时间背景图片/修改下拉背景图片/下拉框高度;</li>
											<li>【升级】VUE版本代码生成器模板改造优化;</li>
											<li>【升级】改造pom.xml，删除不用的或者有子依赖的jar，依赖精简;</li>
											<li>【升级】webUploadpath图片访问和下载服务，改造请求格式，实现浏览器缓存;</li>
											<li>【升级】改造平台底层机制，提高平台性能，访问速度至少提升3倍;</li>
											<li>【升级】列表数据加载重构，减少json解析重复转换的过程，提高列表数据加载速度;</li>
											<li>【升级】字典缓存屏蔽不需要的属性，尽量少占内存;</li>
											<li>【升级】重构缓存机制，采用缓存接口定义，支持Ehcache和redis 非常简单的切换;</li>
											<li>【升级】 ztree 样式风格升级， 用户选择、部门选择的ztree样式替换等。;</li>
											<li>【升级】SQL注入问题处理，Online报表自定义sql,以及查询条件处理重构成占位符;</li>
											<li>【升级】online报表，参数和列查询条件同时支持的问题;</li>
											<li>【升级】升级minidao，表达式混淆参数问题;</li>
											<li>【升级】新版代码生成器一对多模板java增强逻辑支持;</li>
											<li>【改进】数据列表，查询规则友好提醒;</li>
											<li>【改进】online图形报表在线效果图标美化;</li>
											<li>【改进】online风格样式，一对多全tab风格优化;</li>
											<li>【改进】online报表 SQL支持上下文变量;</li>
											<li>【改进】高级查询页面样式优化重构;</li>
											<li>【改进】默认首页改为fineui风格;</li>
											<li>【改进】 ace风格，输入框和select不对齐（online、代码生成器）;</li>
											<li>【改进】字典名称长度太短;</li>
											<li>【改进】Fineui首页， 兼容移动端;</li>
											<li>【改造】online在线风格，boostrap 简约风格样式改造;</li>
											<li>【改造】online在线风格，通用移动模板001 moblieCommon001;</li>
											<li>【改造】代码进行重构，抽取，简化代码逻辑;</li>
											<li>【改造】代码生成器生成代码，列表默认按照创建时间降序排列;</li>
											<li>【改造】jeecg前段js 国际化改造，采用i18n技术实现;</li>
											<li>【改造】上下布局表单二 ，上下拖动等问题修复;</li>
											<li>【改造】UI标签，列表支持操作按钮折叠成组弹出展示，节省按钮列的空间;</li>
											<li>【优化】online代码生成器模板优化,java增强，sql增强非空情况下不生成;</li>
											<li>【优化】精简首页代码;</li>
											<li>【优化】table模式字典性能，优化列表支持ajax异步处理数据值转换;</li>
											<li>【改造】重构通知公告模块;</li>
											<li>【改造】重构消息中心模块;</li>
											<li>【改造】消息中间件优化;</li>
											<li>【改造】日志打印格式错误，统一替换为slf4j日志方式;</li>
											<li>【升级】老版本的代码生成器，原ace系列的模板，js引用全部改成标签方式;</li>
											<li>【demo】下拉数据表格;</li>
											<li>【demo】列表按钮折叠例子;</li>
											<li>【demo】excel导入导出例子，支持导入字段值转换;</li>
											<li>【demo】新UI控件效果demo;</li>
                                        </ol>
                                    </div>
                                </div>
                        </div>
                        <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h5 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#version" href="#v54">v3.7.6</a><code class="pull-right">2018.06.06</code>
                                    </h5>
                                </div>
                                <div id="v54" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <div class="alert alert-warning">此版本提供新一代风格代码生成器模板，采用Vue技术，提供两套精美模板 ElementUI风格、Bootstrap风格，追逐潮流技术支持移动端；</div>
                                        <ol>
											<li>【功能升级】新一代 (单表/一对多) 代码生成器模板，Vue+ElementUI风格功能优化升级;</li>
											<li>【功能升级】新一代 (单表) 代码生成器模板，Bootstrap表单+EasyUI原生态列表风格功能优化升级;</li>
											<li>【功能升级】新一代 (一对多) 代码生成器模板，ElementUI表单+EasyUI原生态列表风格功能优化升级;</li>
											<li>【功能升级】新一代 (一对多) 代码生成器模板，EasyUI标签列表上下布局(列表数据编辑)+Table风格表单功能优化升级;</li>
											<li>【功能升级】牛牛叉功能  -> Datagrid标签升级,通过参数component可以快速实现BootstrapTable与easyUI列表风格切换功能优化升级;</li>
											<li>【功能升级】定时任务支持版本升级;</li>
											<li>【功能升级】定时任务，多个tomcat部署一台服务器的解决方案升级;</li>
											<li>【功能改造】新版代码生成器模板文件扩展名题处理,扩展名统一增加字母“i”;</li>
											<li>【功能改造】清理hplus/js/plugins下的插件;</li>
											<li>【功能改造】将不常改的js组件放进jar包 jeecg-plugin-in,减少eclipse check js;</li>
											<li>【功能改造】删除无用的代码，减少项目jar依赖;</li>
											<li>【功能改造】提示信息停留时间延长;</li>
											<li>【功能改造】防止SQL注入处理;</li>
											<li>【功能改造】druid扫描排除资源修改,durid数据源配置优化;</li>
											<li>【功能改造】权限拦截器重构优化</li>
											<li>【功能改造】重构登录逻辑;</li>
											<li>【功能改造】列表返回json进行gzip压缩，提高加载速度;</li>
											<li>【功能改造】在线清空用户登录权限缓存;</li>
											<li>【功能改造】重构redis缓存功能;</li>
											<li>【功能改造】在线文档预览效果优化;</li>
											<li>【功能改造】简化log4j12配置、highchart 图片导出依赖修改采用官仓;</li>
											<li>【功能改造】演示demo效果优化;</li>
											<li>【功能改造】jacob升级版本，采用官仓maven;</li>
											<li>【功能改造】重构online报表，通用方法抽取统一维护[解析字典支持缓存、解析SQL字段、解析SQL字段参数]，优化UI效果;</li>
											<li>【功能改造】重构webupload上传功能;</li>
											<li>【功能改造】下拉默认请选择去掉，默认为空，美化页面效果;</li>
											<li>【功能改造】bootstrap-table表单，列表按钮图标样式和ace，hplus保持统一;</li>
											<li>【Demo】boostrap报表布局，嵌套多个报表示例;</li>
											<li>【BUG】ElemetUI版本问题修正;</li>
											<li>【BUG】naturebt代码生成器单表文件上传、excel导入，一对多验证settimeout问题修正;</li>
											<li>【BUG】分布式部署不支持redis共享 集群部署问题修正;</li>
											<li>【BUG】online删除文件confirm弹框z-index不足导致被遮挡;</li>
											<li>【BUG】代码生成器radio，checkbox宽度样式修正;</li>
											<li>【BUG】代码生成器多列表级联风格form页面带文件提交弹框不关闭问题修正;</li>
											<li>【BUG】范围查询double类型字段错误问题;</li>
											<li>【BUG】消息模板 查询按钮 改为 查看;</li>
											<li>【BUG】多表头列表 审核弹框大小调整;</li>
											<li>【BUG】部门二级管理员，部门角色在系统角色列表中显示问题修正;</li>
											<li>【BUG】online扩展参数用法问题修正;</li>
											<li>【BUG】UE编辑器图片 回显问题修正;</li>
											<li>【BUG】图片上传blob类型报错问题修正;</li>
											<li>【BUG】修改登录逻辑，解决重复执行login问题，简化代码;</li>
											<li>【BUG】定时任务日志包冲突问题修正;</li>
											<li>【BUG】替换官方仓库版本freemarker,采用classic_compatible=true解决空指针报错问题;</li>
											<li>【BUG】黑名单数据排重处理;</li>
											<li>【BUG】uploadify上传控件被隐藏导致上传失败问题修正;</li>
											<li>【BUG】单表代码生成器，老版NOPOP风格 生成的代码查看功能存在提交按钮问题修正;</li>
											<li>【BUG】合计金额展示千分位格式 如：61,100.00 显示问题修正;</li>
											<li>【BUG】vue 采用validform校验，重复校验提交check不住问题修正;</li>
											<li>【BUG】权限逻辑没有针对组织机构的角色进行控制问题修正;</li>
											<li>【BUG】online开发,自定义按钮显示表达式不起作用问题修正;</li>
											<li>【BUG】注释定时任务调度器启动解决抛出异常问题修正;</li>
											<li>【BUG】element-ui 代码生成器遗留问题修正;</li>
											<li>【BUG】数据字典项录入字典code重复校验问题修正;</li>
											<li>【BUG】用户编辑页面，系统角色列表不需要显示接口角色信息;</li>
											<li>【BUG】一系列论坛网友问题解决;</li>
                                        </ol>
                                    </div>
                                </div>
                        </div>
                        <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h5 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#version" href="#v53">v3.7.5</a><code class="pull-right">2018.05.17</code>
                                    </h5>
                                </div>
                                <div id="v53" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <div class="alert alert-warning">此版本提供新一代风格代码生成器模板，采用Vue技术，提供两套精美模板 ElementUI风格、Bootstrap风格，追逐潮流技术支持移动端；</div>
                                        <ol>
											<li>【新增功能】新一代更灵活的代码生成器工厂，可灵活自定义生成的代码文件名称、路径等；根据模板结构生成代码文件;</li>
											<li>【新增功能】新一代 (单表/一对多) 代码生成器模板，Vue+ElementUI风格;</li>
											<li>【新增功能】新一代 (单表) 代码生成器模板，Bootstrap表单+EasyUI原生态列表风格;</li>
											<li>【新增功能】新一代 (一对多) 代码生成器模板，ElementUI表单+EasyUI原生态列表风格;</li>
											<li>【新增功能】新一代 (一对多) 代码生成器模板，EasyUI标签列表上下布局(列表数据编辑)+Table风格表单;</li>
											<li>【功能升级】牛牛叉功能  -> Datagrid标签升级,通过参数component可以快速实现BootstrapTable与easyUI列表风格切换;</li>
											<li>【新增功能】接口测试功能页面;</li>
											<li>【新增功能】二维码生成功能;</li>
											<li>【功能升级】多Tab风格（一对多）模板升级;</li>
											<li>【功能升级】column列表字典属性扩展dictCondition加sql条件;</li>
											<li>【功能升级】online表单、代码生成器树控件、上传控件升级优化;</li>
											<li>【功能升级】树形代码生成器模板升级，列表支持多选;</li>
											<li>【功能升级】ComboTree标签升级，增加是否只选择子节点属性控制，解决combotree树初始化子节点不能默认选择问题;</li>
											<li>【功能升级】SelectZTree标签升级，增加父子联动选择机制;</li>
											<li>【功能升级】代码生成器模板上传控件、树控件 宏封装;</li>
											<li>【功能升级】mave依赖非jeecg官方的统一采用本地依赖方式，降低maven构建难度;</li>
											<li>【功能改造】jeecg 用户账号字段改长一些;</li>
											<li>【功能改造】高级查询弹出框样式;</li>
											<li>【功能改造】跨域方案改造优化;</li>
											<li>【功能改造】H+风格首页的依赖hplus插件，从jar中移到项目中，方便维护;</li>
											<li>【功能改造】减重 Fineui demo 和plug-in删掉;</li>
											<li>【功能改造】【UI标签扩展】上传新功能 （当限制上传数量为1的时候，上传新图片替换老的）;</li>
											<li>【Demo】Vue bootstrap 示例;</li>
											<li>【Demo】Vue elementUI 示例;</li>
											<li>【Demo】bootstrapTable+ bootstrap表单 示例;</li>
											<li>【BUG】在线Online开发，配置验证规则下拉不显示（360浏览器兼容模式问题）;</li>
											<li>【BUG】一对多，列表带明细的模板，多个明细情况下展示有问题处理;</li>
											<li>【BUG】ehcache.xml 总报端口冲突问题解决;</li>
											<li>【BUG】popup,当字典Text为多个值时,查询条件的input框值为undefined;</li>
											<li>【BUG】行编辑扩展参数字典值为空，模板报错问题处理;</li>
											<li>【BUG】popup弹框出现在录入弹框后面的问题;</li>
											<li>【BUG】范围查询double类型字段错误问题;</li>
											<li>【BUG】Jeecg 新版3.7.3菜单加载慢问题解决;</li>
											<li>【BUG】shortcut及经典下同名菜单冲突，只能点开一个问题;</li>
											<li>【BUG】主子表关联问题;</li>
											<li>【BUG】菜单修改bug，三级菜单编辑，不能改成一级菜单问题;</li>
											<li>【BUG】角色授权，权限加载不出来问题;</li>
											<li>【BUG】自定义表单js增强编辑报错处理;</li>
											<li>【BUG】主键策略为NATIVE 再次编辑附表数据会被删除问题;</li>
											<li>【BUG】online报表问题确认 其它数据源的时候，传进来的查询条件参数不会进行拼接问题;</li>
											<li>【BUG】树状的数据列表添加checkbox后全选选不中;</li>
											<li>【BUG】单表档案行编辑风格表单，代码生成，点击页面编辑所有的数据不可操作;</li>
											<li>【BUG】自定义word模板，编辑页面不赋值问题修正;</li>
											<li>【BUG】Excel导入导出功能bug;</li>
											<li>【BUG】上传组件效果优化;</li>
											<li>【BUG】一对多主子表关联外键的问题优化;</li>
											<li>【BUG】fineUI 首页加载聊天插件时 菜单样式问题优化;</li>
											<li>【BUG】一系列论坛网友问题解决;</li>
                                        </ol>
                                    </div>
                                </div>
                        </div>
                        <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h5 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#version" href="#v52">v3.7.3</a><code class="pull-right">2018.03.13</code>
                                    </h5>
                                </div>
                                <div id="v52" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <div class="alert alert-warning">此版本增加很多比较实用的功能，且UI样式进行进一步优化，极大提升UI美感，及加载速度！</div>
                                        <ol>
											<li>【新增功能】“常用示例-原生态组件”增加省市区复杂的三级联动效果，控件美观，可以很友好的进行省市区的选择;</li>
											<li>【新增功能】新增ECharts集成demo(仪表图、日程图、柱状图、漏斗图折、线图、饼状图、点状图、矩阵图等);</li>
											<li>【新增功能】新增二维码生成demo功能，可自定义生成url，二维码大小;</li>
                                        	<li>【功能升级】Online对外接口改造，使用JWT安全机制对外开放接口;</li>
											<li>【功能升级】Fineui风格优化，增加首页菜单检索;</li>
											<li>【功能升级】Online代码生成器优化,多tab风格优化;</li>
											<li>【功能升级】Online表单开发优化,增加添加的online唯一校验，表单填值功能，校验提示优化;</li>
											<li>【功能升级】升级聊天版本支持历史消息提醒;</li>
											<li>【BUG】定时任务BUG修正;</li>
											<li>【BUG】校验提示问题;</li>
											<li>【BUG】浏览器兼容问题;</li>
											<li>【BUG】多tab生成的样式有问题;</li>
											<li>【BUG】修正已经激活的用户不允许重复激活;</li>
											<li>【BUG】代码生成器，新添加的online唯一校验生成代码问题;</li>
											<li>【BUG】Online 表单，编辑的时候报错;</li>
											<li>【BUG】excel导入字典文本翻译问题;</li>
											<li>【BUG】online维护字段，字段没有判断重复;</li>
                                        	<li>【BUG】用户列表不显示接口类型的用户;</li>
											<li>【BUG】自定义表单js增强编辑报错处理;</li>
											<li>【BUG】online同步针对oracle11g兼容处理;</li>
											<li>【BUG】一对多模板，子表设置radio情况下，点击删除，会全部删除问题;</li>
											<li>【BUG】连接外部数据库导致系统很慢问题修正;</li>
                                        </ol>
                                    </div>
                                </div>
                        </div>
                        <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h5 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#version" href="#v51">v3.7.2</a><code class="pull-right">2018.01.25</code>
                                    </h5>
                                </div>
                                <div id="v51" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <div class="alert alert-warning">此版本为接口开发版，采用jwt token统一验证机制，集成swagger-ui，代码生成器自动生成所需接口；另外此版本UI样式进行刮骨疗法深度优化，极大提升UI美感！</div>
                                        <ol>
											<li>【新功能】restful接口统一采用jwt token机制登录验证机制，方便客户端对接;</li>
											<li>【新功能】接口权限管理，针对restful接口可细化权限控制，实现不同接口人查询不同数据;</li>
											<li>【新功能】集成swagger支持，在线可视化接口文档;</li>
                                        	<li>【新功能】WebUploaderTag的通用上传请求，支持ftpclient模式</li>
											<li>【新功能】代码生成器模板修改，追加swagger-ui注解，自动生成;</li>
											<li>【新功能】新增首页风格，参考fineUI首页 ;</li>
											<li>【新功能】默认首页支持配置;</li>
											<li>【新功能】Online在线风格，新增主子表风格：列表数据点击，可展开显示子表数据;</li>
											<li>【新功能】高级组合查询功能，在线配置支持主子表关联查询，可保存查询历史;</li>
											<li>【新功能】代码生成器新增模板，一对多新模板，全tab风格，表单字段分块布局;</li>
											<li>【新功能】列表支持按列字段条件筛选;</li>
											<li>【新功能】字典增加一个刷新缓存功能;</li>
											<li>【新功能】Online功能，字段支持 唯一校验;</li>
											<li>【新功能】Online功能，字段支持配置填值规则字段，例如：编码自动生成;</li>
											<li>【新功能】组织机构导入新功能，模板新规则下载;</li>
											<li>【新功能】组织机构管理新菜单，支持岗位设置、职务设置、组织机构人员管理 ;</li>
											<li>【新功能】minidao升级版本号，支持主键自增策略;</li>
                                        	<li>【UI美化】h+风格，列表样式优化，字体灰色改成黑色、列表上下宽度缩小，列表标题靠左</li>
											<li>【UI美化】列表排序图标、列表分行样式</li>
											<li>【UI美化】查询条件样式优化;</li>
											<li>【UI美化】Checkbox 选中样式优化;</li>
											<li>【UI美化】列表上方按钮样式修改、按钮与表格缝隙大小调整;</li>
											<li>【UI美化】非DIV表单，label宽一些;</li>
											<li>【UI美化】Online模板 默认图片高宽修改;</li>
                                        	<li>【功能升级】列表支持多条件动态组合查询功能;</li>
											<li>【功能升级】支持二级管理员，权限细化管理;</li>
											<li>【功能升级】增加redis支持;</li>
											<li>【功能升级】Redis单元测试类;</li>
											<li>【功能升级】Restreful接口单元测试类;</li>
											<li>【功能升级】密码找回功能;</li>
											<li>【功能升级】代码生成器支持resutful接口生成（模板改造）;</li>
											<li>【功能升级】online功能，系统表安全机制加强;</li>
											<li>【功能升级】数据权限新增SQL片段，支持解析表达式 ;</li>
											<li>【功能升级】多数据源改造，支持唯一db链接，提供连接关闭方法 ;</li>
											<li>【功能升级】高级查询，支持popup模式 ;</li>
											<li>【bug】online和代码生成器 一对多调用js错误,改成popupClick支持返回多个字段;</li>
											<li>【bug】online代码生成器，支持字典字段驼峰转换;</li>
											<li>【bug】定时任务BUG修改;</li>
											<li>【bug】标签国际化异常处理;</li>
											<li>【bug】用户管理导出功能错误处理;</li>
											<li>【bug】定时任务实例化方式改造，引用不到spring容器的对象处理;</li>
											<li>【bug】 Online 一对多导入失败处理;</li>
											<li>【bug】代码生成器bug处理， popup参数配置，不应该生成excel字典注解，不然点击导出报错;</li>
											<li>【bug】通用移动模板002问题处理;</li>
											<li>【bug】在Sqlserver2008下Online功能同步问题处理;</li>
											<li>【bug】online测试功能，查询条件没有翻译问题处理;</li>
											<li>【bug】Jeecg 用户功能代码事务不严谨，control的逻辑改到service里面;</li>
											<li>【bug】Online提示建表不能超过100个字段问题处理;</li>
											<li>【demo】列表标签列 formatterjs 例子;</li>
											<li>【demo】做个demo，一个页面有多个 datagrid 叠在一起;</li>
											<li>【demo】一对多的效果demo，上下布局主子表效果;</li>
											<li>【demo】ace风格一对多样式改造，参考fineui紧凑样式;</li>
											<li>【demo】Select2 示例;</li>
											<li>【demo】DEMO示例，自定义查询示例效果</li>
                                        </ol>
                                    </div>
                                </div>
                        </div>
                        <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h5 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#version" href="#v50">v3.7.1</a><code class="pull-right">2017.09.18</code>
                                    </h5>
                                </div>
                                <div id="v50" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <div class="alert alert-warning">此版本为跨时代精良重构版，简化平台功能，优化系统性能，制作完善文档，公司项目平台最佳选择！</div>
                                        <ol>
                                        	<li>【功能升级】简化在线定时任务配置，支持分布式;</li>
											<li>【功能升级】jeecg 集成单点登录机制;</li>
											<li>【功能升级】jeecg excel导出 支持选中行的数据;</li>
											<li>【功能升级】在线聊天支持头像设置;</li>
											<li>【功能升级】online表单，sql增强支持minidao语法;</li>
											<li>【功能升级】多数据源，sql支持minidao语法;</li>
											<li>【功能升级】jeecg安全机制加强，增加开发者模式;</li>
											<li>【功能升级】登录验证码容易混淆字母去掉;</li>
											<li>【功能升级】校验机制，手机号码支持170校验;</li>
											<li>【功能升级】系统Ehcache缓存清空功能;</li>
											<li>【权限改造】增加权限拦截器排除注解@JAuth(auth=Permission.SKIP_AUTH);</li>
											<li>【权限改造】数据权限规则支持复杂配置，例如or等复杂规则;</li>
											<li>【权限改造】系统按钮和表单权限原来是反控制设计，改成正控制，授权的人才有权限，未授权看不到对应按钮;</li>
											<li>【权限改造】权限拦截器支持模糊匹配;</li>
											<li>【online】Online 表单支持树控件;</li>
											<li>【online】Online 表单各种控件对校验规则支持;</li>
											<li>【online】Online 一对多对上传组件支持;</li>
											<li>【代码生成器】UE编辑器控件类型问题处理;</li>
											<li>【代码生成器】代码生成器模板，对图片类型上传组件支持;</li>
											<li>【代码生成器】online生成代码，无用太多，简化代码(1. 系统标准字段，表单页面，添加和修改页面，不生成隐藏字段);</li>
											<li>【代码生成器】代码生成，支持行编辑模式生成;</li>
											<li>【代码生成器】代码生成t:dictSelect异常处理;</li>
											<li>【UI标签】列表表头支持换行;</li>
											<li>【UI标签】列表表头支持复杂表头;</li>
											<li>【UI标签】上传标签必填属性增加;</li>
											<li>online表单默认模板，升级功能;</li>
											<li>【IE8问题】IE兼容性优化专项工作;</li>
											<li>【IE8兼容】移动报表，功能测试乱码问题处理;</li>
											<li>【UI优化】默认validform的提示框美化;</li>
											<li>【UI优化】分页效果，页数多，页数遮挡问题解决;</li>
											<li>【UI优化】多tab，支持bootstrap图标样式;</li>
											<li>【UI优化】h+风格下，列表风格美化;</li>
											<li>【UI优化】提示风格做成切换，根据风格切换采用easyui风格或者layui;</li>
											<li>【UI优化】列表上方button支持boostrap图标样式;</li>
											<li>【UI改进】列表加载慢的时候会出现白板效果处理;</li>
											<li>【UI优化】Online 功能测试的列表链接样式，根据浏览器IE进行切换;</li>
											<li>【UI优化】日志功能查看，表单样式优化;</li>
											<li>【demo】列表字段 设置颜色 demo;</li>
											<li>【demo】左右布局demo;</li>
											<li>【demo】springjdbc demo;</li>
											<li>【demo】 通用上传功能demo;</li>
											<li>【demo】树形列表 分页demo;</li>
											<li>【demo】采用jeecg-p3插件模式demo;</li>
											<li>【demo】popup赋多个值 demo;</li>
											<li>【demo】 ztree 实现一个可编辑的树;</li>
											<li>【demo】datagrid 多表头demo;</li>
											<li>【demo】Minidao 数据权限例子;</li>
											<li>【demo】采用标签实现多tab例子;</li>
											<li>【demo】列表标签，exp显示表达式demo;</li>
											<li>【demo】分页多选排序demo;</li>
											<li>【bug】三级菜单删除不成功;</li>
											<li>【bug】shortcut及经典下同名菜单冲突，只能点开一个;</li>
											<li>【bug】shortcut 风格下 layui 确认框 删除确认后不关闭问题;</li>
											<li>【bug】SimpleDateFormat多线程不安全，解决;</li>
											<li>【bug】连接池关闭异常处理;</li>
											<li>【性能优化】online表单访问慢，优化 ;</li>
											<li>【性能优化】优化登录逻辑  ;</li>
											<li>【性能优化】Maven 集成yuicompressor，实现打包压缩静态资源 js css，提高web效率;</li>
											<li>TabsTag.java等，发布模式下缓存机制有效（开发模式无缓存）;</li>
											<li>【性能问题】表索引追加，提高系统性能;</li>
                                        </ol>
                                    </div>
                                </div>
                        </div>
                        <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h5 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#version" href="#v45">v3.7</a><code class="pull-right">2017.04.20</code>
                                    </h5>
                                </div>
                                <div id="v45" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <div class="alert alert-warning">此版本微服务版本，支持插件开发，让我们共同期待后续版本的到来</div>
                                        <ol>
                                        	<li>精简平台代码，重写demo模块，删除无用的JS插件;</li>
                                        	<li>美化平台界面，涉及表单、按钮、链接、my97时间控件、树控件等;</li>
											<li>优化平台，提高平台性能，解决内存溢出问题;</li>
											<li>重构权限（涉及菜单、按钮、表单权限、数据权限等）;</li>
											<li>角色权限树状采用ztree重写，支持切换级联模式;</li>
											<li>公告管理，优化改造，提高性能;</li>
											<li>Onlinecoding 代码生成器，支持树的生成;</li>
											<li>Online、自定义表单，请求方式改造（重要）;</li>
											<li>online 代码生成器模板重构，采用自定义方式;</li>
											<li>Online自定义样式表增加激活状态;</li>
											<li>online 一对多模型，支持UE编辑器;</li>
											<li>online 表单对外接口，支持增删改查;</li>
											<li>online sql增强上下文变量修改;</li>
											<li>online 加强校验机制，校验规则采用选择方式;</li>
											<li>提示信息采用layer风格提示框;</li>
											<li>自定义表单支持表单权限控制;</li>
											<li>自定义表单支持JS增强、Java增强;</li>
											<li>自定义表单，支持默认字段赋值;</li>
											<li>自定义表单，支持精细化校验配置;</li>
											<li>自定义表单，预览页面美化;</li>
											<li>自定义表单数据中心，支持与工作流对接;</li>
											<li>自定义表单，支持双击生成控件功能;</li>
											<li>自定义表单，支持精细化校验规则;</li>
											<li>Datagrid列表标签、支持多字段排序;</li>
											<li>封装popup组件：部门选择、用户选择;</li>
											<li>重构树标签，简化树列表功能写法;</li>
											<li>封装新组织机构选择标签，不同的展示风格供用户选择;</li>
											<li>封装新的上传标签，支持文件图片，简化上传功能;</li>
											<li>Datagrid列表标签，查询条件时间控件自动生成，无需配置;</li>
											<li>Datagrid列表标签，支持切换UI，目前新增支持jqgrid列表展示形式;</li>
											<li>easpoi，导出支持字典配置;</li>
											<li>解决jeecg maven启动打包等问题;</li>
											<li>解决多数据源添加报错bug;</li>
											<li>解决组织机构维护bug修复;</li>
											<li>解决，点击报表打印，页面乱问题;</li>
											<li>解决，在线用户数据不准确问题;</li>
											<li>解决，easyui列表序号分页错误;</li>
											<li>日志输出格式修改;</li>
											<li>弹出窗口最大化JS，处理;</li>
                                            <li>JEECG更多源码下载：http://www.jeecg.com </li>
                                            <li>更多插件发布，敬请期待。。</li>
                                        </ol>
                                    </div>
                                </div>
                        </div>
                        <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h5 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#version" href="#v44">v3.6.6</a><code class="pull-right">2017.02.08</code>
                                    </h5>
                                </div>
                                <div id="v44" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <div class="alert alert-warning">此版本微服务版本，支持插件开发，让我们共同期待后续版本的到来</div>
                                        <ol>
                                        	<li>插件：集成即时聊天webim聊天插件;</li>
                                            <li>插件：我的邮箱风格改版</li>
                                        	<li>online表单支持多配置表模式;</li>
                                            <li>online自定义样式BUG修正;</li>
                                            <li>online功能，word布局自定义模板功能优化：多文件上传、多选checkbox编辑赋值；</li>
                                            <li>ACE系统菜单支持自定义图标样式;</li>
                                            <li>ACE首页风格支持三级菜单;</li>
                                            <li>IE8兼容性修正;</li>
                                            <li>Ztree树标签;</li>
                                            <li>Sqlserver驱动升级，支持2008;</li>
                                            <li>系统管理，组织机构角色赋权功能实现；</li>
                                            <li>代码重构优化</li>
                                            <li>JEECG更多源码下载：http://www.jeecg.com </li>
                                            <li>更多插件发布，敬请期待。。</li>
                                        </ol>
                                    </div>
                                </div>
                        </div>
                        <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h5 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#version" href="#v41">v3.6.5</a><code class="pull-right">2016.07.18</code>
                                    </h5>
                                </div>
                                <div id="v41" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <div class="alert alert-warning">此版本云应用插件开发版本，支持以插件方式升级平台功能，让我们共同期待后续版本的到来</div>
                                        <ol>
                                        	<li>Jeecg3.6.4稳定升级版，精简功能；</li>
                                        	<li>我的邮箱插件功能；</li>
                                            <li>用户锁定提示信息不准确修复；</li>
                                            <li>通过组织机构查看不到用户；</li>
                                            <li>Online代码生成器,支持自定义模板；</li>
                                            <li>Online代码生成器,单表生成支持java增强、sql增强、js增强、自定义按钮、自定义操作；</li>
                                            <li>删掉 OpenLayers-2.11、我的邮箱，在线文档的功能；</li>
                                            <li>多数据源，数据库密码进行加密存储；</li>
                                            <li>datagrid查询条件增加默认值属性；</li>
                                            <li>百度UE编辑器，上传问题解决；</li>
                                            <li>提供mysql、oracle11g、SqlServer2005脚本；</li>
                                            <li>插件发布：我的邮箱</li>
                                            <li>插件发布：CMS系统</li>
                                            <li>插件发布：微信企业号管理平台</li>
                                            <li>JEECG更多源码下载：http://www.jeecg.com </li>
                                            <li>更多插件发布，敬请期待。。</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h5 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#version" href="#v42">v3.6.4</a><code class="pull-right">2016.07.01</code>
                                    </h5>
                                </div>
                                <div id="v42" class="panel-collapse collapse">
                                    <div class="panel-body">
                                       <div class="alert alert-warning">此版本云应用插件开发版本，支持以插件方式升级平台功能，让我们共同期待后续版本的到来</div>
                                        <ol>
                                            <li>扁平化新首页风格；</li>
                                        	<li>jeecg性能优化；</li>
                                            <li>ACE菜单显示不全BUG修复；</li>
                                            <li>解决浏览器报错问题和favicon问题；</li>
                                            <li>特殊布局商品管理demo（上下布局）；</li>
                                            <li>Online表单支持索引配置；</li>
                                            <li>修复ONLINE远程数据库加载慢导致表字段加载不出来；</li>
                                            <li>我的邮箱编辑器问题修复；</li>
                                            <li>ONLINE列表singleSelect属性设置；</li>
                                            <li>代码生成器模板扩展支持UE编辑器；</li>
                                            <li>查询过滤器，采用追加*方式进行模糊查询</li>
                                            <li>UI标签库 t:dgCol 显示内容长度控制；</li>
                                            <li>popup选择组织机构，用户通用JS封装；</li>
                                            <li>火狐下上传文件bug修复；</li>
                                            <li>用户删除，改成逻辑删除；</li>
                                            <li>JEECG更多源码下载：http://www.jeecg.com </li>
                                            <li>插件发布：CMS系统</li>
                                            <li>插件发布：微信企业号管理平台</li>
                                            <li>更多插件发布，敬请期待。。</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                             <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h5 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#version" href="#v43">v3.6.3</a><code class="pull-right">2016.04.09</code>
                                    </h5>
                                </div>
                                <div id="v43" class="panel-collapse collapse">
                                    <div class="panel-body">
                                       <div class="alert alert-warning">此版本是一个扁平化UI风格版，提供4套风格供客户选择，让我们共同期待后续版本的到来</div>
                                        <ol>
                                            <li>ACE扁平化风格；</li>
                                            <li>代码生成器，支持restful后台代码生成；</li>
                                            <li>Online表单提供对外HTTP接口；</li>
                                            <li>用户，角色，组织机构，导入功能；</li>
                                            <li>多附件上传报错处理；</li>
                                            <li>查询过滤器查询报错处理；</li>
                                            <li>online代码生成器支持bootstrap表单风格生成；</li>
                                            <li>online代码生成器支持上传组件生成；</li>
                                            <li>升级minidao；</li>
                                            <li>在线文档管理；</li>
                                            <li>邮件管理；</li>
                                            <li>封装标签：用户标签，组织机构标签；</li>
                                            <li>移动报表展示；</li>
                                            <li>插件演示；</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h5 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#version" href="#v31">v3.6.2</a><code class="pull-right">2016.03.15</code>
                                    </h5>
                                </div>
                                <div id="v31" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <div class="alert alert-warning">此版本是一个移动开发版，主要是拓展移动开发能力和可插拔插件开发能力</div>
                                        <ol>
                                            <li>平台插件支持（可插拔）；</li>
                                            <li>移动报表配置能力（一次配置，7种展示风格）；</li>
                                            <li>移动表单支持（提供多套移动模板）；</li>
                                            <li>移动OA审批；</li>
                                            <li>新增系统公告；</li>
                                            <li>新增招聘管理；</li>
                                            <li>新增在线文档；</li>
                                            <li>新版ACE首页优化（首页+表单优化）；</li>
                                            <li>升级Spring,支持单元测试；</li>
                                            <li>集成cxf webservice接口，并实现一个服务端和客户端调用的demo；</li>
                                            <li>数据库兼容性修改，支持oracle\mysql\sqlserver\postgresql；</li>
                                            <li>online支持UE编辑器类型；</li>
                                            <li>数据权限扩展支持写表达式，通过session取值；</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h5 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#version" href="#v30">v3.6.0</a><code class="pull-right">2015.12.04</code>
                                    </h5>
                                </div>
                                <div id="v30" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <ol>
                                            <li>表单设计器</li>
                                            <li>Online表单配置 能力升级</li>
                                            <li>动态报表支持多数据源</li>
                                            <li>UI标签中增加扩展参数</li>
                                            <li>列表高级查询功能</li>
                                            <li>数据权限、按钮权限优化改进</li>
                                            <li>在线文档预览，TXT文件预览乱码解决</li>
                                            <li>增加行编辑DEMO</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h5 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#version" href="#v32">v3.5.0</a><code class="pull-right">2015.03.10</code>
                                    </h5>
                                </div>
                                <div id="v32" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <ol>
                                            <li>支持数据权限，按钮级、数据行级、列级、字段级；</li>
                                            <li>支持多组织机构，多公司支持（支持多子公司，组织机构无限级）；</li>
                                            <li>支持国际化， 多语言；</li>
                                            <li>支持多数据源 （在线配置数据源）；</li>
                                            <li>云桌面首页风格（适合pad，移动应用）；</li>
                                            <li>动态报表完善（支持在线配置sql，生成报表）；</li>
                                            <li>扩展增加jquery file上传附件组件，多种上传文件风格；</li>
                                            <li>代码生成器支持多种分层方式；</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h5 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#version" href="#v33">更多版本...</a><code class="pull-right"></code>
                                    </h5>
                                </div>
                                <div id="v33" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <ol>
                                            <li>更多版本，请详见官网：www.jeecg.com</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-4">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>JEECG 适用范围</h5>
                </div>
                <div class="ibox-content">
                    <p>为什么选择jeecg？</p>
                    <ol>
                        <li>采用主流框架，容易上手，学习成本低；</li>
                        <li>强大代码生成器和在线配置能力，提高开发效率，大大缩短项目周期；</li>
                        <li>开源免费，万人活跃社区；</li>
                        <li>封装基础用户权限，报表等功能模块，无需再次开发；</li>
                        <li>采用SpringMVC + Hibernate + Minidao+ Easyui+Jquery+Boostrap等基础架构</li>
                        <li>支持多浏览器，多数据库；</li>
                        <li>支持移动开发，可以完美兼容电脑、手机、pad等多平台；</li>
                        <li>……</li>
                    </ol>
                    <hr>
                    <div class="alert alert-warning">JEECG智能开发平台，可以应用在任何J2EE项目的开发中，尤其适合企业信息管理系统（MIS）、内部办公系统（OA）、企业资源计划系统（ERP） 、客户关系管理系统（CRM）等，其半智能手工Merge的开发方式，可以显著提高开发效率60%以上，极大降低开发成本。
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 全局js -->
<!-- update-begin--Author:zhoujf  Date:20180428 for：TASK #2677 【H+风格优化】hplus 引入样式从jar中移到 开源项目中 -->
<script src="plug-in/hplus/js/jquery.min.js?v=2.1.4"></script>
<script src="plug-in/hplus/js/bootstrap.min.js?v=3.3.6"></script>
<!-- 自定义js -->
<script src="plug-in/hplus/js/content.js"></script>
<!-- update-end--Author:zhoujf  Date:20180428 for：TASK #2677 【H+风格优化】hplus 引入样式从jar中移到 开源项目中 -->
<script type="text/javascript" src="plug-in/echart/echarts.min.js"></script>
<script type="text/javascript" src="plug-in/jquery-plugs/i18n/jquery.i18n.properties.js"></script>
<t:base type="tools"></t:base>
<script type="text/javascript" src="plug-in/login/js/getMsgs.js"></script>
<script>
$(document).ready(function() {
	//直接嵌套显示
    laydate.render({
      elem: '#calendar'
      ,position: 'static'
      ,theme: 'molv'
    	
    });
	var chart1 = echarts.init(document.getElementById('chart1'));
	var chart2 = echarts.init(document.getElementById('chart2'));
	var chart3 = echarts.init(document.getElementById('chart3'));
	var chart4 = echarts.init(document.getElementById('chart4'));
	$.ajax({
		type : "POST",
		url : "jeecgListDemoController.do?broswerCount&reportType=pie",
		success : function(jsondata) {
			jsondata=JSON.parse(jsondata);
			var data=jsondata[0].data;
			var xAxisData=[];
			var seriesData=[];
			var picData = [];
			for(var i in data){
				xAxisData.push(data[i].name);
				seriesData.push(data[i].percentage);
				picData.push({"value":data[i].percentage,"name":data[i].name});
			}
			chart1.setOption({
				tooltip: {
					trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
				},
			    legend: {
			        data: xAxisData
			    },
			    series : [
					        {
					            name: "用户人数",
					            type: 'pie',
					            radius : '55%',
					            center: ['50%', '60%'],
					            data:picData,
					            itemStyle: {
					                emphasis: {
					                    shadowBlur: 10,
					                    shadowOffsetX: 0,
					                    shadowColor: 'rgba(0, 0, 0, 0.5)'
					                }
					            }
					        }
					    ]
			});
		}
	});
	
	
	var option3 = {
		    tooltip : {
		        formatter: "{a} <br/>{b} : {c}%"
		    },
		    toolbox: {
		        feature: {
		            restore: {},
		            saveAsImage: {}
		        }
		    },
		    series: [
		        {
		            name: '业务指标',
		            type: 'gauge',
		            detail: {formatter:'{value}%'},
		            data: [{value: 50, name: '完成率'}]
		        }
		    ]
		};

	$.ajax({
		type : "POST",
		url : "jeecgListDemoController.do?broswerCount&reportType=column",
		success : function(jsondata) {
			jsondata=JSON.parse(jsondata);
			var data=jsondata[0].data;
			var xAxisData=[];
			var seriesData=[];
			for(var i in data){
				xAxisData.push(data[i].name);
				seriesData.push(data[i].percentage);
			}
			var option3 = {
		            tooltip: {},
		            legend: {
		                data:[jsondata[0].name],
		                left:'center'
		            },
		            xAxis: {
		            	type: 'category',
		                data: xAxisData,
		                axisLabel:{
		                	interval:0,//横轴信息全部显示
		                	rotate:-30,//-10角度倾斜展示
		                }
		            },
		            yAxis: {},
		            series: [{
		                name: jsondata[0].name,
		                type: 'bar',
		                data: seriesData
		            }]
		        };
			chart3.setOption(option3);
		}
	});
		
		$.ajax({
			type : "POST",
			url : "jeecgListDemoController.do?broswerCount&reportType=line",
			success : function(jsondata) {
				jsondata=JSON.parse(jsondata);
				var data=jsondata[0].data;
				var xAxisData=[];
				var seriesData=[];
				for(var i in data){
					xAxisData.push(data[i].name);
					seriesData.push(data[i].percentage);
				}
				var option4 = {
					    color: ['#3398DB'],
					    tooltip : {
					        trigger: 'axis',
					        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
					            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
					        }
					    },
					    grid: {
					        left: '3%',
					        right: '4%',
					        bottom: '10%',
					        containLabel: true
					    },
					    xAxis : [
					        {
					            type : 'category',
					            data : xAxisData,
					            axisTick: {
					                alignWithLabel: true
					            },
					            axisLabel:{
				                	interval:0,//横轴信息全部显示
				                	rotate:-30,//-10角度倾斜展示
				                }
					        }
					    ],
					    yAxis : [
					        {
					            type : 'value'
					        }
					    ],
					    series : [
					        {
					            name:'用户人数',
					            type:'line',
					            barWidth: '60%',
					            data:seriesData
					        }
					    ]
					};
				chart4.setOption(option4, true);
			}
		});
		
		var colors = ['#5793f3', '#d14a61', '#675bba'];
		$.ajax({
			type : "POST",
			url : "graphReportController.do?datagridGraph",
			data:{
				configId:'yhcztj'
			},
			success : function(jsondata) {
				var data = jsondata.rows;
				var xAxisData=[];
				var seriesData=[];
				var loginData=[];
				if(data!=null){
					for(var i = data.length-1; i >= 0; i--){
						xAxisData.push(data[i].userid);	//用户名
						seriesData.push(data[i].ct);	//操作次数
						loginData.push(data[i].login_count);//登陆次数
					}
				}
				var option2 = {
			            tooltip : {
			                trigger: 'axis',
			                axisPointer : {
			                    type : 'shadow'
			                }
			            },
			            legend: {
			                data: ["操作次数",'登陆次数']
			            },
			            grid: {
			                left: '1%',
			                right: '6%',
			                bottom: '3%',
			                containLabel: true
			            },
			            xAxis:  {
			                type: 'value'
			            },
			            yAxis: {
			                type: 'category',
			                data: xAxisData
			            },
			            series: [
			                {
			                    name: '操作次数',
			                    type: 'bar',
			                    stack: '总量',
			                    label: {
			                        normal: {
			                            show: true,
			                            position: 'insideRight'
			                        }
			                    },
			                    data : seriesData
			                },
			                {
			                    name: '登陆次数',
			                    type: 'bar',
			                    stack: '总量',
			                    label: {
			                        normal: {
			                            show: true,
			                            position: 'insideRight'
			                        }
			                    },
			                    data : loginData
			                }
			            ]
			        };
				chart2.setOption(option2, true);
			}
		});
		
		
		
		$(window).resize(chart1.resize);
		$(window).resize(chart2.resize);
		$(window).resize(chart3.resize);
		$(window).resize(chart4.resize);
});
</script>
<!--统计代码，可删除-->
<script type="text/javascript" src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>
</body>
</html>