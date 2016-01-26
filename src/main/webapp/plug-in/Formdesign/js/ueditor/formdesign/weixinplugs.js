/*
* 参考 leipiFormDesign写的插件
* 龙金波
*/
UE.leipiFormDesignUrl = 'formdesign';

UE.plugins['weixin_template'] = function () {
    var me = this,thePlugins = 'weixin_template';
    me.commands[thePlugins] = {
        execCommand:function (cmd,uiName) {
    		var pos='';
	    	if(uiName=='内容区'){
	        	pos   	='WXNRQ';//此处编码要对应weixin数据字典项
	        }if(uiName=='关注引导'){
	        	pos   	='WXGZYD';
	        }else if(uiName=='标题'){
	        	pos   	='WXBT';
	        }else if(uiName=='原文引导'){
	        	pos   	='WXYWYD';
	        }else if(uiName=='分隔线'){
	        	pos   	='WXFGX';
	        }else if(uiName=='互推账号'){
	        	pos   	='WXHTZH';
	        }else if(uiName=='我的样式'){
	        	pos   	='WXWDYS';
	        }else if(uiName=='其他'){
	        	pos   	='WXQT';
	        }
            var dialog = new UE.ui.Dialog({
                iframeUrl:this.options.UEDITOR_HOME_URL + UE.leipiFormDesignUrl+'/weixin.html?type='+pos,
                name:thePlugins,
                editor:this,
                title: '微信模板',
                cssRules:"width:740px;height:430px;",
                buttons:[
                {
                    className:'edui-okbutton',
                    label:'确定',
                    onclick:function () {
                        dialog.close(true);
                    }
                }]
            });
            dialog.render();
            dialog.open();
        }
    };
};
function weixinButton(editor,uiName){
    if(!this.options.toolleipi)
    {
        return false;
    }
   // alert(uiName);
    //注册按钮执行时的command命令，使用命令默认就会带有回退操作
    editor.registerCommand(uiName,{
        execCommand:function(){
            try {
            	 editor.execCommand('weixin_template',uiName);
            } catch ( e ) {
                alert('打开模板异常'+e);
            }
        }
    });
    var pos ='-928px -0px;width: 61px';
    if(uiName=='内容区'){
    	pos   	='-836px -0px;width: 48px';
    }else if(uiName=='标题'){
    	pos   	='-887px -0px;width: 39px';
    }else if(uiName=='原文引导'){
    	pos   	='-836px -22px;width: 62px';
    }else if(uiName=='分隔线'){
    	pos   	='-903px -22px;width: 50px';
    }else if(uiName=='互推账号'){
    	pos   	='-836px -45px;width: 62px';
    }else if(uiName=='我的样式'){
    	pos   	='-902px -45px;width: 63px';
    }else if(uiName=='其他'){
    	pos   	='-955px -22px;width: 41px';
    }
    //创建一个button
    var btn = new UE.ui.Button({
        //按钮的名字
        name:uiName,
        //提示
        title:uiName,
        //需要添加的额外样式，指定icon图标，这里默认使用一个重复的icon
        cssRules :'background-position:-902px -45px;width: 63px!important;',
        //点击时执行的命令
        onclick:function () {
            //这里可以不用执行命令,做你自己的操作也可
           editor.execCommand(uiName,uiName);
        }
    });

    //因为你是添加button,所以需要返回这个button
    return btn;
}
UE.registerUI('微信模板',weixinButton);
/*
UE.registerUI('标题',weixinButton);
UE.registerUI('内容区',weixinButton);
UE.registerUI('互推账号',weixinButton);
UE.registerUI('分隔线',weixinButton);
UE.registerUI('原文引导',weixinButton);
UE.registerUI('其他',weixinButton);
UE.registerUI('我的样式',weixinButton);*/