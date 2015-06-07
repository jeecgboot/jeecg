package org.jeecgframework.core.util;

import java.beans.XMLDecoder;
import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.io.HTMLWriter;
import org.dom4j.io.OutputFormat;

/**
 * 字符串处理及转换工具类
 * @author  张代浩
 */
public class StringUtil {
	private static Pattern numericPattern = Pattern.compile("^[0-9\\-]+$");
	private static Pattern numericStringPattern = Pattern.compile("^[0-9\\-\\-]+$");
	private static Pattern floatNumericPattern = Pattern.compile("^[0-9\\-\\.]+$");
	private static Pattern abcPattern = Pattern.compile("^[a-z|A-Z]+$");
	public static final String splitStrPattern = ",|，|;|；|、|\\.|。|-|_|\\(|\\)|\\[|\\]|\\{|\\}|\\\\|/| |　|\"";
	private static Log logger = LogFactory.getLog(StringUtil.class);

	/**
	 * 判断是否数字表示
	 * 
	 * @param src
	 *            源字符串
	 * @return 是否数字的标志
	 */
	public static boolean isNumeric(String src) {
		boolean return_value = false;
		if (src != null && src.length() > 0) {
			Matcher m = numericPattern.matcher(src);
			if (m.find()) {
				return_value = true;
			}
		}
		return return_value;
	}

	/**
	 * 判断是否数字表示
	 * 
	 * @param src
	 *            源字符串
	 * @return 是否数字的标志
	 */
	public static boolean isNumericString(String src) {
		boolean return_value = false;
		if (src != null && src.length() > 0) {
			Matcher m = numericStringPattern.matcher(src);
			if (m.find()) {
				return_value = true;
			}
		}
		return return_value;
	}

	/**
	 * 判断是否纯字母组合
	 * 
	 * @param src
	 *            源字符串
	 * @return 是否纯字母组合的标志
	 */
	public static boolean isABC(String src) {
		boolean return_value = false;
		if (src != null && src.length() > 0) {
			Matcher m = abcPattern.matcher(src);
			if (m.find()) {
				return_value = true;
			}
		}
		return return_value;
	}

	/**
	 * 判断是否浮点数字表示
	 * 
	 * @param src
	 *            源字符串
	 * @return 是否数字的标志
	 */
	public static boolean isFloatNumeric(String src) {
		boolean return_value = false;
		if (src != null && src.length() > 0) {
			Matcher m = floatNumericPattern.matcher(src);
			if (m.find()) {
				return_value = true;
			}
		}
		return return_value;
	}

	/**
	 * 把string array or list用给定的符号symbol连接成一个字符串
	 * 
	 * @param array
	 * @param symbol
	 * @return
	 */
	public static String joinString(List array, String symbol) {
		String result = "";
		if (array != null) {
			for (int i = 0; i < array.size(); i++) {
				String temp = array.get(i).toString();
				if (temp != null && temp.trim().length() > 0)
					result += (temp + symbol);
			}
			if (result.length() > 1)
				result = result.substring(0, result.length() - 1);
		}
		return result;
	}

	public static String subStringNotEncode(String subject, int size) {
		if (subject != null && subject.length() > size) {
			subject = subject.substring(0, size) + "...";
		}
		return subject;
	}

	/**
	 * 截取字符串　超出的字符用symbol代替 　　
	 * 
	 * @param len
	 *            　字符串长度　长度计量单位为一个GBK汉字　　两个英文字母计算为一个单位长度
	 * @param str
	 * @param symbol
	 * @return
	 */
	public static String getLimitLengthString(String str, int len, String symbol) {
		int iLen = len * 2;
		int counterOfDoubleByte = 0;
		String strRet = "";
		try {
			if (str != null) {
				byte[] b = str.getBytes("GBK");
				if (b.length <= iLen) {
					return str;
				}
				for (int i = 0; i < iLen; i++) {
					if (b[i] < 0) {
						counterOfDoubleByte++;
					}
				}
				if (counterOfDoubleByte % 2 == 0) {
					strRet = new String(b, 0, iLen, "GBK") + symbol;
					return strRet;
				} else {
					strRet = new String(b, 0, iLen - 1, "GBK") + symbol;
					return strRet;
				}
			} else {
				return "";
			}
		} catch (Exception ex) {
			return str.substring(0, len);
		} finally {
			strRet = null;
		}
	}

	/**
	 * 截取字符串　超出的字符用symbol代替 　　
	 * 
	 * @param len
	 *            　字符串长度　长度计量单位为一个GBK汉字　　两个英文字母计算为一个单位长度
	 * @param str
	 * @param symbol
	 * @return12
	 */
	public static String getLimitLengthString(String str, int len) {
		return getLimitLengthString(str, len, "...");
	}

	/**
	 * 
	 * 截取字符，不转码
	 * 
	 * @param subject
	 * @param size
	 * @return
	 */
	public static String subStrNotEncode(String subject, int size) {
		if (subject.length() > size) {
			subject = subject.substring(0, size);
		}
		return subject;
	}

	/**
	 * 把string array or list用给定的符号symbol连接成一个字符串
	 * 
	 * @param array
	 * @param symbol
	 * @return
	 */
	public static String joinString(String[] array, String symbol) {
		String result = "";
		if (array != null) {
			for (int i = 0; i < array.length; i++) {
				String temp = array[i];
				if (temp != null && temp.trim().length() > 0)
					result += (temp + symbol);
			}
			if (result.length() > 1)
				result = result.substring(0, result.length() - 1);
		}
		return result;
	}

	/**
	 * 取得字符串的实际长度（考虑了汉字的情况）
	 * 
	 * @param SrcStr
	 *            源字符串
	 * @return 字符串的实际长度
	 */
	public static int getStringLen(String SrcStr) {
		int return_value = 0;
		if (SrcStr != null) {
			char[] theChars = SrcStr.toCharArray();
			for (int i = 0; i < theChars.length; i++) {
				return_value += (theChars[i] <= 255) ? 1 : 2;
			}
		}
		return return_value;
	}

