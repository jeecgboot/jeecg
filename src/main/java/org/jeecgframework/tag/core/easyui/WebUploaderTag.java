package org.jeecgframework.tag.core.easyui;

import java.io.IOException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.oConvertUtils;

/**
 * 百度WebUploader上传标签
 * @author scott
 *
 */
public class WebUploaderTag extends TagSupport {
	private static final long serialVersionUID = 1L;
	private String name;//①文件路径 input默认name、②action返回的文件路径的name
	private boolean auto=false;//是否自动上传上传按钮风格
	private String buttonStyle;//默认绿色小号按钮
	private String url = "systemController/filedeal.do";//文件上传处理url
//	private String url = "systemController/ftpUploader.do";//ftp文件上传处理url
	private int fileNumLimit =3;//fileNumLimit 最大文件数
	private int fileSingleSizeLimit=5242880;//fileSingleSizeLimit单个文件最大5M[1024*1024*5]
	private int size;//文件总大小
	private String fileVal="file";//fileVal设置文件上传域的name,默认file
	private boolean duplicate=false;//去重， 根据文件名字、文件大小和最后修改时间来生成hash Key.
	private String showImgDiv;//显示图片的div,如果不给会默认在按钮下方添加div其id为'tempdiv_'+name
	private String showAndDownUrl=ResourceUtil.getConfigByName("showAndDownUrl");//预览图片请求的url&文件下载url
	private String pathValues;//默认值
	private String type="file";
	private String buttonText;//控件按钮显示文本
	private String extensions;//允许的文件后缀，不带点，多个用逗号分割
	private String extendParams;//类似css写法 这是文件上传时候需要传递的参数
	private String datatype;//只要该属性有值,均视之为不为空
	private String nullMsg;//空的时候的提示信息,默认会根据当前控件的类型提示,文件类则提示“请选择文件”;图片类则提示“请选择图片”.
	private String readOnly="false";//保留字段
	private String bizType;//业务类型,根据该类型确定上传路径
	private boolean displayTxt=true;//是否显示上传列表[默认显示]true显示false隐藏
	private boolean outJs = false;//是否在外部引入了js和css
	private boolean swfTransform = false;//是否转换成swf文件，文件预览使用
	//private static String imgexts="gif,jpg,jpeg,bmp,png";
	public int doStartTag() throws JspTagException {
		return EVAL_PAGE;
	}
	public int doEndTag() throws JspTagException {
		JspWriter out = null;
		StringBuffer sb = new StringBuffer();
		try {
			out = this.pageContext.getOut();
			end(sb);
			out.print(sb.toString());
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(out!=null){
				try {
					out.clearBuffer();
					sb.setLength(0);
					sb = null;
					this.showImgDiv=null;
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return EVAL_PAGE;
	}
	/**
	 * 获取带特殊符号的名称
	 * @return
	 */
	private String getSpecialCharName(){
		String temp = getName();
		if(temp.contains(".")){
			this.name = name.replace(".", "");
		}
		if(temp.contains("[")){
			this.name = name.replace("[", "");
		}
		if(temp.contains("]")){
			this.name = name.replace("]", "");
		}
		return temp;
	}
	public void end(StringBuffer sb) {
		String nameWithspchar = getSpecialCharName();
		String btnCss=getButtonStyle();//获取按钮样式
		//typeResetByext(this.extensions);//根据上传文件的后缀重置type
		if(!outJs){
			sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"plug-in/webuploader/custom.css\"></link>");
			sb.append("<script type=\"text/javascript\" src=\"plug-in/webuploader/webuploader.min.js\"></script>");
		}
		sb.append("<div id='"+name+"uploader' class='wu-example'>");
		String showthelist = name+"thelist";
		if("file".equals(type) && oConvertUtils.isNotEmpty(showImgDiv)){
			showthelist=showImgDiv;
		}else{
			sb.append("<div id='"+showthelist+"' class='uploader-list'></div>");
		}
		//进度条html添加
		sb.append("<div id='"+name+"_progress_bar' class='progress-bar-ty '");
		if("image".equals(type)){
			sb.append(" style='display:none'");
		}
		sb.append("><div class='progress-ty'>");
		sb.append("<span class='upload-label-ty' style='display:none;'>正在加载...<b class='value'>79%</b></span></div></div>");

		sb.append("<div class='btns'><div id='"+name+"picker'>"+getButtonText()+"</div></div></div>");
		if("image".equals(type)&&oConvertUtils.isEmpty(showImgDiv)){
			showImgDiv="tempdiv_"+name;
			sb.append("<div id='"+showImgDiv+"'></div>");
		}
			//不要在sb中拼写<%=basePath%>,传到前台直接乱码 
			sb.append("<script type=\"text/javascript\">Array.prototype.removeItem = function(val){var index = this.indexOf(val);if (index > -1) {this.splice(index, 1);}};"
					+ "var exsitPathArr_"+name+" =new Array();"
					+"$(function() { var state = 'pending';var $list=$('#"+ showthelist +"');"
					+"var uploader = WebUploader.create({"
					+"swf: 'plug-in/webuploader/Uploader.swf',"
					+"server :\'"+url+"\',"//getUrl()
					+" pick: '#"+ name +"picker',duplicate: "+duplicate+",resize: false,"
					+"auto:"+auto+","
					+"fileVal:'"+fileVal+"',"
					+"fileNumLimit:"+fileNumLimit+","
					+"fileSingleSizeLimit:"+fileSingleSizeLimit);
			if(oConvertUtils.isNotEmpty(extensions)){
				sb.append(",accept:{extensions:'"+extensions+"'}");
			}
			if(oConvertUtils.isEmpty(extendParams)){
				sb.append(",formData:{isup:'1',swfTransform:'"+swfTransform+"',bizType:'"+bizType+"'}});");
			}else{
				sb.append(",formData:{isup:'1',swfTransform:'"+swfTransform+"',bizType:'"+bizType+"',"+extendParams+"}});");
			}
			if(!auto){
				sb.append("\r\nvar upbtnrdo4=\"<div id='"+name+"ctlBtn' class='upbtn btn-blue "+btnCss+"'>开始上传</div>\";$('#"+name+"picker').find('div:eq(0)').after(upbtnrdo4);upbtnrdo4='';\r\n");
				if("true".equals(readOnly)||"readOnly".equals(readOnly)){
					sb.append("$('#"+name+"ctlBtn').css('display','none');");
				}
			}
			if("image".equals(type)){
				sb.append("var imageAdd_"+name+" = true;");
			}else{
				sb.append("var imageAdd_"+name+" = false;");
			}
			sb.append("$('#"+name+"picker').find('div:eq(0)').addClass('webuploader-pick "+btnCss+"');");
			//sb.append("$('#"+name+"picker').find('div:eq(0)').unbind(\"mouseenter\").unbind(\"mouseleave\");");
			sb.append("$('#"+showImgDiv+"').addClass('tempIMGdiv').append('<ul></ul>');\r\n");
			sb.append("$list.append('<table class=\"temptable\"></table>');\r\n");
			//增加进度条方法
			//进度条加载延迟duration设置太小则出现大文件，则会瞬间达到一个值，然后卡在那个点上,效果太假
			sb.append("var showUploadProgress = function(progress,mycallback,obj){if(!obj){obj = $('#"+name+"_progress_bar').find('.progress-ty');}if(!$('#"+name+"_progress_bar').hasClass('active')){$('#"+name+"_progress_bar').addClass('active');}obj.animate({width:progress+'%'},{duration:100,easing:'swing',complete:function(scope,i,elem){if(!!mycallback){mycallback();}}})};");
			
			//判断是否支持base64
			sb.append(" var isSupportBase64 = function() {var data = new Image();var support = true;data.onload = data.onerror = function() {if( this.width != 1 || this.height != 1 ){support = false;}}//data['src'] = 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==';\r\nreturn support;};");
			//缩略图大小暂时写死,也可以修改css
			sb.append("var ratio = window.devicePixelRatio || 1;var thumbnailWidth = 100 * ratio;var thumbnailHeight = 100 * ratio;");
			//添加列表图片显示上传文件
			sb.append("var "+name+"addImgli=function(src,name,xpath,flag){if(imageAdd_"+name+"){var titleclass='hidetitle';//if(flag==1){titleclass='hidetitle';}\r\nvar img = '<li><img name=\"' + name + 'img\" class=\"tempimg\" src=\"' + src + '\"><div class=\"' + titleclass + '\"><span';");
			if("true".equals(readOnly)||"readOnly".equals(readOnly)){
				sb.append("img+=' style=\"display:none;\"';");
			}
			sb.append("img+=' class=\"titledel\">'+xpath+'</span><span';");
			sb.append("img+=xpath==0?' style=\"display:none;\"' :' ';");
			sb.append("img+=' class=\"titledown\">'+xpath+'</span></div></li>';$('#"+showImgDiv+"').find('ul').append(img);}}\r\n");
			//添加table文字显示上传文件
			String tipTableStyle="";
			if(!displayTxt){
				tipTableStyle=" style=\"display:none\" ";
			}
			sb.append("var addtrFile=function(id,name,text,downsrc,delflag){var namet = name;if(name.length>15){name = name.substring(0,15)+'...';}var trhtml='<tr "+tipTableStyle+" class=\"item\" id=\"'+id+'\"><td title = '+namet+'>'+name+'</td><td class=\"state\">'+text+'</td><td class=\"icontd\"><span';"); 
			sb.append("trhtml+=downsrc==0?' style=\"display:none;\"' :' ';");
			sb.append("trhtml+=' class=\"down icon-down\">'+downsrc+'</span></td><td class=\"icontd\"><span';");
			if("true".equals(readOnly)||"readOnly".equals(readOnly)){
				sb.append("trhtml+=' style=\"display:none;\"';");
			}
			sb.append("trhtml+=' class=\"del icon-cha\" style=\"overflow:hidden;\">'+delflag+'</span></td>';");
			//如果是文件配置swf转换参数则支持文件预览
			if("file".equals(type) && swfTransform){
				sb.append("if(downsrc==0){trhtml+='<td class=\"viewtd\"><span class=\"view\" style=\"overflow:hidden;\"></span></td>';}");
				sb.append("else{ var aaaaa =\"systemController.do?openViewFile&path=\"+downsrc;var viewclick =\"openwindow(\'预览\',\'\"+aaaaa+\"\',\'tempty\',700,500)\";trhtml+='<td class=\\'icontd\\'><span class=\\'view icon-view\\' onclick=\"'+viewclick+'\"></span></td>';}\r\n");
			}
			sb.append("trhtml+='<td></td></tr>';$list.children('table').append(trhtml);}");
			//如果dataType有值
			if(oConvertUtils.isNotEmpty(datatype)){
				sb.append("\r\n$('#"+name+"uploader').find('div.btns').append('<input nullMsg=\""+getNullMsg()+"\" datatype=\"*\" type=\"hidden\" id= \""+name+"dataTypeInp\" />');");
			}
			sb.append("\r\nvar reset_"+name+"_dataTypeInpVal=function(addOrdel){var obj = $(\"#" + name + "dataTypeInp\");if(obj.length>0){var objval=obj.val()||'';\r\nif (addOrdel == 1) {if(objval==''){obj.val('1');}else{obj.val(objval.toString()+(parseInt(objval.length)+1));}}else{if(objval.length <=1){obj.val('');}else{obj.val(objval.substr(0,objval.length-1));\r\n}\r\n}obj.blur();}}");
			//设置默认值
			if(oConvertUtils.isNotEmpty(pathValues)){
				sb.append("\r\n$list.append( '<div class=\"fordel\"><input type=\"hidden\" name=\""+nameWithspchar+"\" value=\""+pathValues.replace("\\","\\\\")+"\" /></div>' );\r\n");
				if("image".equals(type)){
					sb.append("var pvs='"+pathValues.replace("\\","\\\\")+"';exsitPathArr_"+name+"=pvs.split(',');for(var a = 0; a< exsitPathArr_"+name+".length; a++){\r\nvar singlePath=exsitPathArr_"+name+"[a];\r\nif(''!=singlePath){reset_"+name+"_dataTypeInpVal(1);var singleSrc=\""+showAndDownUrl+"\"+singlePath;"+name+"addImgli(singleSrc,'name'+a,singlePath,1);}}");
				}else{
					sb.append("var pvs='"+pathValues.replace("\\","\\\\")+"';exsitPathArr_"+name+"=pvs.split(',');for(var a = 0; a< exsitPathArr_"+name+".length; a++){\r\nvar singlePath=exsitPathArr_"+name+"[a];\r\nif(''!=singlePath){reset_"+name+"_dataTypeInpVal(1);var rf6=randomFor(6);addtrFile('id'+a+rf6,mygetFileName(singlePath),'--历史上传文件--',singlePath,singlePath);}}");
				}
			}
			//删除请求
			sb.append("\r\nvar imgDelReq=function(delpath,spanobj){$.post('"+url+"',{path:delpath,swfTransform:'"+swfTransform+"',isdel:\"1\"},function(aj){var data=JSON.parse(aj);if(data.success){reset_"+name+"_dataTypeInpVal(0);exsitPathArr_"+name+".removeItem(delpath);$list.children('.fordel').children('input').val(exsitPathArr_"+name+".join(','));var myimgli=$(spanobj).closest('li');myimgli.off().find('.hidetitle').off().end().remove();}});}\r\n");
			sb.append("var "+name+"addFile=function(file,filepath){\r\nuploader.makeThumb(file, function(error,src) {\r\nif(error){return false;}\r\nif(isSupportBase64()){if(filepath==''){"+name+"addImgli(src,file.id,0,0);}\r\n}else if(filepath!=''){\r\nvar actSrc=\""+showAndDownUrl+"\"+filepath;\r\n"+name+"addImgli(actSrc,file.id,0,0);}}, thumbnailWidth, thumbnailHeight );}");
			sb.append("\r\nvar updatetdState=function(id,content){$list.children('table').find('#"+name+"'+id).find('.state').text('--'+content+'--');}\r\n");

			if(fileNumLimit==1){
				if(auto){
					sb.append("var "+name+"_oneLimit = 0;");
				}
				if("image".equals(type)){
					sb.append("uploader.on('beforeFileQueued',function(file){");
					if(auto){
						//限制一次性多选图片
						sb.append("if("+name+"_oneLimit>=1){return false;}else{"+name+"_oneLimit++;};");
					}
					//图片类型，先隐藏预览区之前的图片
					sb.append("var currLi=$('#"+showImgDiv+">ul').find('li:last');if(currLi.length>0){currLi.addClass('wait-remove');var abcfile=currLi.find('img').attr('name');if(abcfile.indexOf('name')==0){}else{abcfile=abcfile.substring(0,abcfile.length-3);uploader.removeFile(abcfile)}}});");
				}else{
					sb.append("uploader.on('beforeFileQueued',function(file){");
					if(auto){
						//限制一次性多选图片
						sb.append("if("+name+"_oneLimit>=1){return false;}else{"+name+"_oneLimit++;};");
					}
					//文件类型，先隐藏列表区之前的图片
					sb.append("var currLi=$('#"+showthelist+">table').find('tr.item:last');if(currLi.length>0){currLi.addClass('wait-remove');var abcfile=currLi[0].id;if(abcfile.indexOf('id')==0){}else{abcfile=abcfile.substring("+name.length()+");uploader.removeFile(abcfile)}}});");
				}
			}

			
			//当文件被加入队列以后触发。
			sb.append("uploader.on( 'fileQueued', function( file ) {"//'+file.name+'---等待上传---</span>
					+"var id='"+name+"'+file.id;var name=file.name;var text='--等待上传--';addtrFile(id,name,text,0,0);"+name+"addFile(file,'');\r\n"
					+"});");
			//上传过程中触发，携带上传进度。
			sb.append("	uploader.on( 'uploadProgress', function( file, percentage ) {var $li = $('#"+name+"'+file.id+' td:last'),$percent = $li.find('.progress .progress-bar');if ( !$percent.length ) {$percent = $('<div class=\"progress progress-striped active\"><div class=\"progress-bar\" role=\"progressbar\" style=\"width: 0%\"></div></div>').appendTo($li).find('.progress-bar');}updatetdState(file.id,'上传中');$percent.css( 'width', percentage * 100 + '%' );});");
			//上传开始事件 加载进度条
			sb.append("uploader.on('uploadStart',function(file){$('#"+name+"_progress_bar').find('.progress-ty').css('width','1%');var temprd=Math.floor(Math.random()*7+1);if(temprd<4){temprd=Number(temprd)+3}temprd=Number(temprd)*10;showUploadProgress(temprd,function(){showUploadProgress(Number(temprd)+15);})});");

			//当文件上传成功时触发，会给表单增加一个input赋值 filePath
			sb.append("uploader.on( 'uploadSuccess', function(file,response) {showUploadProgress(100,function(){if(response.success){$('#"+name+"_progress_bar').removeClass('active');updatetdState(file.id,'上传成功');reset_"+name+"_dataTypeInpVal(1);"
					+"var filepath=response['"+name+"']||response.obj;$('#"+name+"'+file.id+' td:first').append('<input type=\"hidden\" name=\""+nameWithspchar+"\" value=\"'+filepath+'\" />');"+name+"addFile(file, filepath);");
			//如果是文件配置swf转换参数则支持文件预览
			if("file".equals(type) && swfTransform){
				sb.append("$('#"+name+"'+file.id+' td.viewtd').removeClass('viewtd').addClass('icontd').find('span').addClass('icon-view').attr('onclick',\"openwindow('预览','systemController.do?openViewFile&path=\"+filepath+\"','tempty',700,500)\");");
			}
			if(fileNumLimit==1){
				if(auto){
					//上传完成 限制放开
					sb.append(name+"_oneLimit = 0;");
				}
				//上传完成，删除旧的文件
				if("image".equals(type)){
					sb.append("$('#"+showImgDiv+">ul').find('li.wait-remove').find('.titledel').click()");
				}else{
					sb.append("$('#"+showthelist+">table').find('tr.wait-remove').find('.del').click()");
				}
			}
			//TODO 上传出错颜色需改变。
			sb.append("}else{$('#"+name+"_progress_bar').removeClass('active');updatetdState(file.id,'上传出错'+response.msg);}});});\r\n");

			
			//上传失败
			sb.append("uploader.on( 'uploadError', function( file,reason ) {updatetdState(file.id,'上传出错-code:'+reason);});");
			//当validate不通过时，会以派送错误事件的形式通知调用者。
			sb.append("uploader.on( 'error', function(type) {if(type=='Q_TYPE_DENIED'){tip('文件类型不识别');}if(type=='Q_EXCEED_NUM_LIMIT'){tip('文件数量超标');}if(type=='F_DUPLICATE'){tip('相同文件请不要重复上传');}if(type=='F_EXCEED_SIZE'){tip('单个文件大小超标');}if(type=='Q_EXCEED_SIZE_LIMIT'){tip('文件大小超标');}});");
			sb.append("uploader.on( 'uploadComplete', function( file ) {$( '#"+name+"'+file.id ).find('.progress').fadeOut('slow');});");
			if(!auto){
				sb.append("var $btn=$('#"+name+"ctlBtn');");
				sb.append("uploader.on('all', function (type) {if (type === 'startUpload') {state = 'uploading';} else if (type === 'stopUpload'){state = 'paused';} else if (type === 'uploadFinished'){state = 'done';}if (state === 'uploading') {$btn.text('暂停上传');} else {$btn.text('开始上传');}});");
				sb.append("\r\n$btn.on('click', function () {if (state === 'uploading') {uploader.stop();} else {uploader.upload();}});");
			}
			if("true".equals(readOnly)||"readOnly".equals(readOnly)){
				sb.append("\r\n$('#"+name+"picker').find('div:eq(0)').css('display','none');");
			}
			sb.append("$('#"+showImgDiv+"').on('mouseenter','li',function(){$(this).find('.hidetitle').slideDown(500);});$('#"+showImgDiv+"').on('mouseleave','li',function(){$(this).find('.hidetitle').slideUp(500);});");
			//图片的删除事件
			sb.append("$('#"+showImgDiv+"').on('click', 'span',function() {var spanopt=$(this).attr('class');var optpath=$(this).text();\r\n");
			//
			sb.append("if(spanopt.indexOf('titledel')>=0){if(0==optpath){var optimgname=$(this).parent('.hidetitle').prev('img').attr('name');var img_file_div='"+name+"'+optimgname.substring(0,optimgname.indexOf('img'));$('#'+img_file_div).find('.del').trigger('click');}else{imgDelReq(optpath,this);}}\r\n");
			sb.append("if(spanopt.indexOf('titledown')>=0){var downsrc=\""+showAndDownUrl+"\"+optpath+'?down=true';location.href=downsrc;//$(this).find('a').click(function(event){event.stopPropagation()});\r\n}});");
			//下载
			sb.append("$list.on(\"click\", \".down\",function(){var optpath=$(this).text();if(0!=optpath){var downsrc=\""+showAndDownUrl+"\"+optpath+'?down=true';location.href=downsrc;}});");
			//删除
			sb.append("$list.on(\"click\", \".del\", function () {var delspantext=$(this).text();var itemObj=$(this).closest(\".item\");var id=itemObj.attr(\"id\").substring("+name.length()+");var delpath=itemObj.find(\"input[name='"+nameWithspchar+"']\").val();if(undefined==delpath||null==delpath){delpath=delspantext;if(delspantext==0){itemObj.remove();uploader.removeFile(id);var myimgli=$('#"+showImgDiv+"').find(\"img[name='\"+id+\"img']\").closest('li');myimgli.off().find('.hidetitle').off().end().remove();\r\nreturn false;}}");
			//sb.append("$list.on(\"click\", \".del\", function () {var delspantext=$(this).text();var itemObj=$(this).closest(\".item\");var id=itemObj.attr(\"id\").substring("+name.length()+");var delpath=itemObj.find(\"input[name='"+name+"']\").val();if((undefined==delpath||null==delpath) && delspantext==1){itemObj.remove();var fordelInput=$list.children('.fordel').children('input');if($(this).text()==0){uploader.removeFile(id);var myimgli=$('#"+showImgDiv+"').find(\"img[name='\"+id+\"img']\").closest('li');myimgli.off().find('.hidetitle').off().end().remove();}\r\nif(fordelInput.length>0){fordelInput.val(exsitPathArr_"+name+".join(','));}return false;}");
			sb.append("$.post('"+url+"',{path:delpath,swfTransform:'"+swfTransform+"',isdel:\"1\"},function(aj){var data=JSON.parse(aj);if(data.success){reset_"+name+"_dataTypeInpVal(0);var fordelInput = $list.children('.fordel').children('input');itemObj.remove();if(delspantext==0){uploader.removeFile(id);var myimgli=$('#"+showImgDiv+"').find(\"img[name='\"+id+\"img']\").closest('li');\r\nmyimgli.off().find('.hidetitle').off().end().remove();}else if(fordelInput.length > 0) {exsitPathArr_"+name+".removeItem(delpath);fordelInput.val(exsitPathArr_"+name+".join(','));\r\n}\r\n}\r\n});\r\n});");
			sb.append("if(location.href.indexOf('load=detail')!=-1){$('#"+name+"uploader').find('.btns').addClass('virtual-hidden').css('visibility','hidden');$list.find('span.del').css('display','none');");
			if("image".equals(type)){
				sb.append("$('#"+showImgDiv+"').find('.titledel').css('display','none');");
			}else{
				sb.append("$('#"+name+"uploader').find('.del').closest('td').css('display','none');");
			}
			sb.append("}\r\n});");
			//获取文件名
			sb.append("\r\nfunction mygetFileName(filepath){var fileNameEndindex = filepath.lastIndexOf('_');var filenameSuffix = filepath.lastIndexOf('.');if(fileNameEndindex<0){fileNameEndindex = filepath.length;}if(filepath.lastIndexOf('\\\\')>0){return filepath.substring(filepath.lastIndexOf('\\\\')+1,fileNameEndindex)+filepath.substring(filenameSuffix);\r\n}else if(filepath.lastIndexOf('/')>0){return filepath.substring(filepath.lastIndexOf('/')+1,fileNameEndindex)+filepath.substring(filenameSuffix);}else{return filepath;}}");
			//随机数
			sb.append("function randomFor(n){var rnd='';for(var i=0;i<n;i++){rnd+=Math.floor(Math.random()*10);\r\n}\r\nreturn rnd;}\r\n");
		sb.append("</script>");
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public boolean isAuto() {
		return auto;
	}
	public void setAuto(boolean auto) {
		this.auto = auto;
	}
	public String getButtonStyle() {
		if(oConvertUtils.isEmpty(buttonStyle)){
			buttonStyle="btn-green btn-S";
		}
		return  buttonStyle;
	}
	public void setButtonStyle(String buttonStyle) {
		this.buttonStyle = buttonStyle;
	}
	public String getUrl() {
		return url+"&sessionId="+pageContext.getSession().getId();
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	public String getShowImgDiv() {
		return showImgDiv;
	}
	public void setShowImgDiv(String showImgDiv) {
		this.showImgDiv = showImgDiv;
	}
	public int getFileNumLimit() {
		return fileNumLimit;
	}
	public int getFileSingleSizeLimit() {
		return fileSingleSizeLimit;
	}
	public void setFileSingleSizeLimit(int fileSingleSizeLimit) {
		if(fileSingleSizeLimit>0){
			this.fileSingleSizeLimit = fileSingleSizeLimit*1024;
		}
	}
	public void setFileNumLimit(int fileNumLimit) {
		this.fileNumLimit = fileNumLimit;
	}
	
	public int getSize() {
		return size;
	}
	public void setSize(int size) {
		this.size = size;
	}
	public String getFileVal() {
		return fileVal;
	}
	public void setFileVal(String fileVal) {
		this.fileVal = fileVal;
	}
	public boolean isDuplicate() {
		return duplicate;
	}
	public void setDuplicate(boolean duplicate) {
		this.duplicate = duplicate;
	}
	public String getExtendParams() {
		return extendParams;
	}
	public void setExtendParams(String extendParams) {

		if(StringUtil.isNotEmpty(extendParams) && !extendParams.endsWith(",")){
			extendParams = extendParams + ",";
		}

		this.extendParams = extendParams;
	}
	public String getPathValues() {
		return pathValues;
	}
	public void setPathValues(String pathValues) {
		this.pathValues = pathValues;
	}

	public String getShowAndDownUrl() {
		return showAndDownUrl;
	}
	public void setShowAndDownUrl(String showAndDownUrl) {
		this.showAndDownUrl = showAndDownUrl;
	}
	public String getReadOnly() {
		return readOnly;
	}
	public void setReadOnly(String readOnly) {
		this.readOnly = readOnly;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getButtonText() {
		if(oConvertUtils.isEmpty(buttonText)){
			buttonText="选择文件";
		}
		return buttonText;
	}
	public void setButtonText(String buttonText) {
		this.buttonText = buttonText;
	}
	public String getExtensions() {
		return extensions;
	}
	public void setExtensions(String extensions) {
		this.extensions = extensions;
	}
	public String getDatatype() {
		return datatype;
	}
	public void setDatatype(String datatype) {
		this.datatype = datatype;
	}
	public String getNullMsg() {
		if(oConvertUtils.isEmpty(nullMsg)){
			this.nullMsg="请选择"+("file".equals(type)?"文件!":"图片!");
		}
		return nullMsg;
	}
	public void setNullMsg(String nullMsg) {
		this.nullMsg = nullMsg;
	}
	public String getBizType() {
		return bizType;
	}
	public void setBizType(String bizType) {
		this.bizType = bizType;
	}
	public boolean isDisplayTxt() {
		return displayTxt;
	}
	public void setDisplayTxt(boolean displayTxt) {
		this.displayTxt = displayTxt;
	}
	public boolean isOutJs() {
		return outJs;
	}
	public void setOutJs(boolean outJs) {
		this.outJs = outJs;
	}
	public boolean isSwfTransform() {
		return swfTransform;
	}
	public void setSwfTransform(boolean swfTransform) {
		this.swfTransform = swfTransform;
	}
	//根据上传文件的后缀重置type
	/*private void typeResetByext(String ext){
		if(null!=ext&&!"".equals(ext)){
			String[] arr=ext.split(",");
			for (int i = 0; i < arr.length; i++) {
				if(imgexts.indexOf(arr[i])>=0){
					this.setType("image");
					break;
				}
			}
		}
	}*/
	
}
