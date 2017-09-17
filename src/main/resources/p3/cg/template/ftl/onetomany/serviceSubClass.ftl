package ${servicePackage};

import java.util.List;
import org.jeecgframework.minidao.annotation.Param;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import ${domainPackage}.${className}Entity;

/**
 * 描述：${codeName}
 * @author: ${author}
 * @since：${nowDate}
 * @version:1.0
 */
public interface ${className}Service {
	public ${className}Entity get(String id);

	public int update(${className}Entity ${lowerName});

	public void insert(${className}Entity ${lowerName});

	public MiniDaoPage<${className}Entity> getAll(${className}Entity ${lowerName},int page,int rows);

	public void delete(${className}Entity ${lowerName});
	
	public List<${className}Entity> getBy${foreignKeyUpper}(String ${foreignKey});
	
	public void delBy${foreignKeyUpper}(String ${foreignKey});

	public void deleteBy${foreignKeyUpper}(String ${foreignKey});
	
	public Integer getCountBy${foreignKeyUpper}(String ${foreignKey});
}
