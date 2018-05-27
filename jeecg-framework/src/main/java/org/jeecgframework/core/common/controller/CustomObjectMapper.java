package org.jeecgframework.core.common.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.JsonSerializer;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializerProvider;
import org.codehaus.jackson.map.ser.CustomSerializerFactory;

/**
 * @description 解决@ResponseBody返回json数据，DATE格式
 * @author scott
 * @date 2013-5-28
 */
public class CustomObjectMapper extends ObjectMapper {

	public CustomObjectMapper() {
		CustomSerializerFactory factory = new CustomSerializerFactory();
		factory.addGenericMapping(Date.class, new JsonSerializer<Date>() {
			@Override
			public void serialize(Date value, JsonGenerator jsonGenerator, SerializerProvider provider) throws IOException, JsonProcessingException {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String dateStr = sdf.format(value);
				if (dateStr.endsWith(" 00:00:00")) {
					dateStr = dateStr.substring(0, 10);
				} else if (dateStr.endsWith(":00")) {
					dateStr = dateStr.substring(0, 16);
				}
				jsonGenerator.writeString(dateStr);
			}
		});
		this.setSerializerFactory(factory);
	}
}
