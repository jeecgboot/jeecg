package jeecg.system.controller.core;

import javax.servlet.http.HttpServletRequest;
import jeecg.system.pojo.base.DuplicateCheckPage;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.dao.jdbc.JdbcDao;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


/**   
 * @Title: Action
 * @Description: 校验工具Action
 * @author zhangdaihao
 * @date 2013-09-12 22:27:30
 * @version V1.0   
 *update-begin--Author:yankang  Date:201309012 for：[TASK#63]UI库常用控件参考示例【重复校验】
 *update-end--Author:yankang  Date:20130912 for：[TASK#63]UI库常用控件参考示例【重复校验】
 */
@Controller
@RequestMapping("/duplicateCheckAction")
public class DuplicateCheckAction extends BaseController {

	private static final Logger logger = Logger.getLogger(DuplicateCheckAction.class);

	@Autowired
	//SQL 使用JdbcDao
	private JdbcDao jdbcDao;
	
	/**
	 * 校验数据是否在系统中是否存在
	 * @return
	 */
	@RequestMapping(params = "doDuplicateCheck")
	@ResponseBody
	public AjaxJson doDuplicateCheck(DuplicateCheckPage duplicateCheckPage, HttpServletRequest request) {

		AjaxJson j = new AjaxJson();
		Long num = null;
		
		if(StringUtils.isNotBlank(duplicateCheckPage.getRowObid())){
			//[2].编辑页面校验
			String sql = "SELECT count(*) FROM "+duplicateCheckPage.getTableName()
						+" WHERE "+duplicateCheckPage.getFieldName() +" =? and id != ?";
			num = jdbcDao.getCountForJdbcParam(sql, new Object[]{duplicateCheckPage.getFieldVlaue(),duplicateCheckPage.getRowObid()});
		}else{
			//[1].添加页面校验
			String sql = "SELECT count(*) FROM "+duplicateCheckPage.getTableName()
						+" WHERE "+duplicateCheckPage.getFieldName() +" =?";
			num = jdbcDao.getCountForJdbcParam(sql, new Object[]{duplicateCheckPage.getFieldVlaue()});
		}
		
		if(num==null||num==0){
			//该值可用
			j.setSuccess(true);
			j.setMsg("该值可用！");
		}else{
			//该值不可用
			j.setSuccess(false);
			j.setMsg("该值不可用，系统中已存在！");
		}
		return j;
	}
}
