

package org.jeecgframework.core.util;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * sql注入处理工具类
 * @author zhoujf
 *
 */
public class SqlInjectionUtil {
	private static final Logger logger = LoggerFactory.getLogger(SqlInjectionUtil.class);
    /**
     * sql注入过滤处理，遇到注入关键字抛异常
     * @param value
     * @return
     */
    public static void filterContent(String value)  {  
        if(value == null || "".equals(value)){  
            return ;  
        }  
        value = value.toLowerCase();//统一转为小写  
//        throw new RuntimeException("值存在sql注入风险："+value);  
//        String xssStr = "and |or |select |update |delete |drop |truncate |%20|=|--|!=";  
        String xssStr = "'|and |exec |insert |select |delete |update |drop |count |chr |mid |master |truncate |char |declare |;|or |+|,";
        String[] xssArr = xssStr.split("\\|");  
        for(int i=0;i<xssArr.length;i++){  
            if(value.indexOf(xssArr[i])>-1){  
            	logger.info("请注意,值可能存在SQL注入风险!---> {}",value);
                throw new RuntimeException("请注意,值可能存在SQL注入风险!--->"+value); 
            }  
        }  
        return ;  
    }  
    
    public static void main(String[] args) {
		String str = "' and";
		filterContent(str);
	}

}
