package org.jeecgframework.core.enums;

import java.io.File;

import org.jeecgframework.core.util.oConvertUtils;

/**
 * 文件上传设置枚举类
 * @author sundonghui
 *
 */
public enum StoreUploadFilePathEnum {
	PHOTOSUCAI("photosucai", "upload"+File.separator+"img"+File.separator+"photosucai"), 
	/**online文件上传位置*/
	ONlINE("online","upload"+File.separator+"online"),
	DEFAULT("default", "upload"+File.separator+"files");	 
	 
	private String name;
	private String path;  
    // 构造方法  
	private StoreUploadFilePathEnum(String name, String path) {  
	    this.name = name;  
	    this.path = path;  
	}  
	
	//获取路径 
    public static String getPath(String name) {
    	if(oConvertUtils.isNotEmpty(name)){
    		for (StoreUploadFilePathEnum storePath : StoreUploadFilePathEnum.values()) {  
                if (storePath.getName().equals(name)) {  
                    return storePath.path;  
                }  
            }  
    	}
        return DEFAULT.path;  
    }

    
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	} 
    
    
}
