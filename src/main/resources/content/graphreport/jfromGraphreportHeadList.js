jQuery(function() {
			storage = jQuery.localStorage;
			if (!storage) storage = jQuery.cookieStorage;
			jQuery('#jformGraphreportHeadList').datagrid({
				idField: 'id',
				title: '图表配置',
				url: 'jformGraphreportHeadController.do?datagrid&field=id,code,name,cgrSql,content,ytext,categories,isShowList,xpageJs,',
				fit: true,
				queryParams: {},
				loadMsg: '数据加载中...',
				pageSize: 10,
				pagination: true,
				pageList: [10, 20, 30],
				rownumbers: true,
				singleSelect: false,
				fitColumns: false,
				striped: true,
				showFooter: true,
				frozenColumns: [[{
					field: 'ck',
					checkbox: 'true'
				},
				]],
				columns: [[{
					field: 'id',
					title: '',
					width: 120,
					hidden: true,
					sortable: true
				},
				{
					field: 'code',
					title: '编码',
					width: 120,
					sortable: true
				},
				{
					field: 'name',
					title: '名称',
					width: 120,
					sortable: true
				},
				{
					field: 'cgrSql',
					title: '查询sql',
					width: 120,
					sortable: true
				},
				{
					field: 'content',
					title: '描述',
					width: 120,
					sortable: true
				},
				{
					field: 'ytext',
					title: 'y轴文字',
					sortable: true
				},
				{
					field: 'categories',
					title: 'x轴数据',
					sortable: true
				},
				{
					field: 'isShowList',
					title: '是否显示明细',
					sortable: true,
					align: 'center',
					formatter: function(value,rec,index){
						return value == 'Y'?'是':'否';
					}
				},
				{
					field: 'xpageJs',
					title: '扩展JS',
					sortable: true
				},
				{
					field: 'opt',
					title: '操作',
					width: 220,
					formatter: function(value, rec, index) {
						if (!rec.id) {
							return '';
						}
						var href = '';
						href += "<a href='#'  class='ace_button'  onclick=delObj('jformGraphreportHeadController.do?doDel&id=" + rec.id + "','jformGraphreportHeadList')>";
						href += "<i class=' fa fa-trash-o'></i>删除</a>";
						href += "<a href='#' style='margin-left:0.5em;' class='ace_button'   onclick=addlisttab('" + rec.code + "','" + rec.content + "')>";
						href += "<i class=' fa fa-gavel'></i>功能测试</a>";
						href += "<a href='#' style='margin-left:0.5em;' class='ace_button'   onclick=popMenuLinkGraph('" + rec.code + "','" + rec.content + "')>";
						href += "<i class=' fa fa-cog'></i>配置地址</a>";
						return href;
					}
				}]],
				onLoadSuccess: function(data) {
					jQuery("#jformGraphreportHeadList").datagrid("clearSelections");
				},
				onClickRow: function(rowIndex, rowData) {
					rowid = rowData.id;
					gridname = 'jformGraphreportHeadList';
				}
			});
			jQuery('#jformGraphreportHeadList').datagrid('getPager').pagination({
				beforePageText: '',
				afterPageText: '/{pages}',
				displayMsg: '{from}-{to}共 {total}条',
				showPageList: true,
				showRefresh: true
			});
			jQuery('#jformGraphreportHeadList').datagrid('getPager').pagination({
				onBeforeRefresh: function(pageNumber, pageSize) {
					jQuery(this).pagination('loading');
					jQuery(this).pagination('loaded');
				}
			});
		});
		function reloadTable() {
			try {
				jQuery('#' + gridname).datagrid('reload');
				jQuery('#' + gridname).treegrid('reload');
			} catch(ex) {}
		}
		function reloadjformGraphreportHeadList() {
			jQuery('#jformGraphreportHeadList').datagrid('reload');
		}
		function getJformGraphreportHeadListSelected(field) {
			return getSelected(field);
		}
		function getSelected(field) {
			var row = jQuery('#' + gridname).datagrid('getSelected');
			if (row != null) {
				value = row[field];
			} else {
				value = '';
			}
			return value;
		}
		
		//查询列表数据
		function jformGraphreportHeadListSearch(){
			//判断是否满足验证规则
			if(!jQuery("#jformGraphreportHeadList").Validform({
				tiptype:3			
			}).check()){
				//校验规则不满足
				return false;
			}
			var queryParams = jQuery("#jformGraphreportHeadList").datagrid("options").queryParams;
			jQuery("#jformGraphreportHeadListtb").find('*').each(function(){
				queryParams[jQuery(this).attr('name')] = jQuery(this).val();
			});	
			jQuery('#jformGraphreportHeadList').datagrid({
				url: 'jformGraphreportHeadController.do?datagrid&field=id,code,name,cgrSql,content,ytext,categories,isShowList,xpageJs,',
				pageNumber : 1
			});
		}
		
		
		//监测回车键
		function EnterPress(e) {
			var e = e || window.event;
			if (e.keyCode == 13) {
				jformGraphreportHeadListSearch();
			}
		}
		
		//切换到功能测试tab页面
		function addlisttab(tableName,content){
			 addOneTab( '<t:mutiLang langKey="form.datalist"/>' + "["+content+"]", "graphReportController.do?list&id="+tableName);
		}
		//弹出菜单配置地址
		function popMenuLinkGraph(tableName,content){
           jQuery.dialog({
           	content: "url:jformGraphreportHeadVMController.do?popMenuLink&url=graphReportController.do?list&isIframe&title="+tableName,
   			drag : false,
			lock : true,
   			title:'菜单链接' + '['+content+']',
   			opacity : 0.3,
   			width:400,
   			height:80,drag:false,min:false,max:false
   		}).zindex();
   	}
		
		//导入
		function ImportXls() {
			openuploadwin('Excel导入', 'jformGraphreportHeadVMController.do?goImportExcel', "jformGraphreportHeadList");
		}

		//导出
		function ExportXls() {
			JeecgExcelExport("jformGraphreportHeadController.do?exportXls","jformGraphreportHeadList");
		}
		