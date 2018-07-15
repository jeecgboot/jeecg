package org.jeecgframework.web.system.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.jeecgframework.core.annotation.Ehcache;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.BrowserUtils;
import org.jeecgframework.core.util.ContextHolderUtils;
import org.jeecgframework.core.util.IpUtil;
import org.jeecgframework.core.util.MutiLangUtil;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.web.system.dao.JeecgDictDao;
import org.jeecgframework.web.system.pojo.base.DictEntity;
import org.jeecgframework.web.system.pojo.base.TSDatalogEntity;
import org.jeecgframework.web.system.pojo.base.TSDepartAuthGroupEntity;
import org.jeecgframework.web.system.pojo.base.TSDepartAuthgFunctionRelEntity;
import org.jeecgframework.web.system.pojo.base.TSFunction;
import org.jeecgframework.web.system.pojo.base.TSIcon;
import org.jeecgframework.web.system.pojo.base.TSLog;
import org.jeecgframework.web.system.pojo.base.TSOperation;
import org.jeecgframework.web.system.pojo.base.TSRole;
import org.jeecgframework.web.system.pojo.base.TSRoleFunction;
import org.jeecgframework.web.system.pojo.base.TSRoleOrg;
import org.jeecgframework.web.system.pojo.base.TSRoleUser;
import org.jeecgframework.web.system.pojo.base.TSType;
import org.jeecgframework.web.system.pojo.base.TSTypegroup;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.jeecgframework.web.system.service.CacheServiceI;
import org.jeecgframework.web.system.service.SystemService;
import org.jeecgframework.web.system.util.OrgConstants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

@Service("systemService")
public class SystemServiceImpl extends CommonServiceImpl implements SystemService {
	private static final Logger logger = LoggerFactory.getLogger(SystemServiceImpl.class);
	
	@Autowired
	private JeecgDictDao jeecgDictDao;
	@Autowired
	private CacheServiceI cacheService;

	@Transactional(readOnly = true)
	public TSUser checkUserExits(TSUser user) throws Exception {
		return this.commonDao.getUserByUserIdAndUserNameExits(user);
	}

	@Transactional(readOnly = true)
	public List<DictEntity> queryDict(String dicTable, String dicCode,String dicText){
		List<DictEntity> dictList = null;
		//step.1 如果没有字典表则使用系统字典表
		if(StringUtil.isEmpty(dicTable)){
			dictList = jeecgDictDao.querySystemDict(dicCode);
			for(DictEntity t:dictList){
				t.setTypename(MutiLangUtil.getLang(t.getTypename()));
			}
		}else {
			dicText = StringUtil.isEmpty(dicText, dicCode);
			dictList = jeecgDictDao.queryCustomDict(dicTable, dicCode, dicText);
		}
		return dictList;
	}

	/**
	 * 添加日志
	 */
	public void addLog(String logcontent, Short operatetype, Short loglevel) {
		HttpServletRequest request = ContextHolderUtils.getRequest();
		String broswer = BrowserUtils.checkBrowse(request);
		TSLog log = new TSLog();
		log.setLogcontent(logcontent);
		log.setLoglevel(loglevel);
		log.setOperatetype(operatetype);

		log.setNote(IpUtil.getIpAddr(request));

		log.setBroswer(broswer);
		/*start dangzhenghui 201703016TASK #1784 【online bug】Online 表单保存的时候，报错*/
		log.setOperatetime(new Date());
		/* end dangzhenghui 201703016TASK #1784 【online bug】Online 表单保存的时候，报错*/
//		log.setTSUser(ResourceUtil.getSessionUser());
		/*start chenqian 201708031TASK #2317 【改造】系统日志表，增加两个字段，避免关联查询 [操作人账号] [操作人名字]*/
		TSUser u = ResourceUtil.getSessionUser();
		if(u!=null){
			log.setUserid(u.getId());
			log.setUsername(u.getUserName());
			log.setRealname(u.getRealName());
		}

		commonDao.save(log);
	}

