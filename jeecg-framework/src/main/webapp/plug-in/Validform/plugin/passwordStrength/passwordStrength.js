(function($){
	$.fn.passwordStrength=function(settings){
		settings=$.extend({},$.fn.passwordStrength.defaults,settings);
		
		this.each(function(){
			var $this=$(this),
				scores = 0,
				checkingerror=false,
				pstrength=$(this).parents("form").find(".passwordStrength");
				
			$this.bind("keyup blur",function(){
				scores = $.fn.passwordStrength.ratepasswd($this.val(),settings);
				scores>=0 && checkingerror==false && (checkingerror=true);
				
				pstrength.find("span").removeClass("bgStrength");
				if(scores < 35 && scores >=0){
					pstrength.find("span:first").addClass("bgStrength");
				}else if(scores < 60 && scores >=35){
					pstrength.find("span:lt(2)").addClass("bgStrength");
				}else if(scores >= 60){
					pstrength.find("span:lt(3)").addClass("bgStrength");
				}
				
				if(checkingerror && ($this.val().length<settings.minLen || $this.val().length>settings.maxLen) ){
					settings.showmsg($this,$this.attr("errormsg"),3);
				}else if(checkingerror){
					settings.showmsg($this,"",2);
				}
				
				settings.trigger($this,!(scores>=0));
			});
		});	
	}
	
	$.fn.passwordStrength.ratepasswd=function(passwd,config){
		//判断密码强度
		var len = passwd.length, scores;
		if(len >= config.minLen && len <= config.maxLen){
			scores = $.fn.passwordStrength.checkStrong(passwd);
		}else{
			scores = -1;
		}
	
		return scores/4*100;
			
	}
	
	//密码强度;
	$.fn.passwordStrength.checkStrong=function(content){
		var modes = 0, len = content.length;
		for(var i = 0;i < len; i++){
			modes |= $.fn.passwordStrength.charMode(content.charCodeAt(i));
		}
		return $.fn.passwordStrength.bitTotal(modes);	
	}
	
	//字符类型;
	$.fn.passwordStrength.charMode=function(content){
		if(content >= 48 && content <= 57){ // 0-9
			return 1;
		}else if(content >= 65 && content <= 90){ // A-Z
			return 2;
		}else if(content >= 97 && content <= 122){ // a-z
			return 4;
		}else{ // 其它
			return 8;
		}
	}
	
	//计算出当前密码当中一共有多少种模式;
	$.fn.passwordStrength.bitTotal=function(num){
		var modes = 0;
		for(var i = 0;i < 4;i++){
			if(num & 1){modes++;}
			num >>>= 1;
		}
		return modes;
	}
	
	$.fn.passwordStrength.defaults={
		minLen:0,
		maxLen:30,
		trigger:$.noop
	}
})(jQuery);