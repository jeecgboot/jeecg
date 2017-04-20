<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>${main.name}</title>
		<meta name="Description" content="在线图表设计器" />
		<meta name="Keywords" content="图表,ichartjs,html5,canvas,html5例子,设计" />
		
		<link id="easyuiTheme" rel="stylesheet" href="plug-in/easyui/themes/default/easyui.css" type="text/css"></link>
		<link rel="stylesheet" href="plug-in/easyui/themes/icon.css" type="text/css"></link>
		<link rel="stylesheet" type="text/css" href="plug-in/accordion/css/accordion.css">
		<link rel="stylesheet" type="text/css" href="plug-in/accordion/css/icons.css">
		<link rel="stylesheet" href="plug-in/jquery-ui/css/ui-lightness/jquery-ui-1.9.2.custom.min.css">
		<link rel="stylesheet" href="plug-in/ichart/css/gallery.css">
		<!--覆盖css文件中的样式 因为与综合类的共同，不能修改css中的样式-->
		<style type="text/css">
			#canvasDiv{
			    position: absolute;
			    top: 0px;
			    left: 0px;
			    width: 100%;
			}
		</style>
		<script type="text/javascript" src="plug-in/jquery/jquery-1.8.3.js"></script>
		<script type="text/javascript" src="plug-in/easyui/jquery.easyui.min.1.3.2.js"></script>
		<script type="text/javascript" src="plug-in/easyui/locale/zh-cn.js"></script>
		<script src="plug-in/jquery-ui/js/jquery-ui-1.9.2.custom.min.js"></script>
		
		<script type="text/javascript" src="plug-in/tools/dataformat.js"></script>
		<!-- //update--begin--author:zhangjiaqiang date:20170315 for:修订layer提示框异常-->
		<script type="text/javascript" src="plug-in/layer/layer.js"></script>
		<!-- //update--begin--author:zhangjiaqiang date:20170315 for:修订layer提示框异常 -->
		<script type="text/javascript" src="plug-in/tools/curdtools_zh-cn.js"></script>
		<script type="text/javascript" src="plug-in/tools/easyuiextend.js"></script> 
		<script type="text/javascript" src="plug-in/tools/syUtil.js"></script>
		<script type="text/javascript" src="plug-in/lhgDialog/lhgdialog.min.js"></script>
		<script src="plug-in/ichart/js/ichart-1.0.js"></script>
		<script src="webpage/jeecg/cgdynamgraph/core/cgDynamGraphDesignMobile.js"></script>
		<script type="text/javascript">
  		$(document).ready(function(){
		    TYPE_ = '${gtype}'
		    TITLE_='${main.content}'
		    var param = {configId: '${config_id}'};
		    //显示趋势图
			$.post("cgDynamGraphController.do?datagrid", param, function(data) {
				DATA_=eval(data).rows;
				doChart();
			});
			
			$(window).resize(function() {
				doChart();
			});
		});

	 </script>
	</head>
	<body>
		<div id="canvasDiv"></div>
	</body>
</html>