	/**
	 * 根据类型编码和类型名称获取Type,如果为空则创建一个
	 *
	 * @param typecode
	 * @param typename
	 * @return
	 */
	@Transactional(readOnly = true)
	public TSType getType(String typecode, String typename, TSTypegroup tsTypegroup) {
		//TSType actType = commonDao.findUniqueByProperty(TSType.class, "typecode", typecode,tsTypegroup.getId());
		List<TSType> ls = commonDao.findHql("from TSType where typecode = ? and typegroupid = ?",typecode,tsTypegroup.getId());
		TSType actType = null;
		if (ls == null || ls.size()==0) {
			actType = new TSType();
			actType.setTypecode(typecode);
			actType.setTypename(typename);
			actType.setTSTypegroup(tsTypegroup);
			commonDao.save(actType);
		}else{
			actType = ls.get(0);
		}
		return actType;

	}

	/**
	 * 根据类型分组编码和名称获取TypeGroup,如果为空则创建一个
	 *
	 * @param typecode
	 * @param typename
	 * @return
	 */
	@Transactional(readOnly = true)
	public TSTypegroup getTypeGroup(String typegroupcode, String typgroupename) {
		TSTypegroup tsTypegroup = commonDao.findUniqueByProperty(TSTypegroup.class, "typegroupcode", typegroupcode);
		if (tsTypegroup == null) {
			tsTypegroup = new TSTypegroup();
			tsTypegroup.setTypegroupcode(typegroupcode);
			tsTypegroup.setTypegroupname(typgroupename);
			commonDao.save(tsTypegroup);
		}
		return tsTypegroup;
	}

	@Transactional(readOnly = true)
	public TSTypegroup getTypeGroupByCode(String typegroupCode) {
		TSTypegroup tsTypegroup = commonDao.findUniqueByProperty(TSTypegroup.class, "typegroupcode", typegroupCode);
		return tsTypegroup;
	}


	@Transactional(readOnly = true)
	public void initAllTypeGroups() {
		List<TSTypegroup> typeGroups = this.commonDao.loadAll(TSTypegroup.class);
		Map<String, TSTypegroup> typeGroupsList = new HashMap<String, TSTypegroup>();
		Map<String, List<TSType>> typesList = new HashMap<String, List<TSType>>();
		for (TSTypegroup tsTypegroup : typeGroups) {
			tsTypegroup.setTSTypes(null);
			typeGroupsList.put(tsTypegroup.getTypegroupcode().toLowerCase(), tsTypegroup);
			List<TSType> types = this.commonDao.findHql("from TSType where TSTypegroup.id = ? order by orderNum" , tsTypegroup.getId());
			for(TSType t:types){
				t.setTSType(null);
				t.setTSTypegroup(null);
				t.setTSTypes(null);
			}
			typesList.put(tsTypegroup.getTypegroupcode().toLowerCase(), types);
		}
		
		cacheService.put(CacheServiceI.FOREVER_CACHE,ResourceUtil.DICT_TYPE_GROUPS_KEY,typeGroupsList);
		cacheService.put(CacheServiceI.FOREVER_CACHE,ResourceUtil.DICT_TYPES_KEY,typesList);
		
		logger.info("  ------ 初始化字典组 【系统缓存】-----------typeGroupsList-----size: [{}]",typeGroupsList.size());
		logger.info("  ------ 初始化字典 【系统缓存】-----------typesList-----size: [{}]",typesList.size());
	}

