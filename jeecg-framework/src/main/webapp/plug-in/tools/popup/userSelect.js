//js增强组件，实现popup选择用户
//窗口宽度
var windowWidth_user = 1000;
//窗口高度
var windowHeight_user = 600;
//已选择用户输入框宽度
var userNameInputWidth_user = 80;
//用于记录已选择用户的input的id
var selectedNamesInputId_user = "realName";
//组件名称
var lblName_user = "用户名称";
//弹出框标头
var title_user = "用户列表";
UserSelectApi = {};
UserSelectApi.popup = function(key){
    /*var first = key.substring(0,1);
    if(first == "#"){
        //id选择器
        $("div[name='searchColums']").append($(key).html());
        $(key).remove();
        /!*$(key).find("input").on("click",function(){
            openUserSelect_user();
        });*!/
    }else if(first == "."){
        //类选择器
    }else{
        //标签名
    }*/
    $("div[name='searchColums']").append($(key).html());
    $(key).remove();
};
function openUserSelect_user() {
    $.dialog.setting.zIndex = 9999;
    $.dialog({content: 'url:userController.do?userSelect', zIndex: 2100, title_user: title_user, lock: true, width:windowWidth_user, height:windowHeight_user, opacity: 0.4, button: [
        {name:'确定',callback:callbackUserSelect_user,focus:true},
        {name:'取消',callback:function (){}}
    ]}).zindex();
}
function callbackUserSelect_user(){
    var iframe = this.iframe.contentWindow;
    var rowsData = iframe.$('#userList1').datagrid('getSelections');
    if (!rowsData || rowsData.length==0) {
        tip('<t:mutiLang langKey="common.please.select.edit.item"/>');
        return;
    }
    var names="";
    for(var i=0;i<rowsData.length;i++){
        names += rowsData[i].realName+",";
    }
    $("#"+selectedNamesInputId_user).val(names);
    $("#"+selectedNamesInputId_user).blur();
}