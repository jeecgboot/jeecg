package org.jeecgframework.web.cgreport.util;

import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.jeecgframework.web.cgreport.common.CgReportConstant;

import org.jeecgframework.core.util.StringUtil;

/**
 * 
 * @Title:QueryParamUtil
 * @description:动态报表查询条件处理工具
 * @author 赵俊夫
 * @date Jul 5, 2013 10:22:31 PM
 * @version V1.0
 */
public class CgReportQueryParamUtil extends  org.jeecgframework.web.cgform.util.QueryParamUtil

{
	/**
	 * 组装查询参数
	 * @param request 请求(查询值从此处取)
	 * @param item 动态报表字段配置
	 * @param params 参数存放
	 */
	@SuppressWarnings("unchecked")
	public static void loadQueryParams(HttpServletRequest request, Map item, Map params) {
		String filedName = (String) item.get(CgReportConstant.ITEM_FIELDNAME);
		String queryMode = (String) item.get(CgReportConstant.ITEM_QUERYMODE);
		String filedType = (String) item.get(CgReportConstant.ITEM_FIELDTYPE);
		if("single".equals(queryMode)){
			//单条件组装方式
			String value =request.getParameter(filedName);
			try {
				if(StringUtil.isEmpty(value)){
					return;
				}
				String uri = request.getQueryString();
				if(uri.contains(filedName+"=")){
					String contiansChinesevalue = new String(value.getBytes("ISO-8859-1"), "UTF-8");
					value = contiansChinesevalue;
				}
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
				return;
			} 
			sql_inj_throw(value);
			value = applyType(filedType,value);
			if(!StringUtil.isEmpty(value)){
				if(value.contains("*")){
					//模糊查询
					value = value.replaceAll("\\*", "%");
					params.put(filedName, CgReportConstant.OP_LIKE+value);
				}else{
					params.put(filedName, CgReportConstant.OP_EQ+value);
				}
			}
		}else if("group".equals(queryMode)){
			//范围查询组装
			String begin = request.getParameter(filedName+"_begin");
			sql_inj_throw(begin);
			begin= applyType(filedType,begin);
			String end = request.getParameter(filedName+"_end");
			sql_inj_throw(end);
			end= applyType(filedType,end);
			if(!StringUtil.isEmpty(begin)){
				String re = CgReportConstant.OP_RQ+begin;
				if(!StringUtil.isEmpty(end)){
					re +=" AND "+filedName+CgReportConstant.OP_LQ+end;
				}
				params.put(filedName, re);
			}else if(!StringUtil.isEmpty(end)){
				String re = CgReportConstant.OP_LQ+end;
				params.put(filedName, re);
			}
		}
	}
	
}
