package org.jeecgframework.web.cgform.service.impl.autoform;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.UUID;

import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.constant.DataBaseConstant;
import org.jeecgframework.core.util.DateUtils;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.UUIDGenerator;
import org.jeecgframework.web.cgform.entity.autoform.AutoFormDbEntity;
import org.jeecgframework.web.cgform.entity.autoform.AutoFormEntity;
import org.jeecgframework.web.cgform.exception.BusinessException;
import org.jeecgframework.web.cgform.service.autoform.AutoFormServiceI;
import org.jeecgframework.web.cgform.util.AutoFormTemplateParseUtil;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.UncategorizedSQLException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("autoFormService")
@Transactional(rollbackFor=Exception.class)
public class AutoFormServiceImpl extends CommonServiceImpl implements AutoFormServiceI {

	
 	public <T> void delete(T entity) {
 		super.delete(entity);
 		//执行删除操作配置的sql增强
		this.doDelSql((AutoFormEntity)entity);
 	}
 	
 	public <T> Serializable save(T entity) {
 		Serializable t = super.save(entity);
 		//执行新增操作配置的sql增强
 		this.doAddSql((AutoFormEntity)entity);
 		return t;
 	}
 	
 	public <T> void saveOrUpdate(T entity) {
 		super.saveOrUpdate(entity);
 		//执行更新操作配置的sql增强
 		this.doUpdateSql((AutoFormEntity)entity);
 	}
 	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param id
	 * @return
	 */
 	public boolean doAddSql(AutoFormEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param id
	 * @return
	 */
 	public boolean doUpdateSql(AutoFormEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param id
	 * @return
	 */
 	public boolean doDelSql(AutoFormEntity t){
	 	return true;
 	}
 	
 	/**
	 * 替换sql中的变量
	 * @param sql
	 * @return
	 */
 	public String replaceVal(String sql,AutoFormEntity t){
 		sql  = sql.replace("#{id}",String.valueOf(t.getId()));
 		sql  = sql.replace("#{form_name}",String.valueOf(t.getFormName()));
 		sql  = sql.replace("#{form_desc}",String.valueOf(t.getFormDesc()));
 		sql  = sql.replace("#{form_style_id}",String.valueOf(t.getFormStyleId()));
 		sql  = sql.replace("#{form_content}",String.valueOf(t.getFormContent()));
 		sql  = sql.replace("#{create_name}",String.valueOf(t.getCreateName()));
 		sql  = sql.replace("#{create_by}",String.valueOf(t.getCreateBy()));
 		sql  = sql.replace("#{create_date}",String.valueOf(t.getCreateDate()));
 		sql  = sql.replace("#{update_name}",String.valueOf(t.getUpdateName()));
 		sql  = sql.replace("#{update_by}",String.valueOf(t.getUpdateBy()));
 		sql  = sql.replace("#{update_date}",String.valueOf(t.getUpdateDate()));
 		sql  = sql.replace("#{sys_org_code}",String.valueOf(t.getSysOrgCode()));
 		sql  = sql.replace("#{sys_company_code}",String.valueOf(t.getSysCompanyCode()));
 		sql  = sql.replace("#{UUID}",UUID.randomUUID().toString());
 		return sql;
 	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public void doAddTable(String formName,Map<String, Map<String, Object>> dataMap)
			throws BusinessException {
		//遍历数据源
		if(dataMap!=null){
	        Iterator it=dataMap.entrySet().iterator();
	        while(it.hasNext()){
	        	 Map.Entry entry1=(Map.Entry)it.next();
			     String dsName=(String)entry1.getKey();
			     if(dsName.indexOf("[")!=-1){
			    	 dsName = dsName.substring(0,dsName.indexOf("["));
			     }
			     Map<String, Object> data = (Map<String, Object>)entry1.getValue();
			     //根据formName和dsName查询要填报的表名
			     String hql = "select afd from AutoFormEntity af,AutoFormDbEntity afd " +
			     		"where af.id=afd.autoFormId and af.formName=? and afd.dbName=?";
			     List<AutoFormDbEntity> list=this.findHql(hql, formName,dsName);
			     if(list!=null&&list.size()>0){
			    	 AutoFormDbEntity autoFormDbEntity = list.get(0);
			    	 String tbDbKey = autoFormDbEntity.getTbDbKey();
			    	 if(StringUtil.isNotEmpty(tbDbKey)){
			    		 throw new BusinessException("暂不支持非平台填报数据源");
			    	 }
			    	 String tbDbTableName = autoFormDbEntity.getTbDbTableName();
			    	//系统上下文变量赋值
//			 		fillInsertSysVar(data);
			    	String comma = "";
			 		StringBuffer insertKey = new StringBuffer();
					StringBuffer insertValue = new StringBuffer();
					for (Entry<String, Object> entry2 : data.entrySet()) {
							//插入SQL语法,兼容多数据库,去掉单引号
							insertKey.append(comma  + entry2.getKey());
							if(entry2.getValue()!=null && entry2.getValue().toString().length()>0){
								insertValue.append(comma + ":"+entry2.getKey());
							}else{
								insertValue.append(comma + "null");
							}
							comma = ", ";

					}
					try {
						String sql = "INSERT INTO " + tbDbTableName + " (" + insertKey + ") VALUES (" + insertValue + ")";
						this.executeSqlReturnKey(sql,data);
					} catch (DuplicateKeyException e) {
						throw new BusinessException("数据已存在");
					} catch (UncategorizedSQLException e){
						throw new BusinessException("数据类型转换异常");
					}
			     }
	        }
		}
	}
	
	/**
	 * 插入操作时将系统变量约定的字段赋值
	 * @param data
	 */
	private void fillInsertSysVar(Map<String, Object> data) {
		if(data.containsKey(DataBaseConstant.CREATE_DATE_TABLE)){
			data.put(DataBaseConstant.CREATE_DATE_TABLE, DateUtils.formatDate());
		}
		if(data.containsKey(DataBaseConstant.CREATE_TIME_TABLE)){
			data.put(DataBaseConstant.CREATE_TIME_TABLE, DateUtils.formatTime());
		}
		if(data.containsKey(DataBaseConstant.CREATE_BY_TABLE)){
			data.put(DataBaseConstant.CREATE_BY_TABLE, ResourceUtil.getUserSystemData(DataBaseConstant.SYS_USER_CODE));
		}
		if(data.containsKey(DataBaseConstant.CREATE_NAME_TABLE)){
			data.put(DataBaseConstant.CREATE_NAME_TABLE, ResourceUtil.getUserSystemData(DataBaseConstant.SYS_USER_NAME));
		}
		if(data.containsKey(DataBaseConstant.SYS_COMPANY_CODE_TABLE)){
			data.put(DataBaseConstant.SYS_COMPANY_CODE_TABLE, ResourceUtil.getUserSystemData(DataBaseConstant.SYS_COMPANY_CODE));
		}
		if(data.containsKey(DataBaseConstant.SYS_ORG_CODE_TABLE)){
			data.put(DataBaseConstant.SYS_ORG_CODE_TABLE, ResourceUtil.getUserSystemData(DataBaseConstant.SYS_ORG_CODE));
		}
		if(data.containsKey(DataBaseConstant.SYS_USER_CODE_TABLE)){
			data.put(DataBaseConstant.SYS_USER_CODE_TABLE, ResourceUtil.getUserSystemData(DataBaseConstant.SYS_USER_CODE));
		}
	}
	

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public String doUpdateTable(String formName,
			Map<String, Map<String, Object>> dataMap,Map<String, List<Map<String, Object>>> oldDataMap) throws BusinessException {
		Set<String> listDsName = new HashSet<String>();
		//遍历数据源
		if(dataMap!=null){
	        Iterator it=dataMap.entrySet().iterator();
	        while(it.hasNext()){
	        	 Map.Entry entry1=(Map.Entry)it.next();
			     String dsName=(String)entry1.getKey();
			     String fkid = "";
			     String fkdsid = "";
			     if(dsName.indexOf("[")!=-1){
			    	 dsName = dsName.substring(0,dsName.indexOf("["));
			    	 listDsName.add(dsName);
			    	 Map<String, Object> param = dataMap.get("param");
			    	 fkid = param.get("listctrl_fk_"+dsName)==null?"":(String)param.get("listctrl_fk_"+dsName);
			    	 fkdsid = param.get("listctrl_fkdsid_"+dsName)==null?"":(String)param.get("listctrl_fkdsid_"+dsName);
			     }
			     Map<String, Object> data = (Map<String, Object>)entry1.getValue();
			     //根据formName和dsName查询要填报的表名
			     String hql = "select afd from AutoFormEntity af,AutoFormDbEntity afd " +
		     		"where af.id=afd.autoFormId and af.formName=? and afd.dbName=?";
			     List<AutoFormDbEntity> list=this.findHql(hql, formName,dsName);
			     if(list!=null&&list.size()>0){
			    	 AutoFormDbEntity autoFormDbEntity = list.get(0);
			    	 String tbDbKey = autoFormDbEntity.getTbDbKey();
			    	 if(StringUtil.isNotEmpty(tbDbKey)){
			    		 throw new BusinessException("暂不支持非平台数据源");
			    	 }
			    	 String tbDbTableName = autoFormDbEntity.getTbDbTableName();
			    	//系统上下文变量赋值
//			 		fillInsertSysVar(data);
			    	String id = null;
			    	String comma = "";
			    	StringBuffer updateSqlBuffer = new StringBuffer();
			    	updateSqlBuffer.append("update ").append(tbDbTableName).append(" set ");
			    	StringBuffer insertKey = new StringBuffer();
					StringBuffer insertValue = new StringBuffer();
					for (Entry<String, Object> entry2 : data.entrySet()) {
							//update
							if(entry2.getValue()!=null&&entry2.getValue().toString().length()>0){
								updateSqlBuffer.append(comma).append(entry2.getKey()).append("=:"+entry2.getKey()+" ");
							}else{
								updateSqlBuffer.append(comma).append(entry2.getKey()).append("=null");
							}
							//insert插入SQL语法,兼容多数据库,去掉单引号
							if("id".equalsIgnoreCase(entry2.getKey())){
								id = entry2.getValue()==null?"":(String)entry2.getValue();
								if(id==null||id.toString().equals("")){
									id=UUIDGenerator.generate();
									entry2.setValue(id);
								}
							}
							insertKey.append(comma  + entry2.getKey());
							if(entry2.getValue()!=null && entry2.getValue().toString().length()>0){
								insertValue.append(comma + ":"+entry2.getKey());
							}else if(StringUtil.isNotEmpty(fkid)&&fkid.equalsIgnoreCase(entry2.getKey())){
								insertValue.append(comma + ":"+entry2.getKey());
							}else{
								insertValue.append(comma + "null");
							}
							comma = ", ";
							
					}
					String sql ="";
					//获取原始数据
					boolean isAdd = true;
					List<Map<String, Object>> oldData = oldDataMap.get(dsName);
					for(int i=0;i<oldData.size();i++){
						Map<String, Object> subMap = oldData.get(i);
						 String oid = getId(subMap);
			    		 if(StringUtil.isNotEmpty(id)&&id.equals(oid)){
			    			 isAdd = false;
			    		 }
					}
					if(isAdd){
						if(StringUtil.isNotEmpty(fkid)){
							Map<String, Object> param = dataMap.get("param");
							String fkidValue = "";
							if(StringUtil.isEmpty(fkidValue)){
								fkidValue = getDsPropertyValue(dataMap,fkdsid);
							}
							if(StringUtil.isEmpty(fkidValue)){
								fkidValue = getId(param);
							}
							if(data.get(fkid)==null){
								insertKey.append(",").append(fkid);
								insertValue.append(",").append(":").append(fkid);
							}
							data.put(fkid, fkidValue);
						}
					}
					
					//智能提交数据
					if(isAdd){
						if(id==null||id.toString().equals("")){
							insertKey.append(",").append("id");
							insertValue.append(",").append("'").append(UUIDGenerator.generate()).append("'");
						}
						sql = "INSERT INTO " + tbDbTableName + " (" + insertKey + ") VALUES (" + insertValue + ")";
						this.executeSqlReturnKey(sql,data);
					}else{
						if(id instanceof java.lang.String){
							updateSqlBuffer.append(" where ID='").append(id).append("'");
						}else{
							updateSqlBuffer.append(" where ID=").append(id);
						}
						sql = updateSqlBuffer.toString();
						try {
							this.executeSql(sql,data);
						} catch (UncategorizedSQLException e){
							throw new BusinessException("数据类型转换异常");
						}
					}
			     }
	        }
		}
		//删除操作
		doDeletTable(formName,dataMap,oldDataMap,listDsName);
		String id = "";
		String op = getDsPropertyValue(dataMap,"param.op");
		if(AutoFormTemplateParseUtil.OP_ADD.equals(op)){
			AutoFormEntity autoFormEntity = this.findUniqueByProperty(AutoFormEntity.class, "formName", formName);
			String idkey = autoFormEntity.getMainTableSource()+".id";//getDsPropertyValue(dataMap,"param.idkey");
			id = getDsPropertyValueNoGenerator(dataMap,idkey);
			if(StringUtil.isEmpty(id)){
				throw new BusinessException("主数据源主键获取失败");
			}
		}else{
			id = getDsPropertyValue(dataMap,"param.id");
		}
		return id;
		
	}
	
	private String getDsPropertyValueNoGenerator(Map<String, Map<String, Object>> dataMap,String key){
		String value = "";
		String [] keys = key.split("\\.");
		if(keys.length==2){
			Map<String, Object> data = dataMap.get(keys[0]);
			if(data==null){
				return value;
			}
			Object obj = data.get(keys[1]);
			if(obj==null){
				obj = data.get(keys[1].toUpperCase());
			}
			value = obj==null?"":obj.toString();
		}
		return value;
	}
	
	private String getDsPropertyValue(Map<String, Map<String, Object>> dataMap,String key){
		String value = "";
		String [] keys = key.split("\\.");
		if(keys.length==2){
			Map<String, Object> data = dataMap.get(keys[0]);
			Object obj = data.get(keys[1]);
			if(obj==null||obj.toString().toString().length()<=0){
				value = UUIDGenerator.generate();
				data.put(keys[1], value);
			}else{
				value = obj==null?"":obj.toString();
			}
		}
		return value;
	}
	
	private String getId(Map<String, Object> dateMap){
		String id = "";
		 id = dateMap.get("id")==null?"":(String)dateMap.get("id");
		 if(StringUtil.isEmpty(id)){
			 id = dateMap.get("ID")==null?"":(String)dateMap.get("ID");
		 }
		 return id;
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private void doDeletTable(String formName,
			Map<String, Map<String, Object>> dataMap,Map<String, List<Map<String, Object>>> oldDataMap,Set<String> listDsName) throws BusinessException{
		 Iterator oldit=oldDataMap.entrySet().iterator();
		 while(oldit.hasNext()){
        	 Map.Entry entry1=(Map.Entry)oldit.next();
        	 List<Map<String, Object>> olddata = (List<Map<String, Object>>)entry1.getValue();
        	 //判断是否数据源
        	 String dsName=(String)entry1.getKey();
        	 Map<String, Object> param = dataMap.get("param");
        	 if(!listDsName.contains(dsName)&&param.get("listctrl_fk_"+dsName)==null){
        		 return;
        	 }
        	//根据formName和dsName查询要填报的表名
		     String hql = "select afd from AutoFormEntity af,AutoFormDbEntity afd " +
	     		"where af.id=afd.autoFormId and af.formName=? and afd.dbName=?";
		     List<AutoFormDbEntity> list=this.findHql(hql, formName,dsName);
		     if(list!=null&&list.size()>0){
		    	 AutoFormDbEntity autoFormDbEntity = list.get(0);
		    	 String tbDbKey = autoFormDbEntity.getTbDbKey();
		    	 if(StringUtil.isNotEmpty(tbDbKey)){
		    		 throw new BusinessException("暂不支持非平台数据源");
		    	 }
		    	 String tbDbTableName = autoFormDbEntity.getTbDbTableName();
		    	 for(Map<String, Object> item:olddata){
		    		 String itemId = getId(item);
			    	 if(StringUtil.isEmpty(itemId)){
			    		 continue;
			    	 }
		    		 //判断是否为删除数据 是则删除数据
		    		 isDeleteDate(dsName,tbDbTableName,itemId,dataMap);
		    	 }
		     }
		 }
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private void isDeleteDate(String itemDsName,String tableName,String itemId,Map<String, Map<String, Object>> dataMap){
		boolean exist = false;
		//遍历数据源
		if(dataMap!=null){
	        Iterator it=dataMap.entrySet().iterator();
	        while(it.hasNext()){
	        	 Map.Entry entry1=(Map.Entry)it.next();
			     String dsName=(String)entry1.getKey();
			     boolean listctrflag = false;
			     if(dsName.indexOf("[")!=-1){
			    	 dsName = dsName.substring(0,dsName.indexOf("["));
			    	 listctrflag = true;
			     }
			     if(listctrflag&&itemDsName.equals(dsName)){
			    	 Map<String, Object> data = (Map<String, Object>)entry1.getValue();
			    	 String id = getId(data);
			 		 if(StringUtil.isNotEmpty(itemId)){
			 			if(itemId.equals(id)){
			 				exist = true;
			 			}
			 		 }
			     }
	        }
		}
		if(!exist){
			StringBuffer deleteSqlBuffer = new StringBuffer();
			deleteSqlBuffer.append("delete from ").append(tableName).append(" where ");
			deleteSqlBuffer.append(" ID = '").append(itemId).append("'");
			this.executeSql(deleteSqlBuffer.toString());
		}
	}
	
}