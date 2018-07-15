<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>ace风格修改页面</title>
  <meta name="description" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <t:base type="jquery,aceform,DatePicker,validform,ueditor,uploadify,layer"></t:base>
</head>
 <body>
 <form id="formobj"  action="jeecgListDemoController.do?doUpdate" name="formobj" method="post">
	<input type="hidden" id="btn_sub" class="btn_sub"/>
	<input type="hidden" id="id" name="id" value = "${jeecgDemoPage.id}"/>
	<div class="tab-wrapper">
		<!-- tab -->
	    <ul class="nav nav-tabs">
	      <li role="presentation" class="active"><a href="javascript:void(0);">ace新增demo</a></li>
	    </ul>
	    <!-- tab内容 -->
		<div class="con-wrapper" id="con-wrapper1" style="display: block;">
			<div class="row form-wrapper">
			
				<div class="row show-grid">
			        <div class="col-xs-3 text-center">
				        <b>名称：</b>
				    </div>
				    <div class="col-xs-6">
						<input id="name" name="name" type="text" class="form-control"   datatype="s2-50" value = "${jeecgDemoPage.name}" />
						<span class="Validform_checktip" style="float:left;height:0px;"></span>
						<label class="Validform_label" style="display: none">名称</label>
			        </div>
				</div>
				
				<div class="row show-grid">
			        <div class="col-xs-3 text-center">
				        <b>年龄：</b>
				    </div>
				    <div class="col-xs-6">
						<input id="age" name="age" type="text" class="form-control"  ignore="ignore"  datatype="n"  value = "${jeecgDemoPage.age}"/>
						<span class="Validform_checktip" style="float:left;height:0px;"></span>
						<label class="Validform_label" style="display: none">年龄</label>
			        </div>
				</div>
				
				<div class="row show-grid">
			        <div class="col-xs-3 text-center">
				        <b>性别：</b>
				    </div>
				    <div class="col-xs-6">
						<select name="sex" class="form-control"  style="width:164px" datatype="*" >
							<option value="">  </option> 
							<option value="0" <c:if test="${jeecgDemoPage.sex==0}">selected</c:if>>男 </option>
							<option value="1" <c:if test="${jeecgDemoPage.sex==1}">selected</c:if>>女 </option> 
						</select>
						<span class="Validform_checktip" style="float:left;height:0px;"></span>
						<label class="Validform_label" style="display: none">性别</label>
			        </div>
				</div>
				
				<div class="row show-grid">
			        <div class="col-xs-3 text-center">
				        <b>工资：</b>
				    </div>
				    <div class="col-xs-6">
						<input id="salary" name="salary" type="text" class="form-control"  ignore="ignore"  value = "${jeecgDemoPage.salary}"/>
						<span class="Validform_checktip" style="float:left;height:0px;"></span>
						<label class="Validform_label" style="display: none">工资</label>
			        </div>
				</div>
				
				<div class="row show-grid">
			        <div class="col-xs-3 text-center">
				        <b>生日：</b>
				    </div>
				    <div class="col-xs-6">
						<input id="birthday" name="birthday" type="text" ignore="ignore" style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;"  class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" value='<fmt:formatDate value='${jeecgDemoPage.birthday}' type="date" pattern="yyyy-MM-dd"/>' />
						<span class="Validform_checktip" style="float:left;height:0px;"></span>
						<label class="Validform_label" style="display: none">生日</label>
			        </div>
				</div>
			</div>
		</div>
	
	
	
	</div>
</form>
	<script type="text/javascript">
	var subDlgIndex = null;
	$(function() {
	    $("#formobj").Validform({
	        tiptype: function(msg, o, cssctl) {
	            if (o.type == 3) {
	                layer.open({
	                    title: '提示信息',
	                    content: msg,
	                    icon: 5,
	                    shift: 6,
	                    btn: false,
	                    shade: false,
	                    time: 5000,
	                    cancel: function(index) {
	                        o.obj.focus();
	                        layer.close(index);
	                    },
	                    yes: function(index) {
	                        o.obj.focus();
	                        layer.close(index);
	                    }
	                })
	            }
	        },
	        btnSubmit: "#btn_sub",
	        btnReset: "#btn_reset",
	        ajaxPost: true,
	        beforeSubmit: function(curform) {
	            var tag = false;
	            subDlgIndex = $.dialog({
	                content: '正在加载中',
	                zIndex: 19910320,
	                lock: true,
	                width: 100,
	                height: 50,
	                opacity: 0.3,
	                title: '提示',
	                cache: false
	            });
	            var infoTable = subDlgIndex.DOM.t.parent().parent().parent();
	            infoTable.parent().append('<div id="infoTable-loading" style="text-align:center;"><img src="plug-in/layer/skin/default/loading-0.gif"/></div>');
	            infoTable.css('display', 'none');
	        },
	        usePlugin: {
	            passwordstrength: {
	                minLen: 6,
	                maxLen: 18,
	                trigger: function(obj, error) {
	                    if (error) {
	                        obj.parent().next().find(".Validform_checktip").show();
	                        obj.find(".passwordStrength").hide();
	                    } else {
	                        $(".passwordStrength").show();
	                        obj.parent().next().find(".Validform_checktip").hide();
	                    }
	                }
	            }
	        },
	        callback: function(data) {
	            if (subDlgIndex && subDlgIndex != null) {
	                $('#infoTable-loading').hide();
	                subDlgIndex.close();
	            }
	            var win = frameElement.api.opener;
	            frameElement.api.close();
				win.reloadTable();
				win.tip(data.msg);
	        }
	    });
	});
	</script>
</body>
</html>