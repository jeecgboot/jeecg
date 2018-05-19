package org.jeecgframework.web.cgform.engine;

import freemarker.cache.TemplateLoader;
import org.jeecgframework.core.util.ContextHolderUtils;
import org.jeecgframework.core.util.LogUtil;
import org.jeecgframework.web.cgform.common.CgAutoListConstant;
import org.jeecgframework.web.cgform.common.FormHtmlUtil;
import org.jeecgframework.web.cgform.entity.config.CgFormFieldEntity;
import org.jeecgframework.web.cgform.entity.config.CgFormHeadEntity;
import org.jeecgframework.web.cgform.entity.template.CgformTemplateEntity;
import org.jeecgframework.web.cgform.service.cgformftl.CgformFtlServiceI;
import org.jeecgframework.web.cgform.service.config.CgFormFieldServiceI;
import org.jeecgframework.web.cgform.service.template.CgformTemplateServiceI;
import org.jeecgframework.web.cgform.util.TemplateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.stereotype.Component;

import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @ClassName: DBTempletLoader
 * @Description: (模板加载处理类)
 * @author zhoujunfeng
 */
@Component("templetLoader")
public class DBTempletLoader implements TemplateLoader {
	
	public static final String TEMPLET = "org/jeecgframework/web/cgform/engine/jform.ftl";
	public static final String TEMPLET_ONE_MANY = "org/jeecgframework/web/cgform/engine/jformunion.ftl";
	//生成输入框匹配内容
	private final static String regEx_attr = "\\#\\{([a-zA-Z_0-9]+)\\}";
	
	@Autowired
	private CgformFtlServiceI cgformFtlService;
	
	@Autowired
	private CgFormFieldServiceI cgFormFieldService;
	@Autowired
	private CgformTemplateServiceI cgformTemplateService;
	
    public Object findTemplateSource(String name) throws IOException {
    	//update by Robin  postgreSQL 修正大小写的问题 2013-03-13
		name = name.replace("_zh_cn", "").replace("_ZH_CN", "").replace("_zh_CN", "");
		name = name.replace("_en_us", "").replace("_EN_US", "").replace("_en_US", "");
		//update by Robin postgreSQL 修正大小写的问题 2013-03-13
    	LogUtil.debug("table name----------->"+name);
        Object obj = getObject(name);
        return obj;
    }

    
    public long getLastModified(Object templateSource) {
        return 0;
    }

    
    public Reader getReader(Object templateSource, String encoding) throws IOException {
    	Reader br = new StringReader("");
    	if (templateSource instanceof InputStreamReader) {
			br = new BufferedReader((InputStreamReader)templateSource);
		} else {
			StringBuilder str = (StringBuilder)templateSource;
			br = new StringReader(str.toString()); 
		}
    	return br;
    }
    
    private Object getObject(String name) throws IOException {

        String ftlVersion = "";
        String ftlVersionParam = "&ftlVersion=";
        if(name.contains(ftlVersionParam)) {
            ftlVersion = name.substring(name.indexOf(ftlVersionParam) + ftlVersionParam.length());
            name = name.substring(0, name.indexOf(ftlVersionParam));
        }

		TemplateUtil.TemplateType templateType= null;
		if(name.lastIndexOf(".ftl")==-1&&name.lastIndexOf("_")!=-1){
			templateType=TemplateUtil.TemplateType.getVal(name.substring(name.lastIndexOf("_")+1));
			name=name.substring(0,name.lastIndexOf("_"));
		}
		if(templateType==null){
			templateType= TemplateUtil.TemplateType.UPDATE;
		}

		
    	PathMatchingResourcePatternResolver patternResolver = new PathMatchingResourcePatternResolver();
    	if(name.lastIndexOf(".ftl")==-1){//判断是否为include的模板
	    	//如果是主表直接走一对多模板
	    	CgFormHeadEntity head = cgFormFieldService.getCgFormHeadByTableName(name);
	    	if(head==null)return null;

			CgformTemplateEntity entity=cgformTemplateService.findByCode(head.getFormTemplate());

			if(head.getJformType()==CgAutoListConstant.JFORM_TYPE_MAIN_TALBE){

				Resource[] resources = patternResolver.getResources(TemplateUtil.getTempletPath(entity, head.getJformType(), templateType));

	    		InputStreamReader inputStreamReader =null;
	    		if (resources != null && resources.length > 0) {
	    			 inputStreamReader = new InputStreamReader(resources[0].getInputStream(),"UTF-8");
	    		}
	    		return inputStreamReader;
			}
	    	//1、根据table name 查询cgformftl 有则获取模板内容
	    	//2、没有cgformftl 则查询cgformfield 根据cgformfield生成模板

	    	Map<String,Object> cgformFtlEntity = new HashMap<String, Object>();
            if (ftlVersion != null && ftlVersion.length() > 0) {
                cgformFtlEntity = cgformFtlService.getCgformFtlByTableName(name, ftlVersion);
            } else {
                cgformFtlEntity = cgformFtlService.getCgformFtlByTableName(name);
            }

            if(cgformFtlEntity!=null){
	    		String content = (String) (cgformFtlEntity.get("ftl_content")==null?"":cgformFtlEntity.get("ftl_content"));
	    		content = initFormHtml( content, name);
//	    		org.jeecgframework.core.util.LogUtil.info(content);
	    		return new StringBuilder(content);
	    	}else{

	    		Resource[] resources = patternResolver.getResources(TemplateUtil.getTempletPath(entity, head.getJformType(),templateType));

				InputStreamReader inputStreamReader =null;
	    		if (resources != null && resources.length > 0) {
	    			 inputStreamReader = new InputStreamReader(resources[0].getInputStream(),"UTF-8");
	    		}
	    		return inputStreamReader;
	    	}
    	}else{
    		Resource[] resources = patternResolver.getResources(name);
    		InputStreamReader inputStreamReader =null;
    		if (resources != null && resources.length > 0) {
    			 inputStreamReader = new InputStreamReader(resources[0].getInputStream(),"UTF-8");
    		}
    		return inputStreamReader;
    	}
    }
    
    
    public void closeTemplateSource(Object templateSource) throws IOException {
      
    }

