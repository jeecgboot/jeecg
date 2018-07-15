/**
 * 	构造Ztree 说明。
 * 
 * 	快速构造默认配置的ztree
 * 	new ZtreeCreator('treeId',url).initZtree(param); 
 * 	treeId:树的Id，url：请求的url ， 
 *	initZtree(param,level,call); 
 *		parma 异步请求提供参数，
 *   		level展开层级（可略，默认展开全部），
 *   		call 回调提供Ztree初始化对象  
 *
 *
 *　完整例子
 *	var ztreeCreator = new ZtreeCreator('groupTree',url)
 *			.setCallback({beforeClick:beforeClick,onClick:zTreeOnLeftClick,onRightClick:zTreeOnRightClick})
 *			.initZtree(params,function(treeObj){groupTree=treeObj}); 
 *
  ****/

var ZtreeCreator = function(treeId,url,initJson){
	
	if(!treeId) alert("构造Ztree必须提供 treeId");
	this.treeId = treeId;
	
	var _treeObj;
	var outLookStyle =false;
	
	 
	/**初始化树**/	
	this.initZtree = function(param,level,callBack){
		if(!url && !_setting.async.url) alert("构造Ztree必须提供 请求地址！");
		if (jQuery.isFunction(param)) {
			callBack = param;
			param = {}; 
		}
		
		if (jQuery.isFunction(level)) {
			callBack = level; 
			level = false;
		}
		if(!param) param = {};
		
		// 通过json初始化树
		if(initJson){
			pushJsonToBuildTree(initJson,level,callBack);
			return this;
		}
		
		//传入自定义设置参数
		if(param.setting){
			this.setSetingParam(param.setting);
		}
		
		//如果异步加载
		if(_setting.async.url){
			_treeObj=jQuery.fn.zTree.init(jQuery("#"+treeId), _setting);
			return this;
		}
		//一次性加载
		jQuery.post(url,param,function(result){
			if(Object.prototype.toString.call(result) === "[object String]") result =eval('(' + result + ')');
			pushJsonToBuildTree(result,level,callBack);
		});
		return this;
	}
	
	
	 function pushJsonToBuildTree(json,level,callBack){
		_treeObj = jQuery.fn.zTree.init(jQuery("#"+treeId),_setting,json);
		//展开层级
		if(level){
			_treeObj.expandAll(false);
			expandTree(_treeObj,_treeObj.getNodes(),level);
		}
		else{ 
			_treeObj.expandAll(true); 
		}
		
		if(jQuery.isFunction(callBack)) callBack(_treeObj,treeId); 
		
		if(outLookStyle){
			try{
				var curMenu = _treeObj.getNodes()[0].children[0].children[0];
			}catch(e){}
			_treeObj.selectNode(curMenu);
		}
	}
	
	this.getTreeObj = function(){
		if(!_treeObj) alert(treeId+"尚未初始化");
		return _treeObj;
	};
	
	
	/**设置树展示的标识key  {idKey:"idKEY名称",pIdKey:"",name:"显示名称",title,rootPid}
	 * idKey 默认 id
	 * pIdKey 默认 parentId
	 * name 默认 name
	 * title 默认 name
	 * */
	this.setDataKey = function(keys){
		if(!keys) return this;
		if(keys.idKey) _setting.data.simpleData.idKey = keys.idKey;
		if(keys.pIdKey) _setting.data.simpleData.pIdKey = keys.pIdKey;
		if(keys.name) _setting.data.key.name = keys.name;
		if(keys.title) _setting.data.key.title = keys.title;
		if(keys.rootPId) _setting.data.simpleData.rootPId=keys.rootPId;
		
		return this;
	}
	this.setChildKey = function(key){
		if(!key)key = "children";
		_setting.data.simpleData.enable = false;
		_setting.data.key.children =key;
		return this;
	}
	
	/** 设置选择框的方式默认没有选择框
	 * 如果需要选择框，不需要级联 则传 true
	 * param  true   or  { "Y": "p", "N": "s" }
	 */
	this.setCheckboxType = function(type){
		_setting.check.enable = true
		if(type instanceof Object){
			_setting.check.chkboxType = type;
		}
		return this;
	}
	
	/**这里支持Ztree 所有的回调方法，请查API
	 * eg:传入参数{beforeClick：beforeClick,onClick:onClick,beforeCheck:beforeCheck}
	 **/
	this.setCallback = function(callBack){
		if(callBack instanceof Object) 
		for(call in callBack){
			if(!jQuery.isFunction(callBack[call])) alert(call+" :is not a function");
			_setting.callback[call]	= callBack[call];
		}
		return this; 
	}
	
	/** 异步加载 */
	this.setAsync = function(conf){
		_setting.async = conf;
		return this; 
	}
	
	/**是否显示图标配置项**/
	this.setShowIcon = function(call){
		_setting.view.showIcon = call;
		return this; 
	}
	/**设置一些特殊的值请参照 Ztree _setting 格式 ***/
	this.setSetingParam = function(param){
		if(param instanceof Object) 
		for(p in param){
			_setting[p]	= param[p];
		}
		return this; 
	}
	this.setOutLookStyle =function(){
		//设置一些参数 
		this.setSetingParam({view :{showLine: false, showIcon: true,
				selectedMulti: false, dblClickExpand: false,
				addDiyDom: function(treeId, treeNode){
						var spaceWidth = 15;
						var switchObj = jQuery("#" + treeNode.tId + "_switch"),
						icoObj = jQuery("#" + treeNode.tId + "_ico");
						switchObj.remove();
						if(!treeNode.children ||treeNode.children.length==0){
							switchObj.removeClass("switch");
						}
						icoObj.before(switchObj);
						if (treeNode.level > 0){
							var spaceStr = "<span style='display: inline-block;width:" + (spaceWidth * treeNode.level)+ "px'></span>";
							switchObj.before(spaceStr);
						}
				}
			}});
		
		jQuery("#"+treeId).addClass("showIcon"); 
		outLookStyle =true;
		return this;
	}
	/***
	 * 注意。isShowIn!= treeId，当前情况treeId可以随意写。只要唯一即可
	 * isShowIn,被显示在某个元素下面，比如 input框，做成累似comboTree的样子
	 * width,height 设置出现 那个 combox的宽高
	 * TODO 如果是input 设置 autoSetValue = true ， 扩展回显和自动填值功能。
	 */
	var _isShowIn,_menuContent;
	this.makeCombTree = function(isShowIn,width,height){
		height = height? height:300;
		width =width ? width:163;
		_menuContent = treeId+"MenuContent";
		_isShowIn = isShowIn; 
		var menuContent ='<div id="'+_menuContent+'" style="width:'+width+'px; height:'+height+'px;overflow-y:scroll; position:absolute;z-index: 9999;display:none;background-color:#F5F5F5">'
					+'<ul id="'+treeId+'" class="ztree" ></ul></div>';
		jQuery("#"+isShowIn).after(menuContent); 
		jQuery("#"+isShowIn).bind("click",this.showMenu);  
		return this;
	}
	// 可以添加一个目标对象，如果是添加了点击事件的，则默认
	this.showMenu = function(target){
		if(!target || target.currentTarget) {
			target = jQuery(this);
		}

		var btnOffset =  target.offset();
		jQuery("#"+_menuContent).css({left:btnOffset.left + "px", top:btnOffset.top + target.outerHeight() + "px"}).slideDown("fast");
		jQuery("body").bind("mousedown",onBodyDown);
	}
	this.hideMenu =function(){
		hideMenu(); 
	}
	
	var onBodyDown = function (event){
		if (!(event.target.id == _isShowIn || event.target.id == _menuContent || jQuery(event.target).parents("#"+_menuContent).length>0)){
			hideMenu();
		}
	}
	var hideMenu = function(){
		jQuery("#"+_menuContent).fadeOut("fast");
		jQuery("body").unbind("mousedown", onBodyDown);
	}
	
	/**_setting 私有 配置项**/ 
	var _setting = {
			data: {
				key:{
					name: "name",
					title: "name"
				},
				simpleData: {
					enable: true,
					idKey: "id",
					pIdKey: "parentId",
					rootPId:0
				}
			},
			async: {enable: false},
			edit: {
					drag: {isCopy:true},
					enable: true,
					showRemoveBtn: false,
					showRenameBtn: false
				},
			view:{
				nameIsHTML: true,
				selectedMulti: true,
				showIconFont:true,
			    showIcon: null
			},
			check: {
				enable: false,
				chkboxType: { "Y": "", "N": "" }
			},
			callback:{
				beforeClick: null,
				onClick: null,
				onRightClick: null,
				beforeDrop: null,
				onDrop: null,
				onAsyncSuccess: null
			}
		}
		
		/***设置展开层级*/
	 function expandTree(treeObj,nodes,level){
			var thelevel=level-1;  
            for(var i=0;i<nodes.length;i++)
            {
            	var node =nodes[i];
                treeObj.expandNode(node, true, false, false);  
                if(thelevel>0 && node.children && node.children.length>0)
                {
                    expandTree(treeObj, node.children,thelevel);   
                }  
            }  
	}
	
	};