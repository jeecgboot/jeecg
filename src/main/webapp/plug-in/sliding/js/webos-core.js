/**
* webos 1.2 
* JS采用面向对象编写
* 仿webQQ基本功能
* 1.1 新加拖拽 桌面切换 右键 1级栏布局切换 应用自适应布局 
* 1.2 新加全局桌面  代码借鉴1kb.js
* @xiaofan
* @2012.3.9 
*/
var menujson=null;
var datajson=null;
var iconjson=null;
var totalnum =null;
var DATA=new Object();

var iconCookieKey = "iconCookieKey";
var iconCookieKeyForSlider = "iconCookieKeyForSlider";
var cookieParam = {expires: 30};
/*默认左侧菜单*/
var defaultIconForSlider = [
//    '297e20104620167201462016b5fe001f',/*用户管理*/
//    '297e20104620167201462016b6020021' /*角色管理*/
];

	//增加数据动态处理的过程
	////这里使用menuString来替换掉每个一级二级菜单的数据

function dataFlush(){
	$.ajax({
        url: "loginController.do?getPrimaryMenuForWebos",
        datatype: "json",
        async:false,
        type: "post",
  	  	success: function (data) {
            //修改webOS界面菜单不出现的问题
            var menu;
            menu = eval("(" +data+")");
            var array = menu.msg.split("$$");
            menujson=array[0];
            menujson = eval("("+menujson+")");
            iconjson=array[1];
            iconjson = eval("("+iconjson+")");
            datajson=array[2];
            datajson = eval("("+datajson+")");
            var totalnum1=array[3];
            totalnum = totalnum1 - 1;

            calcuIconJson();
		}
    });
}

/**
 * 转换用户的桌面
 */
function calcuIconJson() {
    var iconCookieData = $.cookie(iconCookieKey);
    var iconCookieDataForSlider = $.cookie(iconCookieKeyForSlider);
    if (iconCookieData) {
        var allIconIdArrOfCookie = new Array(); // cookie中所有的菜单图标Id
        var tempIconJson = {}; // 临时的图标对象
        for (var attr in iconjson) {
            tempIconJson[attr] = new Array();
        }
        // 处理桌面菜单
        var arrColumn = iconCookieData.split('|');
        $.each(arrColumn, function (index, content) {
            var iconName = content.split(':')[0]; //iconName
            var arrIconId = content.split(':')[1] ? content.split(':')[1].split('@') : ""; //单个序列ID
            $.each(arrIconId, function (index, content) {
                if (content) {//排除空值
                    tempIconJson[iconName].push(content);
                    allIconIdArrOfCookie.push(content);
                }
            });
        });
        // 处理左侧菜单
        if(iconCookieDataForSlider) {
            DATA.sApp = {};
            defaultIconForSlider = new Array();
            var arrIconId = iconCookieDataForSlider.split('@'); //单个序列ID
            $.each(arrIconId, function (index, content) {
                if (content) {//排除空值
                    for (var attrName in datajson.app) {
                        if(content == attrName) {
                            DATA.sApp[attrName] = datajson.app[attrName];
                            break;
                        }
                    }

                    defaultIconForSlider.push(content);

                    allIconIdArrOfCookie.push(content);
                }
            });
        }

        // 处理新增的菜单图标id
        for (var attrName in iconjson) {
            for(var iconIndex in iconjson[attrName]) {
                var iconId = iconjson[attrName][iconIndex];
                if(allIconIdArrOfCookie.indexOf(iconId) == -1) {
                    tempIconJson[attrName].push(iconId);
                }
            }
        }
        iconjson = tempIconJson;
    }
}



//工具类
Util = {
	formatmodel : function (str, model) {
		for (var k in model) {
			var re = new RegExp("{" + k + "}", "g");
			str = str.replace(re, model[k])
		}
		return str
	}
}

//面板类
Panel=function(){
	return me={
		hitTest:function(panel,x,y){//碰撞检测，检测坐标[x,y]是否落在panel里面
			var pl,pt;
			return !(
				  x<(pl=panel.offset().left)
				||y<(pt=panel.offset().top)
				||x>pl+panel.width()
				||y>pt+panel.height()
			);
		},
		getIdx:function(panel){//获取节点在panel是第几个儿子节点
			var ci=0;
			while(panel=panel.prev()){
				ci++;
			}
			return ci;
		},
		unSelecte:function(){//清除选中
			return window.getSelection?function(){window.getSelection().removeAllRanges();}:function(){document.selection.empty();};
		}()
	};
}();

//BODY
Body=function(me){
	//优先刷新出后台的数据以便其他方法中使用替换
	dataFlush();
	return me={
		init:function(){
			me.create();
			me.bindEvent();
		},
		create:function(){
			me.box=$('body');
			me.setStyle();
		},
		bindEvent:function(){//清除选中
			function move(evt){
				window.getSelection?window.getSelection().removeAllRanges():document.selection.empty();
			}
			function up(evt){
				$(document).unbind('mousemove',move).unbind('mouseup',up);
			}
			$(document).bind('mousedown',function(){
				$(document).bind('mousemove',move).bind('mouseup',up);
			});
		},
		addPanel:function(panel){
			me.box.append(panel);
		},
		setStyle:function(){
			me.box.css({
					backgroud:"none repeat scroll 0 0 transparent",					
					display: "block",
					height:"500px"
			});
			
		}
		
	};
}();

//创建桌面最外层类
Desktop=function(me){
	return me={
		init:function(){
			me.create();
			//me.setMenu();//绑定右键
			return me;
		}, 
		create:function(){		
			me.box=$("<div id='desktop'  style='position: static;'></div>");
			Body.addPanel(me.box);
		},
		addPanel:function(panel){
			me.box.append(panel);
		},
		show:function(){
			me.box.show();
		},
		hide:function(){
			me.box.hide();
		},
		setMenu:function(){
			var MenuData = [
						[{
							text: "显示桌面",
							func: function() {
								
							}
						},{
							text: "关闭所有",
							func: function() {
								Windows.closeAllWindow();
							}
						}, {
							text: "锁屏",
							func: function() {
								
							}
						}],
						[{
							text: "系统设置",
							func: function() {
								 
							}
						},{
							text: "主题设置",
							func: function() {								
							  Windows.openSys({
								id :'themSetting',
								title :'设置主题',
								width :650,
								height:500,
							 	content :document.getElementById("themeSetting_wrap")
							 });
							}
						},
						{
							text: "图标设置",
							data: [[{
								text: "大图标",
								func: function() {
									Deskpanel.desktopsContainer.removeClass("desktopSmallIcon");
								}
							}, {
								text: "小图标",
								func: function() {
									Deskpanel.desktopsContainer.addClass("desktopSmallIcon");
								}
							}]]
						}],
						[{
							text:"注销",
							func:function(){
							
							}
						}]
					];
					
			me.box.smartMenu(MenuData, {
				name: "image"    
			});
		}
	};
}();

