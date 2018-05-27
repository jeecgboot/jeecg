<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>

<link rel="stylesheet" type="text/css" href="plug-in/ztree/css/zTreeStyle.css">
<script type="text/javascript" src="plug-in/ztree/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="plug-in/ztree/js/jquery.ztree.excheck-3.5.min.js"></script>
<script type="text/javascript">
    var setting = {
        check: {
            enable: false,
            chkboxType: { "Y": "", "N": "" }
        },
        data: {
            simpleData: {
                enable: true
            }
        },callback: {
            onClick:onClick
        }
    };
    
    function onClick(event, treeId, treeNode){
    	$("#sitePanel").panel({
            title:treeNode.name,
		    content:'<iframe src="' + treeNode.site + '" frameborder=0 height=100% width=100% ></iframe>'
		});
    }

    //加载tree
    $(function(){
    	$.getJSON("${webRoot}/webpage/com/jeecg/demo/siteData.json",function(data){ 
    		var d = data;//$.parseJSON(data);
            if (d.success) {
                var dbDate = eval(d.msg);
                $.fn.zTree.init($("#siteSelect"), setting, dbDate);               
                
                $("#sitePanel").panel({
                	title:dbDate[0].name,
				    content:'<iframe src="' + dbDate[0].site + '" frameborder=0 height=100% width=100% ></iframe>'
				});
            }
    	});
    });
</script>
<div class="easyui-layout" fit="true" style="width:1000px;height:600px;">
    <div region="west" split="true" title="网址列表" style="width:200px;">
        <ul id="siteSelect" class="ztree" ></ul>
    </div>
    <div region="center" title="webSite" style="width:800px;" id="sitePanel" class="easyui-panel">
    </div>
</div>