<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" />
<title>表单管理</title>
<t:base type="validform,bootstrap,layer,bootstrap-form,jquery"></t:base>
</head>
<body style="margin: 20px">
	<form id="formobj" action="jeecgListDemoController.do?doUpdate" class="form-horizontal validform" role="form"  method="post">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
	    <input id="id" name="id" type="hidden" value="${jeecgDemoPage.id }">
		<div class="form-group">
			<label for="name" class="col-sm-3 control-label">名称：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input type="text" class="form-control input-sm required" id="name"  name="name" value="${jeecgDemoPage.name }" data-msg-required="" datatype="*" placeholder="请输入名字" aria-required="true" />
				</div>
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-3 control-label">工资：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input id="salary" name="salary" type="text" class="form-control input-sm required" value="${jeecgDemoPage.salary }" placeholder="请输入工资"  data-msg-required="" datatype="/^(-?\d+)(\.\d+)?$/" aria-required="true" />
				</div>
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-3 control-label">生日：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
                    <input type="text" name="birthday" id="birthday" class="form-control input-sm" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" type="date" value="${jeecgDemoPage.birthday }"/>"   datatype="*" placeholder="请输入生日" />
                    <span class="input-group-addon" >
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-3 control-label">性别：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input type="radio" class="i-checks" name="sex" value="0" <c:if test="${jeecgDemoPage.sex=='0'}"> checked="checked"</c:if> />男&nbsp;&nbsp;
					<input type="radio" class="i-checks" name="sex" value="1" <c:if test="${jeecgDemoPage.sex=='1'}"> checked="checked"</c:if> />女
				</div>
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-3 control-label">部门：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<span class="input-group-btn">
                        <button class="btn btn-default input-sm" type="button">Go!</button>
                    </span> 
                    <select name="depId" class="form-control input-sm" datatype="*">
						<option value=""></option>
						<option value="402880e447e99cf10147e9a03b320003" <c:if test="${jeecgDemoPage.depId=='402880e447e99cf10147e9a03b320003'}"> selected </c:if>>北京国炬软件</option>
						<option value="402880e447e9a9570147e9b677320003" <c:if test="${jeecgDemoPage.depId=='402880e447e9a9570147e9b677320003'}"> selected </c:if>>软件信息部</option>
						<option value="402880e447e9a9570147e9b6a3be0005" <c:if test="${jeecgDemoPage.depId=='402880e447e9a9570147e9b6a3be0005'}"> selected </c:if>>销售部门</option>
						<option value="402880e447e9a9570147e9b710d20007" <c:if test="${jeecgDemoPage.depId=='402880e447e9a9570147e9b710d20007'}"> selected </c:if>>人力资源部</option>
						<option value="402880e447e9a9570147e9b762e30009" <c:if test="${jeecgDemoPage.depId=='402880e447e9a9570147e9b762e30009'}"> selected </c:if>>销售经理</option>
						<option value="402880e447e9ba550147e9c53b2e0013" <c:if test="${jeecgDemoPage.depId=='402880e447e9ba550147e9c53b2e0013'}"> selected </c:if>>财务</option>
						<option value="402880e6487e661a01487e6b504e0001" <c:if test="${jeecgDemoPage.depId=='402880e6487e661a01487e6b504e0001'}"> selected </c:if>>销售人员</option>
						<option value="402880f15986303c0159864816180002" <c:if test="${jeecgDemoPage.depId=='402880f15986303c0159864816180002'}"> selected </c:if>>部门经理</option>
						<option value="8a8ab0b246dc81120146dc8180a20016" <c:if test="${jeecgDemoPage.depId=='8a8ab0b246dc81120146dc8180a20016'}"> selected </c:if>>中国人寿总公司</option>
						<option value="8a8ab0b246dc81120146dc8180ba0017" <c:if test="${jeecgDemoPage.depId=='8a8ab0b246dc81120146dc8180ba0017'}"> selected </c:if>>JEECG开源社区</option>
						<option value="8a8ab0b246dc81120146dc8180bd0018" <c:if test="${jeecgDemoPage.depId=='8a8ab0b246dc81120146dc8180bd0018'}"> selected </c:if>>软件开发部</option>
					</select>
				</div>
			</div>
		</div>
							
		<div class="form-group">
			<label class="col-sm-3 control-label">头像：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input type="checkbox" class="i-checks" name="touxiang" value="1" <c:if test="${fn:contains(jeecgDemoPage.touxiang,'1')}">checked="checked"</c:if> /> 头像1
					<input type="checkbox" class="i-checks" name="touxiang" value="2" <c:if test="${fn:contains(jeecgDemoPage.touxiang,'2')}">checked="checked"</c:if> /> 头像2
					<input type="checkbox" class="i-checks" name="touxiang" value="3" <c:if test="${fn:contains(jeecgDemoPage.touxiang,'3')}">checked="checked"</c:if> /> 头像3
				</div>
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-3 control-label">个人介绍：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<textarea id="content" name="content" class="form-control input-sm" placeholder="请输入个人介绍"  rows="4">${jeecgDemoPage.content}</textarea>
				</div>
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-3 control-label">年龄：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input name="age" id="age" type="text" class="form-control input-sm" value="${jeecgDemoPage.age}" placeholder="请输入年龄" />
				</div>
			</div>
		</div>
	</form>	

</body>
</html>

<script type="text/javascript">
	$(document).ready(function() {
		//日期控件初始化
	    laydate.render({
		   elem: '#birthday'
		  ,type: 'datetime'
		  ,trigger: 'click' //采用click弹出
		  ,ready: function(date){
		  	 $("#birthday").val(DateJsonFormat(date,this.format));
		  }
		});
		//单选框/多选框初始化
		$('.i-checks').iCheck({
			labelHover : false,
			cursor : true,
			checkboxClass : 'icheckbox_square-green',
			radioClass : 'iradio_square-green',
			increaseArea : '20%'
		});
		
		//表单提交
		$("#formobj").Validform({
			tiptype:function(msg,o,cssctl){
				if(o.type==3){
					validationMessage(o.obj,msg);
				}else{
					removeMessage(o.obj);
				}
			},
			btnSubmit : "#btn_sub",
			btnReset : "#btn_reset",
			ajaxPost : true,
			beforeSubmit : function(curform) {
			},
			usePlugin : {
				passwordstrength : {
					minLen : 6,
					maxLen : 18,
					trigger : function(obj, error) {
						if (error) {
							obj.parent().next().find(
									".Validform_checktip")
									.show();
							obj.find(".passwordStrength")
									.hide();
						} else {
							$(".passwordStrength").show();
							obj.parent().next().find(
									".Validform_checktip")
									.hide();
						}
					}
				}
			},
			callback : function(data) {
				var win = window.parent;
				if (data.success == true) {
					var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
					parent.layer.close(index); 
					win.tip(data.msg,'1');
				} else {
					win.tip(data.msg,'2');
				}
				//layui 全局弹窗刷新列表
				try {
					win.reloadTable();
				}catch(e) {}
			}
		});
	});
</script>