	@Transactional(readOnly = true)
	public void refleshTypesCach(TSType type) {
		Map<String, List<TSType>> typesList = null;
		TSTypegroup result = null;
		Object obj = cacheService.get(CacheServiceI.FOREVER_CACHE,ResourceUtil.DICT_TYPES_KEY);
		if(obj!=null){
			typesList = (Map<String, List<TSType>>) obj;
		}else{
			typesList = new HashMap<String, List<TSType>>();
		}
		TSTypegroup tsTypegroup = type.getTSTypegroup();
		TSTypegroup typeGroupEntity = this.commonDao.get(TSTypegroup.class, tsTypegroup.getId());

		List<TSType> tempList = this.commonDao.findHql("from TSType where TSTypegroup.id = ? order by orderNum" , tsTypegroup.getId());
		List<TSType> types = new ArrayList<TSType>();
		for(TSType t:tempList){
			TSType tt = new TSType();
			tt.setTSType(null);
			tt.setTSTypegroup(null);
			tt.setTSTypes(null);
			tt.setId(t.getId());
			tt.setOrderNum(t.getOrderNum());
			tt.setTypecode(t.getTypecode());
			tt.setTypename(t.getTypename());
			types.add(tt);
		}

		typesList.put(typeGroupEntity.getTypegroupcode().toLowerCase(), types);
		cacheService.put(CacheServiceI.FOREVER_CACHE,ResourceUtil.DICT_TYPES_KEY,typesList);
		logger.info("  ------ 重置字典缓存【系统缓存】  ----------- typegroupcode: [{}] ",typeGroupEntity.getTypegroupcode().toLowerCase());
	}

	@Transactional(readOnly = true)
	public void refleshTypeGroupCach() {
		Map<String, TSTypegroup> typeGroupsList = new HashMap<String, TSTypegroup>();
		List<TSTypegroup> typeGroups = this.commonDao.loadAll(TSTypegroup.class);
		for (TSTypegroup tsTypegroup : typeGroups) {
			typeGroupsList.put(tsTypegroup.getTypegroupcode().toLowerCase(), tsTypegroup);
		}
		cacheService.put(CacheServiceI.FOREVER_CACHE,ResourceUtil.DICT_TYPE_GROUPS_KEY,typeGroupsList);
		logger.info("  ------ 重置字典分组缓存&字典缓存【系统缓存】  ------ refleshTypeGroupCach --------  ");
	}
	
	/**
	 * 刷新字典分组缓存&字典缓存
	 */
	@Transactional(readOnly = true)
	public void refreshTypeGroupAndTypes() {
		logger.info("  ------ 重置字典分组缓存&字典缓存【系统缓存】  ------ refreshTypeGroupAndTypes --------  ");
		this.initAllTypeGroups();
	}


	/**
	 * 根据角色ID 和 菜单Id 获取 具有操作权限的按钮Codes
	 * @param roleId
	 * @param functionId
	 * @return
	 */
	@Transactional(readOnly = true)
	public Set<String> getOperationCodesByRoleIdAndFunctionId(String roleId, String functionId) {
		Set<String> operationCodes = new HashSet<String>();
		TSRole role = commonDao.get(TSRole.class, roleId);
		CriteriaQuery cq1 = new CriteriaQuery(TSRoleFunction.class);
		cq1.eq("TSRole.id", role.getId());
		cq1.eq("TSFunction.id", functionId);
		cq1.add();
		List<TSRoleFunction> rFunctions = getListByCriteriaQuery(cq1, false);
		if (null != rFunctions && rFunctions.size() > 0) {
			TSRoleFunction tsRoleFunction = rFunctions.get(0);
			if (null != tsRoleFunction.getOperation()) {
				String[] operationArry = tsRoleFunction.getOperation().split(",");
				for (int i = 0; i < operationArry.length; i++) {
					operationCodes.add(operationArry[i]);
				}
			}
		}
		return operationCodes;
	}	

	
	/**
	 * 获取页面控件权限控制的
	 * JS片段
	 * @param out
	 */
	@Transactional(readOnly = true)
	public String getAuthFilterJS() {
		StringBuilder out = new StringBuilder();
		out.append("<script type=\"text/javascript\">");
		out.append("$(document).ready(function(){");
		if(ResourceUtil.getSessionUser().getUserName().equals("admin")|| !Globals.BUTTON_AUTHORITY_CHECK){
			return "";
		}else{
			HttpServletRequest request = ContextHolderUtils.getRequest();
			Set<String> operationCodes = (Set<String>) request.getAttribute(Globals.OPERATIONCODES);
			if (null!=operationCodes) {
				for (String MyoperationCode : operationCodes) {
					if (oConvertUtils.isEmpty(MyoperationCode))
						break;
					TSOperation operation = this.getEntity(TSOperation.class, MyoperationCode);
					if (operation.getOperationcode().startsWith(".") || operation.getOperationcode().startsWith("#")){
						if (operation.getOperationType().intValue()==Globals.OPERATION_TYPE_HIDE){
							//out.append("$(\""+name+"\").find(\"#"+operation.getOperationcode().replaceAll(" ", "")+"\").hide();");
							out.append("$(\""+operation.getOperationcode().replaceAll(" ", "")+"\").hide();");
						}else {
							//out.append("$(\""+name+"\").find(\"#"+operation.getOperationcode().replaceAll(" ", "")+"\").find(\":input\").attr(\"disabled\",\"disabled\");");
							out.append("$(\""+operation.getOperationcode().replaceAll(" ", "")+"\").attr(\"disabled\",\"disabled\");");
							out.append("$(\""+operation.getOperationcode().replaceAll(" ", "")+"\").find(\":input\").attr(\"disabled\",\"disabled\");");
						}
					}
				}
			}else{
				return "";
			}
			
		}
		out.append("});");
		out.append("</script>");
		return out.toString();
	}
	