	/**
	 * 检查数据串中是否包含非法字符集
	 * 
	 * @param str
	 * @return [true]|[false] 包含|不包含
	 */
	public static boolean check(String str) {
		String sIllegal = "'\"";
		int len = sIllegal.length();
		if (null == str)
			return false;
		for (int i = 0; i < len; i++) {
			if (str.indexOf(sIllegal.charAt(i)) != -1)
				return true;
		}

		return false;
	}

	/***************************************************************************
	 * getHideEmailPrefix - 隐藏邮件地址前缀。
	 * 
	 * @param email
	 *            - EMail邮箱地址 例如: linwenguo@koubei.com 等等...
	 * @return 返回已隐藏前缀邮件地址, 如 *********@koubei.com.
	 * @version 1.0 (2006.11.27) Wilson Lin
	 **************************************************************************/
	public static String getHideEmailPrefix(String email) {
		if (null != email) {
			int index = email.lastIndexOf('@');
			if (index > 0) {
				email = repeat("*", index).concat(email.substring(index));
			}
		}
		return email;
	}

	/***************************************************************************
	 * repeat - 通过源字符串重复生成N次组成新的字符串。
	 * 
	 * @param src
	 *            - 源字符串 例如: 空格(" "), 星号("*"), "浙江" 等等...
	 * @param num
	 *            - 重复生成次数
	 * @return 返回已生成的重复字符串
	 * @version 1.0 (2006.10.10) Wilson Lin
	 **************************************************************************/
	public static String repeat(String src, int num) {
		StringBuffer s = new StringBuffer();
		for (int i = 0; i < num; i++)
			s.append(src);
		return s.toString();
	}

	/**
	 * 根据指定的字符把源字符串分割成一个数组
	 * 
	 * @param src
	 * @return
	 */
	public static List<String> parseString2ListByCustomerPattern(String pattern, String src) {

		if (src == null)
			return null;
		List<String> list = new ArrayList<String>();
		String[] result = src.split(pattern);
		for (int i = 0; i < result.length; i++) {
			list.add(result[i]);
		}
		return list;
	}

	/**
	 * 根据指定的字符把源字符串分割成一个数组
	 * 
	 * @param src
	 * @return
	 */
	public static List<String> parseString2ListByPattern(String src) {
		String pattern = "，|,|、|。";
		return parseString2ListByCustomerPattern(pattern, src);
	}

	/**
	 * 格式化一个float
	 * 
	 * @param format
	 *            要格式化成的格式 such as #.00, #.#
	 */

	public static String formatFloat(float f, String format) {
		DecimalFormat df = new DecimalFormat(format);
		return df.format(f);
	}

	/**
	 * 判断是否是空字符串 null和"" 都返回 true
	 * 
	 * @author Robin Chang
	 * @param s
	 * @return
	 */
	public static boolean isEmpty(String s) {
		if (s != null && !s.equals("")) {
			return false;
		}
		return true;
	}

	/**
	 * 自定义的分隔字符串函数 例如: 1,2,3 =>[1,2,3] 3个元素 ,2,3=>[,2,3] 3个元素 ,2,3,=>[,2,3,] 4个元素 ,,,=>[,,,] 4个元素
	 * 
	 * 5.22算法修改，为提高速度不用正则表达式 两个间隔符,,返回""元素
	 * 
	 * @param split
	 *            分割字符 默认,
	 * @param src
	 *            输入字符串
	 * @return 分隔后的list
	 * @author Robin
	 */
	public static List<String> splitToList(String split, String src) {
		// 默认,
		String sp = ",";
		if (split != null && split.length() == 1) {
			sp = split;
		}
		List<String> r = new ArrayList<String>();
		int lastIndex = -1;
		int index = src.indexOf(sp);
		if (-1 == index && src != null) {
			r.add(src);
			return r;
		}
		while (index >= 0) {
			if (index > lastIndex) {
				r.add(src.substring(lastIndex + 1, index));
			} else {
				r.add("");
			}

			lastIndex = index;
			index = src.indexOf(sp, index + 1);
			if (index == -1) {
				r.add(src.substring(lastIndex + 1, src.length()));
			}
		}
		return r;
	}

	/**
	 * 把 名=值 参数表转换成字符串 (a=1,b=2 =>a=1&b=2)
	 * 
	 * @param map
	 * @return
	 */
	public static String linkedHashMapToString(LinkedHashMap<String, String> map) {
		if (map != null && map.size() > 0) {
			String result = "";
			Iterator it = map.keySet().iterator();
			while (it.hasNext()) {
				String name = (String) it.next();
				String value = (String) map.get(name);
				result += (result.equals("")) ? "" : "&";
				result += String.format("%s=%s", name, value);
			}
			return result;
		}
		return null;
	}

	/**
	 * 解析字符串返回 名称=值的参数表 (a=1&b=2 => a=1,b=2)
	 * 
	 * @see test.koubei.util.StringUtilTest#testParseStr()
	 * @param str
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static LinkedHashMap<String, String> toLinkedHashMap(String str) {
		if (str != null && !str.equals("") && str.indexOf("=") > 0) {
			LinkedHashMap result = new LinkedHashMap();

			String name = null;
			String value = null;
			int i = 0;
			while (i < str.length()) {
				char c = str.charAt(i);
				switch (c) {
				case 61: // =
					value = "";
					break;
				case 38: // &
					if (name != null && value != null && !name.equals("")) {
						result.put(name, value);
					}
					name = null;
					value = null;
					break;
				default:
					if (value != null) {
						value = (value != null) ? (value + c) : "" + c;
					} else {
						name = (name != null) ? (name + c) : "" + c;
					}
				}
				i++;

			}

			if (name != null && value != null && !name.equals("")) {
				result.put(name, value);
			}

			return result;

		}
		return null;
	}

	/**
	 * 根据输入的多个解释和下标返回一个值
	 * 
	 * @param captions
	 *            例如:"无,爱干净,一般,比较乱"
	 * @param index
	 *            1
	 * @return 一般
	 */
	public static String getCaption(String captions, int index) {
		if (index > 0 && captions != null && !captions.equals("")) {
			String[] ss = captions.split(",");
			if (ss != null && ss.length > 0 && index < ss.length) {
				return ss[index];
			}
		}
		return null;
	}

