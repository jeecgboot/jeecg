var navigatorName = "Microsoft Internet Explorer"; 
	if( navigator.appName == navigatorName ){ 
		alert("IE浏览器采用传统首页风格，更佳体验建议使用Chrome浏览器!") 
		$.cookie('JEECGINDEXSTYLE', 'shortcut');
	}

function reloadRandCodeImage() {
	    var date = new Date();
	    var img = document.getElementById("randCodeImage");
	    img.src='randCodeImage?a=' + date.getTime();
	}

  function darkStyle(){
    $('body').attr('class', 'login-layout');
    $('#id-text2').attr('class', 'red');
    $('#id-company-text').attr('class', 'blue');
    e.preventDefault();
  }
  function lightStyle(){
    $('body').attr('class', 'login-layout light-login');
    $('#id-text2').attr('class', 'grey');
    $('#id-company-text').attr('class', 'blue');

    e.preventDefault();
  }
  function blurStyle(){
    $('body').attr('class', 'login-layout blur-login');
    $('#id-text2').attr('class', 'white');
    $('#id-company-text').attr('class', 'light-blue');
    e.preventDefault();
  }
	//设置cookie
  function setCookie()
  {
	// 记住登录用户名---
  	if ($('#on_off').attr("checked")) {
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
              if("admin" == $.cookie(this.name)) {
                  $("#randCode").focus();
              } else {
                  $("#password").val("");
                  $("#password").focus();
              }
          });
  		$("#on_off").attr("checked", true);
  		$("#on_off").val("1");
  	} 
  	else
  	{
  		$("#on_off").attr("checked", false);
  		$("#on_off").val("0");
        $("#randCode").focus();
  	}
  }
  
  function optErrMsg(){
		$("#showErrMsg").html('');
		$("#errMsgContiner").hide();
	}
  
//登录处理函数
  function newLogin(orgId) {
    setCookie();
    var actionurl="loginController.do?login";//提交路径
    var checkurl="loginController.do?checkuser";//验证路径
    var formData = new Object();
    var data=$(":input").each(function() {
      formData[this.name] =$("#"+this.name ).val();
    });
    formData['orgId'] = orgId ? orgId : "";
    //语言
    formData['langCode']=$("#langCode").val();
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
          if (d.attributes.orgNum > 1) {
          	  //用户拥有多个部门，需选择部门进行登录
        	  var title, okButton;
              if($("#langCode").val() == 'en') {
                title = "Please select Org";
                okButton = "Ok";
              } else {
                title = "请选择组织机构";
                okButton = "确定";
              }
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
                  //----------------------------------------------------
                  //变更采用ajax方式提高效率
                  formData['orgId'] = orgId ? orgId : "";
                  $.ajax({
              		async : false,
              		cache : false,
              		type : 'POST',
              		url : 'loginController.do?changeDefaultOrg',// 请求的action路径
              		data : formData,
              		error : function() {// 请求失败处理函数
              		},
              		success : function(data) {
              			window.location.href = actionurl;
              		}
                  });
                  //----------------------------------------------------
                  this.close();
                  return false;
                }
              }],
              close: function(){
                setTimeout("window.location.href='"+actionurl+"'", 10);
              }
            });
          } else {
            window.location.href = actionurl;
          }
       } else {
			showErrorMsg(d.msg);
		  	if(d.msg === "用户名或密码错误" || d.msg === "验证码错误")
		  		reloadRandCodeImage();
        }
      }
    });
  }
  //登录提示消息显示
  function showErrorMsg(msg){	
    $("#errMsgContiner").show();
    $("#showErrMsg").html(msg);    
    window.setTimeout(optErrMsg,3000); 
  }
  
  //表单验证
  function validForm(){
    if($.trim($("#userName").val()).length==0){
      showErrorMsg("请输入用户名");
      return false;
    }

    if($.trim($("#password").val()).length==0){
      showErrorMsg("请输入密码");
      return false;
    }

    if($.trim($("#randCode").val()).length==0){
      showErrorMsg("请输入验证码");
      return false;
    }
    return true;
  }