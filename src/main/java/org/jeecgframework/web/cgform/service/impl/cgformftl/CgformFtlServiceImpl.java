package org.jeecgframework.web.cgform.service.impl.cgformftl;

import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.web.cgform.entity.cgformftl.CgformFtlEntity;
import org.jeecgframework.web.cgform.service.cgformftl.CgformFtlServiceI;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service("cgformFtlService")
@Transactional
public class CgformFtlServiceImpl extends CommonServiceImpl implements CgformFtlServiceI {

    @Override
    public Map<String, Object> getCgformFtlByTableName(String tableName, String ftlVersion) {
        StringBuilder sql = new StringBuilder("");
        sql.append("select ftl.* from cgform_ftl ftl,cgform_head head");
        sql.append(" where ftl.cgform_id=head.id");
        sql.append(" and ftl.ftl_version=? ");
        sql.append(" and head.table_name=? ");
        List<Map<String,Object>> list = this.findForJdbc(sql.toString(), ftlVersion, tableName);
        if(list!=null&&list.size()>0){
            return list.get(0);
        }
        return null;
    }


    /**
	 * 根据tableName获取form模板信息
	 */

	public Map<String,Object> getCgformFtlByTableName(String tableName) {
		StringBuilder sql = new StringBuilder("");
		sql.append("select ftl.* from cgform_ftl ftl,cgform_head head");
		sql.append(" where ftl.cgform_id=head.id");
		sql.append(" and ftl.ftl_status='1'");
		sql.append(" and head.table_name=? ");
		List<Map<String,Object>> list = this.findForJdbc(sql.toString(), tableName);
		if(list!=null&&list.size()>0){
			return list.get(0);
		}
		return null;
	}

	
	public int getNextVarsion(String cgformId) {
		StringBuilder sql = new StringBuilder("");
		sql.append("select (max(ftl_version)+1) as varsion from cgform_ftl");
		sql.append(" where cgform_id = ? ");
		Map<String,Object> map = this.findOneForJdbc(sql.toString(), cgformId);
		if(map!=null){
			int varsion = map.get("varsion")==null?1:Integer.valueOf(map.get("varsion").toString());
			return varsion;
		}
		return 1;
	}

	
	public boolean hasActive(String cgformId) {
		StringBuilder sql = new StringBuilder("");
		sql.append("select * from cgform_ftl");
		sql.append(" where ftl_status = '1' ");
		sql.append(" and cgform_id = ? ");
		Map<String,Object> map = this.findOneForJdbc(sql.toString(), cgformId);
		if(map!=null){
			return true;
		}
		return false;
	}

	@Override
	public String getUserFormFtl(String id) {
		CriteriaQuery cq = new CriteriaQuery(CgformFtlEntity.class);
		cq.eq("cgformId", id);
		cq.eq("ftlStatus", "1");
		cq.add();
		List<CgformFtlEntity> list = this.getListByCriteriaQuery(cq,false);
		if(list.size() == 1){
			return list.get(0).getFtlContent();
		}
		return null;
	}
	
}