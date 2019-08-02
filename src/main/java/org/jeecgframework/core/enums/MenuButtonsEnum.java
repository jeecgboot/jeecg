package org.jeecgframework.core.enums;

import org.jeecgframework.core.util.oConvertUtils;

/**
 * 主从页面 菜单配置  ,code字符串不要有包含的情况 (例如：有了add 就不能有addOne)
 * ERP上下布局 按钮菜单枚举
 */
//addSingle,editSingle,batchDel,save,reject,template,importe,export,filter
public enum MenuButtonsEnum {
	addgroup("addgroup","表单新增&word模式","iframeGoAdd&tempNoDo","fa fa-file-text-o&fa fa-file-word-o&fa fa-plus")
	,editgroup("editgroup","表单编辑&word模式","iframeGoUpdate&tempNoDo","fa fa-file-text-o&fa fa-file-word-o&fa fa-pencil-square-o")
	,addSingle("addSingle","新增","iframeGoAdd","fa fa-plus")
	,editSingle("editSingle","编辑","iframeGoUpdate","fa fa-pencil-square-o")
	,batchDel("batchDel","批量删除","iframeDeleteAll","fa fa-trash-o")
	,save("save","保存","iframeGoSaveRow","fa fa-floppy-o")
	,reject("reject","取消编辑","iframeRejectUpdate","fa fa-reply")
	,template("template","模板下载","iframeExportXlsByT","fa fa-upload")
	,importe("import","数据导入","iframeImportExcel","fa fa-download")
	,export("export","数据导出","iframeExportXls","fa fa-share-square-o")
	,filter("filter","过滤","iframeFilter","fa fa-filter")
	,superQuery("superQuery","高级查询","superQuery","fa fa-search-plus")
	;
	
	String code;
	String title;
	String fun;
	String icon;
	
	MenuButtonsEnum(String code, String title, String fun, String icon) {
		this.code = code;
		this.title = title;
		this.fun = fun;
		this.icon = icon;
	}
	
	public static MenuButtonsEnum getMenuByCode(String code){
		if(oConvertUtils.isNotEmpty(code)){
			for (MenuButtonsEnum e : MenuButtonsEnum.values()) {
				if(code.equals(e.code)){
					return e;
				}
			}
		}
		return null;
	}

	/**
	 * @return the code
	 */
	public String getCode() {
		return code;
	}

	/**
	 * @param code the code to set
	 */
	public void setCode(String code) {
		this.code = code;
	}

	/**
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}

	/**
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 * @return the fun
	 */
	public String getFun() {
		return fun;
	}

	/**
	 * @param fun the fun to set
	 */
	public void setFun(String fun) {
		this.fun = fun;
	}

	/**
	 * @return the icon
	 */
	public String getIcon() {
		return icon;
	}

	/**
	 * @param icon the icon to set
	 */
	public void setIcon(String icon) {
		this.icon = icon;
	}
	
}
