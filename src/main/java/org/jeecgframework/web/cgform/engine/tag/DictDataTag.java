package org.jeecgframework.web.cgform.engine.tag;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.jeecgframework.core.util.MutiLangUtil;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.web.system.pojo.base.TSType;
import org.jeecgframework.web.system.service.SystemService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import freemarker.core.Environment;
import freemarker.template.SimpleCollection;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
import freemarker.template.TemplateModelException;
import freemarker.template.TemplateScalarModel;

/**
 * 自定义字典表标签
 * 
 * @author Zhoujf
 * 
 */
@Component("dictDataTag")
public class DictDataTag implements TemplateDirectiveModel {

	private static final Logger LOG = LoggerFactory
			.getLogger(DictDataTag.class);

	@Autowired
	private SystemService systemService;

	@SuppressWarnings("unchecked")
	public void execute(Environment env, Map params, TemplateModel[] loopVars,
			TemplateDirectiveBody body) throws TemplateException, IOException {

		// 数据名称
		String name = getAttribute(params, "name");
		if (name == null) {
			throw new TemplateException(
					"Can not find attribute 'name' in data tag", env);
		}
		String text = getAttribute(params, "text");
		String tablename = getAttribute(params, "tablename");
		// 变量名称
		String var = getAttribute(params, "var");
		// 加入数据
		var = var != null ? var : name;

		if (tablename == null || tablename.trim().length() <= 0) {
			// 根据dict_field查询字典表list
			List<TSType> dataList = ResourceUtil.allTypes.get(name.toLowerCase());
			if (dataList == null) {
				dataList = new ArrayList<TSType>();
			}

			for(TSType s:dataList){
				String names = s.getTypename();
				s.setTypename(MutiLangUtil.getLang(names));
			}

			env.setGlobalVariable(var, new SimpleCollection(dataList));
		} else {
			// table表查询
			StringBuilder sql = new StringBuilder("");
			sql.append("select distinct ").append(name)
					.append(" as typecode, ");
			if (text == null || text.trim().length() <= 0) {
				sql.append(name).append(" as typename ");
			} else {
				sql.append(text).append(" as typename ");
			}
			sql.append(" from ").append(tablename);
			sql.append(" order by ").append(name);
			List<Map<String, Object>> dataList = systemService.findForJdbc(sql
					.toString());
			env.setGlobalVariable(var, new SimpleCollection(dataList));
		}
		body.render(env.getOut());
	}

	/**
	 * 取得标签参数
	 * 
	 * @param params
	 * @param name
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private String getAttribute(Map params, String name) {
		String value = null;
		if (params.containsKey(name)) {
			TemplateModel paramValue = (TemplateModel) params.get(name);
			try {
				value = ((TemplateScalarModel) paramValue).getAsString();
			} catch (TemplateModelException e) {
				LOG.error("get attribute '{}' error", name, e);
			}
		}
		return value;
	}

}