//桌面内部面板
Deskpanel = function(me){
	
	var desktopWrapper = "<div id='desktopWrapper'></div>";//最外层容器
	var desktopsContainer = "<div id='desktopsContainer' class='desktopsContainer'	>";
	var desktopContainer = "<div class='desktopContainer' index='{index}' >";
	var desktopAppListener = "<div class='appListContainer' customacceptdrop='{index}' index='{index}' _olddisplay='block' >";//内部监听容器
	var defaultIndex = 0,
		////替换掉具体的一级菜单数量
		defaultNum = 15,
		defautlSpace ={//默认尺寸
			left:0,
			top:0,
			right:0,
			bottom:120
		}
		
	
	
	return me ={
		init:function(ops, firstLoad){
			me.create();
			me.addIcons(ops);
			me.space(defautlSpace);
			me.refresh(firstLoad);
			me.bindEvent();
			me.addCurrnet(defaultIndex);
			return me;
		},		
		create:function(){
			me.box=$(desktopWrapper);//桌面外层面板			
			me.desktopsContainer = $(desktopsContainer);
			me.createDesktopsContainer(defaultNum);	//创建桌面外层容器
			me.box.append(me.desktopsContainer);
			me.box.css({"left": "73px","right": "0px"});
			me.desktopsContainer.css("left",73);
			Desktop.addPanel(me.box);
			me.Icon=[];
		},
		bindEvent:function(){
			//桌面图标拖拽
			me.desktopsContainer.find(".appListContainer").each(function(){
				var desk = $(this);
				var index = desk.attr("index");
				desk.sortable({
					items:".appButton",
					connectWith :".dock_middle",					
					opacity :"0.6",
					start:function(event,ui){
									
					},
					stop: function(event, ui) {							
						var p = ui.item.parent();	
						if(p.hasClass("dock_middle"))ui.item.removeAttr("style");//落在侧边栏																		
						Deskpanel.switchCurrent(index);
						Deskpanel.refreshIcon();	
					}
				}).disableSelection();		
			});
			//浏览器改变刷新
			$(window).resize(me.refresh);
	
		},			
		createDesktopsContainer:function(n){//桌面外层容器 n创建几层桌面					
			if(n&&n!=0){
				for(var i =1;i<=n;i++){					
					me.desktopsContainer.append(me.addContainer(i))//填充容器
				}
			}
		},
		addContainer:function(i){		//添加容器
			var c = me.createDesktopContainer(i);	
			var a = me.createDesktopAppListener(i);
			c.append(a);	
			return c ;
		},	
		createDesktopContainer:function(n){		//容器项
		    return  $(Util.formatmodel(desktopContainer,{"index":n-1}));			
		},
		createDesktopAppListener:function(n){//容器监听项
			return  $(Util.formatmodel(desktopAppListener,{"index":n-1}));
		},		
		addIcons:function(ops){//添加应用			
			for(var i in ops){
				var key = i.substring(i.length-1,i.length);				
				me.addIcon(ops[i],key);
			}		
		},	
		addIcon:function(icon,idx){//添加应用 idx 第几桌面
			if(icon){
				if($.isArray(icon)){//传入是数组
					$.each(icon,function(){						
						me.addIcon(this.valueOf(),idx);//添加应用程序
					});
					return me ;
				}
				var Icon = typeof icon=='string'?appIcon_t1(icon):icon;//传入的是ID还是图标对象
				me.Icon.push(Icon);
				me.box.find("div[customacceptdrop='"+parseInt(idx-1)+"']").append(Icon.box);
			}		
		},
		addCurrnet:function(n){//根据index设置当前桌面样式
			me.desktopsContainer.find(".desktopContainer[index='"+n+"']").addClass("desktop_current");		
		},
		removeCurrent:function(n){//根据index移除当前桌面样式
			me.desktopsContainer.find(".desktopContainer[index='"+n+"']").removeClass("desktop_current");	
		},	
		switchCurrent:function(n){//切换index桌面样式
			var dc = me.desktopsContainer;
			dc.find(".desktopContainer[index='"+n+"']")
			  .addClass("desktop_current")
			  .siblings().removeClass("desktop_current");
		},
		space:function(ops){//设置桌面各面板尺寸位置			
			('top' in ops)&&(typeof ops.top=='string'?me.spaceTop+=ops.top:me.spaceTop=+ops.top||0);
			('left' in ops)&&(typeof ops.left=='string'?me.spaceLeft+=ops.top:me.spaceLeft=+ops.left||0);
			('right' in ops)&&(typeof ops.right=='string'?me.spaceRight+=ops.top:me.spaceRight=+ops.right||0);
			('bottom' in ops)&&(typeof ops.bottom=='string'?me.spaceBottom+=ops.top:me.spaceBottom=+ops.bottom||0);
			return me;			
		},
		refresh:function(firstLoad){//刷新桌面
			var ww = $(window).width(),//浏览器宽
				wh = $(window).height();//浏览器高				
			me.width = ww-me.spaceRight -me.spaceLeft;//容器宽
			me.height =wh-me.spaceTop - me.spaceBottom;//容器高 
			var desktopContainer = me.desktopsContainer.find(".desktopContainer");
			var appContainer = desktopContainer.find(".appListContainer");
			
			$(desktopContainer).each(function(i){//容器宽高
				$(this).css({
					left:me.width*i,
					height:me.height-me.spaceBottom
				});
			})
			
			$("#zoomWallpaperGrid,#zoomWallpaper").width(ww).height(wh);//背景图片div
			
			var r = me.row = ~~(me.height/112);//行数
			
			me.desktopsContainer.css({//设置应用容器样式和位置
				left:me.spaceLeft,
				top:me.spaceTop,
				width:me.width,
				height:me.height		
			});
			
			appContainer.each(function(){
				$(this).css({
					width:me.width,
					height:me.height,
					"margin-left": 28,
					"margin-top": 46,
					display: "block"
				});	
			});
			
			me.refreshIcon(firstLoad);
			
		},

		refreshIcon:function(firstLoad){//刷新应用
			var r = ~~(me.height/112);
            var curIndex = 1;
            var iconCookieData = "";
            me.desktopsContainer.find(".appListContainer").each(function(){
                iconCookieData += "Icon" + curIndex + ":";
				var icon = $(this).children();
				for(var j= 0 ;j<icon.length;j++){
					var leftI=~~(j/r),
						topI=j%r;
					$(icon[j]).css({
						left:leftI*142,
						top:topI*112
					});

                    var iconId = $(icon[j]).attr("id").replace("icon_app_", "");
                    iconId = iconId.substring(0, iconId.indexOf("_"));
                    iconCookieData += iconId + "@";
                }
                iconCookieData += "|";
                curIndex++;
			});
            if (!firstLoad) {
                $.cookie(iconCookieKey, iconCookieData, cookieParam);
                var iconCookieDataForSlider = "";
                $("#dockContainer").find(".dock_middle").each(function () {
                    var icon = $(this).children();
                    for (var j = 0; j < icon.length; j++) {
                        var iconId = $(icon[j]).attr("id").replace("icon_app_", "");
                        iconId = iconId.substring(0, iconId.indexOf("_"));
                        iconCookieDataForSlider += iconId + "@";
                    }
                });
                $.cookie(iconCookieKeyForSlider, iconCookieDataForSlider, cookieParam);
            }
		},

		moveIconTo:function(icon,idx2){//目标位置
			var ids=(Panel.getIdx(icon.box));
			if(idx>idx2){//往前移
				me.box.children(".appListContainer[index='1']").append(icon.box,idx2);
			}else if(idx<idx2){//往后移
				me.box.children(".appListContainer[index='1']").append(icon.box,idx2+1);
			}
			me.Icon.splice(idx,1);
			me.Icon.splice(idx2,0,icon);
			me.refresh();
		
		},
		removeIcon:function(icon){
			var idx = (Panel.getIdx(icon.box));
			me.Icon.splice(idx,1);
			icon.box.remove();
			me.refresh();
		},
		getIdx:function(ex,ey){
			ex-=me.spaceLeft+me.spaceRight;
			ey-=me.spaceTop+me.spaceBottom;
			return (~~(ex/142))*me.row+(~~(ey/112));
		}
	};
	
	
}();

