package org.jeecgframework.web.cgform.service.impl.autolist;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.jeecgframework.core.annotation.Ehcache;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.web.cgform.common.CgAutoListConstant;
import org.jeecgframework.web.cgform.entity.button.CgformButtonEntity;
import org.jeecgframework.web.cgform.entity.config.CgFormFieldEntity;
import org.jeecgframework.web.cgform.entity.config.CgFormHeadEntity;
import org.jeecgframework.web.cgform.entity.enhance.CgformEnhanceJsEntity;
import org.jeecgframework.web.cgform.service.autolist.ConfigServiceI;
import org.jeecgframework.web.cgform.service.button.CgformButtonServiceI;
import org.jeecgframework.web.cgform.service.config.CgFormFieldServiceI;
import org.jeecgframework.web.cgform.service.enhance.CgformEnhanceJsServiceI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
/**
 * 
 * @Title:ConfigServiceImpl
 * @description:动态配置服务实现
 * @author 赵俊夫
 * @date Jul 5, 2013 9:35:22 PM
 * @version V1.0
 */
@Service("configService")
@Transactional
public class ConfigServiceImpl implements ConfigServiceI {
	private static Logger log = Logger.getLogger(ConfigServiceImpl.class);
	
	@Autowired
	private CgFormFieldServiceI tablePropertyService;
	@Autowired
	private CgformButtonServiceI cgformButtonService;
	@Autowired
	private CgformEnhanceJsServiceI cgformEnhanceJsService;
	
	/**
	 * tableName 表单名
	 */
	@Ehcache
	public Map<String, Object> queryConfigs(String tableName,String jversion) {
		//step.1 要返回的配置数据
		Map<String, Object> configs = new HashMap<String,Object>();
		//step.2 获取动态表配置
		CgFormHeadEntity tableEntity = null;
		try{
			tableEntity = tablePropertyService.findByProperty(CgFormHeadEntity.class, "tableName", tableName).get(0);
			loadConfigs(configs,tableEntity);
		}catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("没有找到该动态列表");
		}
		return configs;
	}

	private void loadConfigs(Map<String, Object> configs, CgFormHeadEntity tableEntity) {
		//获取动态表明细配置
		List<CgFormFieldEntity> columns = tableEntity.getColumns();
		configs.put(CgAutoListConstant.CONFIG_ID, tableEntity.getTableName());
		configs.put(CgAutoListConstant.CONFIG_NAME, tableEntity.getContent());
		configs.put(CgAutoListConstant.TABLENAME,tableEntity.getTableName());
		configs.put(CgAutoListConstant.CONFIG_ISCHECKBOX,tableEntity.getIsCheckbox());
		configs.put(CgAutoListConstant.CONFIG_ISPAGINATION,tableEntity.getIsPagination());
		configs.put(CgAutoListConstant.CONFIG_ISTREE,tableEntity.getIsTree());
		configs.put(CgAutoListConstant.CONFIG_QUERYMODE,tableEntity.getQuerymode());
		log.info("-- columns -- size--"+columns.size());
		configs.put(CgAutoListConstant.FILEDS,columns);
		configs.put(CgAutoListConstant.CONFIG_VERSION, tableEntity.getJformVersion());
		configs.put(CgAutoListConstant.TREE_PARENTID_FIELDNAME, tableEntity.getTreeParentIdFieldName());
		configs.put(CgAutoListConstant.TREE_ID_FIELDNAME, tableEntity.getTreeIdFieldname());
		configs.put(CgAutoListConstant.TREE_FIELDNAME, tableEntity.getTreeFieldname());
		configs.put(CgAutoListConstant.TABLE_TYPE, tableEntity.getJformType());
		configs.put(CgAutoListConstant.SUB_TABLES, tableEntity.getSubTableStr());
		String formId = tableEntity.getId();
		List<CgformButtonEntity>  buttons = cgformButtonService.getCgformButtonListByFormId(formId);
		configs.put(CgAutoListConstant.CONFIG_BUTTONLIST,buttons.size()>0?buttons:new ArrayList<CgformButtonEntity>(0));
		String jsCode = "";
		CgformEnhanceJsEntity  jsEnhance = cgformEnhanceJsService.getCgformEnhanceJsByTypeFormId("list", formId);
			if(jsEnhance!=null){
			jsCode = jsEnhance.getCgJsStr();
			if(StringUtil.isEmpty(jsCode)){
				jsCode = "";
			}
		}
		configs.put(CgAutoListConstant.CONFIG_JSENHANCE,jsCode);
	}
	
	
}
