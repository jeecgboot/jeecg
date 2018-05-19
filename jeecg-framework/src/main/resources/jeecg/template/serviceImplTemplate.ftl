package ${bussiPackage}.service.impl.${entityPackage};

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ${bussiPackage}.service.${entityPackage}.${entityName}ServiceI;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;

@Service("${entityName?uncap_first}Service")
@Transactional
public class ${entityName}ServiceImpl extends CommonServiceImpl implements ${entityName}ServiceI {
	
}