//侧边栏
Sidebar=function(me){
	
	var tool_list = "<div class='dock_tool_list' id='dockToolList' >";
	var tool_item = "<div class='dock_tool_item'></div>";
	var tool_a ="<a title='{title}' cmd='{cmd}'	class='dock_tool_icon dock_tool_{key}' href='###'></a>";
	
	//装载容器类
	var SideBox = $.Class({
		init :function(ops){
			this.create(ops.location);
		},
		create:function(location){
			this.box =$("<div id='"+location+"Bar'></div>");	
			Desktop.addPanel(this.box);	
		},
		addPanel:function(sidebar){			
			this.box.append(sidebar.pbox);
		}
	});
	return me ={
		 init : function(ops){
			
			
			me.create(ops.location);
			me.movePanel();
			me.addIcon(ops.Icon);
			me.addToolList();
			me.initDrag();

		 },
		 create:function(location){//创建
			//创建上左右 侧边栏容器
			me.leftPanel = SideBox({location:'left'});
			me.rightPanel = SideBox({location:'right'});
			me.topPanel = SideBox({location:'top'});
			
			me.box  = $('<div class="dock_middle"></div>');
			me.pbox = $('<div id="dockContainer" class="dock_container " style="z-index: 10;"> </div>');			
			//创建父边栏容器
			me[location+'Panel'].addPanel(me.pbox);
			me.location = location;
			me.Icon = [];		
			me.pbox.addClass("dock_pos_"+location);
			me.pbox.append(me.box);
			me.leftPanel.box.append(me.pbox);			
			Desktop.addPanel(me.leftPanel.box);
			Desktop.addPanel(me.rightPanel.box);
			Desktop.addPanel(me.topPanel.box);
			me.createStartTool();
			me.createPinyinTool();
			me.createSoundTool();
			me.createSettingTool();
			me.createThemeTool();
		 },
		 movePanel:function(){ //移动panel
			//初始化拖拽效果box
			dockEffectBox.init();
			//绑定鼠标按下事件			
			me.pbox.bind("mousedown",function(e){
				if($(e.target).css("cursor")=='pointer')return 				
				$(document).bind({
					'mousemove':drag,
					'mouseup':drop
				});
				e.preventDefault();	
			    e.stopPropagation();
			});
			//判断是否在拖动
			var flag = 0,deskWidth,deskHeight,location;
			function drag(e){
				Panel.unSelecte();
				if(!flag){
					flag=1;
					deskWidth=Desktop.box.outerWidth();
					deskHeight=Desktop.box.outerHeight();
					dockEffectBox.show();
				}
				var ex = e.pageX;
				var ey = e.pageY;
				if(ey<deskHeight*.2){//上				
					location='top';		
						
				}else if(ex<deskWidth*.5){//左边				
					location='left';
				}else{				
					location='right';
				}
				
			}
			function drop(){
				$(document).unbind('mousemove',drag).unbind('mouseup',drop);
				flag=0;
				dockEffectBox.hide();
				me[location+'Panel'].addPanel(me);			
				me.location=location;					
				me.addStyle();				
				Deskpanel.refreshIcon();//重新排布桌面图标
			} 
			  
		 },
		 addToolList:function(){//添加工具栏
			  var docklist = $(tool_list);
			  var dockItem = $(tool_item);
			  var dockItem2 = $(tool_item);
			  var dockItem3 = $(tool_item);
			  dockItem.append(me.pinyin).append(me.sound);
			  dockItem2.append(me.settingtool).append(me.theme);
			  dockItem3.append(me.start);
			  docklist.append(dockItem).append(dockItem2).append(dockItem3);
			  me.box.append(docklist);		
		 },		 
		 createStartTool:function(){//开始设置
			me.start = $("<a title='点击这里开始' class='dock_tool_icon dock_tool_start'	href='javascript:void(0);'></a>");

            me.start.powerFloat({
                 eventType: "click",
                 offsets:{x:getX,y:-100},
                 target: $("#startMenuContainer")
            });

             function getX(){
                 var p =me.pbox.parent();
                 var pid = p.attr("id");
                 var key = pid.substring(0,pid.length-3);
                 if(key=="left"){
                	 if(p.css("height").replace("px","")<=825)
                		 return -60;
                	 else
                		 return 60;
                 }else if(key=="top"){
                     return 0;
                 }else{
                    return 60;
                 }
             }

		 },
		 createPinyinTool :function(){//输入法
			me.pinyin =$(Util.formatmodel(tool_a,{
				"cmd":"Pinyin",
				"title":"输入法",
				"key":"pinyin"
			}));
		 }, 
		 createSoundTool:function(){//声音设置
			var sound = me.sound= $(Util.formatmodel(tool_a,{
				"cmd":"Sound",
				"title":"静音",
				"key":"sound"
			}));
			sound.toggle(function(){
				$(this).addClass("dock_tool_sound_mute").attr("title","取消静音");	
			
			},function(){
				$(this).removeClass("dock_tool_sound_mute").attr("titile","静音");
			});
		 },
		 createSettingTool:function(){//系统设置
			me.settingtool = $(Util.formatmodel(tool_a,{
				"cmd":"Setting",
				"title":"系统设置",
				"key":"setting"
			}));
		 },
		 createThemeTool:function(){//主题设置				
			 var theme = me.theme= $(Util.formatmodel(tool_a,{
				"cmd":"Theme",
				"title":"主题设置",
				"key":"theme"
			  }));
			  me.bindTheme();
		 },	 
		 bindTheme:function(){
			 var themsSetting = $("#themeSetting_wrap");			 
			 me.theme.click(function(){
					Windows.openSys({
						id :'themSetting',
						title :'设置主题',
						width :650,
						height:500,
						content :document.getElementById("themeSetting_wrap")
					});
			 });

			 $("a",themsSetting).live("click",function(){

					var a  = $(this);
					var themeid = a.attr("themeid");
					var src = themeid.substring(themeid.indexOf("_")+1,themeid.length);
					var h = $(window).height();
					var w = $(window).width();
					$("#zoomWallpaper").attr("src","plug-in/sliding/images/bg/"+src+".jpg").width(w).height(h);

					$.cookie("myskin","plug-in/sliding/images/bg/"+src+".jpg",cookieParam);

					$("#zoomWallpaperGrid").width(w).height(h);
					$("a",themsSetting).removeClass("themeSetting_selected");
					a.addClass("themeSetting_selected");
			 });
		 
		 }, 
		 addIcon:function(icon,idx){
			if(icon){
				if($.isArray(icon)){//传入的是数组
					$.each(icon,function(){
						me.addIcon(this.valueOf());
					});
					return me;
				}
				if(me.Icon.length==6){
					var last=me.Icon[5];////替换掉具体的一级菜单数量
					me.Icon.length=6;
					$(last.box).remove();
					return;
				}
				
				var Icon=typeof icon=='string'?appIcon_t2(icon):icon;//传入的是程序的fid还是Icon对象
				if(idx!=undefined){
					me.Icon.splice(idx,0,Icon);
					me.box.append(Icon.box,idx);				
				}else{
					me.Icon.push(Icon);
					me.box.append(Icon.box);
				}
			
			
			}
		 },
		 removeIcon:function(icon){
			var idx = (Panel.getIdx(icon.box));
			me.Icon.splice(idx,1);
			$(icon.box).remove();		 
		 },
		 getIdx:function(ex,ey){//获得位置		
			var off =me.pbox.offset();
			switch(me.location){
				case 'top':
					return~~((ex-off.left)/142);
				case 'left':
				case 'right':
					return~~((ey-off.top)/112);
			}
		 },
		 addStyle:function(){//添加拖拽后的样式
			me.pbox.removeClass().addClass("dock_container dock_pos_"+me.location);
			switch(me.location){
				case "top":					
					me.topPanel.box.css({"width":"100%","height":"73px"}).show();
					me.leftPanel.box.css({"width":"0","height":"0"}).hide();
					me.rightPanel.box.css({"width":"0%","height":"0"}).hide();
					Deskpanel.box.css({"left":0,"right": 0});
					Deskpanel.desktopsContainer.css("top",73);
					break;
				case "left":
					me.leftPanel.box.css({"width": "73px","height":"100%"}).show();
					me.topPanel.box.css({"width":"0","height":"0"}).hide();					
					me.rightPanel.box.css({"width":"0%","height":"0"}).hide();
					Deskpanel.box.css({"left": "73px","right": "0px"});
					Deskpanel.desktopsContainer.css("left",73);
					break;					
				case "right":
					me.rightPanel.box.css({"width": "73px","height":"100%"}).show();	
					me.leftPanel.box.css({"width": "0","height":"0"}).hide();
					me.topPanel.box.css({"width":"0","height":"0"}).hide();	
					Deskpanel.box.css({"left":0,"right":73});
					Deskpanel.desktopsContainer.css("top",0);
				break;
			}
		 
		 },
		 initDrag:function(){//绑定元素拖拽
			var  desk =Deskpanel.desktopsContainer.find(".appListContainer");
			
			me.box.sortable({
				connectWith: desk,
				items:".appButton",
				opacity :"0.6",	
				scroll :true,
				start:function(event,ui){
					
				},
				stop:function(event,ui){
					
					var item = ui.item;
					var p = item.parent();
					if(p.hasClass("appListContainer")){
						item.css("position","absolute");
					}
					Deskpanel.refreshIcon();
					
				}
				
			}).disableSelection();
		 }
		 	
	}

}();


