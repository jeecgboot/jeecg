package org.jeecgframework.core.util;


public class UrlCheckUtil {
   /**
	*检查url是否包含指定字符串
	*
	* @return
	*/
	public static Boolean checkUrl(String url,String specifyCharacter) {
		url=url.replace("\\", "/");
		Boolean flag = false;
		if(url.contains(specifyCharacter)){
			flag=true;
		}
        return flag;
	}
	
	/**
	 * 检查url是否包含/./或是/../,有则返回true 
	 */
	public static Boolean checkUrl(String url) {
		return checkUrl(url,"/./") || checkUrl(url,"/../");
	}
	public static void main(String[] args) {
		try {
			Boolean checkUrl = checkUrl("\\user\\.\\aa.jpg","/./");
			System.out.println(checkUrl);
			if(checkUrl){
				throw new Exception("文件地址不合法");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
