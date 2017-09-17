package ${servicePackage};

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
	
}
