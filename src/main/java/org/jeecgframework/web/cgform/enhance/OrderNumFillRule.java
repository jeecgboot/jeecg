package org.jeecgframework.web.cgform.enhance;

import java.text.SimpleDateFormat;
import java.util.Date;

import net.sf.json.JSONObject;

import org.apache.commons.lang.math.RandomUtils;

/**
 * 订单号生成规则实现类
 * @author YanDong
 */
public class OrderNumFillRule implements IFillRuleHandler{

	@Override
	public Object execute(String paramJson) {
		String prefix="CN";
		//订单前缀默认为CN 如果规则参数不为空，则取自定义前缀
		if(paramJson!=null && !"".equals(paramJson)){
			JSONObject jsonObject = JSONObject.fromObject(paramJson);
			Object obj = jsonObject.get("prefix");
			if(obj!=null)prefix=obj.toString();
		}
		SimpleDateFormat format=new SimpleDateFormat("yyyyMMddHHmmss");
		int random=RandomUtils.nextInt(90)+10;
		return prefix+format.format(new Date())+random;
	}
}
