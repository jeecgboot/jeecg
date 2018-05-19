//js增强组件，实现popup选择组织机构组件
//用于显示已选择部门名称的input的id
var selectedIdsInputId_depart = "orgIds";
//用于记录已选择部门编号的input的id
var selectedNamesInputId_depart = "departname";
//已选择机构输入框宽度
var departName_departInputWidth_depart = 80;
//窗口宽度
var windowWidth_depart = 600;
//窗口高度
var windowHeight_depart = 300;
//部门ID
var departId_depart = "";
//部门名称
var departName_depart = "";
//组件名称
var lblDepartment_depart = "组织机构";
//名称
var commonDepartmentList_depart = "组织机构列表";
$(function(){
    var htmlContent = "<span style=\"display:-moz-inline-box;display:inline-block;\">"
    htmlContent += "<span style=\"vertical-align:middle;display:-moz-inline-box;display:inline-block;width: " + departName_departInputWidth_depart + ";text-align:right;\" title=\"" + lblDepartment_depart + "\"/>"
    htmlContent += lblDepartment_depart + "：";
    htmlContent += "</span>";
    htmlContent += "<input readonly=\"true\" type=\"text\" id=\"" + selectedNamesInputId_depart + "\" name=\"" + selectedNamesInputId_depart + "\" style=\"width: 300px\" onclick=\"openDepartmentSelect_depart()\" ";
    if(departId_depart!=""){
        htmlContent += " value=\""+departName_depart+"\"";
    }
    htmlContent += " />";
    htmlContent += "<input id=\"" + selectedIdsInputId_depart + "\" name=\"" + selectedIdsInputId_depart + "\" type=\"hidden\" ";
    if(departName_depart!=""){
        htmlContent += " value=\""+departId_depart+"\"";
    }
    htmlContent += ">";
    htmlContent += "</span>";
    $("div[name='searchColums']").append(htmlContent);
})

function openDepartmentSelect_depart(){
    $.dialog.setting.zIndex = 9999;
    $.dialog({content: 'url:departController.do?departSelect', zIndex: 2100, title: commonDepartmentList_depart, lock: true, width:windowWidth_depart, height:windowHeight_depart, opacity: 0.4, button: [
        {name: '确定', callback: callbackDepartmentSelect_depart, focus: true},
        {name: '取消', callback: function (){}}
    ]}).zindex();
}

function callbackDepartmentSelect_depart(){
    var iframe = this.iframe.contentWindow;
    var treeObj = iframe.$.fn.zTree.getZTreeObj("departSelect");
    var nodes = treeObj.getCheckedNodes(true);
    if(nodes.length>0){
        var ids='',names='';
        for(i=0;i<nodes.length;i++){
            var node = nodes[i];
            ids += node.id+',';
            names += node.name+',';
        }
        $("#" + selectedNamesInputId_depart).val(names);
        $("#" + selectedNamesInputId_depart).blur();
        $("#" + selectedIdsInputId_depart).val(ids);
    }
}

