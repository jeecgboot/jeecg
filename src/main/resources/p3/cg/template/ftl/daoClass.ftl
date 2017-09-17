package ${daoPackage};

import org.jeecgframework.minidao.annotation.Param;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.annotation.Sql;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.springframework.stereotype.Repository;

import ${domainPackage}.${className}Entity;

/**
 * 描述：${codeName}
 * @author：${author}
 * @since：${nowDate}
 * @version:1.0
 */
@Repository
public interface ${className}Dao{

    /**
	 * 查询返回Java对象
	 * @param id
	 * @return
	 */
	@Sql("SELECT * FROM ${tableName} WHERE ID = :id")
	${className}Entity get(@Param("id") String id);
	
	/**
	 * 修改数据
	 * @param ${lowerName}
	 * @return
	 */
	int update(@Param("${lowerName}") ${className}Entity ${lowerName});
	
	/**
	 * 插入数据
	 * @param act
	 */
	void insert(@Param("${lowerName}") ${className}Entity ${lowerName});
	
	/**
	 * 通用分页方法，支持（oracle、mysql、SqlServer、postgresql）
	 * @param ${lowerName}
	 * @param page
	 * @param rows
	 * @return
	 */
	@ResultType(${className}Entity.class)
	public MiniDaoPage<${className}Entity> getAll(@Param("${lowerName}") ${className}Entity ${lowerName},@Param("page")  int page,@Param("rows") int rows);
	
	@Sql("DELETE from ${tableName} WHERE ID = :id")
	public void delete(@Param("id") String id);
	
	/**
	 * 根据ID删除
	 * @param id
	 */
	 @Sql("DELETE from ${tableName} WHERE ID = :id")
	 public void deleteById(@Param("id") String id);
	
}