    /**
     * 获取jform.ftl的路径
     */
//    private  String getFilePath(String fileName){
//		String path = DBTempletLoader.class.getResource("").toString();
//		if (path != null)
//		{
//			String systemType = System.getProperty("os.name");
//			if(systemType.toLowerCase().indexOf("window")!=-1){
//				path = path.substring(6, path.indexOf("WEB-INF") + 8)+"classes/jeecg/cgform/engine/";//window 
//			}else{
//				path = path.substring(5, path.indexOf("WEB-INF") + 8)+"classes/jeecg/cgform/engine/";//linux
//			}
//			try {
//				path = java.net.URLDecoder.decode(path,"UTF-8");
//			} catch (UnsupportedEncodingException e) {
//				e.printStackTrace();
//			}
//			org.jeecgframework.core.util.LogUtil.info("current path :" + path);
//		}
//		return (path + fileName);
//	}
    
    
    private String initFormHtml(String htmlStr,String tableName){
    	Pattern pattern;   
	    Matcher matcher;   
    	try {
    		//根据formid获取所有的CgFormFieldEntity
			Map<String,CgFormFieldEntity> fieldMap = cgFormFieldService.getAllCgFormFieldByTableName(tableName);
			//根据formid获取所有的CgFormFieldEntity
			List<CgFormFieldEntity> hiddenFielList = cgFormFieldService.getHiddenCgFormFieldByTableName(tableName);
			
			//添加input语句
			pattern = Pattern.compile(regEx_attr,Pattern.CASE_INSENSITIVE);   
			matcher = pattern.matcher(htmlStr);   

			StringBuffer sb = new StringBuffer(); 
			String thStr = "";
			String inputStr = "";

			boolean result = matcher.find(); 
			while(result) {
				thStr = matcher.group(1);
				inputStr = "";
				if("jform_hidden_field".equals(thStr)){
					inputStr = getHiddenForm(hiddenFielList);
				}else{
					if(fieldMap.get(thStr)!=null){
						CgFormFieldEntity cgFormFieldEntity = fieldMap.get(thStr);
						if("Y".equals(cgFormFieldEntity.getIsShow())){
							inputStr = FormHtmlUtil.getFormHTML(cgFormFieldEntity);
							inputStr +="<span class=\"Validform_checktip\">&nbsp;</span>";
						}
					}
				}
				matcher.appendReplacement(sb, inputStr); 
				result = matcher.find(); 
			} 
			matcher.appendTail(sb); 
			htmlStr = sb.toString();
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return htmlStr;
    }
    
    private String getHiddenForm(List<CgFormFieldEntity> hiddenFielList){
    	StringBuffer html = new StringBuffer(""); 
    	if(hiddenFielList!=null&&hiddenFielList.size()>0){
    		for(CgFormFieldEntity cgFormFieldEntity:hiddenFielList){
    		      html.append("<input type=\"hidden\" ");
    		      html.append("id=\"").append(cgFormFieldEntity.getFieldName()).append("\" ");
    		      html.append("name=\"").append(cgFormFieldEntity.getFieldName()).append("\" ");
    		      html.append("value=\"\\${").append(cgFormFieldEntity.getFieldName()).append("?if_exists?html}\" ");
    		      html.append("\\/>\r\n");
    		}
    	}
    	return html.toString();
    }


}