//导航栏
Navbar =function(me){
	//优先刷新出后台的数据以便其他方法中使用替换
//	dataFlush();
	var _box = "<div  id='navbar' class='no_sysbtn' ></div>";
	var _innerBox = "<div class='indicator_container nav_current_{index}'	id='indicatorContainer'></div>";
	var _userbox = "<div class='indicator indicator_header' id='navbarHeaderImg' cmd='user' title='{title}'><img src='{url}' alt='{title}' class='indicator_header_img' ></div>";
	var _abox  = "<a class='indicator indicator_{num}' href='###' cmd='switch' index='{index}'	title='{name}'><span class='indicator_icon_bg'></span><span class='indicatorhover indicator_icon_{num}'>{num}</span></a>";
	var _abox2 = "<a class='indicator indicator_{key}' href='###' cmd='{key}' title='{title}'></a>";
	var num =totalnum+1 ,////替换掉一级菜单的总数量
		defaultnum=1,
		title = "请登录",
		usericon = "plug-in/sliding/images/jeecg.png";
	
	return me = {
		init :function(){
			me.create();			
			me.bindEvent();//绑定导航按钮单击事件  
			me.setPosition();
		},
		bindEvent:function(){
		   me.innerbox.find("a[cmd='switch']").click(function(){
				var _this = $(this);
				var cmd = _this.attr("cmd[switch]");
				var classname = $.trim(me.innerbox.attr("class"));
				var currentindex = parseInt(classname.substring(classname.length-1));	
				var index = parseInt(_this.attr("index"));
				me.bindSwitchDesktopAnimate(index,currentindex);
				me.innerbox.removeClass().addClass("indicator_container nav_current_"+parseInt(index+1));
		   });
		   me.box.draggable();
		},
		bindSwitchDesktopAnimate:function(t,c){//切换动画事件 t 目标桌面  c当前桌面
			var left = 0;
			var c = parseInt(c-1);			
			if(t<c){//往左移动
				left = -2000;
			}else{//往右移动
				left = 2000;
			}			
			var cdesk=Deskpanel.desktopsContainer.find(".desktopContainer[index="+c+"]");
				cdesk.removeClass("desktop_current");
				cdesk.stop().animate({
					left: left
				}, 'normal', function(){
							
				});	
			var idesk =Deskpanel.desktopsContainer.find(".desktopContainer[index="+t+"]");
			idesk.removeClass("desktop_current").addClass("desktop_current");
			idesk.stop().animate({
					left:0
				 }, 'normal', function(){
					
			});
		},
		create:function(){//创建导航
			me.box = $(_box);
			me.box.append("<div class='indicator_wrapper'></div>");
			me.box.find(".indicator_wrapper").append(me.createInnerbox());
			Desktop.addPanel(me.box);			
		},
		createInnerbox:function(){//创建内部容器
			var con = me.innerbox =   $(Util.formatmodel(_innerBox,{
				"index":defaultnum
			}));
			con.append(me.createUser());
			me.createIndicator();
			con.append(me.createSearch());
			con.append(me.createManage());
			return con;
		},
		createUser:function(){//创建用户头像
			var user = me.userbox =  $(Util.formatmodel(_userbox,{
				"url":usericon,
				"title":title	
			}));
			user.click(function(){
				alert("It's  xiaofan ");			
			});
			
			return user
		},
		createIndicator:function(){//创建导航项
			//增加数据动态处理的过程
			////这里使用menuString来替换掉每个一级二级菜单的数据
			
//			dataFlush();
			var i = 0;
			$.each(menujson,function(n,value){
				var obj = Util.formatmodel(_abox,{
					"num":i+1,
					"id":value.id,
					"index":i,
					"name":value.name
				});
				i++;
			    me.innerbox.append(obj);
			})
//			for(var i =0;i<5;i++){
////				alert(ss[i].id);
//				var obj = Util.formatmodel(_abox,{
//					"num":i+1,
//					"index":i
//				});
//			    me.innerbox.append(obj);
//			}
		},
		createSearch : function(){//搜索		
			var search = me.search  = $(Util.formatmodel(_abox2,{
					"key":"search",
					"title":"搜索"
			}));
			//创建搜索栏
			var pagelet_search_bar = $("<div class='pagelet_search_bar' style='display: none; '></div>");
			var pageletSearchInput = $("<input>",{
				"class" : "pagelet_search_input",
				value  : "搜索功能模块和应用..."
			});
			var pageletSearchButton = $("<input>",{
				id : "pageletSearchButton",
				"class" : "pagelet_search_button",
				title :"搜索..."
			});			
			var pagelet_search_suggest =$("<div class='pagelet_search_suggest' id='pagelet_search_suggest'style='display: none;' ></div>");
			var sb_resultbox = $("<ul id='sb_resultBox'  style='display: block;'></ul>");

			var sb_app_item_1 =$("<div idx='-1' class='sb_resultList fsb_resultList sb_page'><a href='#'><span class='sb_pageTxt'><span id='sb_resultBox_key' class='sb_resultBox_key'>s</span>-在“百度”搜索...</span></a>  </div>");		
			var sb_app_item_2 = $("<div idx='-2' class='sb_resultList fsb_resultList sb_app'><a href='#'><span class='sb_appTxt'><span id='sb_resultBox_key'  class='sb_resultBox_key'>s</span>-去系统应用搜搜...</span></a></div>");
			pagelet_search_suggest.append(sb_resultbox).append(sb_app_item_1).append(sb_app_item_2);			

			pagelet_search_bar.append(pageletSearchInput).append(pageletSearchButton);	
			
			Body.addPanel(pagelet_search_bar);
			Body.addPanel(pagelet_search_suggest);
			
			search.powerFloat({
				width: pagelet_search_bar.width(),
				eventType:"click",
				offsets: {
					x: 5,
					y: 20
				},
				position:"3-1",
				target: pagelet_search_bar, 	 		
				showCall: function(){
					//设置suggest结果框位置
					var _offset = pagelet_search_bar.offset();
					pagelet_search_suggest.offset({top:_offset.top+32,left:_offset.left});
				
				}
			});
			
			pageletSearchInput.focus(function(){
				$(this).val("");				
			}).blur(function(){
				toggleSearchSuggest();	

				var searchhtnl=$(this).val();
				$(this).val("搜索功能模块和应用...");
				
				$(".fsb_resultList").show();

			}).keyup(function(){
				var _this = $(this);
				var _val = _this.val();
				$(".sb_resultBox_key").html(_val);
				if(_val=="o"){		
					$("#sb_resultBox").append("<li class='sb_resultList' idx='2232'><a href='#' title='owlhr'><div class='listInner'>新奥尔</div></a></li>")
					 .show();
					 pagelet_search_suggest.show();		
				}
				
				if(_val==""){
					pagelet_search_suggest.hide();	
				}
				
			});
			var toggleSearchSuggest =function(){
				var _val = pageletSearchInput.val();				
				if(_val==""){
					pagelet_search_suggest.hide();			
				}else{
					pagelet_search_suggest.show()
				}	
			}
			
			
			return search ;
		},
		createManage :function(){//全局视图
			var manage = me.manage = $(Util.formatmodel(_abox2,{
					"key":"manage",
					"title":"全局视图"
			}));			
			manage.click(function(){
				//显示全局桌面 关闭正常桌面
				if(appManagerPanel){
					appManagerPanel.show();				
					appManagerPanel.showItemsTurn();
					appManagerPanel.resize();
					Desktop.hide();				
					//设置列表区的高度 
					
				}
			});
			
			
			
			return manage;
		},
		setPosition :function(){//设置位置
			var ww = $(window).width();
			var mw = me.box.width();
			me.box.css("left",parseInt(ww/2)-parseInt(mw/2));
		}
		
		
		
	}
	

}();
//全局应用管理
appManagerPanel = function(me){
	
	var appManagerPanel ="<div id='appManagerPanel' class='appManagerPanel' style='display: none; '></div>";//创建全局桌面容器
	var aMg_Close="<a class='aMg_close' href='###'></a>";//关闭按钮			
	var aMg_dock_container ="<div class='aMg_dock_container' index='{totalnum}' customacceptdrop='1'></div>";	
	var aMg_line_x = "<div class='aMg_line_x'></div>";//x轴线
	var aMg_line_y = "<div class='aMg_line_y'></div>";//y轴线
	var aMg_App_container = "<div class='aMg_folder_container'></div>";//应用容器
	var folderitem ="<div class='folderItem'><div class='folder_bg folder_bg{key}'></div><div class='folderOuter' index='{index}' customacceptdrop='{key}'></div></div>";

//	var folderinner ="<div class='folderInner' style='height: 100%; overflow-x: hidden; overflow-y: hidden; ' index='{index}' customacceptdrop='{key}'></div>";
	var folderinner ="<div class='folderInner' style='height: 90%; overflow-x: hidden; overflow-y: hidden; ' index='{index}' customacceptdrop='{key}'></div>";

	var scrollBar ="<div class='scrollBar' style='margin-top: 0px; height: 0px; display: none;' _olddisplay='block'></div>";

	return me = {
		init : function(){
			me.create();			
			me.bindEvent();
			me.resize();
		},
		create:function(){
			me.box = $(appManagerPanel);
			me.aMg_close = $(aMg_Close);
			me.box.append(me.aMg_close)
				.append(me.cSidebarApp())
				.append(aMg_line_x)
				.append(me.cDeskApp());
			Body.addPanel(me.box);
		},		
		cSidebarApp:function(){//创建侧边栏界面
			me.aMg_dock_container = $(aMg_dock_container);
			me.loadSidebarData();
			return me.aMg_dock_container;
		},	
		loadSidebarData:function(){//侧边栏应用克隆到顶部
			var sItems = Sidebar.box.find(".appButton").clone().appendTo(me.aMg_dock_container);
		},
		cDeskApp:function(){//创建全局界面
			me.aMg_App_container = $(aMg_App_container);
			me.loadDeskData();
			return me.aMg_App_container;
		},
		loadDeskData:function(){//加载当前桌面应用数据 到全局界面		
			Deskpanel.desktopsContainer.find(".appListContainer").each(function(){
				 var _this = $(this);
				 var _index = parseInt(_this.attr("index"));
				 var item = $(Util.formatmodel(folderitem,{
						"index":_index,
						"key":_index+1
				 }));
				 var inner  = $(Util.formatmodel(folderinner,{
						"index":_index,
						"key":_index+1
				 }))
				 var outer =item.find(".folderOuter");
				 _this.children().each(function(){								
					inner.append(appIcon_amg1($(this).attr("fid")).box);
				 });
				 outer.append(inner);
                 outer.append(scrollBar);
				 if(_index!=0){
					outer.after(aMg_line_y);//纵轴线
				 }

				 me.aMg_App_container.append(item);
			});
		},
		bindEvent:function(){
			var  folderitems =$(".folderItem",me.box);
			me.aMg_close.click(function(){//绑定关闭
				me.hide();
				folderitems.removeClass("folderItem_turn");
				Desktop.show();
			});			
			
			var item = folderitems.find(".folderInner");//绑定拖拽
			item.sortable({
					items:".appButton",
					connectWith :[item,me.aMg_dock_container],					
					opacity :"0.6",
					stop: function(event, ui) {
						var item = ui.item;
						var p = item.parent();
						if(item.parent().hasClass("aMg_dock_container")){
							item.removeClass("amg_folder_appbutton");
						}
					}
			}).disableSelection();		
			
			
			me.aMg_dock_container.sortable({
					items:".appButton",
					connectWith :".folderInner",					
					opacity :"0.6",
					stop: function(event, ui) {
						item = ui.item;
						var p = item.parent();
						if(p.hasClass("folderInner")){							
							item.addClass("amg_folder_appbutton");
						}
					}
			}).disableSelection();		
			
		},
		showItemsTurn:function(){			
			$(".folderItem",me.box).show().addClass("folderItem_turn");
		},
		show:function(){
			me.box.show();
		},
		hide:function(){
			me.box.hide();
		},
		resize:function(){
			var h = $(window).height() -60	;		
			me.aMg_App_container.height(h);
		}
	
	};

}();