	@Transactional(readOnly = true)
	public void flushRoleFunciton(String id, TSFunction newFunction) {
		TSFunction functionEntity = this.getEntity(TSFunction.class, id);
		if (functionEntity.getTSIcon() == null || !StringUtil.isNotEmpty(functionEntity.getTSIcon().getId())) {
			return;
		}
		TSIcon oldIcon = this.getEntity(TSIcon.class, functionEntity.getTSIcon().getId());
		if (!oldIcon.getIconClas().equals(newFunction.getTSIcon().getIconClas())) {
			// 刷新缓存
			HttpSession session = ContextHolderUtils.getSession();
			TSUser user = ResourceUtil.getSessionUser();
			List<TSRoleUser> rUsers = this.findByProperty(TSRoleUser.class, "TSUser.id", user.getId());
			for (TSRoleUser ru : rUsers) {
				TSRole role = ru.getTSRole();
				session.removeAttribute(role.getId());
			}
		}
	}
	
	@Transactional(readOnly = true)
    public String generateOrgCode(String id, String pid) {

        int orgCodeLength = 2; // 默认编码长度
        if ("3".equals(ResourceUtil.getOrgCodeLengthType())) { // 类型2-编码长度为3，如001
            orgCodeLength = 3;
        }


        String  newOrgCode = "";
        if(!StringUtils.hasText(pid)) { // 第一级编码
            String sql = "select max(t.org_code) orgCode from t_s_depart t where t.parentdepartid is null";
            Map<String, Object> pOrgCodeMap = commonDao.findOneForJdbc(sql);
            if(pOrgCodeMap.get("orgCode") != null) {
                String curOrgCode = pOrgCodeMap.get("orgCode").toString();
                newOrgCode = String.format("%0" + orgCodeLength + "d", Integer.valueOf(curOrgCode) + 1);
            } else {
                newOrgCode = String.format("%0" + orgCodeLength + "d", 1);
            }
        } else { // 下级编码
            String sql = "select max(t.org_code) orgCode from t_s_depart t where t.parentdepartid = ?";
            Map<String, Object> orgCodeMap = commonDao.findOneForJdbc(sql, pid);
            if(orgCodeMap.get("orgCode") != null) { // 当前基本有编码时
                String curOrgCode = orgCodeMap.get("orgCode").toString();
                String pOrgCode = curOrgCode.substring(0, curOrgCode.length() - orgCodeLength);
                String subOrgCode = curOrgCode.substring(curOrgCode.length() - orgCodeLength, curOrgCode.length());
                newOrgCode = pOrgCode + String.format("%0" + orgCodeLength + "d", Integer.valueOf(subOrgCode) + 1);
            } else { // 当前级别没有编码时
                String pOrgCodeSql = "select max(t.org_code) orgCode from t_s_depart t where t.id = ?";
                Map<String, Object> pOrgCodeMap = commonDao.findOneForJdbc(pOrgCodeSql, pid);
                String curOrgCode = pOrgCodeMap.get("orgCode").toString();
                newOrgCode = curOrgCode + String.format("%0" + orgCodeLength + "d", 1);
            }
        }

        return newOrgCode;
    }

