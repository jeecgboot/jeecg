package org.jeecgframework.web.cgform.dao.upload;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.springframework.stereotype.Repository;

/**
 * 
 * @Title:CgFormUploadDao
 * @description:智能表单文件上传
 * @author 赵俊夫
 * @date Aug 27, 2013 8:42:55 PM
 * @version V1.0
 */

@Repository("cgFormUploadDao")
public interface CgFormUploadDao {
	/**
	 * 将文件上传的信息回填到业务表中
	 * @param cgFormId 动态表主键ID
	 * @param cgFormName 动态表名
	 * @param cgFormField 动态表上传控件字段
	 * @param fileId 文件ID
	 * @param fileUrl 文件路径
	 * @return
	 */
	@Arguments({"cgFormId","cgFormName","cgFormField","fileId","fileUrl"})
	public void updateBackFileInfo(String cgFormId,String cgFormName,String cgFormField,String fileId,String fileUrl);
}
