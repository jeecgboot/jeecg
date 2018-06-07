/**
 * describe:描述必填
 * name:(pmsContractList的name是pmsContract)
 * form:{width:"form的宽度",height:"form的高度"}
 * urls:{
 * 	  addForm:'form添加请求 默认xxController?goAdd',
 *    update:'form修改请求 默认xxController?goUpdate',
 *    detail:'form详情查看请求 默认xxController?goUpdate',
 *    batchDel:'批量删除请求 默认xxController?doBatchDel',
 *    saveRows:'行编辑提交修改请求 默认xxController?saveRows',
 * 	  excelImport:'excel导入请求 默认xxController?goUpload',
 *  }
 *  afterRowEdit:行编辑模式开启后需要处理的事件 自带参数:该编辑行的索引
 */
(function($){
	$.curdInIframe = function(params){
		if(!params || !params.describe ||!params.name){
			alert('请自行传入必填参数');
			return false;
		}
		var addRowLastSeq = 0;
		var defaults = {
			isMain:false,
			isSeq:false,
			queryCode:"",
			describe:"",
			name:"",
			form:{width:"",height:""},
			urls:{
				addForm:'',
				update:'',
				detail:'',
				batchDel:'',
				saveRows:'',
				excelImport:'',
				deleteOne:''
			},
			afterRowEdit:function(index){}
		};
		var options = $.extend(defaults,params);
		
		var dgname = options.name+"List";
		var dgthis = "#"+dgname;

		var methods = {
			//激活tab加载子表数据
			initListByMain:function (id,isDel){
				gridname = dgname;
				if(!isDel){
					var tempv = $("#"+options.name+"ListMainId").val();
					if(tempv==id){
						return false;
					}
					$("#"+options.name+"ListMainId").val(id);
					
					$(dgthis).datagrid('load',{
						mainId : id
					});
				}else{
					$(dgthis).datagrid('load',{
						mainId : id
					});
				}
			},
			//增FORM
			addForm:function(){
				var mainId ='';
				if(!options.isMain){
					mainId = $("#"+options.name+"ListMainId").val();
					if(!mainId){
						topWinTip('请先选中一条主表信息！');
						return false;
					}
				}
				var req = options.urls.addForm;
				if(!req){
					req = options.name+'Controller.do?goAdd';
				}
				if(!options.isMain){
					req+= '&mainId='+mainId;
				}
				//createwindow('录入'+options.describe,req,options.form.width,options.form.height);
				add('录入'+options.describe,req,dgname,options.form.width,options.form.height);
			},
			//改FORM
			update:function(){
				if(!options.isMain){
					var mainId = $("#"+options.name+"ListMainId").val();
					if(!mainId){
						topWinTip('请先选中一条主表信息！');
						return false;
					}
				}
				var req = options.urls.update;
				if(!req){
					req = options.name+'Controller.do?goUpdate';
				}
				updatePms('编辑'+options.describe,req,dgname,
						options.form.width,options.form.height);
			},
			//查FORM
			detail:function(id,url){
				 if(!isNaN(url)){
					 //因为该函数会默认拼接一个index到参数中,故而此处判断是否是数字,是数字则走doDel
					 if(!options.urls.detail){
						 url = options.name+'Controller.do?goUpdate';
					 }else{
						 url = options.urls.detail;
					 }
				 }
				url +="&load=detail&id="+id;
				createdetailwindow('查看详情',url,dgname,options.form.width,options.form.height);
			},
			//批量删除
			batchDel:function(){
				// var ids = [];
				 //var mainId = $("#"+options.name+"ListMainId").val();
				 //var rows = $(dgthis).datagrid('getSelections');
				 var req = options.urls.batchDel;
				 if(!req){
					req = options.name+'Controller.do?doBatchDel';
				 }
				 deleteALLSelectPms('',req,dgname,options.isMain);
			},
			//行新增
			addRow:function (){
				if(!options.isMain){
					if(!$("#"+dgname+"MainId").val()){
						topWinTip('请先选中一条主表信息！');
						return false;
					}
				}
				$(dgthis).datagrid('appendRow',{});
				var editIndex = $(dgthis).datagrid('getRows').length-1;
				$(dgthis).datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
				//添加opt小图标
				addEditRowOptBtn(dgname,editIndex);
				options.afterRowEdit.call(this,editIndex);
				if(options.isSeq){
					var lastIndex = 0;
					if(addRowLastSeq!=0){
						lastIndex = addRowLastSeq;
					}else{
						var irows = $(dgthis).datagrid("getRows");
						console.log(irows);
						if(!irows || irows.length<=0){
						}else{
							for(var a in irows){
								var tempSeq = irows[a].seq;
							//	console.log(a+"--"+ irows[a].seq);
								if(!!tempSeq){
									if(tempSeq>lastIndex){
										lastIndex = irows[a].seq;
									}
								}
							}
						}
					}
					addRowLastSeq = parseInt(lastIndex)+1;
					//TODO 删除的时候在做减少
					//$($(dgthis).datagrid('getEditor', {index:editIndex,field:'seq'}).target).val(addRowLastSeq);
				}
			 },
			 rejectUpdate:function(){
				 $(dgthis).datagrid('clearChecked');
				 $(dgthis).datagrid('rejectChanges');
			 },
			 saveRows:function(){
				 var req = options.urls.saveRows;
				 if(!req){
					req = options.name+'Controller.do?saveRows';
				 }
				 saveData(req,dgname);
			 },
			 doFilterit:function(){
				 if(typeof(eval(dgname+"Filter")) == "function"){        
			          eval(dgname+"Filter();");
			     }
			 },
			 deleteOne:function(id,url){
				 if(!isNaN(url)){
					 //因为该函数会默认拼接一个index到参数中,故而此处判断是否是数字,是数字则走doDel
					 if(!options.urls.deleteOne){
						 url = options.name+'Controller.do?doDel';
					 }else{
						 url = options.urls.deleteOne;
					 }
				 }
				 if(!options.isMain){
					 //如果不是主表
					 delObjPms(id,url);
				 }else{
					 deleteMainRecord(id,url);
				 }
			 },
			 //EXCEL导入
			 excelImport:function(){
				var mainId ='';
				if(!options.isMain){
					mainId = $("#"+dgname+"MainId").val();
				 	if(!mainId){
				 		topWinTip('请选中一条合同信息然后执行该操作！');
						return false;
				 	}
				}
				var req = options.urls.excelImport;
				if(!req){
					req = options.name+'Controller.do?goUpload';
				}
				req+="&listname="+options.name;
				if(!options.isMain){
					req+="&mainId="+mainId;
				}
			 	//openuploadwin('',req, dgname);
				$.dialog({
				    content: 'url:'+req,
				    title:'Excel导入',
					zIndex: getzIndex(),
				    cache:false,
				    button: [
				        {
				            name: "开始导入",
				            callback: function(){
				            	var iframe = this.iframe.contentWindow;
								iframe.upload();
								return false;
				            },
				            focus: true
				        },
				        {
				            name: "取消",
				            callback: function(){
				            	var iframe = this.iframe.contentWindow;
								iframe.cancel();
				            }
				        }
				    ]
				});
			 },
			 superQuery:function(){
				 if(!!options.queryCode){
					 eval(dgname+"SuperQuery").call(this,options.queryCode);
				 }
			 },
			 test:function(a){console.log(123+a);}
		}
		return methods;
	}
})(jQuery);
/*----------------------------------------增删改查------------------------------------------*/