<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>HTML5在线图表设计器</title>
		<meta name="Description" content="在线图表设计器" />
		<meta name="Keywords" content="图表,ichartjs,html5,canvas,html5例子,设计" />
		
		
		<link id="easyuiTheme" rel="stylesheet" href="plug-in/easyui/themes/default/easyui.css" type="text/css"></link>
		<link rel="stylesheet" href="plug-in/easyui/themes/icon.css" type="text/css"></link>
		<link rel="stylesheet" type="text/css" href="plug-in/accordion/css/accordion.css">
		<link rel="stylesheet" type="text/css" href="plug-in/accordion/css/icons.css">
		<link rel="stylesheet" href="plug-in/jquery-ui/css/ui-lightness/jquery-ui-1.9.2.custom.min.css">
		<link rel="stylesheet" href="plug-in/ichart/css/gallery.css">
<!-- //update--begin--author:yugwu date:20170618 for:[TASK #2138] 【ie8兼容】移动报表，功能测试乱码 -->
<!--[if gte IE 6]>
<!--[if lte IE 8]>
		<script type="text/javascript" src="plug-in/html5ie/js/html5.js"></script>
		<script type="text/javascript" src="plug-in/html5ie/js/excanvas.compiled.js"></script>
		<style type="text/css">
			#canvasDiv{
				behavior: url(/plug-in/html5ie/css/ie-css3.htc);
			}
		</style>
		<script type="text/javascript">
			document.createElement("section");
			document.createElement("article");
			document.createElement("footer");
			document.createElement("header");
			document.createElement("hgroup");
			document.createElement("nav");
			document.createElement("menu");
		</script>
