<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="plug-in/bootstrap/css/bootstrap.min.css">
<script type="text/javascript" src="plug-in/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="plug-in/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plug-in/layer/layer.js"></script>
<title>密码重置--发送邮件</title>
<style type="text/css">
	body {
		position: relative;
	    min-height: 600px;
		background-color: #2F4056;	    
	}
	.box {
		position: relative;
	    width: 500px;
	    margin: auto;
	    padding: 35px 30px;
	    color: #666;
	    border-radius: 4px;
	    background: #fff;
	    -webkit-box-shadow: 1px 1px 4px #767676;
	    box-shadow: 1px 1px 4px #767676;
	}
	.logo {
		display: inline-block;
	    width: 200px;
	    height: 65px;
	    margin: 5vh 0 4vh 130px;
	    background: url(plug-in/login/images/jeecg-aceplus.png) no-repeat;
	}
	.reset-box {
		display: flex;
	}
	
	.reset-box:after,.reset-box:before,.box:after,.box:before {
		box-sizing: border-box;
	}
	.form-wrapper {
		 width: 300px;
   		 margin: auto;
	}
	.form-item {
   		 margin-bottom: 20px;
    }
	input {
		width:85%;
	}
	input:not([type=button]) {
	    font-size:.875rem;
	    line-height:1.6;
	    padding:12px 20px;
	    -webkit-transition:all .2s;
	    transition:all .2s;
	    color:#666;
	    border:1px solid #dce4e6;
	    border-radius:3px;
	    outline:0;
	    background:#f3f6f8
	}
	
	.btn {
		padding:10px 14px;
	}
	
	.login-link {
		margin-left: 40%;
	}
</style>
</head>
<body>
<div class="header">
	<span class="logo"></span>
</div>
<div class="box">
	<div class="reset-box">
		<div class="form-wrapper">
			<div class="form-item">
				<input type="text" id="email" name="email" placeholder="请输入邮箱地址"/>
			</div>
			<div class="form-item">
				<button id="btn-submit" class="btn btn-success btn-block btn-lg " >找回密码</button>
				<a class="btn btn-link login-link" href="loginController.do?login">登录</a>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(function(){
	$("#btn-submit").click(function(){
		var email = $("#email").val();
		if(email == null || email == ''){
			layer.msg("请输入邮箱地址",{icon:5});
			$("#email").focus();
			return;
		}
		var loadingIndex = layer.load();
		$("#btn-submit").attr("disabled","disabled");
		$("#email").attr("readonly","readonly");
		$.ajax({
			url:'loginController.do?sendResetPwdMail',
			type:'POST',
			dataType:'JSON',
			data:{
				email:$("#email").val()
			},
			success:function(res){
				layer.close(loadingIndex);
				if(res.success){
					layer.msg(res.msg,{icon:6});
				}else{
					layer.msg(res.msg,{icon:5});
					$("#btn-submit").removeAttr("disabled","disabled");
					$("#email").removeAttr("readonly","readonly");
				}
			}
		});
	});
})
</script>
</body>
</html>