	/**
	 * 数字转字符串,如果num<=0 则输出"";
	 * 
	 * @param num
	 * @return
	 */
	public static String numberToString(Object num) {
		if (num == null) {
			return null;
		} else if (num instanceof Integer && (Integer) num > 0) {
			return Integer.toString((Integer) num);
		} else if (num instanceof Long && (Long) num > 0) {
			return Long.toString((Long) num);
		} else if (num instanceof Float && (Float) num > 0) {
			return Float.toString((Float) num);
		} else if (num instanceof Double && (Double) num > 0) {
			return Double.toString((Double) num);
		} else {
			return "";
		}
	}

	/**
	 * 货币转字符串
	 * 
	 * @param money
	 * @param style
	 *            样式 [default]要格式化成的格式 such as #.00, #.#
	 * @return
	 */

	public static String moneyToString(Object money, String style) {
		if (money != null && style != null && (money instanceof Double || money instanceof Float)) {
			Double num = (Double) money;

			if (style.equalsIgnoreCase("default")) {
				// 缺省样式 0 不输出 ,如果没有输出小数位则不输出.0
				if (num == 0) {
					// 不输出0
					return "";
				} else if ((num * 10 % 10) == 0) {
					// 没有小数
					return Integer.toString((int) num.intValue());
				} else {
					// 有小数
					return num.toString();
				}

			} else {
				DecimalFormat df = new DecimalFormat(style);
				return df.format(num);
			}
		}
		return null;
	}

	/**
	 * 在sou中是否存在finds 如果指定的finds字符串有一个在sou中找到,返回true;
	 * 
	 * @param sou
	 * @param find
	 * @return
	 */
	public static boolean strPos(String sou, String... finds) {
		if (sou != null && finds != null && finds.length > 0) {
			for (int i = 0; i < finds.length; i++) {
				if (sou.indexOf(finds[i]) > -1)
					return true;
			}
		}
		return false;
	}

	public static boolean strPos(String sou, List<String> finds) {
		if (sou != null && finds != null && finds.size() > 0) {
			for (String s : finds) {
				if (sou.indexOf(s) > -1)
					return true;
			}
		}
		return false;
	}

	public static boolean strPos(String sou, String finds) {
		List<String> t = splitToList(",", finds);
		return strPos(sou, t);
	}

	/**
	 * 判断两个字符串是否相等 如果都为null则判断为相等,一个为null另一个not null则判断不相等 否则如果s1=s2则相等
	 * 
	 * @param s1
	 * @param s2
	 * @return
	 */
	public static boolean equals(String s1, String s2) {
		if (StringUtil.isEmpty(s1) && StringUtil.isEmpty(s2)) {
			return true;
		} else if (!StringUtil.isEmpty(s1) && !StringUtil.isEmpty(s2)) {
			return s1.equals(s2);
		}
		return false;
	}

	public static int toInt(String s) {
		if (s != null && !"".equals(s.trim())) {
			try {
				return Integer.parseInt(s);
			} catch (Exception e) {
				return 0;
			}
		}
		return 0;
	}

	public static double toDouble(String s) {
		if (s != null && !"".equals(s.trim())) {
			return Double.parseDouble(s);
		}
		return 0;
	}

