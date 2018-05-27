<!DOCTYPE html>
<html>
<head>
<!-- context path -->
${config_iframe}
</head>
<body>
<div class="operations" style="text-align: right;"> 
	<div class="bd3">
		<#list config_queryList as x>
			<span style="display:-moz-inline-box;display:inline-block;">
			<span style="display:-moz-inline-box;display:inline-block;width: 100px;text-align:right;text-align:right;text-overflow:ellipsis;-o-text-overflow:ellipsis; overflow: hidden;white-space:nowrap; position: relative;top: 3px" title="${x['field_txt']}">${x['field_txt']}：</span>
			<#if x['search_mode']=="group">
				<input type="text" name="${x['field_name']}_begin"  style="width: 94px"  <#if x['field_type']=="Date">class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"</#if> />
				<span style="display:-moz-inline-box;display:inline-block;width: 8px;text-align:right;">~</span>
				<input type="text" name="${x['field_name']}_end"  style="width: 94px" <#if x['field_type']=="Date">class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"</#if> />
			</#if>
			<#if x['search_mode']=="single">
				<#if  (x['field_dictlist']?size >0)>
					<#if x['field_type']=="ComboGrid">
						<input type="text" name="${x['field_name']}" id="${x['field_name']}"  style="width: 100px"/>
						<script type="text/javascript">
				            $(function () {
				                $(":input[name='${x['field_name']}']").combogrid({
				                    panelWidth: 180,
				                    multiple: true,
				                    value: '',
				                    idField: 'key',
				                    textField: 'value',
				                    columns: [[
						                {field:'key', checkbox:true},
						                {field:'value', title:'全选', width:148}
						            ]],
				                });
				                var comboGridData = [
					                <#list x['field_dictlist'] as xd>
										{ key: '${xd['typecode']}', value: '${xd['typename']}' }
										<#if (x['field_dictlist']?size > xd_index + 1)>,</#if>
									</#list>
				                ];
				                $("#${x['field_name']}").combogrid("grid").datagrid("loadData", comboGridData);
				            });
				        </script>
					<#else>
						<select name = "${x['field_name']}" WIDTH="100" style="width: 104px" <#if  (x['field_dictlist']?size >10)>class="easyui-combobox"</#if>>
						<#if  (x['field_dictlist']?size <= 10)><option value = "">-- 请选择 --</option></#if>
						<#if  (x['field_dictlist']?size > 10)><option value = ""></option></#if>
						<#list x['field_dictlist']  as xd>
							<option value = "${xd['typecode']}">${xd['typename']}</option>
						</#list>
						</select>
					</#if>
				</#if>
				<#if  (x['field_dictlist']?size <= 0)>
					<input type="text" name="${x['field_name']}"  style="width: 100px" <#if x['field_type']=="Date">class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"</#if>  /> 
				</#if>
			</#if>
			</span>	
		</#list> 
		<#if (config_queryList?size > 0)>
			<span style="display:-moz-inline-box;display:inline-block;margin-top: 5px;margin-left: 10px;">
				<a href="#" class="easyui-linkbutton" iconCls="icon-search" id="searchBtn">查询</a>
				<a href="#" class="easyui-linkbutton" iconCls="icon-reload" id="resetBtn">重置</a>
			</span>
		</#if>	 
	</div>
</div>

<div class="mod mod1" id="realTimeReport">
	<div class="mod-header radius clearfix">
    <h2>${main['name']}</h2>
	</div>
	<div class="mod-body">
		<div class="content">
			<#if (tabList?size > 1)>
				<div class="tabpanel js-um-tab" id="tabpanel_items">
					<ul class="borders">
						<#list tabList as x>
				          <li dataType="1" <#if (x_index == 0)>class="on"</#if> >${x}</li>
						</#list>
					</ul>
				</div>
			</#if>
			<div class="chartpanel">
				<div id="today_chartcontainer" data-highcharts-chart="2"></div>
			</div>
		</div>
	</div>
</div>

<div class="mod mod1 parent-table">
	<div class="mod-header radius">
		<h2>数据明细</h2>
		<div class="option">
			<a href="###" id="exportExcel">
				<span class="icon export exportCsv" title="导出"></span>
			</a>
		</div>
	</div>
	<div class="mod-body " id="data-load" >
	  <table class="data-load " width="100%" border="0" cellspacing="0" id="installation_table"></table>
	</div>
</div>

