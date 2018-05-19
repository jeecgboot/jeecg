package org.jeecgframework.tag.core.easyui;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.jeecgframework.core.util.ApplicationContextUtil;
import org.jeecgframework.web.system.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
/**
 * 
 * @Title:AuthFilterTag
 * @description:列表按钮权限过滤
 * @author 赵俊夫
 * @date Aug 24, 2013 7:46:57 PM
 * @version V1.0
 */
public class AuthFilterTag extends TagSupport{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**列表容器的ID*/
	protected String name;
	@Autowired
	private SystemService systemService;
	
	public int doStartTag() throws JspException {
		return super.doStartTag();
	}
	
	public int doEndTag() throws JspException {
		JspWriter out = null;

		try {
			out = this.pageContext.getOut();
			systemService = ApplicationContextUtil.getContext().getBean(SystemService.class);
			out.print(systemService.getAuthFilterJS());
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(out!=null){
				try {
					out.clearBuffer();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return EVAL_PAGE;

	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
}
