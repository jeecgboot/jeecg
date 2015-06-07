package org.jeecgframework.web.cgform.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.jeecgframework.web.cgform.exception.BusinessException;

/**   
 * @author 张代浩
 * @date 2013-08-11 09:47:30
 * @version V1.0   
 */
public class CommUtils {
	
	
	/**
	 * 排除相应名称的属性，返回剩余属性键对
	 * String filterName[]={"name1","name2","name3"};
	 * @param filterName
	 * @return
	 */
    @SuppressWarnings("unchecked")
	public static Map attributeMapFilter(Map map,String[] filterName)
    {
      for(int i=0;i<filterName.length;i++)
      {
       if(map.containsKey(filterName[i]))map.remove(filterName[i]);
      }
      return map;
    }
    
    @SuppressWarnings("unchecked")
	public static Map<String,Object> mapConvert(Map map) {
    	Map<String,Object> dataMap= new HashMap<String, Object>(0);
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
                dataMap.put(key, keyval);
	        }
        }
        return dataMap;
    }
    
    @SuppressWarnings("unchecked")
	public static Map<String,List<Map<String,Object>>> mapConvertMore(Map map,String tableName) {
    	Map<String,List<Map<String,Object>>> fanalMap = new HashMap<String, List<Map<String,Object>>>();
    	Map<String,Map<String,Object>> dataMap= new HashMap<String, Map<String,Object>>(0);
    	Map<String,Object> mapField = null;
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
                String keyArr[] = key.split("\\.");
                mapField =  new HashMap<String, Object>(0);
                if(keyArr.length==1){
                	if(dataMap.get(tableName)!=null){
                		mapField = dataMap.get(tableName);
                	}
                	mapField.put(keyArr[0], keyval);
                	dataMap.put(tableName, mapField);
                }else if(keyArr.length==2){
                	if(dataMap.get(keyArr[0])!=null){
                		mapField = dataMap.get(keyArr[0]);
                	}
                	mapField.put(keyArr[1], keyval);
                	dataMap.put(keyArr[0], mapField);
                }
	        }
        }
        List<Map<String,Object>> listField = null;
        if(dataMap.size()>0){
        	Iterator it=dataMap.entrySet().iterator();
        	while(it.hasNext()){
        		Map.Entry entry=(Map.Entry)it.next();
        		String ok=(String)entry.getKey();
        		Map<String,Object> ov=(Map<String,Object>)entry.getValue();
        		listField = new ArrayList<Map<String,Object>>();
        		if(ok.indexOf("[")!=-1){
        			ok = ok.substring(0,ok.indexOf("["));
        		}
        		if(fanalMap.get(ok)!=null){
    				listField = fanalMap.get(ok);
    			}
    			listField.add(ov);
    			fanalMap.put(ok, listField);
        		
        	}
        }
        return fanalMap;
    }
    

    public static Map<String,Object> convertFKMap(Map<String, Object> fieldMap,Map<String, Object> mainMap,List<Map<String, Object>> fkFieldList) throws BusinessException {
    	if(fkFieldList!=null){
    		for(Map<String, Object> fkField:fkFieldList){
    			if(mainMap.get((String)fkField.get("main_field"))!=null){
    				fieldMap.put((String)fkField.get("field_name"), mainMap.get((String)fkField.get("main_field")));
    			}else{
    				throw new BusinessException("表单中没有外键："+(String)fkField.get("main_field"));
    			}
    		}
    	}
        return fieldMap;
    }
    
    public static void main(String[] args) {
    	String str = "jform_tbd[0].name";
    	String strs [] = str.split("\\.");
    	org.jeecgframework.core.util.LogUtil.info(strs.length+"");
    	org.jeecgframework.core.util.LogUtil.info(strs[0].substring(0,strs[0].indexOf("[")));
	}
}