	/**
	 * 把xml 转为object
	 * 
	 * @param xml
	 * @return
	 */
	public static Object xmlToObject(String xml) {
		try {
			ByteArrayInputStream in = new ByteArrayInputStream(xml.getBytes("UTF8"));
			XMLDecoder decoder = new XMLDecoder(new BufferedInputStream(in));
			return decoder.readObject();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static long toLong(String s) {
		try {
			if (s != null && !"".equals(s.trim()))
				return Long.parseLong(s);
		} catch (Exception exception) {
		}
		return 0L;
	}

	public static String simpleEncrypt(String str) {
		if (str != null && str.length() > 0) {
			// str = str.replaceAll("0","a");
			str = str.replaceAll("1", "b");
			// str = str.replaceAll("2","c");
			str = str.replaceAll("3", "d");
			// str = str.replaceAll("4","e");
			str = str.replaceAll("5", "f");
			str = str.replaceAll("6", "g");
			str = str.replaceAll("7", "h");
			str = str.replaceAll("8", "i");
			str = str.replaceAll("9", "j");
		}
		return str;

	}

	/**
	 * 过滤用户输入的URL地址（防治用户广告） 目前只针对以http或www开头的URL地址 本方法调用的正则表达式，不建议用在对性能严格的地方例如:循环及list页面等
	 * 
	 * @author fengliang
	 * @param str
	 *            需要处理的字符串
	 * @return 返回处理后的字符串
	 */
	public static String removeURL(String str) {
		if (str != null)
			str = str.toLowerCase().replaceAll("(http|www|com|cn|org|\\.)+", "");
		return str;
	}

	/**
	 * 随即生成指定位数的含数字验证码字符串
	 * 
	 * @author Peltason
	 * @date 2007-5-9
	 * @param bit
	 *            指定生成验证码位数
	 * @return String
	 */
	public static String numRandom(int bit) {
		if (bit == 0)
			bit = 6; // 默认6位
		String str = "";
		str = "0123456789";// 初始化种子
		return RandomStringUtils.random(bit, str);// 返回6位的字符串
	}

	/**
	 * 随即生成指定位数的含验证码字符串
	 * 
	 * @author Peltason
	 * 
	 * @date 2007-5-9
	 * @param bit
	 *            指定生成验证码位数
	 * @return String
	 */
	public static String random(int bit) {
		if (bit == 0)
			bit = 6; // 默认6位
		// 因为o和0,l和1很难区分,所以,去掉大小写的o和l
		String str = "";
		str = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz";// 初始化种子
		return RandomStringUtils.random(bit, str);// 返回6位的字符串
	}

	/**
	 * Wap页面的非法字符检查
	 * 
	 * @author hugh115
	 * @date 2007-06-29
	 * @param str
	 * @return
	 */
	public static String replaceWapStr(String str) {
		if (str != null) {
			str = str.replaceAll("<span class=\"keyword\">", "");
			str = str.replaceAll("</span>", "");
			str = str.replaceAll("<strong class=\"keyword\">", "");
			str = str.replaceAll("<strong>", "");
			str = str.replaceAll("</strong>", "");

			str = str.replace('$', '＄');

			str = str.replaceAll("&amp;", "＆");
			str = str.replace('&', '＆');

			str = str.replace('<', '＜');

			str = str.replace('>', '＞');

		}
		return str;
	}

	/**
	 * 字符串转float 如果异常返回0.00
	 * 
	 * @param s
	 *            输入的字符串
	 * @return 转换后的float
	 */
	public static Float toFloat(String s) {
		try {
			return Float.parseFloat(s);
		} catch (NumberFormatException e) {
			return new Float(0);
		}
	}

	/**
	 * 页面中去除字符串中的空格、回车、换行符、制表符
	 * 
	 * @author shazao
	 * @date 2007-08-17
	 * @param str
	 * @return
	 */
	public static String replaceBlank(String str) {
		if (str != null) {
			Pattern p = Pattern.compile("\\s*|\t|\r|\n");
			Matcher m = p.matcher(str);
			str = m.replaceAll("");
		}
		return str;
	}

	/**
	 * 全角生成半角
	 * 
	 * @author bailong
	 * @date 2007-08-29
	 * @param str
	 * @return
	 */
	public static String Q2B(String QJstr) {
		String outStr = "";
		String Tstr = "";
		byte[] b = null;
		for (int i = 0; i < QJstr.length(); i++) {
			try {
				Tstr = QJstr.substring(i, i + 1);
				b = Tstr.getBytes("unicode");
			} catch (java.io.UnsupportedEncodingException e) {
				if (logger.isErrorEnabled()) {
					logger.error(e);
				}
			}
			if (b[3] == -1) {
				b[2] = (byte) (b[2] + 32);
				b[3] = 0;
				try {
					outStr = outStr + new String(b, "unicode");
				} catch (java.io.UnsupportedEncodingException ex) {
					if (logger.isErrorEnabled()) {
						logger.error(ex);
					}
				}
			} else {
				outStr = outStr + Tstr;
			}
		}
		return outStr;
	}

	/**
	 * 
	 * 转换编码
	 * 
	 * @param s
	 *            源字符串
	 * @param fencode
	 *            源编码格式
	 * @param bencode
	 *            目标编码格式
	 * @return 目标编码
	 */
	public static String changCoding(String s, String fencode, String bencode) {
		String str;
		try {
			if (StringUtil.isNotEmpty(s)) {
				str = new String(s.getBytes(fencode), bencode);
			} else {
				str = "";
			}
			return str;
		} catch (UnsupportedEncodingException e) {
			return s;
		}
	}

	/**
	 * @param str
	 * @return
	 ************************************************************************* 
	 */
	public static String removeHTMLLableExe(String str) {
		str = stringReplace(str, ">\\s*<", "><");
		str = stringReplace(str, "&nbsp;", " ");// 替换空格
		str = stringReplace(str, "<br ?/?>", "\n");// 去<br><br />
		str = stringReplace(str, "<([^<>]+)>", "");// 去掉<>内的字符
		str = stringReplace(str, "\\s\\s\\s*", " ");// 将多个空白变成一个空格
		str = stringReplace(str, "^\\s*", "");// 去掉头的空白
		str = stringReplace(str, "\\s*$", "");// 去掉尾的空白
		str = stringReplace(str, " +", " ");
		return str;
	}

	/**
	 * 除去html标签
	 * 
	 * @param str
	 *            源字符串
	 * @return 目标字符串
	 */
	public static String removeHTMLLable(String str) {
		str = stringReplace(str, "\\s", "");// 去掉页面上看不到的字符
		str = stringReplace(str, "<br ?/?>", "\n");// 去<br><br />
		str = stringReplace(str, "<([^<>]+)>", "");// 去掉<>内的字符
		str = stringReplace(str, "&nbsp;", " ");// 替换空格
		str = stringReplace(str, "&(\\S)(\\S?)(\\S?)(\\S?);", "");// 去<br><br />
		return str;
	}

	/**
	 * 去掉HTML标签之外的字符串
	 * 
	 * @param str
	 *            源字符串
	 * @return 目标字符串
	 */
	public static String removeOutHTMLLable(String str) {
		str = stringReplace(str, ">([^<>]+)<", "><");
		str = stringReplace(str, "^([^<>]+)<", "<");
		str = stringReplace(str, ">([^<>]+)$", ">");
		return str;
	}

	/**
	 * 
	 * 字符串替换
	 * 
	 * @param str
	 *            源字符串
	 * @param sr
	 *            正则表达式样式
	 * @param sd
	 *            替换文本
	 * @return 结果串
	 */
	public static String stringReplace(String str, String sr, String sd) {
		String regEx = sr;
		Pattern p = Pattern.compile(regEx, Pattern.CASE_INSENSITIVE);
		Matcher m = p.matcher(str);
		str = m.replaceAll(sd);
		return str;
	}

	/**
	 * 
	 * 将html的省略写法替换成非省略写法
	 * 
	 * @param str
	 *            html字符串
	 * @param pt
	 *            标签如table
	 * @return 结果串
	 */
	public static String fomateToFullForm(String str, String pt) {
		String regEx = "<" + pt + "\\s+([\\S&&[^<>]]*)/>";
		Pattern p = Pattern.compile(regEx, Pattern.CASE_INSENSITIVE);
		Matcher m = p.matcher(str);
		String[] sa = null;
		String sf = "";
		String sf2 = "";
		String sf3 = "";
		for (; m.find();) {
			sa = p.split(str);
			if (sa == null) {
				break;
			}
			sf = str.substring(sa[0].length(), str.indexOf("/>", sa[0].length()));
			sf2 = sf + "></" + pt + ">";
			sf3 = str.substring(sa[0].length() + sf.length() + 2);
			str = sa[0] + sf2 + sf3;
			sa = null;
		}
		return str;
	}

	/**
	 * 
	 * 得到字符串的子串位置序列
	 * 
	 * @param str
	 *            字符串
	 * @param sub
	 *            子串
	 * @param b
	 *            true子串前端,false子串后端
	 * @return 字符串的子串位置序列
	 */
	public static int[] getSubStringPos(String str, String sub, boolean b) {
		// int[] i = new int[(new Integer((str.length()-stringReplace( str , sub
		// , "" ).length())/sub.length())).intValue()] ;
		String[] sp = null;
		int l = sub.length();
		sp = splitString(str, sub);
		if (sp == null) {
			return null;
		}
		int[] ip = new int[sp.length - 1];
		for (int i = 0; i < sp.length - 1; i++) {
			ip[i] = sp[i].length() + l;
			if (i != 0) {
				ip[i] += ip[i - 1];
			}
		}
		if (b) {
			for (int j = 0; j < ip.length; j++) {
				ip[j] = ip[j] - l;
			}
		}
		return ip;
	}

	/**
	 * 
	 * 根据正则表达式分割字符串
	 * 
	 * @param str
	 *            源字符串
	 * @param ms
	 *            正则表达式
	 * @return 目标字符串组
	 */
	public static String[] splitString(String str, String ms) {
		String regEx = ms;
		Pattern p = Pattern.compile(regEx, Pattern.CASE_INSENSITIVE);
		String[] sp = p.split(str);
		return sp;
	}

	/**
	 * 根据正则表达式提取字符串,相同的字符串只返回一个
	 * 
	 * @param str源字符串
	 * @param pattern
	 *            正则表达式
	 * @return 目标字符串数据组
	 ************************************************************************* 
	 */

	// ★传入一个字符串，把符合pattern格式的字符串放入字符串数组
	// java.util.regex是一个用正则表达式所订制的模式来对字符串进行匹配工作的类库包
	public static String[] getStringArrayByPattern(String str, String pattern) {
		Pattern p = Pattern.compile(pattern, Pattern.CASE_INSENSITIVE);
		Matcher matcher = p.matcher(str);
		// 范型
		Set<String> result = new HashSet<String>();// 目的是：相同的字符串只返回一个。。。 不重复元素
		// boolean find() 尝试在目标字符串里查找下一个匹配子串。
		while (matcher.find()) {
			for (int i = 0; i < matcher.groupCount(); i++) { // int groupCount()
																// 返回当前查找所获得的匹配组的数量。
				// org.jeecgframework.core.util.LogUtil.info(matcher.group(i));
				result.add(matcher.group(i));

			}
		}
		String[] resultStr = null;
		if (result.size() > 0) {
			resultStr = new String[result.size()];
			return result.toArray(resultStr);// 将Set result转化为String[] resultStr
		}
		return resultStr;

	}

	/**
	 * 得到第一个b,e之间的字符串,并返回e后的子串
	 * 
	 * @param s
	 *            源字符串
	 * @param b
	 *            标志开始
	 * @param e
	 *            标志结束
	 * @return b,e之间的字符串
	 */

	/*
	 * String aaa="abcdefghijklmn"; String[] bbb=StringProcessor.midString(aaa, "b","l"); org.jeecgframework.core.util.LogUtil.info("bbb[0]:"+bbb[0]);//cdefghijk org.jeecgframework.core.util.LogUtil.info("bbb[1]:"+bbb[1]);//lmn ★这个方法是得到第二个参数和第三个参数之间的字符串,赋给元素0;然后把元素0代表的字符串之后的,赋给元素1
	 */

	/*
	 * String aaa="abcdefgllhijklmn5465"; String[] bbb=StringProcessor.midString(aaa, "b","l"); //ab cdefg llhijklmn5465 // 元素0 元素1
	 */
	public static String[] midString(String s, String b, String e) {
		int i = s.indexOf(b) + b.length();
		int j = s.indexOf(e, i);
		String[] sa = new String[2];
		if (i < b.length() || j < i + 1 || i > j) {
			sa[1] = s;
			sa[0] = null;
			return sa;
		} else {
			sa[0] = s.substring(i, j);
			sa[1] = s.substring(j);
			return sa;
		}
	}

	/**
	 * 带有前一次替代序列的正则表达式替代
	 * 
	 * @param s
	 * @param pf
	 * @param pb
	 * @param start
	 * @return
	 */
	public static String stringReplace(String s, String pf, String pb, int start) {
		Pattern pattern_hand = Pattern.compile(pf);
		Matcher matcher_hand = pattern_hand.matcher(s);
		int gc = matcher_hand.groupCount();
		int pos = start;
		String sf1 = "";
		String sf2 = "";
		String sf3 = "";
		int if1 = 0;
		String strr = "";
		while (matcher_hand.find(pos)) {
			sf1 = matcher_hand.group();
			if1 = s.indexOf(sf1, pos);
			if (if1 >= pos) {
				strr += s.substring(pos, if1);
				pos = if1 + sf1.length();
				sf2 = pb;
				for (int i = 1; i <= gc; i++) {
					sf3 = "\\" + i;
					sf2 = replaceAll(sf2, sf3, matcher_hand.group(i));
				}
				strr += sf2;
			} else {
				return s;
			}
		}
		strr = s.substring(0, start) + strr;
		return strr;
	}

	/**
	 * 存文本替换
	 * 
	 * @param s
	 *            源字符串
	 * @param sf
	 *            子字符串
	 * @param sb
	 *            替换字符串
	 * @return 替换后的字符串
	 */
	public static String replaceAll(String s, String sf, String sb) {
		int i = 0, j = 0;
		int l = sf.length();
		boolean b = true;
		boolean o = true;
		String str = "";
		do {
			j = i;
			i = s.indexOf(sf, j);
			if (i > j) {
				str += s.substring(j, i);
				str += sb;
				i += l;
				o = false;
			} else {
				str += s.substring(j);
				b = false;
			}
		} while (b);
		if (o) {
			str = s;
		}
		return str;
	}
	
	// 字符串的替换
	public static String replace(String strSource, String strOld, String strNew) {
		if (strSource == null) {
			return null;
		}
		int i = 0;
		if ((i = strSource.indexOf(strOld, i)) >= 0) {
			char[] cSrc = strSource.toCharArray();
			char[] cTo = strNew.toCharArray();
			int len = strOld.length();
			StringBuffer buf = new StringBuffer(cSrc.length);
			buf.append(cSrc, 0, i).append(cTo);
			i += len;
			int j = i;
			while ((i = strSource.indexOf(strOld, i)) > 0) {
				buf.append(cSrc, j, i - j).append(cTo);
				i += len;
				j = i;
			}
			buf.append(cSrc, j, cSrc.length - j);
			return buf.toString();
		}
		return strSource;
	}

	/**
	 * 判断是否与给定字符串样式匹配
	 * 
	 * @param str
	 *            字符串
	 * @param pattern
	 *            正则表达式样式
	 * @return 是否匹配是true,否false
	 */
	public static boolean isMatch(String str, String pattern) {
		Pattern pattern_hand = Pattern.compile(pattern);
		Matcher matcher_hand = pattern_hand.matcher(str);
		boolean b = matcher_hand.matches();
		return b;
	}

	/**
	 * 截取字符串
	 * 
	 * @param s
	 *            源字符串
	 * @param jmp
	 *            跳过jmp
	 * @param sb
	 *            取在sb
	 * @param se
	 *            于se
	 * @return 之间的字符串
	 */
	public static String subStringExe(String s, String jmp, String sb, String se) {
		if (isEmpty(s)) {
			return "";
		}
		int i = s.indexOf(jmp);
		if (i >= 0 && i < s.length()) {
			s = s.substring(i + 1);
		}
		i = s.indexOf(sb);
		if (i >= 0 && i < s.length()) {
			s = s.substring(i + 1);
		}
		if (se == "") {
			return s;
		} else {
			i = s.indexOf(se);
			if (i >= 0 && i < s.length()) {
				s = s.substring(i + 1);
			}
			return s;
		}
	}

	/**
	 * ************************************************************************* 用要通过URL传输的内容进行编码
	 * 
	 * @param 源字符串
	 * @return 经过编码的内容
	 ************************************************************************* 
	 */
	public static String URLEncode(String src) {
		String return_value = "";
		try {
			if (src != null) {
				return_value = URLEncoder.encode(src, "GBK");

			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return_value = src;
		}

		return return_value;
	}

	/**
	 * *************************************************************************
	 * 
	 * @author 李锋 2007.4.18
	 * @param 传入
	 *            &#31119;test&#29031;&#27004;&#65288;&#21271;&#22823;&#38376;&# 24635 ;&#24215;&#65289;&#31119;
	 * @return 经过解码的内容
	 ************************************************************************* 
	 */
	public static String getGBK(String str) {

		return transfer(str);
	}

	public static String transfer(String str) {
		Pattern p = Pattern.compile("&#\\d+;");
		Matcher m = p.matcher(str);
		while (m.find()) {
			String old = m.group();
			str = str.replaceAll(old, getChar(old));
		}
		return str;
	}

	public static String getChar(String str) {
		String dest = str.substring(2, str.length() - 1);
		char ch = (char) Integer.parseInt(dest);
		return "" + ch;
	}

	/**
	 * yahoo首页中切割字符串.
	 * 
	 * @author yxg
	 * @date 2007-09-17
	 * @param str
	 * @return
	 */
	public static String subYhooString(String subject, int size) {
		subject = subject.substring(1, size);
		return subject;
	}

	public static String subYhooStringDot(String subject, int size) {
		subject = subject.substring(1, size) + "...";
		return subject;
	}

	/**
	 * 泛型方法(通用)，把list转换成以“,”相隔的字符串 调用时注意类型初始化（申明类型） 如：List<Integer> intList = new ArrayList<Integer>(); 调用方法：StringUtil.listTtoString(intList); 效率：list中4条信息，1000000次调用时间为850ms左右
	 * 
	 * @author fengliang
	 * @serialData 2008-01-09
	 * @param <T>
	 *            泛型
	 * @param list
	 *            list列表
	 * @return 以“,”相隔的字符串
	 */
	public static <T> String listTtoString(List<T> list) {
		if (list == null || list.size() < 1)
			return "";
		Iterator<T> i = list.iterator();
		if (!i.hasNext())
			return "";
		StringBuilder sb = new StringBuilder();
		for (;;) {
			T e = i.next();
			sb.append(e);
			if (!i.hasNext())
				return sb.toString();
			sb.append(",");
		}
	}

	/**
	 * 把整形数组转换成以“,”相隔的字符串
	 * 
	 * @author fengliang
	 * @serialData 2008-01-08
	 * @param a
	 *            数组a
	 * @return 以“,”相隔的字符串
	 */
	public static String intArraytoString(int[] a) {
		if (a == null)
			return "";
		int iMax = a.length - 1;
		if (iMax == -1)
			return "";
		StringBuilder b = new StringBuilder();
		for (int i = 0;; i++) {
			b.append(a[i]);
			if (i == iMax)
				return b.toString();
			b.append(",");
		}
	}

	/**
	 * 判断文字内容重复
	 * 
	 * @author 沙枣
	 * @Date 2008-04-17
	 */
	public static boolean isContentRepeat(String content) {
		int similarNum = 0;
		int forNum = 0;
		int subNum = 0;
		int thousandNum = 0;
		String startStr = "";
		String nextStr = "";
		boolean result = false;
		float endNum = (float) 0.0;
		if (content != null && content.length() > 0) {
			if (content.length() % 1000 > 0)
				thousandNum = (int) Math.floor(content.length() / 1000) + 1;
			else
				thousandNum = (int) Math.floor(content.length() / 1000);
			if (thousandNum < 3)
				subNum = 100 * thousandNum;
			else if (thousandNum < 6)
				subNum = 200 * thousandNum;
			else if (thousandNum < 9)
				subNum = 300 * thousandNum;
			else
				subNum = 3000;
			for (int j = 1; j < subNum; j++) {
				if (content.length() % j > 0)
					forNum = (int) Math.floor(content.length() / j) + 1;
				else
					forNum = (int) Math.floor(content.length() / j);
				if (result || j >= content.length())
					break;
				else {
					for (int m = 0; m < forNum; m++) {
						if (m * j > content.length() || (m + 1) * j > content.length() || (m + 2) * j > content.length())
							break;
						startStr = content.substring(m * j, (m + 1) * j);
						nextStr = content.substring((m + 1) * j, (m + 2) * j);
						if (startStr.equals(nextStr)) {
							similarNum = similarNum + 1;
							endNum = (float) similarNum / forNum;
							if (endNum > 0.4) {
								result = true;
								break;
							}
						} else
							similarNum = 0;
					}
				}
			}
		}
		return result;
	}

	/**
	 * 判断是否是空字符串 null和"" null返回result,否则返回字符串
	 * 
	 * @param s
	 * @return
	 */
	public static String isEmpty(String s, String result) {
		if (s != null && !s.equals("")) {
			return s;
		}
		return result;
	}

	/**
	 * 判断对象是否为空
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isNotEmpty(Object str) {
		boolean flag = true;
		if (str != null && !str.equals("")) {
			if (str.toString().length() > 0) {
				flag = true;
			}
		} else {
			flag = false;
		}
		return flag;
	}

	/**
	 * 全角字符变半角字符
	 * 
	 * @author shazao
	 * @date 2008-04-03
	 * @param str
	 * @return
	 */
	public static String full2Half(String str) {
		if (str == null || "".equals(str))
			return "";
		StringBuffer sb = new StringBuffer();

		for (int i = 0; i < str.length(); i++) {
			char c = str.charAt(i);

			if (c >= 65281 && c < 65373)
				sb.append((char) (c - 65248));
			else
				sb.append(str.charAt(i));
		}

		return sb.toString();

	}

	/**
	 * 全角括号转为半角
	 * 
	 * @author shazao
	 * @date 2007-11-29
	 * @param str
	 * @return
	 */
	public static String replaceBracketStr(String str) {
		if (str != null && str.length() > 0) {
			str = str.replaceAll("（", "(");
			str = str.replaceAll("）", ")");
		}
		return str;
	}

	/**
	 * 解析字符串返回map键值对(例：a=1&b=2 => a=1,b=2)
	 * 
	 * @param query
	 *            源参数字符串
	 * @param split1
	 *            键值对之间的分隔符（例：&）
	 * @param split2
	 *            key与value之间的分隔符（例：=）
	 * @param dupLink
	 *            重复参数名的参数值之间的连接符，连接后的字符串作为该参数的参数值，可为null null：不允许重复参数名出现，则靠后的参数值会覆盖掉靠前的参数值。
	 * @return map
	 * @author sky
	 */
	@SuppressWarnings("unchecked")
	public static Map<String, String> parseQuery(String query, char split1, char split2, String dupLink) {
		if (!isEmpty(query) && query.indexOf(split2) > 0) {
			Map<String, String> result = new HashMap();

			String name = null;
			String value = null;
			String tempValue = "";
			int len = query.length();
			for (int i = 0; i < len; i++) {
				char c = query.charAt(i);
				if (c == split2) {
					value = "";
				} else if (c == split1) {
					if (!isEmpty(name) && value != null) {
						if (dupLink != null) {
							tempValue = result.get(name);
							if (tempValue != null) {
								value += dupLink + tempValue;
							}
						}
						result.put(name, value);
					}
					name = null;
					value = null;
				} else if (value != null) {
					value += c;
				} else {
					name = (name != null) ? (name + c) : "" + c;
				}
			}

			if (!isEmpty(name) && value != null) {
				if (dupLink != null) {
					tempValue = result.get(name);
					if (tempValue != null) {
						value += dupLink + tempValue;
					}
				}
				result.put(name, value);
			}

			return result;
		}
		return null;
	}

	/**
	 * 将list 用传入的分隔符组装为String
	 * 
	 * @param list
	 * @param slipStr
	 * @return String
	 */
	@SuppressWarnings("unchecked")
	public static String listToStringSlipStr(List list, String slipStr) {
		StringBuffer returnStr = new StringBuffer();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				returnStr.append(list.get(i)).append(slipStr);
			}
		}
		if (returnStr.toString().length() > 0)
			return returnStr.toString().substring(0, returnStr.toString().lastIndexOf(slipStr));
		else
			return "";
	}

	/**
	 * 获取从start开始用*替换len个长度后的字符串
	 * 
	 * @param str
	 *            要替换的字符串
	 * @param start
	 *            开始位置
	 * @param len
	 *            长度
	 * @return 替换后的字符串
	 */
	public static String getMaskStr(String str, int start, int len) {
		if (StringUtil.isEmpty(str)) {
			return str;
		}
		if (str.length() < start) {
			return str;
		}

		// 获取*之前的字符串
		String ret = str.substring(0, start);

		// 获取最多能打的*个数
		int strLen = str.length();
		if (strLen < start + len) {
			len = strLen - start;
		}

		// 替换成*
		for (int i = 0; i < len; i++) {
			ret += "*";
		}

		// 加上*之后的字符串
		if (strLen > start + len) {
			ret += str.substring(start + len);
		}

		return ret;
	}

	/**
	 * 根据传入的分割符号,把传入的字符串分割为List字符串
	 * 
	 * @param slipStr
	 *            分隔的字符串
	 * @param src
	 *            字符串
	 * @return 列表
	 */
	public static List<String> stringToStringListBySlipStr(String slipStr, String src) {

		if (src == null)
			return null;
		List<String> list = new ArrayList<String>();
		String[] result = src.split(slipStr);
		for (int i = 0; i < result.length; i++) {
			list.add(result[i]);
		}
		return list;
	}

	/**
	 * 截取字符串
	 * 
	 * @param str
	 *            原始字符串
	 * @param len
	 *            要截取的长度
	 * @param tail
	 *            结束加上的后缀
	 * @return 截取后的字符串
	 */
	public static String getHtmlSubString(String str, int len, String tail) {
		if (str == null || str.length() <= len) {
			return str;
		}
		int length = str.length();
		char c = ' ';
		String tag = null;
		String name = null;
		int size = 0;
		String result = "";
		boolean isTag = false;
		List<String> tags = new ArrayList<String>();
		int i = 0;
		for (int end = 0, spanEnd = 0; i < length && len > 0; i++) {
			c = str.charAt(i);
			if (c == '<') {
				end = str.indexOf('>', i);
			}

			if (end > 0) {
				// 截取标签
				tag = str.substring(i, end + 1);
				int n = tag.length();
				if (tag.endsWith("/>")) {
					isTag = true;
				} else if (tag.startsWith("</")) { // 结束符
					name = tag.substring(2, end - i);
					size = tags.size() - 1;
					// 堆栈取出html开始标签
					if (size >= 0 && name.equals(tags.get(size))) {
						isTag = true;
						tags.remove(size);
					}
				} else { // 开始符
					spanEnd = tag.indexOf(' ', 0);
					spanEnd = spanEnd > 0 ? spanEnd : n;
					name = tag.substring(1, spanEnd);
					if (name.trim().length() > 0) {
						// 如果有结束符则为html标签
						spanEnd = str.indexOf("</" + name + ">", end);
						if (spanEnd > 0) {
							isTag = true;
							tags.add(name);
						}
					}
				}
				// 非html标签字符
				if (!isTag) {
					if (n >= len) {
						result += tag.substring(0, len);
						break;
					} else {
						len -= n;
					}
				}

				result += tag;
				isTag = false;
				i = end;
				end = 0;
			} else { // 非html标签字符
				len--;
				result += c;
			}
		}
		// 添加未结束的html标签
		for (String endTag : tags) {
			result += "</" + endTag + ">";
		}
		if (i < length) {
			result += tail;
		}
		return result;
	}

	public static String getProperty(String property) {
		if (property.contains("_")) {
			return property.replaceAll("_", "\\.");
		}
		return property;
	}

	/**
	 * 解析前台encodeURIComponent编码后的参数
	 * 
	 * @param encodeURIComponent
	 *            (encodeURIComponent(no))
	 * @return
	 */
	public static String getEncodePra(String property) {
		String trem = "";
		if (isNotEmpty(property)) {
			try {
				trem = URLDecoder.decode(property, "UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		return trem;
	}

	// 判断一个字符串是否都为数字
	public boolean isDigit(String strNum) {
		Pattern pattern = Pattern.compile("[0-9]{1,}");
		Matcher matcher = pattern.matcher((CharSequence) strNum);
		return matcher.matches();
	}

	// 截取数字
	public String getNumbers(String content) {
		Pattern pattern = Pattern.compile("\\d+");
		Matcher matcher = pattern.matcher(content);
		while (matcher.find()) {
			return matcher.group(0);
		}
		return "";
	}

	// 截取非数字
	public String splitNotNumber(String content) {
		Pattern pattern = Pattern.compile("\\D+");
		Matcher matcher = pattern.matcher(content);
		while (matcher.find()) {
			return matcher.group(0);
		}
		return "";
	}

	/**
	 * 判断某个字符串是否存在于数组中
	 * 
	 * @param stringArray
	 *            原数组
	 * @param source
	 *            查找的字符串
	 * @return 是否找到
	 */
	public static boolean contains(String[] stringArray, String source) {
		// 转换为list
		List<String> tempList = Arrays.asList(stringArray);

		// 利用list的包含方法,进行判断
		if (tempList.contains(source)) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * html 必须是格式良好的
	 * @param str
	 * @return
	 * @throws Exception
	 */
	public static String formatHtml(String str) throws Exception {
		Document document = null;
		document = DocumentHelper.parseText(str);

		OutputFormat format = OutputFormat.createPrettyPrint();
		format.setEncoding("utf-8");
		StringWriter writer = new StringWriter();

		HTMLWriter htmlWriter = new HTMLWriter(writer, format);

		htmlWriter.write(document);
		htmlWriter.close();
		return writer.toString();
	}
	
	/**
	 * 首字母大写
	 * @param realName
	 * @return
	 */
	public static String firstUpperCase(String realName) {
		return StringUtils.replaceChars(realName, realName.substring(0, 1),realName.substring(0, 1).toUpperCase());
	}

	/**
	 * 首字母小写
	 * @param realName
	 * @return
	 */
	public static String firstLowerCase(String realName) {
		return StringUtils.replaceChars(realName, realName.substring(0, 1),realName.substring(0, 1).toLowerCase());
	}
	
	/**
	 * 判断这个类是不是java自带的类
	 * @param clazz
	 * @return
	 */
	public static boolean isJavaClass(Class<?> clazz) {
		boolean isBaseClass = false;
		if(clazz.isArray()){
			isBaseClass = false;
		}else if (clazz.isPrimitive()||clazz.getPackage()==null
				|| clazz.getPackage().getName().equals("java.lang")
				|| clazz.getPackage().getName().equals("java.math")
				|| clazz.getPackage().getName().equals("java.util")) {
			isBaseClass =  true;
		}
		return isBaseClass;
	}
	
	/**
	 * 判断这个类是不是java自带的类
	 * @param clazz
	 * @return
	 */
	public static String getEmptyString() {
		return "";
	}
}