//拖拽效果容器
dockEffectBox = function(me){
	
	var _tbox ="<div id='docktop' class='dock_drap_effect dock_drap_effect_top ' style='display: none;' _olddisplay='block'></div>";
	var _lbox ="<div id='dockleft' class='dock_drap_effect dock_drap_effect_left' style='display: none;'></div>";
	var _rbox ="<div id='dockright' class='dock_drap_effect dock_drap_effect_right' style='display: none;'></div>";
	var	_proxybox ="<div class='dock_drap_proxy' style='display: none; left: -79px; top: -260px;'></div>";
	var	_maskbox="<div id='dockmask' class='dock_drap_mask' style='display: none;'>"+
					"<div class='dock_drop_region_top' cmd='region'name='top'></div>"+
					"<div class='dock_drop_region_left' cmd='region' name='left'></div>"+
					"<div class='dock_drop_region_right' cmd='region' name='right'></div>"+
				"</div>";
	return me = {		 
		 init : function(){
			me.create();
		 },
		 create :function(){		
		 	me.tbox = $(_tbox);
			me.lbox = $(_lbox);
			me.rbox = $(_rbox);
			me.proxybox = $(_proxybox);
			me.maskbox = $(_maskbox);
			me.addDesktop();
		 },
		 addDesktop :function(){
			Desktop.addPanel(me.tbox);
			Desktop.addPanel(me.lbox);
			Desktop.addPanel(me.rbox);
			Desktop.addPanel(me.proxybox);
			Desktop.addPanel(me.maskbox);
		 },
		 show:function(){
			me.tbox.show();
			me.lbox.show();
			me.rbox.show();
			me.maskbox.show();
		 },
		 hide:function(){
			me.tbox.hide();
			me.lbox.hide();
			me.rbox.hide();
			me.maskbox.hide();
		 }
	
	};
}();