	@Transactional(readOnly = true)
	public Set<String> getDataRuleIdsByRoleIdAndFunctionId(String roleId,String functionId) {
		Set<String> operationCodes = new HashSet<String>();
		TSRole role = commonDao.get(TSRole.class, roleId);
		CriteriaQuery cq1 = new CriteriaQuery(TSRoleFunction.class);
		cq1.eq("TSRole.id", role.getId());
		cq1.eq("TSFunction.id", functionId);
		cq1.add();
		List<TSRoleFunction> rFunctions = getListByCriteriaQuery(cq1, false);
		if (null != rFunctions && rFunctions.size() > 0) {
			TSRoleFunction tsRoleFunction = rFunctions.get(0);
			if (null != tsRoleFunction.getDataRule()) {
				String[] operationArry = tsRoleFunction.getDataRule().split(",");
				for (int i = 0; i < operationArry.length; i++) {
					operationCodes.add(operationArry[i]);
				}
			}
		}
		return operationCodes;
	}

	/**
	 * 加载所有图标
	 * @return
	 */
	@Transactional(readOnly = true)
	public  void initAllTSIcons() {
		List<TSIcon> list = this.loadAll(TSIcon.class);
		for (TSIcon tsIcon : list) {
			ResourceUtil.allTSIcons.put(tsIcon.getId(), tsIcon);
		}
	}
	/**
	 * 更新图标
	 * @param icon
	 */
	public void upTSIcons(TSIcon icon) {
		ResourceUtil.allTSIcons.put(icon.getId(), icon);
	}
	/**
	 * 更新图标
	 * @param icon
	 */
	public void delTSIcons(TSIcon icon) {
		ResourceUtil.allTSIcons.remove(icon.getId());
	}

	@Override
	public void addDataLog(String tableName, String dataId, String dataContent) {

		int versionNumber = 0;

		Integer integer = null;
		String sql = "select max(VERSION_NUMBER) as mvn from t_s_data_log where TABLE_NAME = ? and DATA_ID = ?";
		Map<String,Object> maxVersion = commonDao.findOneForJdbc(sql, tableName ,dataId);
		if(maxVersion.get("mvn")!=null){
			integer = Integer.parseInt(maxVersion.get("mvn").toString());
		}

		if (integer != null) {
			versionNumber = integer.intValue();
		}

		TSDatalogEntity tsDatalogEntity = new TSDatalogEntity();
		tsDatalogEntity.setTableName(tableName);
		tsDatalogEntity.setDataId(dataId);
		tsDatalogEntity.setDataContent(dataContent);
		tsDatalogEntity.setVersionNumber(versionNumber + 1);
		commonDao.save(tsDatalogEntity);
	}

	/**
	 * 获取二级管理员页面控件权限授权配置【二级管理员后台权限配置功能】
	 * @param groupId 部门角色组ID
	 * @param functionId 选中菜单ID
	 * @Param type 0:部门管理员组/1:部门角色
	 * @return
	 */
	@Override
	@Transactional(readOnly = true)
	public Set<String> getDepartAuthGroupOperationSet(String groupId,String functionId,String type) {
		Set<String> operationCodes = new HashSet<String>();
		TSDepartAuthGroupEntity functionGroup = null;
		if(OrgConstants.GROUP_DEPART_ROLE.equals(type)) {
			TSRole role = commonDao.get(TSRole.class, groupId);
			CriteriaQuery cq1 = new CriteriaQuery(TSRoleFunction.class);
			cq1.eq("TSRole.id", role.getId());
			cq1.eq("TSFunction.id", functionId);
			cq1.add();
			List<TSRoleFunction> functionGroups = getListByCriteriaQuery(cq1, false);
			if (null != functionGroups && functionGroups.size() > 0) {
				TSRoleFunction tsFunctionGroup = functionGroups.get(0);
				if (null != tsFunctionGroup.getOperation()) {
					String[] operationArry = tsFunctionGroup.getOperation().split(",");
					for (int i = 0; i < operationArry.length; i++) {
						operationCodes.add(operationArry[i]);
					}
				}
			}
		} else {
			functionGroup = commonDao.get(TSDepartAuthGroupEntity.class, groupId);
			CriteriaQuery cq1 = new CriteriaQuery(TSDepartAuthgFunctionRelEntity.class);
			cq1.eq("tsDepartAuthGroup.id", functionGroup.getId());
			cq1.eq("tsFunction.id", functionId);
			cq1.add();
			List<TSDepartAuthgFunctionRelEntity> functionGroups = getListByCriteriaQuery(cq1, false);
			if (null != functionGroups && functionGroups.size() > 0) {
				TSDepartAuthgFunctionRelEntity tsFunctionGroup = functionGroups.get(0);
				if (null != tsFunctionGroup.getOperation()) {
					String[] operationArry = tsFunctionGroup.getOperation().split(",");
					for (int i = 0; i < operationArry.length; i++) {
						operationCodes.add(operationArry[i]);
					}
				}
			}
		}
		return operationCodes;
	}

