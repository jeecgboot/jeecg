<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>单据打印</title>
<meta name="keywords" content="">
<meta name="description" content="">
<link rel="shortcut icon" href="favicon.ico"> <link href="plug-in/bootstrap3.3.5/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="plug-in/hplus/css/font-awesome.css?v=4.4.0" rel="stylesheet">
<link href="plug-in/hplus/css/animate.css" rel="stylesheet">
<link href="plug-in/hplus/css/style.css?v=4.1.0" rel="stylesheet">
</head>
<body class="white-bg">
    <div class="wrapper wrapper-content p-xl">
        <div class="ibox-content p-xl">
            <div class="row">
                <div class="col-sm-6">
                    <address>
                        <strong>北京百度在线网络技术有限公司</strong><br>
                        北京市海淀区上地十街10号<br>
                        <abbr title="Phone">总机：</abbr> (+86 10) 5992 8888
                    </address>
                </div>

                <div class="col-sm-6 text-right">
                    <h4>单据编号：</h4>
                    <h4 class="text-navy">H+-000567F7-00</h4>
                    <address>
                        <strong>阿里巴巴集团</strong><br>
                        中国杭州市华星路99号东部软件园创业大厦6层(310099)<br>
                        <abbr title="Phone">总机：</abbr> (86) 571-8502-2088
                    </address>
                    <p>
                        <span><strong>日期：</strong> 2014-11-11</span>
                    </p>
                </div>
            </div>

            <div class="table-responsive m-t">
                <table class="table invoice-table">
                    <thead>
                        <tr>
                            <th>清单</th>
                            <th>数量</th>
                            <th>单价</th>
                            <th>税率</th>
                            <th>总价</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <div><strong>尚都比拉2013冬装新款女装 韩版修身呢子大衣 秋冬气质羊毛呢外套</strong>
                                </div>
                            </td>
                            <td>1</td>
                            <td>&yen;26.00</td>
                            <td>&yen;1.20</td>
                            <td>&yen;31,98</td>
                        </tr>
                        <tr>
                            <td>
                                <div><strong>11*11夏娜 新款斗篷毛呢外套 女秋冬呢子大衣 韩版大码宽松呢大衣</strong>
                                </div>
                                <small>双十一特价
                                            </small>
                            </td>
                            <td>2</td>
                            <td>&yen;80.00</td>
                            <td>&yen;1.20</td>
                            <td>&yen;196.80</td>
                        </tr>
                        <tr>
                            <td>
                                <div><strong>2013秋装 新款女装韩版学生秋冬加厚加绒保暖开衫卫衣 百搭女外套</strong>
                                </div>
                            </td>
                            <td>3</td>
                            <td>&yen;420.00</td>
                            <td>&yen;1.20</td>
                            <td>&yen;1033.20</td>
                        </tr>

                    </tbody>
                </table>
            </div>
            <!-- /table-responsive -->

            <table class="table invoice-total">
                <tbody>
                    <tr>
                        <td><strong>总价：</strong>
                        </td>
                        <td>&yen;1026.00</td>
                    </tr>
                    <tr>
                        <td><strong>税：</strong>
                        </td>
                        <td>&yen;235.98</td>
                    </tr>
                    <tr>
                        <td><strong>总计</strong>
                        </td>
                        <td>&yen;1261.98</td>
                    </tr>
                </tbody>
            </table>

            <div class="well m-t"><strong>注意：</strong> 请在30日内完成付款，否则订单会自动取消。
            </div>
        </div>

    </div>

    <!-- 全局js -->
    <script src="plug-in/hplus/js/jquery.min.js?v=2.1.4"></script>
    <script src="plug-in/bootstrap3.3.5/js/bootstrap.min.js?v=3.3.6"></script>



    <!-- 自定义js -->
    <script src="plug-in/hplus/js/content.js?v=1.0.0"></script>

    <script type="text/javascript">
        window.print();
    </script>

    <script type="text/javascript" src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>
    <!--统计代码，可删除-->

</body>

</html>
