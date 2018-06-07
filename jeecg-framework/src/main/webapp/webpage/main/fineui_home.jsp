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
    <!--  <link href="plug-in/themes/fineui/css/animate.css" rel="stylesheet">
    <link href="plug-in/themes/fineui/css/style.css?v=4.1.0" rel="stylesheet"> -->
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
	.color_red{color:#e55555;} */
    </style>
</head>
 <body class="gray-bg">
        <div class="wrapper wrapper-content">
           
			<div class="row">
                <div class="col-sm-2">
					<div class="widget  p-lg text-center" style="background: #cfa972;">
						<div><!-- class="ibtn" -->
                            <i class="iconfont icon-zhihuizhongxin" style="font-size: 30px;"></i>
                            <h3 class="font-bold no-margins"></h3>
                            <small>功能1</small>
                        </div>
                    </div>
                </div>
                <div class="col-sm-2" >
					<div class="widget  p-lg text-center" style="background: #f29b76;">
						<div>
                            <i class="iconfont icon-yujing" style="font-size: 30px;"></i>
                            <h3 class="font-bold no-margins"></h3>
                            <small>功能2</small>
                        </div>
                    </div>
                </div>
                <div class="col-sm-2" >
					<div class="widget  p-lg text-center" style="background: #acd598;">
						<div>
                            <i class="iconfont icon-ln-" style="font-size: 30px;"></i>
                            <h3 class="font-bold no-margins"></h3>
                            <small>功能3</small>
                        </div>
                    </div>
                </div>
                <div class="col-sm-2" style="width: 9%;">
					<div class="widget  p-lg text-center" style="background: #84ccc9;">
						<div>
                            <i class="iconfont icon-wuliu" style="font-size: 30px;"></i>
                            <h3 class="font-bold no-margins"></h3>
                            <small>功能4</small>
                        </div>
                    </div>
                </div>
                <div class="col-sm-2" style="width: 11%;">
					<div class="widget  p-lg text-center" style="background: #89c997;">
						<div>
                            <i class="iconfont icon-quanshengmingzhouqiguanli" style="font-size: 30px;"></i>
                            <h3 class="font-bold no-margins"></h3>
                            <small>功能5</small>
                        </div>
                    </div>
                </div>
                <div class="col-sm-2" >
					<div class="widget  p-lg text-center" style="background: #88abda;">
						<div>
                            <i class="iconfont icon-jixiao" style="font-size: 30px;"></i>
                            <h3 class="font-bold no-margins"></h3>
                            <small>功能6</small>
                        </div>
                    </div>
                </div>
				<div class="col-sm-2" >
					<div class="widget  p-lg text-center" style="background: #8c97cb;">
						<div>
                            <i class="iconfont icon-fangdajing-copy" style="font-size: 30px;"></i>
                            <h3 class="font-bold no-margins"></h3>
                            <small>功能7</small>
                        </div>
                    </div>
                </div>
				<div class="col-sm-2" >
					<div class="widget  p-lg text-center" style="background: #c490bf;">
						<div>
                            <i class="iconfont icon--youhuajieduan" style="font-size: 30px;"></i>
                            <h3 class="font-bold no-margins"></h3>
                            <small>功能8</small>
                        </div>
                    </div>
                </div>
				<div class="col-sm-2" >
					<div class="widget  p-lg text-center" style="background: #f19ec2;">
						<div>
                            <i class="iconfont icon-duoren" style="font-size: 30px;"></i>
                            <h3 class="font-bold no-margins"></h3>
                            <small>功能9</small>
                        </div>
                    </div>
                </div>
				<div class="col-sm-2" >
					<div class="widget p-lg text-center" style="background: #7ecef4;">
						<div>
                            <i class="iconfont icon-kongzhi" style="font-size: 30px;"></i>
                            <h3 class="font-bold no-margins"></h3>
                            <small>功能10</small>
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
            <b>当前版本：</b>v_3.7.6
        </p>
        <p>
            <span class="label label-warning">开源     &nbsp; | &nbsp; 免费  | &nbsp; 更多插件</span>
        </p>
        <br>
        <p>
        	<a class="btn btn-success btn-outline" href="http://yun.jeecg.org" target="_blank">
                <i class="fa fa-cloud"></i> 云应用中心
            </a>
            <a class="btn btn-white btn-bitbucket" href="http://www.jeecg.org/" target="_blank">
                <i class="fa fa-qq"> </i> 联系我们
            </a>
            <a class="btn btn-white btn-bitbucket" href="http://blog.csdn.net/zhangdaiscott" target="_blank">
                <i class="fa fa-home"></i> 官方博客
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
                    <p><i class="fa fa-send-o"></i> 官网：<a href="http://www.jeecg.org" target="_blank">http://www.jeecg.org</a>
                    </p>
                    <p><i class="fa fa-qq"></i> QQ群：<a href="javascript:;">190866569</a>
                    </p>
                    <p><i class="fa fa-weixin"></i>微信公众号：<a href="javascript:;">jeecg</a>
                    </p>
                    <p><i class="fa fa-credit-card"></i> 邮箱：<a href="javascript:;" class="邮箱">jeecg@sina.com</a>
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
                                        <a data-toggle="collapse" data-parent="#version" href="#v54">v3.7.6</a><code class="pull-right">2018.06.06</code>
                                    </h5>
                                </div>
                                <div id="v54" class="panel-collapse collapse in">
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
                                            <li>JEECG云插件下载地址：http://yun.jeecg.org </li>
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
                                            <li>JEECG云插件下载地址：http://yun.jeecg.org </li>
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
                                            <li>JEECG云插件下载地址：http://yun.jeecg.org </li>
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
                                            <li>JEECG云应用平台中心发布：http://yun.jeecg.org </li>
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
                                            <li>更多版本，请详见论坛：www.jeecg.org</li>
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
<script src="plug-in/hplus/js/jquery.min.js?v=2.1.4"></script>
<script src="plug-in/hplus/js/bootstrap.min.js?v=3.3.6"></script>
<!-- 自定义js -->
<script src="plug-in/hplus/js/content.js"></script>
<script type="text/javascript" src="plug-in/echart/echarts.min.js"></script>
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
<script type="text/javascript" src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>
<!--统计代码，可删除-->
</body>
</html>