	/**
	 * 获取二级管理员数据权限授权配置【二级管理员后台权限配置功能】
	 * @param groupId 部门角色组ID
	 * @param functionId 选中菜单ID
	 * @Param type  0:部门管理员组/1:部门角色
	 * @return
	 */
	@Override
	@Transactional(readOnly = true)
	public Set<String> getDepartAuthGroupDataRuleSet(String groupId, String functionId,String type) {
		Set<String> dataRuleCodes = new HashSet<String>();
		TSDepartAuthGroupEntity functionGroup = null;
		if(OrgConstants.GROUP_DEPART_ROLE.equals(type)) {
			TSRole role = commonDao.get(TSRole.class, groupId);
			CriteriaQuery cq1 = new CriteriaQuery(TSRoleFunction.class);
			cq1.eq("TSRole.id", role.getId());
			cq1.eq("TSFunction.id", functionId);
			cq1.add();
			List<TSRoleFunction> functionGroups = getListByCriteriaQuery(cq1, false);
			if (null != functionGroups && functionGroups.size() > 0) {
				TSRoleFunction tsFunctionGroup = functionGroups.get(0);
				if (null != tsFunctionGroup.getDataRule()) {
					String[] dataRuleArry = tsFunctionGroup.getDataRule().split(",");
					for (int i = 0; i < dataRuleArry.length; i++) {
						dataRuleCodes.add(dataRuleArry[i]);
					}
				}
			}
		} else {
			functionGroup = commonDao.get(TSDepartAuthGroupEntity.class, groupId);
			CriteriaQuery cq1 = new CriteriaQuery(TSDepartAuthgFunctionRelEntity.class);
			cq1.eq("tsDepartAuthGroup.id", functionGroup.getId());
			cq1.eq("tsFunction.id", functionId);
			cq1.add();
			List<TSDepartAuthgFunctionRelEntity> functionGroups = getListByCriteriaQuery(cq1, false);
			if (null != functionGroups && functionGroups.size() > 0) {
				TSDepartAuthgFunctionRelEntity tsFunctionGroup = functionGroups.get(0);
				if (null != tsFunctionGroup.getDatarule()) {
					String[] dataRuleArry = tsFunctionGroup.getDatarule().split(",");
					for (int i = 0; i < dataRuleArry.length; i++) {
						dataRuleCodes.add(dataRuleArry[i]);
					}
				}
			}
		}
		return dataRuleCodes;
	}

	/**
	 * 【AuthInterceptor】根据用户请求URL，查询数据库中对应的菜单ID
	 */
	@Override
	@Ehcache(cacheName="sysAuthCache")
	public String getFunctionIdByUrl(String url,String menuPath) {
		//查询请求对应的菜单ID
		//解决rest风格下 权限失效问题
		String functionId="";
		String realRequestPath = null;
		if(url.endsWith(".do")||url.endsWith(".action")){
			realRequestPath=menuPath;
		}else {
			realRequestPath=url;
		}
		
		//----自定义表单页面控件权限控制---------------
		if(realRequestPath.indexOf("autoFormController/af/")>-1 && realRequestPath.indexOf("?")!=-1){
			realRequestPath = realRequestPath.substring(0, realRequestPath.indexOf("?"));
		}
		List<TSFunction> functions = this.findByProperty(TSFunction.class, "functionUrl", realRequestPath);
		if (functions.size()>0){
			functionId = functions.get(0).getId();
		}
		logger.debug("-----[ 读取数据库获取访问请求的菜单ID ]-------functionId: "+functionId +"------ url: "+url+"-----menuPath: "+menuPath);
		return functionId;
	}
	