//底部栏容器类
BottomBar = function(me){
	
	var _box = "<div id='bottomBar' class='bottomBar' style='z-index: 12;'></div>";	
	var _NextBox = "<div id='taskNextBox' class='taskNextBox' _olddisplay='' style='display: none;'><a id='taskNext' class='taskNext' hidefocus='true' href='#'></a></div>";
	var _PreBox = "<div id='taskPreBox' class='taskPreBox' _olddisplay='' style='display: none;'><a id='taskPre' class='taskPre' hidefocus='true' href='#'></a></div>";
	var _taskContainner = "<div id='taskContainer' class='taskContainer' style=''></div>";
	var bottonbarbg = "<div class='bottomBarBg'></div>";
	var bottomBarBgTask = "<div class='bottomBarBgTask'></div>";
	
	return me  = {
		init:function(){
			me.create();
			Desktop.addPanel(me.box);
			Desktop.addPanel(bottonbarbg);
			Desktop.addPanel(bottomBarBgTask);			
		},
		create:function(){
			var box =me.box = $(_box);
			me.innerbox = $("<div id='taskContainerInner' class='taskContainerInner' style=''></div>");
			me.taskContainner = $(_taskContainner);
			me.taskContainner.append(me.innerbox);
			box.append(_NextBox);
			box.append(me.taskContainner);
			box.append(_PreBox);			
		},
		addItem:function(item){//像底部任务栏添加任务项
			me.innerbox.append(item);
			var len = me.innerbox.children().length;
			var id = item.attr("id");
			var w = item.width()*len+20;
			me.taskContainner.width(w);
			me.innerbox.css({"margin-right": 0,"width":(w)});	
			me.setCurrent(id);
		},
		getItem:function(id){//根据ID查询底部任务栏
			return me.innerbox.find("a[tid='"+id+"']");
		},
		getItemNum:function(){//得到当前任务数
			return me.innerbox.children().size();
		},
		setCurrent:function(id){			
			me.addCurrent(id);
			me.removeItemSibling(id);		
		},		
		addCurrent:function(id){//设置当前任务栏样式			
			me.innerbox
			.find("#"+id)
			.addClass("taskCurrent");				
		},
		removeItemSibling:function(id){//移除当前任务同类样式
			me.innerbox
			.find("#"+id)
			.siblings()
			.removeClass("taskCurrent");		
		},
		getALLItemID :function(){//得到当前任务栏所有任务ID
			var items = me.innerbox.children();
			var idArray =[];
			items.each(function(){
				var id =$(this).attr("id");
				id  =id.substring(id.lastIndexOf("_")+1,id.length);			
				idArray.push(id);
			})
			return idArray ; 
		}
		
	}

}();

//任务类
Task = $.Class({
	init :function(op){
		this.create(op);
		this.rightMenu();
	},
	create:function(op)	{
		var task =$("<div>", {
		  "class": "taskGroup taskGroupAnaWidth",
		  id: "taskGroup_"+op.id+"_"+op.id
		});
		var taskItemIcon = $("<div>",{
			"class":"taskItemIcon"
		});
		$("<img src='plug-in/sliding/icon/"+op.icon+"'/><div class='taskItemIconState'></div>").appendTo(taskItemIcon);
	
		var taskItemTxt  = $("<div>",{
			"class":"taskItemTxt",
			text : op.title
		});
		var taskItemBox  = $("<div>",{
			"class":"taskItemBox",
		});			
		var taskA =$("<a>",{
			"class":"taskItem fistTaskItem",
			"href" :"#",
			id  : "taskItem_"+op.id,
			"title" :op.title,
			"tid" :op.id,
			"appid":op.id+"_"+op.id
		});
		taskA.append(taskItemIcon).append(taskItemTxt);
		taskItemBox.append(taskA);
		task.append(taskItemBox);
		this.box = task ;
	},
	rightMenu:function(){
		var taskmenu = [
			[{
				text:"最大化",
				func:function(){
                    var id = $(this).attr("id");
                    wid  =id.substring(id.lastIndexOf("_")+1,id.length);
                    $.dialog.list[wid].show().max();
				}
			},
			 {
				text:"最小化",
				func:function(){
				
				}
			 }	
			],
			[{
				text:"关闭",
				func:function(){
					var id = $(this).attr("id");
					wid  =id.substring(id.lastIndexOf("_")+1,id.length);
					$.dialog.list[wid].close();
					$("#"+id).remove();
				}
			}]
		
		]
		this.box.smartMenu(taskmenu, {
			name: "taskmenu"  ,
			offsetX :-100,
			offsetY :-100
		});
	}
});

