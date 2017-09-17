package ${serviceImplPackage};

import javax.annotation.Resource;
import java.util.List;
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
		${lowerName}Dao.insert(${lowerName});
		
	}

	@Override
	public MiniDaoPage<${className}Entity> getAll(${className}Entity ${lowerName}, int page, int rows) {
		return ${lowerName}Dao.getAll(${lowerName}, page, rows);
	}

	@Override
	public void delete(${className}Entity ${lowerName}) {
		${lowerName}Dao.delete(${lowerName});
		
	}
	
	@Override
	public List<${className}Entity> getBy${foreignKeyUpper}(String ${foreignKey}) {
		return this.${lowerName}Dao.getBy${foreignKeyUpper}(${foreignKey});
	}
	
	@Override
	public void delBy${foreignKeyUpper}(String ${foreignKey}) {
		this.${lowerName}Dao.delBy${foreignKeyUpper}(${foreignKey});
	}

	@Override
	public void deleteBy${foreignKeyUpper}(String ${foreignKey}) {
		this.${lowerName}Dao.deleteBy${foreignKeyUpper}(${foreignKey});
	}

	@Override
	public Integer getCountBy${foreignKeyUpper}(String ${foreignKey}) {
		return ${lowerName}Dao.getCountBy${foreignKeyUpper}(${foreignKey});
	}
}
