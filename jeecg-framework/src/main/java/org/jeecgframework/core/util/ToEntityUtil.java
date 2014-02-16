package org.jeecgframework.core.util;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

/**
 * ?* @author HongChongYuan ?* @date 2012-1-12 ?* @time 下午04:05:13 ?
 */
public final class ToEntityUtil {

	@SuppressWarnings("unchecked")
	public static <T> T toEntityList(List<?> datas, Class<?> clas, String... labels) {
		// 返回实体列表
		List<T> entitys = new ArrayList<T>();
		for (int i = 0; i < datas.size(); i++) {
			// 结果集对象
			Object[] data = (Object[]) datas.get(i);
			T entity;
			try {
				entity = toEntity(clas, data, labels);
				entitys.add(entity);
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		return (T) entitys;
	}

	@SuppressWarnings("unchecked")
	public static <T> T toEntity(Class<?> clas, Object[] data, String... labels)
			throws Exception {
		// 创建对象实例
		T entity = (T) clas.newInstance();
		// 每个字段进行赋值
		for (int j = 0; j < labels.length; j++) {
			if (null == data[j] || 0 == data[j].toString().trim().length()) {
				continue;
			}
			// 得到设值方法名称
			String methodName = "set"
					+ ((labels[j].charAt(0) + "").toUpperCase())
					+ labels[j].substring(1);
			// 得到字段名称
			Field field = entity.getClass().getDeclaredField(labels[j]);
			// 得到字段类型
			String parameterType = field.getType().getSimpleName();
			// 得到设值方法
			Method method = entity.getClass().getDeclaredMethod(methodName,
					field.getType());
			String val = data[j].toString();
			if (parameterType.equals("String")) {
				method.invoke(entity, val);
			} else if (parameterType.equals("Character")) {
				method.invoke(entity, val.charAt(0));
			} else if (parameterType.equals("Boolean")) {
				method.invoke(entity,
						val.equals("true") || val.equals("1") ? true : false);
			} else if (parameterType.equals("Short")) {
				method.invoke(entity, Short.parseShort(val));
			} else if (parameterType.equals("Integer")) {
				method.invoke(entity, Integer.parseInt(val));
			} else if (parameterType.equals("Float")) {
				method.invoke(entity, Float.parseFloat(val));
			} else if (parameterType.equals("Long")) {
				method.invoke(entity, Long.parseLong(val));
			} else if (parameterType.equals("Double")) {
				method.invoke(entity, Double.parseDouble(val));
			}
		}
		return entity;
	}
}