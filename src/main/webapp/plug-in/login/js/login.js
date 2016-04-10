$(document).ready(function() {
	
	$("#userName").attr("nullmsg",pleaseinutusername);
	$("#userName").attr("title",username);
	
	$("#password").attr("nullmsg",pleaseinutpassword);
	$("#password").attr("title",password);
	
	$("#randCode").attr("nullmsg",pleaseinputvalidatecode);
	$("#randCode").attr("title",validatecode);
	
	getCookie();
	onfocus();
	
	$(".on_off_checkbox").iphoneStyle();
	$('.tip a ').tipsy({
		gravity : 'sw'
	});
	$('#login').show().animate({
		opacity : 1
	}, 2000);
	$('.logo').show().animate({
		opacity : 1,
		top : '32%'
	}, 800, function() {
		$('.logo').show().delay(1200).animate({
			opacity : 1,
			top : '1%'
		}, 300, function() {
			$('.formLogin').animate({
				opacity : 1,
				left : '0'
			}, 300);
			$('.userbox').animate({
				opacity : 0
			}, 200).hide();
		});
	});
});
$('.userload').click(function(e) {
	$('.formLogin').animate({
		opacity : 1,
		left : '0'
	}, 300);
	$('.userbox').animate({
		opacity : 0
	}, 200, function() {
		$('.userbox').hide();
	});
});
//update-begin--Author:zhangguoming  Date:20140226 for：添加验证码
$('#randCodeImage').click(function(){
    reloadRandCodeImage();
});
/**
 * 刷新验证码
 */