//窗体类 集成artDialog
Windows = function(me){	

	return me = {
		
		showWindow : function(id){//art弹出 
			
			var array= $.dialog.list;
			var taskIds = BottomBar.getALLItemID();
			var taskLen = taskIds.length;
			var api=array[id];

            function changeLhgDialogFocus() {
                var foucsApi = null;
                for(var obj in $.dialog.list){
                    obj = $.dialog.list[obj];
                    var wrap = obj.DOM.wrap;
                    var $wrap = $(wrap);
                    if($wrap.css("visibility") == 'visible'){
                        if(foucsApi == null){
                            foucsApi = obj
                        }else{
                            foucsApi = $wrap[0].style.zIndex > foucsApi.DOM.wrap[0].style.zIndex
                                ?obj:foucsApi;
                        }

                    }
                }
                if(foucsApi){
                    $.dialog.focus.DOM.border.removeClass('ui_state_focus');
                    $.dialog.focus = foucsApi;
                    foucsApi.DOM.border.addClass('ui_state_focus');
                }

            }

			var wrap = api.DOM.wrap;
			var $wrap = $(wrap);

            if(taskLen >1){//判断任务个数 显示切换和焦点切换
				if($wrap.css("visibility") == 'hidden'){
					 api.show().zindex();
				}else{
					if(!api.DOM.border.hasClass('ui_state_focus')){
						api.zindex();
					}else{
						api.hide();
                        changeLhgDialogFocus();
					} 
				}
				
			}else{
				if($wrap.css("visibility") == 'visible'){
					api.hide();
				}else{
					api.show();
				}
				
			}

		},
		hideWindow :function(id){//隐藏
            $.dialog.list[id].hide();
		},
		closeMinTask:function(id){//关闭任务
			$("#taskGroup_"+id+"_"+id).remove();
		},
		closeAllWindow:function(){//关闭所有窗体
			var list = $.dialog.list;
			for (var i in list) {
				list[i].close();
			};
		},	
		openSys :function(op){//打开系统窗体
            $.dialog({
				id :op.id,
				title :op.title,
				width :op.width,
				height:op.height,
				max:false,
				min:false,
				content :op.content
			});
			
		},
		openApp:function(id,title,url,icon,width,height){//打开应用窗体
			var taskInner =BottomBar.innerbox;
			var taskItem = BottomBar.getItem(id);
			if(taskItem.length==1){
				return ;
			}else{
				var len = BottomBar.getItemNum();// 任务图标集合 大于7 不让添加
				if(len>7&&len!=0){	   
					return false;
				}	
				var task = Task({//创建最小化任务图标
					"id":id,
					"title":title,
					"icon":icon						
				});
				BottomBar.addItem(task.box);	
				task.box.click(function(){	   				
					me.showWindow(id);	  
					BottomBar.setCurrent(task.box.attr("id"));
				});

                $.dialog({
                    id:id,
                    lock : false,

                    zIndex:1000+getDialogLength(),

                    width:width,
                    height:height,
                    title:title,
                    opacity : 0.3,
                    min:false,
                    content:'url:'+url,
                    close:function(){
                        me.closeMinTask(id);
                    }
                }).zindex();


				/*art.dialog.open(url,*//** 弹出ART窗体*//*
					{
						"id" :id,
						title: title,
						width:width,
						height:height,
						close:function(){
							me.closeMinTask(id);
						}
					}
                );*/
			}
		
		}
	
	
	}

}();


function getDialogLength(){
    var length = 0;
    for( var i in $.dialog.list ){
        length++;
    }
    return length;
}

//图标基类 
appIcon_amg= $.Class({		
	create:function(t)	{
		this.box = $("<div  type='"+t+"'  class='appButton amg_folder_appbutton' ></div>");
	}
});

//图标类t0
appIcon_t0 = $.Class({
	create :function(t){
		this.box =  $("<div type='"+t+"'  class='appButton'></div>");
		this.setRightMenu();
	},	
	setRightMenu:function(){	
	}
});

//全局应用图标
appIcon_amg1 = appIcon_amg.extend({
	init : function(fid){	
		this.fid = fid;
		//替换data.js数据——这里的方法貌似没有用到
		this.app = datajson.app[fid];
//		this.app = DATA.app[fid];
		this.tx ="app";	
		this.create();
		this.bindEvent();
	},		
	create:function(){	
		this._super(1);			
		this.box.attr({
			id:"icon_app_"+this.app.appid+"_"+this.app.asc,
			appid:this.app.appid,
			fileid : this.app.appid,
			title:this.app.name,

            url: this.app.url,

			uid :"app_"+this.app.appid
		});
		
		var appIcon =$("<div>",{
			  id : "icon_app_"+this.app.appid+"_"+this.app.asc+"_icon_div",
			  "class" : "appButton_appIcon"
		});
		appIcon.append($("<img>",{
			alt:this.app.name ,
            /*update-begin--Author:zhangguoming  Date:20140509 for：云桌面图标管理*/
//			src:'plug-in/sliding/icon/'+this.app.icon,
			src:this.app.icon,
            /*update-end--Author:zhangguoming  Date:20140509 for：云桌面图标管理*/
			"class":"appButton_appIconImg",
			id:'icon_app_'+this.app.appid+'_'+this.app.asc+'_img'
		
		}));			
		var nameDiv = $("<div class='appButton_appName'></div>");
		var name_inner = $("<div>",{
			"class":'appButton_appName_inner',
			id:'icon_app_'+this.app.appid+'_'+this.app.asc+'_name',
			text:this.app.name		
		});
		var name_right =$("<div class='appButton_appName_inner_right'></div>");
		nameDiv.append(name_inner).append(name_right);
		
		var notify = $("<div>",{
			"class": 'appButton_notify',
			id :'icon_app_'+this.app.appid+'_'+this.app.asc+'_notify',
		});
		$("<span class='appButton_notify_inner'></span>").appendTo(notify);
		
		var deleteDiv = $("<div>",{
			title:'卸载应用' ,
			id :'icon_app_'+this.app.appid+'_'+this.app.asc+'_delete',
			"class":'appButton_delete'		
		}); 
		
		this.box.append(appIcon).append(nameDiv).append(notify).append(deleteDiv);
	},
	bindEvent:function(){

        this.box.click(function(e){
            e.preventDefault();
            e.stopPropagation();
            var _this = $(this);
            var id = _this.attr("appid");
            var title = $.trim(_this.text());
            var url =_this.attr("url");
            var icon =_this.find("img").attr("src").split("/")[3];
            Windows.openApp(id,title,url,icon,1000,500);

            appManagerPanel.hide();
            Desktop.show();

        });
	}	
		
});


