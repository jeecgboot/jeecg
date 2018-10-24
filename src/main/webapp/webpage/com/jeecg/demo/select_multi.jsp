<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>下拉多选demo</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="这是一个基于 bootstrap 下拉多选demo">
    <meta name="Keywords" content="bootstrap,下拉多选demo"/>
    <link href="plug-in/hplus/css/bootstrap.min.css" rel="stylesheet">
    <script src="plug-in/hplus/js/jquery.min.js"></script>
    <link href="plug-in/hplus/css/plugins/chosen/chosen.css" rel="stylesheet">
    <script src="plug-in/hplus/js/plugins/chosen/chosen.jquery.js"></script>
    <link href="plug-in/hplus/css/style.css" rel="stylesheet">
</head>
<body>
<div class="container">
<div class="row" style="margin-top:10px">
	 <select data-placeholder="选择省份..." class="chosen-select1" style="width:350px;" tabindex="2">
		<option value="">请选择省份</option>
		<option value="110000" hassubinfo="true">北京</option>
		<option value="120000" hassubinfo="true">天津</option>
		<option value="130000" hassubinfo="true">河北省</option>
		<option value="140000" hassubinfo="true">山西省</option>
		<option value="150000" hassubinfo="true">内蒙古自治区</option>
		<option value="210000" hassubinfo="true">辽宁省</option>
		<option value="220000" hassubinfo="true">吉林省</option>
		<option value="230000" hassubinfo="true">黑龙江省</option>
		<option value="310000" hassubinfo="true">上海</option>
		<option value="320000" hassubinfo="true">江苏省</option>
		<option value="330000" hassubinfo="true">浙江省</option>
		<option value="340000" hassubinfo="true">安徽省</option>
		<option value="350000" hassubinfo="true">福建省</option>
		<option value="360000" hassubinfo="true">江西省</option>
		<option value="370000" hassubinfo="true">山东省</option>
		<option value="410000" hassubinfo="true">河南省</option>
		<option value="420000" hassubinfo="true">湖北省</option>
		<option value="430000" hassubinfo="true">湖南省</option>
		<option value="440000" hassubinfo="true">广东省</option>
		<option value="450000" hassubinfo="true">广西壮族自治区</option>
		<option value="460000" hassubinfo="true">海南省</option>
		<option value="500000" hassubinfo="true">重庆</option>
		<option value="510000" hassubinfo="true">四川省</option>
		<option value="520000" hassubinfo="true">贵州省</option>
		<option value="530000" hassubinfo="true">云南省</option>
		<option value="540000" hassubinfo="true">西藏自治区</option>
		<option value="610000" hassubinfo="true">陕西省</option>
		<option value="620000" hassubinfo="true">甘肃省</option>
		<option value="630000" hassubinfo="true">青海省</option>
		<option value="640000" hassubinfo="true">宁夏回族自治区</option>
		<option value="650000" hassubinfo="true">新疆维吾尔自治区</option>
		<option value="710000" hassubinfo="true">台湾省</option>
		<option value="810000" hassubinfo="true">香港特别行政区</option>
		<option value="820000" hassubinfo="true">澳门特别行政区</option>
		<option value="990000" hassubinfo="true">海外</option>
	</select><span class="showval1" style="margin-left:10px"></span>
</div>

<div class="row" style="margin-top:10px">
	<select data-placeholder="选择省份" class="chosen-select2" multiple style="width:350px;" tabindex="4">
		<option value="">请选择省份</option>
		<option value="110000" hassubinfo="true">北京</option>
		<option value="120000" hassubinfo="true">天津</option>
		<option value="130000" hassubinfo="true">河北省</option>
		<option value="140000" hassubinfo="true">山西省</option>
		<option value="150000" hassubinfo="true">内蒙古自治区</option>
		<option value="210000" hassubinfo="true">辽宁省</option>
		<option value="220000" hassubinfo="true">吉林省</option>
		<option value="230000" hassubinfo="true">黑龙江省</option>
		<option value="310000" hassubinfo="true">上海</option>
		<option value="320000" hassubinfo="true">江苏省</option>
		<option value="330000" hassubinfo="true">浙江省</option>
		<option value="340000" hassubinfo="true">安徽省</option>
		<option value="350000" hassubinfo="true">福建省</option>
		<option value="360000" hassubinfo="true">江西省</option>
		<option value="370000" hassubinfo="true">山东省</option>
		<option value="410000" hassubinfo="true">河南省</option>
		<option value="420000" hassubinfo="true">湖北省</option>
		<option value="430000" hassubinfo="true">湖南省</option>
		<option value="440000" hassubinfo="true">广东省</option>
		<option value="450000" hassubinfo="true">广西壮族自治区</option>
		<option value="460000" hassubinfo="true">海南省</option>
		<option value="500000" hassubinfo="true">重庆</option>
		<option value="510000" hassubinfo="true">四川省</option>
		<option value="520000" hassubinfo="true">贵州省</option>
		<option value="530000" hassubinfo="true">云南省</option>
		<option value="540000" hassubinfo="true">西藏自治区</option>
		<option value="610000" hassubinfo="true">陕西省</option>
		<option value="620000" hassubinfo="true">甘肃省</option>
		<option value="630000" hassubinfo="true">青海省</option>
		<option value="640000" hassubinfo="true">宁夏回族自治区</option>
		<option value="650000" hassubinfo="true">新疆维吾尔自治区</option>
		<option value="710000" hassubinfo="true">台湾省</option>
		<option value="810000" hassubinfo="true">香港特别行政区</option>
		<option value="820000" hassubinfo="true">澳门特别行政区</option>
		<option value="990000" hassubinfo="true">海外</option>
	</select><span class="showval2" style="margin-left:10px"></span>
