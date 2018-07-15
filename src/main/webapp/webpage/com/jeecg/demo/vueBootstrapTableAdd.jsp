<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>vueBootstrapTableList</title>
    <meta charset="UTF-8"></meta>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"></meta>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport"></meta>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="https://cdn.bootcss.com/bootstrap-table/1.12.1/bootstrap-table.min.css" rel="stylesheet"/>
    <link href="plug-in/vue-BootstrapTable/css/common.min.css" rel="stylesheet" />
    <link href="plug-in/vue-BootstrapTable/css/style.min.css" rel="stylesheet" />
</head>
<body>
	<div id="dpLTE" class="container-fluid" v-cloak>
		<table class="form" id="form">
			<tr>
	            <td class="formTitle">姓名<font face="宋体">*</font></td>
	            <td class="formValue">
					<input type="text" class="form-control" placeholder="姓名" v-model="user.name" datatype="*">
	            </td>
	            <td class="formTitle">年龄<font face="宋体">*</font></td>
	            <td class="formValue">
					<input type="text" class="form-control" placeholder="年龄" v-model="user.age" datatype="num">
	            </td>
        	</tr>
        	<tr>
				<td class="formTitle">性别</td>
				<td class="formValue" colspan="3">
					<label class="radio-inline">
						<input type="radio" name="sex" value="1" v-model="user.sex"/> 男
					</label>
					<label class="radio-inline">
						<input type="radio" name="sex" value="0" v-model="user.sex"/> 女
					</label>
				</td>
			</tr>
        	<tr>
	            <td class="formTitle">生日</td>
	            <td class="formValue">
					<input type="text" id="birthday" class="form-control" placeholder="请选择生日">
	            </td>
        		<td class="formTitle">手机号</td>
	            <td class="formValue">
	            <!--update-begin-Author:zhangweijian Date: 20180710 for：TASK #2941 【bug】常用示例，小问题，手机号校验-->
					<input type="text" class="form-control" placeholder="请输入手机号" v-model="user.phone" datatype="m">
	            <!--update-end-Author:zhangweijian Date: 20180710 for：TASK #2941 【bug】常用示例，小问题，手机号校验-->
	            </td>
        	</tr>
		</table>
	</div>
</body>
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdn.bootcss.com/layer/3.1.0/layer.js"></script>
<script src="https://cdn.bootcss.com/vue/2.5.17-beta.0/vue.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap-table/1.12.1/bootstrap-table.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap-table/1.12.1/locale/bootstrap-table-zh-CN.min.js"></script>
<script src="plug-in/Validform/js/Validform_v5.3.1_min_zh-cn.js"></script>
<script src="plug-in/Validform/js/Validform_Datatype_zh-cn.js"></script>
<script src="plug-in/Validform/js/datatype_zh-cn.js"></script>
<script src="plug-in/lhgDialog/lhgdialog.min.js?skin=metrole"></script>
<script src="plug-in/laydate/laydate.js"></script>
<script src="plug-in/vue-BootstrapTable/js/common.js"></script>
<script src="plug-in/vue-BootstrapTable/js/form.js"></script>
<script>
var valid=null;
$(function(){
	valid=$("#form").Validform({
		tiptype:function(msg,o,cssctl){
			if(o.type==3){
				ValidationMessage(o.obj,msg);
			}else{
				removeMessage(o.obj);
			}
		}
    });
	//生日
	laydate.render({
	  elem: '#birthday',
	  done: function(value, date, endDate){
		vm.user.birthday=value;
	  }
	});
});
var vm = new Vue({
	el:'#dpLTE',
	data: {
		user:{
			name: '',
			sex: 1,
			age: null,
			birthday: '',
			phone: ''
		}
	},
	methods : {
		acceptClick: function() {
            if (!valid.check(false)) {
                return false;
            }
		    $.SaveForm({
		    	url: 'jeecgListDemoController.do?doAdd',
		    	param: this.user,
		    	success: function(){
		    		frameElement.api.opener.vm.load();
		    	}
		    });
		}
	}
});
</script>
</html>