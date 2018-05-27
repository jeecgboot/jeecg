package org.jeecgframework.web.cgform.entity.generate;

import java.util.List;

import org.jeecgframework.codegenerate.pojo.onetomany.SubTableEntity;
/**
 * 
 * @Title:SubTableListEntity
 * @description:代码生成一对多模型
 * @author 赵俊夫
 * @date Sep 7, 2013 3:42:09 PM
 * @version V1.0
 */
public class GenerateSubListEntity {
	private String projectPath;
	private String packageStyle;
	/**
	 * 代码生成的物理配置
	 */
	private List<SubTableEntity> subTabParamIn;
	

	public List<SubTableEntity> getSubTabParamIn() {
		return subTabParamIn;
	}

	public void setSubTabParamIn(List<SubTableEntity> subTabParamIn) {
		this.subTabParamIn = subTabParamIn;
	}

	public String getProjectPath() {
		String pt = projectPath;
		if(pt!=null){
			pt = pt.replace("\\", "/");
			if(!pt.endsWith("/")){
				pt = pt+"/";
			}
		}
		return pt;
	}

	public void setProjectPath(String projectPath) {
		this.projectPath = projectPath;
	}

	public String getPackageStyle() {
		return packageStyle;
	}

	public void setPackageStyle(String packageStyle) {
		this.packageStyle = packageStyle;
	}

	
}