	/**
	 * 【AuthInterceptor】判断用户是否有菜单访问权限
	 * @param requestPath       用户请求URL
	 * @param clickFunctionId   菜单ID(未使用)
	 * @param userid  			用户id
	 * @param orgId   			用户登录机构ID
	 * @return
	 */
	@Ehcache(cacheName="sysAuthCache")
	public boolean loginUserIsHasMenuAuth(String requestPath,String clickFunctionId,String userid,String orgId){
        //step.1 先判断请求是否配置菜单，没有配置菜单默认不作权限控制[注意：这里不限制权限类型菜单]
        String hasMenuSql = "select count(*) from t_s_function where functiontype = 0 and functionurl = ?";
        Long hasMenuCount = this.getCountForJdbcParam(hasMenuSql,requestPath);
    	logger.debug("-----[ 读取数据库判断访问权限 ]-------requestPath----------"+requestPath+"------------hasMenuCount--------"+ hasMenuCount);
        if(hasMenuCount<=0){
        	return true;
        }
        
        //step.2 判断菜单是否有角色权限
        Long authSize = Long.valueOf(0);
		String sql = "SELECT count(*) FROM t_s_function f,t_s_role_function  rf,t_s_role_user ru " +
					" WHERE f.id=rf.functionid AND rf.roleid=ru.roleid AND " +
					"ru.userid=? AND f.functionurl = ?";
		authSize = this.getCountForJdbcParam(sql,userid,requestPath);
		if(authSize <=0){
			//step.3 判断菜单是否有组织机构角色权限
            Long orgAuthSize = Long.valueOf(0);
            String functionOfOrgSql = "SELECT count(*) from t_s_function f, t_s_role_function rf, t_s_role_org ro  " +
                    "WHERE f.ID=rf.functionid AND rf.roleid=ro.role_id " +
                    "AND ro.org_id=? AND f.functionurl = ?";
            orgAuthSize = this.getCountForJdbcParam(functionOfOrgSql,orgId,requestPath);
			return orgAuthSize > 0;
        }else{
			return true;
		}
	}
	
	/**
	 * 【AuthInterceptor】获取登录用户数据权限IDS
	 */
	@Ehcache(cacheName="sysAuthCache")
	@Transactional(readOnly = true)
	public Set<String> getLoginDataRuleIdsByUserId(String userId,String functionId,String orgId) {
		Set<String> dataRuleIds = new HashSet<String>();
		List<TSRoleUser> rUsers = findByProperty(TSRoleUser.class, "TSUser.id", userId);
		for (TSRoleUser ru : rUsers) {
			TSRole role = ru.getTSRole();
			CriteriaQuery cq1 = new CriteriaQuery(TSRoleFunction.class);
			cq1.eq("TSRole.id", role.getId());
			cq1.eq("TSFunction.id", functionId);
			cq1.add();
			List<TSRoleFunction> rFunctions = getListByCriteriaQuery(cq1, false);
			if (null != rFunctions && rFunctions.size() > 0) {
				TSRoleFunction tsRoleFunction = rFunctions.get(0);
				if (oConvertUtils.isNotEmpty(tsRoleFunction.getDataRule())) {
					String[] dataRuleArry = tsRoleFunction.getDataRule().split(",");
					for (int i = 0; i < dataRuleArry.length; i++) {
						dataRuleIds.add(dataRuleArry[i]);
					}
				}
			}
		}

		List<TSRoleOrg> tsRoleOrg = findByProperty(TSRoleOrg.class, "tsDepart.id", orgId);
		for (TSRoleOrg roleOrg : tsRoleOrg) {
			TSRole role = roleOrg.getTsRole();
			CriteriaQuery cq1 = new CriteriaQuery(TSRoleFunction.class);
			cq1.eq("TSRole.id", role.getId());
			cq1.eq("TSFunction.id", functionId);
			cq1.add();
			List<TSRoleFunction> rFunctions = getListByCriteriaQuery(cq1, false);
			if (null != rFunctions && rFunctions.size() > 0) {
				TSRoleFunction tsRoleFunction = rFunctions.get(0);
				if (oConvertUtils.isNotEmpty(tsRoleFunction.getDataRule())) {
					String[] dataRuleArry = tsRoleFunction.getDataRule().split(",");
					for (int i = 0; i < dataRuleArry.length; i++) {
						dataRuleIds.add(dataRuleArry[i]);
					}
				}
			}
		}

		logger.debug("-----[ 读取数据库获取数据权限集合IDS ]-------dataRuleIds: "+dataRuleIds+"--------userId: "+userId+"------functionId: "+ functionId);
		return dataRuleIds;
	}
	