<![endif]-->
<![endif]-->
<!-- //update--end--author:yugwu date:20170618 for:[TASK #2138] 【ie8兼容】移动报表，功能测试乱码 -->
		<script type="text/javascript" src="plug-in/jquery/jquery-1.8.3.js"></script>
		<script type="text/javascript" src="plug-in/easyui/jquery.easyui.min.1.3.2.js"></script>
		<script type="text/javascript" src="plug-in/easyui/locale/zh-cn.js"></script>
		<script src="plug-in/jquery-ui/js/jquery-ui-1.9.2.custom.min.js"></script>
		
		<script type="text/javascript" src="plug-in/tools/dataformat.js"></script>
		<!-- //update--begin--author:zhangjiaqiang date:20170315 for:修订layer提示框异常 -->
		<script type="text/javascript" src="plug-in/layer/layer.js"></script>
		<!--//update--begin--author:zhangjiaqiang date:20170315 for:修订layer提示框异常 -->
		<script type="text/javascript" src="plug-in/tools/curdtools_zh-cn.js"></script>
		<script type="text/javascript" src="plug-in/tools/easyuiextend.js"></script> 
		<script type="text/javascript" src="plug-in/tools/syUtil.js"></script>
		<script type="text/javascript" src="plug-in/lhgDialog/lhgdialog.min.js"></script>
		<script src="plug-in/ichart/js/ichart-1.0.js"></script>
		<script src="webpage/jeecg/cgdynamgraph/core/cgDynamGraphDesign.js"></script>
		<script type="text/javascript">
			$(function(){$('#${config_id}List').datagrid(
				{
				idField: 'id',
				title: '${config_name}',
				url:' cgDynamGraphController.do?datagrid&configId=${config_id}${config_params}',
				fit:true,
				fitColumns:false,
				pageSize: 10,
				pagination:true,
				pageList:[10,30,50,100],
				singleSelect:true,
				checkbox:false,
				sortOrder:'asc',
				rownumbers:true,
				showFooter:true,
				frozenColumns:[[]],
				columns:[
					[			<#if (config_fieldList?size>0)>
								<#list config_fieldList  as x>  
								 	<#if x_has_next>
									{field:'${x['field_name']}',
									 title:'${x['field_txt']}',
								 	 <#if x['field_href']?? && x['field_href']!="">
									 	formatter:function(value,rec,index){
									 		var href='';
									 		href+=applyHref('字段链接','${x['field_href']}',value,rec,index);
									 		return href;
									 	},
								 	 </#if>
									 <#if x['is_show'] == "N" >hidden:true,</#if>
									 width:80},
									<#else>
									{field:'${x['field_name']}',title:'${x['field_txt']}',width:80}
								  	</#if>
								</#list>
								</#if>
					]
				],
				onLoadSuccess:function(data){$("#${config_id}List").datagrid("clearSelections");
							DATA_=data.rows;
							doChart();},
				onClickRow:function(rowIndex,rowData)
					{rowid=rowData.id;gridname='${config_id}List';}
				});
				$('#${config_id}List').datagrid('getPager').pagination({beforePageText:'',afterPageText:'/{pages}',displayMsg:'{from}-{to}共{total}条',showPageList:true,showRefresh:true});
				$('#${config_id}List').datagrid('getPager').pagination({onBeforeRefresh:function(pageNumber, pageSize){ $(this).pagination('loading');$(this).pagination('loaded'); }});});
				function reloadTable(){	
					try{
					$('#'+gridname).datagrid('reload');
					$('#'+gridname).treegrid('reload');
					}catch(ex){
						//donothing
					}
				}
				function reload${config_id}List(){$('#${config_id}List').datagrid('reload');}
				function get${config_id}ListSelected(field){return getSelected(field);}
				function getSelected(field){var row = $('#'+gridname).datagrid('getSelected');if(row!=null){value= row[field];}else{value='';}return value;}
				function get${config_id}ListSelections(field){var ids = [];var rows = $('#${config_id}List').datagrid('getSelections');for(var i=0;i<rows.length;i++){ids.push(rows[i][field]);}ids.join(',');return ids};
				function ${config_id}Listsearch(){var queryParams=$('#${config_id}List').datagrid('options').queryParams;$('#${config_id}Listtb').find('*').each(function(){queryParams[$(this).attr('name')]=$(this).val();});$('#${config_id}List').datagrid({url:' cgDynamGraphController.do?datagrid&configId=${config_id}',pageNumber:1});}
				function dosearch(params){var jsonparams=$.parseJSON(params);$('#${config_id}List').datagrid({url:' cgDynamGraphController.do?datagrid&configId=${config_id},',queryParams:jsonparams});}
				function ${config_id}Listsearchbox(value,name){var queryParams=$('#${config_id}List').datagrid('options').queryParams;queryParams[name]=value;queryParams.searchfield=name;$('#${config_id}List').datagrid('reload');}$('#${config_id}Listsearchbox').searchbox({searcher:function(value,name){${config_id}Listsearchbox(value,name);},menu:'#${config_id}Listmm',prompt:'请输入查询关键字'});
				function searchReset_${config_id}(name){ $("#"+name+"tb").find(":input").val("");${config_id}Listsearch();}
				//导出
				function exportXls() {
					var submitUrl = "cgExportExcelController.do?exportXls&configId=${config_id}";
					var queryParams = "";
					$('#${config_id}Listtb').find('*').each(function(){
							queryParams+= "&"+$(this).attr('name')+"="+$(this).val();
						}
					);
					submitUrl+=queryParams;
					submitUrl = encodeURI(submitUrl);
					 window.location.href=submitUrl;
				}
				
				//将字段href中的变量替换掉
				function applyHref(tabname,href,value,rec,index){
					//addOneTab(tabname,href);
					var hrefnew = href;
					var re = "";
					var p1 = /\#\{(\w+)\}/g;
					try{
						var vars =hrefnew.match(p1); 
						for(var i=0;i<vars.length;i++){
							var keyt = vars[i];
							var p2 = /\#\{(\w+)\}/g;
							var key = p2.exec(keyt);
							 hrefnew =  hrefnew.replace(keyt,rec[key[1]]);
						}
					}catch(ex){
					}
					re += "<a href = '#' onclick=\"addOneTab('"+tabname+"','"+ hrefnew+"')\" ><u>"+value+"</u></a>";
					return re;
				}
			</script>
	</head>
	<body>
		<nav>
			<div id="gallery_tools">
				<div class="gallery_tool">
					<div class="gallery_too">
					开启动画:<input name="animate" type="checkbox" id="gallery_animate" class="gallery_check" checked="checked"/>
					</div>
					<div class="gallery_too">
					开启阴影:<input type="checkbox" id="gallery_shadow" class="gallery_check"/>
					</div>
					<div class="gallery_too">
						背景颜色:
						<div class="gallery_bg">
							<div class="gallery_bg_list">
								<div class="gallery_color" type="0" style="background-color: #d9e6f4;"></div>
								<div class="gallery_color" type="0" style="background-color: #fefefe;"></div>
								<div class="gallery_color" type="0" style="background-color: #eeeeee;"></div>
								<div class="gallery_color" type="0" style="background-color: #eff8ff;"></div>
							</div>
						</div>
					</div>
					<div class="gallery_too">
						坐标系背景颜色:
						<div class="gallery_bg">
							<div class="gallery_bg_list">
								<div class="gallery_color" type="1" style="background-color: #d9e6f4;"></div>
								<div class="gallery_color" type="1" style="background-color: #fefefe;"></div>
								<div class="gallery_color" type="1" style="background-color: #eeeeee;"></div>
								<div class="gallery_color" type="1" style="background-color: #eff8ff;"></div>
								<div class="gallery_color" type="1" style="background-color: #d6dbd2;"></div>
							</div>
						</div>
					</div>
					<div class="gallery_too">
						<input type="button" id="custom-data" class="gallery_check" value="自定义数据"/>
					</div>
					<div class="gallery_too">
						<a href="javascript: void(0);" title="download chart" target="_blank" download="chart.png" id="download_a">
							<input id="download" disabled="disabled" type="button" class="gallery_check" value="导出图表" />
						</a>
					</div>
				</div>
			</div>
		</nav>
		<section id="gallery_container">
			<section id="gallery_left_container">
				<section id="gallery_ichart" class="gallery_section">
					<div class="gallery_bar">单击图标进行图表类型选择->></div>
					<div class="gallery_draggable pie2d" type="Pie2D">
					</div>
					<div class="gallery_draggable pie3d" type="Pie3D">
					</div>
					<div class="gallery_draggable column2d" type="Column2D">
					</div>
					<div class="gallery_draggable column3d" type="Column3D">
					</div>
					<div class="gallery_draggable bar2d" type="Bar2D">
					</div>
					<div class="gallery_draggable area2d" type="Area2D">
					</div>
					<div class="gallery_draggable line2d" type="LineBasic2D"></div>
					
					<div class="gallery_draggable sline2d" type="LineBasic2D" option="1"></div>
				</section >
			</section>
			<section id="gallery_right_container" >
				<section id="gallery_right_bg" class="right_container"></section>
			</section>
			<section id="canvasDiv"></section>
		</section>
		
		<div id="dialog-form" title="定制数据">
			<p id="validateTips">所有文本均为必填项.</p>
			<div>
			<span>标题：</span><span>
			<input type="text" id="form_title" class="form_title" size="34" value="输入标题名称"/>
			</span>&nbsp;&nbsp;
			<span><a href="javascript:void(0)" onclick="addRow();">增加一行</a></span>
			</div>
			<div style="margin-top:4px;">
			<span style="float: left;">数据：</span>
			<span>
				<table class='form_table' id='data_table'>
					<thead>
						<tr><td>名称</td><td>数值(数字)</td><td>颜色</td><td></td></tr>
					</thead>
					<tbody id='form_tbody'>
						<tr id='form_tr_head'><td><input type="text" class="form_text" /></td><td><input type="text" class="form_text" /></td><td class="td_color"><input type="text" class="form_text" /></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
					</tbody>
				</table>
			</span>
			</div>
			<div id ="gallery_color_picker">
				<div class="color" style="background-color: #a5c2d5;" color="#a5c2d5"></div>
				<div class="color" style="background-color: #cbab4f;" color="#cbab4f"></div>
				<div class="color" style="background-color: #76a871;" color="#76a871"></div>
				<div class="color" style="background-color: #9f7961;" color="#9f7961"></div>
				<div class="color" style="background-color: #a56f8f;" color="#a56f8f"></div>
				<div class="color" style="background-color: #cf77d7;" color="#cf77d7"></div>
				<div class="color" style="background-color: #f76f6f;" color="#f76f6f"></div>
				<div class="color" style="background-color: #c12c44;" color="#c12c44"></div>
				<div class="color" style="background-color: #6f83a5;" color="#6f83a5"></div>
			</div>
		</div>
		<div id="gallery_data" class="gallery_section">