function reloadRandCodeImage() {
    var date = new Date();
    var img = document.getElementById("randCodeImage");
    img.src='randCodeImage?a=' + date.getTime();
}
//update-end--Author:zhangguoming  Date:20140226 for：添加验证码
// 重置
$('#forgetpass').click(function(e) {
	$(":input").each(function() {
	$('#'+this.name).val("");
	});
});
// 点击登录
$('#but_login').click(function(e) {
	submit();
});
//回车登录
$(document).keydown(function(e){
	if(e.keyCode == 13) {
		submit();
	}
});
//表单提交
function submit()
{
	var submit = true;
	$("input[nullmsg]").each(function() {
		if ($("#" + this.name).val() == "") {
			showError($("#" + this.name).attr("nullmsg"), 500);
			jrumble();
			setTimeout('hideTop()', 1000);
			submit = false;
			return false;
		}
	});
	if (submit) {
		hideTop();
		loading(checking, 1);
		setTimeout("unloading()", 1000);
		setTimeout("Login()", 1000);
	}

}
function zhanggm(orgId) {

    alert("zhanggm test in login.js: orgId= " +orgId);
}
//登录处理函数
function Login(orgId) {
	setCookie();
	var actionurl=$('form').attr('action');//提交路径
	var checkurl=$('form').attr('check');//验证路径
	 var formData = new Object();
	var data=$(":input").each(function() {
		 formData[this.name] =$("#"+this.name ).val();
	});
    formData['orgId'] = orgId ? orgId : "";
	// update-begin--Author:ken  Date:20140629 for：添加语言选择
	formData['langCode']=$("#langCode").val();
	// update-end--Author:ken  Date:20140629 for：添加语言选择
	formData['langCode'] = $("#langCode option:selected").val();
	$.ajax({
		async : false,
		cache : false,
		type : 'POST',
		url : checkurl,// 请求的action路径
		data : formData,
		error : function() {// 请求失败处理函数
		},
		success : function(data) {
			var d = $.parseJSON(data);
			if (d.success) {
				loginsuccess();
//                update-start--Author:zhangguoming  Date:20140825 for：用户有多个组织机构，则弹出选择组织架构页面
                // todo zhanggm 没有处理多语言，暂时这样判断下吧
                var title, okButton;
                if($("#langCode").val() == 'en') {
                    title = "Please select Org";
                    okButton = "Ok";
                } else {
                    title = "请选择组织机构";
                    okButton = "确定";
                }
                if (d.attributes.orgNum > 1) {
                    $.dialog({
                        id: 'LHG1976D',
                        title: title,
                        max: false,
                        min: false,
                        drag: false,
                        resize: false,
                        content: 'url:userController.do?userOrgSelect&userId=' + d.attributes.user.id,
                        lock:true,
                        button : [ {
                            name : okButton,
                            focus : true,
                            callback : function() {
                                iframe = this.iframe.contentWindow;
                                var orgId = $('#orgId', iframe.document).val();
                                Login(orgId);
                                this.close();
                                return false;
                            }
                        }],
                        close: function(){
                            window.location.href = actionurl;
                        }
                    });
                } else {
                    setTimeout("window.location.href='"+actionurl+"'", 1000);
                }
//                update-end--Author:zhangguoming  Date:20140825 for：用户有多个组织机构，则弹出选择组织架构页面
			} else {
				if(d.msg == "a"){
					$.dialog.confirm("数据库无数据,是否初始化数据?", function(){
						window.location = "init.jsp";
					}, function(){
						//
					});
				} else
					showError(d.msg);
			}
		}
	});
}
//设置cookie
function setCookie()
{
	if ($('#on_off').val() == '1') {
		$("input[iscookie='true']").each(function() {
			$.cookie(this.name, $("#"+this.name).val(), "/",24);
			$.cookie("COOKIE_NAME","true", "/",24);
		});
	} else {
		$("input[iscookie='true']").each(function() {
			$.cookie(this.name,null);
			$.cookie("COOKIE_NAME",null);
		});
	}
}
//读取cookie
function getCookie()
{
	var COOKIE_NAME=$.cookie("COOKIE_NAME");
	if (COOKIE_NAME !=null) {
		$("input[iscookie='true']").each(function() {
			$($("#"+this.name).val( $.cookie(this.name)));
//            update-begin--Author:zhangguoming  Date:20140429 for：是否记住用户名优化
            if("admin" == $.cookie(this.name)) {
                $("#randCode").focus();
            } else {
                $("#password").val("");
                $("#password").focus();
            }
//            update-end--Author:zhangguoming  Date:20140429 for：是否记住用户名优化
        });
		$("#on_off").attr("checked", true);
		$("#on_off").val("1");
	} 
	else
	{
		$("#on_off").attr("checked", false);
		$("#on_off").val("0");
//      update-begin--Author:zhangguoming  Date:20140429 for：是否记住用户名优化
        $("#randCode").focus();
//      update-end--Author:zhangguoming  Date:20140429 for：是否记住用户名优化
	}
}
//点击消息关闭提示
$('#alertMessage').click(function() {
	hideTop();
});
//显示错误提示
function showError(str) {
	$('#alertMessage').addClass('error').html(str).stop(true, true).show().animate({
		opacity : 1,
		right : '0'
	}, 500);

}
//验证通过加载动画
function loginsuccess()
{
	$("#login").animate({
		opacity : 1,
		top : '49%'
	}, 200, function() {
		$('.userbox').show().animate({
			opacity : 1
		}, 500);
		$("#login").animate({
			opacity : 0,
			top : '60%'
		}, 500, function() {
			$(this).fadeOut(200, function() {
				$(".text_success").slideDown();
				$("#successLogin").animate({
					opacity : 1,
					height : "200px"
				}, 1000);
			});
		});
	});
}
function showSuccess(str) {
	$('#alertMessage').removeClass('error').html(str).stop(true, true).show().animate({
		opacity : 1,
		right : '0'
	}, 500);
}

function onfocus() {
	if ($(window).width() > 480) {
		$('.tip input').tipsy({
			trigger : 'focus',
			gravity : 'w',
			live : true
		});
	} else {
		$('.tip input').tipsy("hide");
	}
}

function hideTop() {
	$('#alertMessage').animate({
		opacity : 0,
		right : '-20'
	}, 500, function() {
		$(this).hide();
	});
}
//加载信息
function loading(name, overlay) {
	$('body').append('<div id="overlay"></div><div id="preloader">' + name + '..</div>');
	if (overlay == 1) {
		$('#overlay').css('opacity', 0.1).fadeIn(function() {
			$('#preloader').fadeIn();
		});
		return false;
	}
	$('#preloader').fadeIn();
}

function unloading() {
	$('#preloader').fadeOut('fast', function() {
		$('#overlay').fadeOut();
	});
}
// 表单晃动
function jrumble() {
	$('.inner').jrumble({
		x : 4,
		y : 0,
		rotation : 0
	});
	$('.inner').trigger('startRumble');
	setTimeout('$(".inner").trigger("stopRumble")', 500);
}