<script>
jQuery.ajaxSettings.traditional = true;
var data1;
$(function() {
	//执行扩展js
	if(typeof(initX) == 'function') {
		initX();
	}
	
	show();
	
	//查询
	$(".operations #searchBtn").click(function() {
		show(); 
	});
	
	<#if (tabList?size > 1)>
		//tab切换
		$("#tabpanel_items li").click(function() {
			if(!$(this).hasClass("on")) {
				$("#tabpanel_items .on").removeClass("on");
				$(this).addClass("on");
				showReport(data1, $(this).text());
			}
		});
	</#if>
	
	//导出excel
	$("#exportExcel").click(function() {
		window.location = "graphReportController.do?datagridGraph&export=1&" + $.param(getParam());
	});
	
	//重置
	$("#resetBtn").click(function() {
		window.location = "graphReportController.do?list&id=${config_id}";
	});
	
	//按回车键搜索
	$(".operations :input[name]").keydown(function(event) {
		if(event.keyCode == 13) {
			$(".operations #searchBtn").click();
		}
	});
	
	$(window).resize(function() {
		reizeTable();
	});
});

function show() {
	//显示趋势图
	$.post("graphReportController.do?datagridGraph", getParam(), function(data) {
		log(data);
		data = eval(data).rows;
		data1 = data; 
		
		<#if (tabList?size > 1)>
			showReport(data1, $("#tabpanel_items li.on").text());
		<#else>
			showReport(data1);
		</#if>
		
		
		<#if main['is_show_list'] == "Y"> 
			setTimeout(function() {
				showTable(data1);
			}, 1000);
		</#if> 
	});
}

function getParam() {
	var param = {configId: '${config_id}'};
	$(".operations :input[name]").each(function() {
		var name = $(this).attr("name");
		var value = $(this).val();
		//判断多选情况
		if($(this).hasClass('combo-value')) {
			value = new Array();
			$(":input[name='" + name + "']").each(function() {
				value.push($(this).val());
			});
		}
		param[name] = value;
	});
		
	return param;
}

function showReport(data, tabName) {
	//执行扩展js
	if(typeof(xReport) == 'function') {
		xReport(data, tabName);
	}
	
	<#if main['categories']?substring(0, 1) == "[">
		var categories = eval("${main['categories']}");
	<#else>
		var categories = $.map(data, function(n) {return n["${main['categories']}"]});
	</#if>
	//数据转换成报表格式
	var series = new Array();
	
	<#list graphList as x>
		<#if (tabList?size > 1)>
			if(tabName || $.trim(tabName)) {
				if("${x['tab_name']!''}" == tabName) {
					series.push({type: "${x['graph_type']}", name: "${x['graph_name']}", data: $.map(data, function(n) {
						return n["${x['field_name']}"] * 1 || 0;
					})});
				}
			}
		<#else>
			series.push({type: "${x['graph_type']}", name: "${x['graph_name']}", data: $.map(data, function(n) {
				return n["${x['field_name']}"] * 1 || 0;
			})});
		</#if>
		
	</#list>
	 
	var options = reportUtil.getSplineOptions(categories, series, "${main['ytext']}");
	//options.tooltip.headerFormat = '<span style="font-size: 10px">{point.key}人</span><br/>';
	//执行扩展js
	if(typeof(xFixedOptions) == 'function') {
		xFixedOptions(options, tabName);
	}
	$("#today_chartcontainer").highcharts(options);
}

//显示列表 
<#if main['is_show_list'] == "Y"> 

var columns = new Array();
<#list config_fieldList as x> 
	<#if x["is_show"]== "Y">
		columns.push({field:"${x['field_name']}",title:"<#if x['field_txt']??>${x['field_txt']}</#if>",width:120, sortable: true});
	</#if> 
</#list>
columns = [columns];

var datagrid = {
	    columns: columns,
	    rownumbers:true,
        singleSelect:true,
        autoRowHeight:false,
		remoteSort:false,
        multiSort:false,
		showFooter: false
	}

//显示列表
function showTable(data) {
	//执行扩展js
	if(typeof(xList) == 'function') {
		xList(data);
	}
	
	if(data.length > 19) {
		datagrid.height = 500;
	}
	
	//合计
	var totalRows = [];
	//执行扩展js
	if(typeof(getTotalRows) == 'function') {
		totalRows = getTotalRows(totalRows);
		datagrid.showFooter=true;
	}
	$("#installation_table").datagrid(datagrid);
	
	if(totalRows || totalRows.length > 0) {
		var total = {};
		$.each(data, function() {
			for(var i = 0; i < totalRows.length; i++) {
				var totalRow = totalRows[i];
				total[totalRow] = (total[totalRow] || 0) * 1 + (this[totalRow] || 0) * 1;
			}
		});
		for(key in total) {
			total[key] = "合计：" + total[key];
		}
		footer = [total];
		data = {
			total: data.length,
	    	rows: data,
	    	footer: footer
		}
	}
	
	
	$("#installation_table").datagrid('loadData', data);
	reizeTable();
	//执行扩展js，默认排序
	if(typeof(defaultSort) == 'function') {
		defaultSort();
	}
}

//调整列表宽度
function reizeTable() {
	$("#installation_table").datagrid("resize", { width: $("#data-load").width() });
}
</#if>

//页面扩展js
${main['x_page_js']!""};
</script>

</body>
</html>