<table width="100%"   id="${config_id}List" toolbar="#${config_id}Listtb"></table>
<div id="${config_id}Listtb" style="padding:3px; height: auto">
<div name="searchColums">
	<#list config_queryList  as x>
		<span style="display:-moz-inline-box;display:inline-block;">
		<span style="display:-moz-inline-box;display:inline-block;width: 100px;text-align:right;text-align:right;text-overflow:ellipsis;-o-text-overflow:ellipsis; overflow: hidden;white-space:nowrap;" title="${x['field_txt']}">${x['field_txt']}：</span>
		<#if x['search_mode']=="group">
			<input type="text" name="${x['field_name']}_begin"  style="width: 94px"  <#if x['field_type']=="Date">class="easyui-datebox"</#if> />
			<span style="display:-moz-inline-box;display:inline-block;width: 8px;text-align:right;">~</span>
			<input type="text" name="${x['field_name']}_end"  style="width: 94px" <#if x['field_type']=="Date">class="easyui-datebox"</#if> />
		</#if>
		<#if x['search_mode']=="single">
				<#if  (x['field_dictlist']?size >0)>
				<select name = "${x['field_name']}" WIDTH="100" style="width: 104px">
				<option value = "">-- 请选择 --</option>
				<#list x['field_dictlist']  as xd>
					<option value = "${xd['typecode']}">${xd['typename']}</option>
				</#list>
				</select>
			</#if>
			<#if  (x['field_dictlist']?size <= 0)>
				<input type="text" name="${x['field_name']}"  style="width: 100px" <#if x['field_type']=="Date">class="easyui-datebox"</#if>  />
			</#if>
		</#if>
		</span>	
	</#list>
	</div>
	<div style="height:30px;" class="datagrid-toolbar">
	<span style="float:left;" >
	<a href="#" class="easyui-linkbutton" plain="true" icon="icon-putout" onclick="exportXls();">导出excel</a>
	</span>
	
<#if  (config_queryList?size >0)>
		<span style="float:right">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="${config_id}Listsearch()">查询</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-reload" onclick="searchReset_${config_id}('${config_id}List')">重置</a>
		</span>
</#if>
	</div>
</div>
	  </div >
	</body>
</html>
