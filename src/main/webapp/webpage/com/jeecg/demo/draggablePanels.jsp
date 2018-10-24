<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>拖动面板</title>

    <link rel="shortcut icon" href="favicon.ico"> <link href="plug-in/hplus/css/bootstrap.min.css" rel="stylesheet">
    <link href="plug-in/hplus/css/font-awesome.css" rel="stylesheet">
    <link href="src/main/webapp/plug-in/hplus/css/animate.css" rel="stylesheet">
    <link href="plug-in/hplus/css/style.css" rel="stylesheet">

</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content  animated fadeInRight">
        <div class="row">
            <div class="col-sm-6">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>v3.7.8</h5>
                        <div class="ibox-tools">
                            <label class="label label-primary">可拖动</label>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <h2>
                                版本 3.7.8 中的新功能
                            </h2>
                        <p>
                          	1.【新功能】一套新的代码生成器模板，Bootstrap表单+EasyUI列表（单表、一对多）;
                            <br>2.【新功能】一套新的代码生成器模板，Bootstrap表单+EasyUI原生列表（单表、一对多）;
                            <br>3.【新功能】一套新的代码生成器模板， Boostrap表单+BootstapTable原生列表（单表、一对多）;
                            <br>4.【新功能】一套新的代码生成器模板，Boostrap表单+BootstapTable标签列表（单表、一对多）;
                            <br>5.【新功能】Datagrid列表按钮折叠功能;
                            <br>6.【新功能】webuploader上传组件支持openoffice格式转换控制;
                            <br>7.【新功能】validform标签验证提示效果扩展tiptype="6";
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="ibox float-e-margins no-drop">
                    <div class="ibox-title">
                        <h5>v3.7.7</h5>
                        <div class="ibox-tools">
                            <label class="label label-danger">不可拖动</label>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <h2>
                                版本 3.7.7 中的新功能
                            </h2>
                        <p>
                            1.【新功能】一套新的代码生成器模板，Bootstrap表单+EasyUI列表（单表、一对多）;
                            <br>2.【新功能】一套新的代码生成器模板，Bootstrap表单+EasyUI原生列表（单表、一对多）;
                            <br>3.【bug】online 开发，自定义按钮显示表达式问题;
                            <br>4.【bug】Online移动报表功能演示导出Excel报错;
                            <br>5.【bug】新版代码生成器乱码问题;
                            <br>6.【bug】SystemService.addLog( )的调用，第二个参数和第三个参数搞错了;
                            <br>7.【bug】Online word 布局模板唯一值校验问题;
                        </p>
                    </div>
                </div>
            </div>

        </div>
        <div class="row">
            <div class="col-sm-4">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>v 3.7.6</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="fa fa-wrench"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="#">选项1</a>
                                </li>
                                <li><a href="#">选项2</a>
                                </li>
                            </ul>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <h2>
                                版本 3.7.6 中的新功能
                            </h2>
                        <p>
                            1.【功能升级】新一代 (一对多) 代码生成器模板，EasyUI标签列表上下布局(列表数据编辑)+Table风格表单功能优化升级;
                            <br>2.【功能升级】牛牛叉功能 -> Datagrid标签升级,通过参数component可以快速实现BootstrapTable与easyUI列表风格切换功能优化升级;
                            <br>3.【功能改造】清理hplus/js/plugins下的插件;
                            <br>4.【功能改造】将不常改的js组件放进jar包 jeecg-plugin-in,减少eclipse check js;
                            <br>5.【功能改造】删除无用的代码，减少项目jar依赖;
                            <br>6.【功能改造】提示信息停留时间延长;
                            <br>7.【功能改造】防止SQL注入处理;
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>v 3.7.5</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="fa fa-wrench"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="#">选项1</a>
                                </li>
                                <li><a href="#">选项2</a>
                                </li>
                            </ul>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <h2>
                                版本 3.7.5 中的新功能
                            </h2>
                        <p>
                            1.【新增功能】新一代更灵活的代码生成器工厂，可灵活自定义生成的代码文件名称、路径等；根据模板结构生成代码文件;
                            <br>2.【新增功能】新一代 (单表/一对多) 代码生成器模板，Vue+ElementUI风格;
                            <br>3.【新增功能】新一代 (一对多) 代码生成器模板，ElementUI表单+EasyUI原生态列表风格;
                            <br>4.【新增功能】新一代 (一对多) 代码生成器模板，EasyUI标签列表上下布局(列表数据编辑)+Table风格表单;
                            <br>5.【Demo】Vue bootstrap 示例;
                            <br>6.【Demo】Vue elementUI 示例;
                            <br>7.【Demo】bootstrapTable+ bootstrap表单 示例;
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="ibox float-e-margins no-drop">
                    <div class="ibox-title">
                        <h5>v 3.7.4</h5>
                        <div class="ibox-tools">
                            <label class="label label-danger">不可拖动</label>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <h2>
                                版本 3.7.4 中的新功能
                            </h2>
                        <p>
                            1.【新增功能】“常用示例-原生态组件”增加省市区复杂的三级联动效果，控件美观，可以很友好的进行省市区的选择;
                            <br>2.【新增功能】新增ECharts集成demo(仪表图、日程图、柱状图、漏斗图折、线图、饼状图、点状图、矩阵图等);
                            <br>3.【新增功能】新增二维码生成demo功能，可自定义生成url，二维码大小;
                            <br>4.【功能升级】Online表单开发优化,增加添加的online唯一校验，表单填值功能，校验提示优化;
                            <br>5.【功能升级】升级聊天版本支持历史消息提醒;
                            <br>6.【BUG】一对多模板，子表设置radio情况下，点击删除，会全部删除问题;
                            <br>7.【BUG】连接外部数据库导致系统很慢问题修正;
                        </p>
                    </div>
                </div>
            </div>

        </div>
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>v 3.7.3</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="fa fa-wrench"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="#">选项1</a>
                                </li>
                                <li><a href="#">选项2</a>
                                </li>
                            </ul>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <h2>
                                版本 3.7.3 中的新功能
                            </h2>
                        <p>
                           1.【新功能】restful接口统一采用jwt token机制登录验证机制，方便客户端对接;
                            <br>2.【新功能】接口权限管理，针对restful接口可细化权限控制，实现不同接口人查询不同数据;
                            <br>3.【新功能】集成swagger支持，在线可视化接口文档;
                            <br>4.【新功能】WebUploaderTag的通用上传请求，支持ftpclient模式
                            <br>5.【新功能】代码生成器模板修改，追加swagger-ui注解，自动生成;
                            <br>6.【新功能】Online在线风格，新增主子表风格：列表数据点击，可展开显示子表数据;
                            <br>7.【新功能】代码生成器新增模板，一对多新模板，全tab风格，表单字段分块布局;
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!-- 全局js -->
    <script src="plug-in/hplus/js/jquery.min.js"></script>
    <script src="plug-in/hplus/js/bootstrap.min.js"></script>



    <!-- Peity -->
    <script src="plug-in/hplus/js/plugins/peity/jquery.peity.min.js"></script>

    <!-- 自定义js -->
    <script src="plug-in/hplus/js/content.js"></script>


    <script src="plug-in/hplus/js/jquery-ui-1.10.4.min.js"></script>

    <!-- iCheck -->
    <script src="plug-in/hplus/js/plugins/iCheck/icheck.min.js"></script>

    <!-- Peity d data  -->
    <script src="plug-in/hplus/js/demo/peity-demo.js"></script>

    <script>
        $(document).ready(function () {
            WinMove();
        });
    </script>

</body>

</html>
