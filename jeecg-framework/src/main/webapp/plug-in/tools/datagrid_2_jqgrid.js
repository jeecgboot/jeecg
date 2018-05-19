(function($){
	$.fn.datagrid = function(param){
		if(param != '' && param != undefined){
			if(param == 'getSelections'){
				var rowIds = this.jqGrid('getGridParam','selarrrow');
				var rowsData = [];
				if(rowIds.length > 0){
					for(var i = 0; i < rowIds.length; i++){
						var rowData = this.jqGrid('getRowData',rowIds[i]);
						rowsData.push(rowData);
					}
				}
				return rowsData;
			}else if(param == 'unselectAll'){
				var ids = this.jqGrid('getDataIDs');
                for (var i=0; i<ids.length; i++) {
                    var cl = ids[i];
                    var curRowData = this.jqGrid('getRowData', cl);
                    var ckt = this.find("input[id='jqg_" + cl + "']").attr("disabled");
                    if(!ckt){
                       this.find("input[id='jqg_" + cl + "']").attr("checked", false);
                    }
                }
			}else if(param == 'options'){
				var jqGridParam = {
						queryParams:{},
						columns:[]
				};
				var colModelArray = this.jqGrid('getGridParam','colModel');
				var columns = new Array();
				colModelArray.forEach(function(val,index){
					val.field = val.name;
					columns.push(val);
				});
				jqGridParam.columns = columns;
				var id = this.attr('id');
				var formId =  id + "From";
				$("#" + formId).find('*').each(function(){
					console.log(this);
				});
				console.log(jqGridParam)
				return jqGridParam;
			}
		}
	}
})(jQuery);