</div>
<div class="row" style="margin-top:20px"><button id="getval" type="button" class="btn btn-success">点击获取控件值</button></div>
</div>
<script type="text/javascript">
$(function(){
	 $('.chosen-select1').chosen();
	 $('.chosen-select2').chosen();
	 $("#getval").click(function(){
		 var a = $('.chosen-select1').val();
		 var b = $('.chosen-select2').val();
		 $('.showval1').text("获取选中的值是："+a);
		 $('.showval2').text("获取选中的值是："+b);
	 })
});
</script>

 <div class="container" style="margin-top:20px">
 <style>
 .optionsTb{font-size:16px}
 .optionsTb tr td:first-child{padding-right:20px}
 
 </style>
 <div><h2>------------------------------------------API-------------------------------------------------</h2></div>
 <h3>配置参数</h3>
 <table class="optionsTb">
 <thead>
 <tr>
 <th>选项</th>
 <th>默认值</th>
 <th>描述</th>
 </tr>
 </thead>
 <tbody>
<tr><td>allow_single_deselect</td><td>	false</td><td>		设置为 true 时非必选的单选框会显示清除选中项图标</td></tr>
<tr><td>disable_search</td><td>		false</td><td>	设置为 true 隐藏单选框的搜索框</td></tr>
<tr><td>disable_search_threshold</td><td>		0</td><td>	少于 n 项时隐藏搜索框</td></tr>
<tr><td>enable_split_word_search</td><td>		true</td><td>	是否开启分词搜索，默认开启</td></tr>
<tr><td>inherit_select_classes</td><td>		false</td><td>	是否继承 select 元素的 class，如果设为 true，Chosen 将把 select 的 class 添加到容器上</td></tr>
<tr><td>max_selected_options</td><td>		Infinity</td><td>	最多选择项数，达到最大限制时会触发 chosen:maxselected 事件</td></tr>
<tr><td>no_results_text	</td><td>	"No results match"</td><td>	没有搜索到匹配项时显示的文字</td></tr>
<tr><td>placeholder_text_multiple</td><td>		"Select Some Options"</td><td>	多选框没有选中项时显示的占位文字</td></tr>
<tr><td>placeholder_text_single</td><td>		"Select an Option"</td><td>	单选框没有选中项时显示的占位文字</td></tr>
<tr><td>search_contains</td><td>	false</td><td>		搜素包含项，默认从第一个字符开始匹配</td></tr>
<tr><td>single_backstroke_delete</td><td>		true</td><td>	多选框中使用退格键删除选中项目，如果设为 false，第一次按 delete/backspace 会高亮最好一个选中项目，再按会删除该项</td></tr>
<tr><td>display_disabled_options</td><td>		true</td><td>	是否显示禁止选择的项目</td></tr>
<tr><td>display_selected_options</td><td>		true</td><td>	多选框是否在下拉列表中显示已经选中的项</td></tr>
</tbody>
 </table>
 <pre>
 调用方法：
 $('.chosen-select').chosen({
  disable_search_threshold: 10,
  no_results_text: 'Oops, nothing found!',
  width: '95%'
});
 </pre>
  <hr/>
 <h3>属性参数</h3>
  <table class="optionsTb">
 <thead>
 <tr>
 <th>属性</th>
 <th>描述</th>
 </tr>
 </thead>
 <tbody>
<tr><td>data-placeholder</td><td>占位符文字 </td></tr>
<tr><td>multiple</td><td>有此属性的 select 会渲染成可以多选的 Chosen 选框 </td></tr>
<tr><td>selected, disabled</td><td>设置选中、禁止状态，Chosen 会读取这些属性 </td></tr>
</tbody>
</table>
 <div style="font-size:14px;margin-top:10px">
 可以通过在select 上设置属性传递给 Chosen.<br>
 <b>注意： 改属性会覆盖 placeholder_text_multiple 或 placeholder_text_single 选项。</b>
 </div>
 
 <hr/>
 
 <h3>事件参数</h3>
  <table class="optionsTb">
 <thead>
 <tr>
 <th>事件</th>
 <th>描述</th>
 </tr>
 </thead>
 <tbody>
<tr><td>change</td><td>Chosen 触发标准的 change 事件，同时会传递 selected or deselected 参数， 方便用户获取改变的选项 </td></tr>
<tr><td>chosen:ready</td><td>Chosen 实例化完成时触发</td></tr>
<tr><td>chosen:maxselected</td><td>超过 max_selected_options 设置时触发</td></tr>
<tr><td>chosen:showing_dropdown</td><td>Chosen 下拉选框打开完成时触发</td></tr>
<tr><td>chosen:hiding_dropdown</td><td>Chosen 下拉选框关闭完成时触发</td></tr>
<tr><td>chosen:no_results</td><td>搜索没有匹配项时触发</td></tr>
</tbody>
</table>
 <div style="font-size:14px;margin:10px 0">
 <pre>
 调用方法：
 $('.chosen-select').on('change', function(e, params) {
  do_something(e, params);
});
 **注意：**所有 Chosen 自定义事件 都包含 Chosen 实例 chosen 对象作为参数。
 </pre>
 可以通过在select 上设置属性传递给 Chosen.<br>
 <b>注意： 改属性会覆盖 placeholder_text_multiple 或 placeholder_text_single 选项。</b>
 </div>
	
 <a href = "https://harvesthq.github.io/chosen/#hide-search-on-single-select" target="view_window">插件官方示例</a>
 <div style="height:20px"></div>
</body>
</html>