//来至桌面的图标
appIcon_t1 = appIcon_t0.extend({		
	init : function(fid){	
		this.fid = fid;
//		//替换data.js数据
		this.app = datajson.app[fid];
//		this.app = DATA.app[fid];
		this.tx =1;	
		this.create(fid);
		this.bindEvent();
	},		
	create:function(fid){	
		this._super(1);			
		this.box.attr({
			id:"icon_app_"+this.app.appid+"_"+this.app.asc,
			appid:this.app.appid,
			fileid : this.app.appid,
			title:this.app.name,
			uid :"app_"+this.app.appid	,
			fid: fid,
			//TODO:加载url地址
			url:this.app.url
//			url:"userController.do?user"
		});
		
		var appIcon =$("<div>",{
			  id : "icon_app_"+this.app.appid+"_"+this.app.asc+"_icon_div",
			  "class" : "appButton_appIcon"
		});
		appIcon.append($("<img>",{
			alt:this.app.name ,
            /*update-begin--Author:zhangguoming  Date:20140509 for：云桌面图标管理*/
//			src:'plug-in/sliding/icon/'+this.app.icon,
			src:this.app.icon,
            /*update-end--Author:zhangguoming  Date:20140509 for：云桌面图标管理*/
			"class":"appButton_appIconImg",
			id:'icon_app_'+this.app.appid+'_'+this.app.asc+'_img'
		
		}));			
		var nameDiv = $("<div class='appButton_appName'></div>");
		var name_inner = $("<div>",{
			"class":'appButton_appName_inner',
			id:'icon_app_'+this.app.appid+'_'+this.app.asc+'_name',
			text:this.app.name		
		});
		var name_right =$("<div class='appButton_appName_inner_right'></div>");
		nameDiv.append(name_inner).append(name_right);
		
		var notify = $("<div>",{
			"class": 'appButton_notify',
			id :'icon_app_'+this.app.appid+'_'+this.app.asc+'_notify'
		});
		$("<span class='appButton_notify_inner'></span>").appendTo(notify);
		
		var deleteDiv = $("<div>",{
			title:'卸载应用' ,
			id :'icon_app_'+this.app.appid+'_'+this.app.asc+'_delete',
			"class":'appButton_delete'		
		}); 
		
		this.box.append(appIcon).append(nameDiv).append(notify).append(deleteDiv);
	},
	bindEvent:function(){//绑定事件
		this.box.click(function(e){
			 e.preventDefault();
			 e.stopPropagation();
			 var _this = $(this);
			 var id = _this.attr("appid");
			 var title = $.trim(_this.text());
//			 var url ="http://www.jeecg.org";
			 var url =_this.attr("url");
			 var icon =_this.find("img").attr("src").split("/")[3];			
			 Windows.openApp(id,title,url,icon,1400,600);
		});
	}
});

//来至侧边框的图标
appIcon_t2 = appIcon_t0.extend({
	init:function(fid){
		this.fid = fid;
		this.sApp = DATA.sApp[fid];
		this.tx = 2;
		this.create();	
		this.bindEvent();		
	},
	create : function(){
		this._super(2);
		this.box.attr({
			id:"icon_app_"+this.sApp.appid+"_"+this.sApp.asc,
			appid:this.sApp.appid,
			fileid : this.sApp.appid,
			title:this.sApp.name,

			uid :"app_"+this.sApp.appid,
            url:this.sApp.url

		});
		
		var appIcon =$("<div>",{
			  id : "icon_app_"+this.sApp.appid+"_"+this.sApp.asc+"_icon_div",
			  "class" : "appButton_appIcon"
		});
		appIcon.append($("<img>",{
			alt:this.sApp.name ,

//			src:'plug-in/sliding/icon/'+this.sApp.icon,
			src:this.sApp.icon,

			"class":"appButton_appIconImg",
			id:'icon_app_'+this.sApp.appid+'_'+this.sApp.asc+'_img'
		
		}));			
		var nameDiv = $("<div class='appButton_appName'></div>");
		var name_inner = $("<div>",{
			"class":'appButton_appName_inner',
			id:'icon_app_'+this.sApp.appid+'_'+this.sApp.asc+'_name',
			text:this.sApp.name		
		});
		var name_right =$("<div class='appButton_appName_inner_right'></div>");
		nameDiv.append(name_inner).append(name_right);
		var deleteDiv = $("<div",{
			title:'卸载应用' ,
			id :'icon_app_'+this.sApp.appid+'_'+this.sApp.asc+'_delete',
			"class":'appButton_delete'		
		}); 
		
		this.box.append(appIcon).append(nameDiv).append(deleteDiv);
	},
	bindEvent:function(){//绑定事件
		this.box.click(function(e){
			 e.preventDefault();
			 e.stopPropagation();
			 var _this = $(this);
			 var id = _this.attr("appid");
			 var title = $.trim(_this.text());
			 var url =_this.attr("url");
//			 var url ="logController.do?log";
			 var icon =_this.find("img").attr("src").split("/")[3];			
                 Windows.openApp(id,title,url,icon,1000,500);
		});
	}
});

$(function() {

	Body.init();
//	dataFlush();
	Desktop.init();
	//替换icon的数组内容

//	Deskpanel.init(iconjson).refresh();
	Deskpanel.init(iconjson, true);

	Sidebar.init({
		location:'left',//初始化sidebar的位置为左侧

        Icon:defaultIconForSlider
		/*Icon:[
			'appmarket',
			'zone',
			'weibo',
			'mail',
			'internet',
			'qq'
		]*/

	});
	Navbar.init();//初始化导航条	
	BottomBar.init();//初始化下部栏
	appManagerPanel.init();//初始化全局桌面
	
});

$(function(){
	$(".fsb_resultList").live("click",function(){
		
		var idx=$(this).attr("idx");
		var sb_resultBox_key=$(this).find(".sb_resultBox_key").html();
		if(idx=="-1"){
			Windows.openApp("","百度搜索","http://www.baidu.com/s?tn=13081079_1_pg&ie=utf-8&bs=fda&f=8&rsv_bp=1&rsv_spt=1&wd="+sb_resultBox_key,"default.png",1000,500);
		}else if(idx=="-2"){
			
			Windows.openApp("","应用搜索","functionController.do?searchApp&name="+sb_resultBox_key,"default.png",800,400);
		}
		$(".fsb_resultList").hide();
	})

	  var mychangeskin=$.cookie("myskin");
	
	  if(mychangeskin)
		 {
			 $("#zoomWallpaper").attr("src",mychangeskin);
			 $.cookie("myskin",mychangeskin,cookieParam);//1为关掉浏览器不消失效果，0为消失
		 }

	
});

