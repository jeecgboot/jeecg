function getLodop(oOBJECT,oEMBED){
/**************************
  本函数根据浏览器类型决定采用哪个对象作为控件实例：
  IE系列、IE内核系列的浏览器采用oOBJECT，
  其它浏览器(Firefox系列、Chrome系列、Opera系列、Safari系列等)采用oEMBED,
  对于64位浏览器指向64位的安装程序install_lodop64.exe。
**************************/
        var strHtmInstall="<br><font color='#FF00FF'>打印控件未安装!点击这里<a href='plug-in/lodop/install_lodop32.exe'>执行安装</a>,安装后请刷新页面或重新进入。</font>";
        var strHtmUpdate="<br><font color='#FF00FF'>打印控件需要升级!点击这里<a href='plug-in/lodop/install_lodop32.exe'>执行升级</a>,升级后请重新进入。</font>";
        var strHtm64_Install="<br><font color='#FF00FF'>打印控件未安装!点击这里<a href='plug-in/lodop/install_lodop64.exe'>执行安装</a>,安装后请刷新页面或重新进入。</font>";
        var strHtm64_Update="<br><font color='#FF00FF'>打印控件需要升级!点击这里<a href='plug-in/lodop/install_lodop64.exe'>执行升级</a>,升级后请重新进入。</font>";
        var strHtmFireFox="<br><br><font color='#FF00FF'>注意：<br>1：如曾安装过Lodop旧版附件npActiveXPLugin,请在【工具】->【附加组件】->【扩展】中先卸它。";
        var LODOP=oEMBED;		
	try{		     
	     if (navigator.appVersion.indexOf("MSIE")>=0) LODOP=oOBJECT;
	     if ((LODOP==null)||(typeof(LODOP.VERSION)=="undefined")) {
		 if (navigator.userAgent.indexOf('Firefox')>=0)
  	         document.documentElement.innerHTML=strHtmFireFox+document.documentElement.innerHTML;
		 if (navigator.userAgent.indexOf('Win64')>=0){
		 	if (navigator.appVersion.indexOf("MSIE")>=0) document.write(strHtm64_Install); else
		 	document.documentElement.innerHTML=strHtm64_Install+document.documentElement.innerHTML;		 
		 } else {
		 	if (navigator.appVersion.indexOf("MSIE")>=0) document.write(strHtmInstall); else
		 	document.documentElement.innerHTML=strHtmInstall+document.documentElement.innerHTML;
		 }
		 return LODOP; 
	     } else if (LODOP.VERSION<"6.1.1.5") {
		if (navigator.userAgent.indexOf('Win64')>=0){
	            if (navigator.appVersion.indexOf("MSIE")>=0) document.write(strHtm64_Update); else
		    document.documentElement.innerHTML=strHtm64_Update+document.documentElement.innerHTML; 
		} else {
	            if (navigator.appVersion.indexOf("MSIE")>=0) document.write(strHtmUpdate); else
		    document.documentElement.innerHTML=strHtmUpdate+document.documentElement.innerHTML; 
		}
		 return LODOP;
	     }
	     //*****如下空白位置适合调用统一功能:*********	     


	     //*******************************************
	     return LODOP; 
	}catch(err){
		if (navigator.userAgent.indexOf('Win64')>=0)	
		document.documentElement.innerHTML="Error:"+strHtm64_Install+document.documentElement.innerHTML;else
		document.documentElement.innerHTML="Error:"+strHtmInstall+document.documentElement.innerHTML;
	     return LODOP; 
	}
}
