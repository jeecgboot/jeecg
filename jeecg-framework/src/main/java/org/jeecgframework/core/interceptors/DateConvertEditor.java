package org.jeecgframework.core.interceptors;

import java.beans.PropertyEditorSupport;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.util.StringUtils;

/**
 * 
 * @author 张代浩
 * 
 */
public class DateConvertEditor extends PropertyEditorSupport {
	private SimpleDateFormat datetimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

	/**
	 * 字符串转换为date对象
	 * 据2014-05-26 00:00:00长度来判断选择哪种转换方式
	 */
	public void setAsText(String text) throws IllegalArgumentException {
		if (StringUtils.hasText(text)) {
			try {
				if (text.indexOf(":") == -1 && text.length() == 10) {
					setValue(this.dateFormat.parse(text));
				} else if (text.indexOf(":") > 0 && text.length() == 19) {
					setValue(this.datetimeFormat.parse(text));
				} else if (text.indexOf(":") > 0 && text.length() == 21) {
					text = text.replace(".0", "");
					setValue(this.datetimeFormat.parse(text));

				} else if (text.indexOf(":") > 0 && text.indexOf(".") > 0 && text.length() > 21) {
					text = text.substring(0, text.indexOf("."));
					setValue(this.datetimeFormat.parse(text));
				} else {
					throw new IllegalArgumentException("Could not parse date, date format is error ");
				}
			} catch (ParseException ex) {
				IllegalArgumentException iae = new IllegalArgumentException("Could not parse date: " + ex.getMessage());
				iae.initCause(ex);
				throw iae;
			}
		} else {
			setValue(null);
		}
	}

	/**
	 * 转换为日期字符串
	 */
	@Override
	public String getAsText() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date value = (Date) getValue();
		String dateStr = null;
		if (value == null) {
			return "";
		} else {
			try {
				dateStr = sdf.format(value);
				if (dateStr.endsWith(" 00:00:00")) {
					dateStr = dateStr.substring(0, 10);
				} else if (dateStr.endsWith(":00")) {
					dateStr = dateStr.substring(0, 16);
				}
				return dateStr;
			} catch (Exception ex) {
				throw new IllegalArgumentException("转换日期失败: " + ex.getMessage(), ex);
			}
		}
	}
}
