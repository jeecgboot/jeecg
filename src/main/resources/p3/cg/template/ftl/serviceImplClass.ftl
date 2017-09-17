package ${serviceImplPackage};

import javax.annotation.Resource;
import java.util.UUID;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.stereotype.Service;

import ${daoPackage}.${className}Dao;
import ${domainPackage}.${className}Entity;
import ${servicePackage}.${className}Service;

/**
 * 描述：${codeName}
 * @author: ${author}
 * @since：${nowDate}
 * @version:1.0
 */

@Service("${lowerName}Service")
public class ${className}ServiceImpl implements ${className}Service {
	@Resource
	private ${className}Dao ${lowerName}Dao;

	@Override
	public ${className}Entity get(String id) {
		return ${lowerName}Dao.get(id);
	}

	@Override
	public int update(${className}Entity ${lowerName}) {
		return ${lowerName}Dao.update(${lowerName});
	}

	@Override
	public void insert(${className}Entity ${lowerName}) {
		String randomSeed = UUID.randomUUID().toString().replaceAll("-", "").toUpperCase();
		${lowerName}.setId(randomSeed);
		${lowerName}Dao.insert(${lowerName});
		
	}

	@Override
	public MiniDaoPage<${className}Entity> getAll(${className}Entity ${lowerName}, int page, int rows) {
		return ${lowerName}Dao.getAll(${lowerName}, page, rows);
	}

	@Override
	public void delete(String id) {
		${lowerName}Dao.delete(id);
		
	}
	
	@Override
	public void batchDelete(String[] ids) {
		for(int i = 0; i < ids.length; i++) {
			String id = ids[i];
			${lowerName}Dao.deleteById(id);
		}
	}
}