	/**
	 * 【AuthInterceptor】获取登录用户的页面控件权限（表单权限、按钮权限）
	 * {逻辑说明： 查询菜单的页面控件权限，排除授权用户的页面控件权限，剩下未授权的页面控件权限}
	 *  @param userId 		用户ID
	 *  @param functionId 	菜单ID
	 */
	@Override
	@Ehcache(cacheName="sysAuthCache")
	@Transactional(readOnly = true)
	public List<TSOperation> getLoginOperationsByUserId(String userId, String functionId, String orgId) {
		String hql="FROM TSOperation where functionid = ?";
		List<TSOperation> operations = findHql(hql,functionId);
		if(operations == null || operations.size()<1){
			return null;
		}
		List<TSRoleUser> rUsers = findByProperty(TSRoleUser.class, "TSUser.id", userId);
		
		for(TSRoleUser ru : rUsers){
			TSRole role = ru.getTSRole();
			CriteriaQuery cq1 = new CriteriaQuery(TSRoleFunction.class);
			cq1.eq("TSRole.id", role.getId());
			cq1.eq("TSFunction.id", functionId);
			cq1.add();
			List<TSRoleFunction> rFunctions = getListByCriteriaQuery(cq1, false);
			if (null != rFunctions && rFunctions.size() > 0) {
				TSRoleFunction tsRoleFunction = rFunctions.get(0);
				if (oConvertUtils.isNotEmpty(tsRoleFunction.getOperation())) {
					String[] operationArry = tsRoleFunction.getOperation().split(",");
					for (int i = 0; i < operationArry.length; i++) {
						for(int j=0;j<operations.size();j++){
							if(operationArry[i].equals(operations.get(j).getId())){
								operations.remove(j);
								break;
							}
						}
					}
				}
			}
		}

		List<TSRoleOrg> tsRoleOrgs = findByProperty(TSRoleOrg.class, "tsDepart.id", orgId);
		for (TSRoleOrg tsRoleOrg : tsRoleOrgs) {
			TSRole role = tsRoleOrg.getTsRole();
			CriteriaQuery cq1 = new CriteriaQuery(TSRoleFunction.class);
			cq1.eq("TSRole.id", role.getId());
			cq1.eq("TSFunction.id", functionId);
			cq1.add();
			List<TSRoleFunction> rFunctions = getListByCriteriaQuery(cq1, false);
			if (null != rFunctions && rFunctions.size() > 0) {
				TSRoleFunction tsRoleFunction = rFunctions.get(0);
				if (oConvertUtils.isNotEmpty(tsRoleFunction.getOperation())) {
					String[] operationArry = tsRoleFunction.getOperation().split(",");
					for (int i = 0; i < operationArry.length; i++) {
						for (int j = 0; j < operations.size(); j++) {
							if (operationArry[i].equals(operations.get(j).getId())) {
								operations.remove(j);
								break;
							}
						}
					}
				}
			}
		}

		
		logger.debug("-----[ 读取数据库获取操作权限集合operations ]-------operations: "+operations+"-------userId: "+userId+"------functionId: "+ functionId);
		return operations;
	}
}
