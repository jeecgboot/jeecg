package org.jeecgframework.web.cgform.util;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.apache.log4j.Logger;



public class AutoFormCommUtil {
	
	private static final Logger logger = Logger.getLogger(AutoFormCommUtil.class);
	
	@SuppressWarnings("rawtypes")
	public static Map<String,Map<String,Object>> mapConvert(Map map) {
		Map<String,Map<String,Object>> dataMap = new HashMap<String, Map<String,Object>>();
    	Map<String,Object> subDataMap= null;
        if(map!=null){
	        Iterator it=map.entrySet().iterator();
	        while(it.hasNext()){
		        Map.Entry entry=(Map.Entry)it.next();
		        Object ok=entry.getKey();
		        Object ov=entry.getValue()==null?"":entry.getValue();
		        String key=ok.toString();
		        String keyval="";
		        String[] value=new String[1];
                if(ov instanceof String[]){
                    value=(String[])ov;
                }else{
                    value[0]=ov.toString();
                }
                keyval+=value[0];
                for(int k=1;k<value.length;k++){
                    keyval+=","+value[k];
                }
                String [] keys = key.split("\\.");
                if(keys.length==2){
                	String index = "";
                	if(keys[1].indexOf("[")!=-1){
                		index = keys[1].substring(keys[1].indexOf("["));
                		keys[0] = keys[0]+index;
                		keys[1] = keys[1].substring(0,keys[1].indexOf("["));
                	}
                	subDataMap = dataMap.get(keys[0]);
                	if(subDataMap!=null){
                		subDataMap.put(keys[1], keyval);
                	}else{
                		subDataMap= new HashMap<String, Object>();
                		subDataMap.put(keys[1], keyval);
                		dataMap.put(keys[0], subDataMap);
                	}
                	logger.info("ds:"+keys[0]+";name:"+keys[1]+";value:"+keyval);
                }else{
                	String paramKey = "param";
                	subDataMap = dataMap.get(paramKey);
                	if(subDataMap!=null){
                		subDataMap.put(keys[0], keyval);
                	}else{
                		subDataMap= new HashMap<String, Object>();
                		subDataMap.put(keys[0], keyval);
                		dataMap.put(paramKey, subDataMap);
                	}
                	logger.info("ds:"+paramKey+";name:"+keys[0]+";value:"+keyval);
                }
                
	        }
        }
        return dataMap;
    }

}
