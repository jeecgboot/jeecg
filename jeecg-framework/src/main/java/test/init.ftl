package jeecg.system.service.impl;

import org.jeecgframework.web.system.pojo.base.TSFunction;
import org.jeecgframework.web.system.pojo.base.TSIcon;
import org.jeecgframework.web.system.service.RepairService;

import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/** 
 * @Description 修复数据库Service
 * @ClassName: RepairService
 * @author tanghan
 * @date 2013-7-19 下午01:31:00  
 */ 
@Service("repairService")
@Transactional
public class RepairServiceImpl extends CommonServiceImpl implements RepairService{
        
	/** 
	 * @Description  先清空数据库，然后再修复数据库
	 * @author tanghan 2013-7-19  
	 */
	
	public void deleteAndRepair() {
		
	}

	/** 
	 * @Description  修复数据库
	 * @author tanghan 2013-7-19  
	 */
	
		synchronized public void repair() {
		repaireIcon(); //修复图标
		repairAttachment();  //修改附件
		repairDepart();
		repairMenu();// 修复菜单权限【权限控制到菜单级别】
		repairRole();// 修复角色
		repairUser();// 修复用户
//		repairRoleAuth();// 修复角色和权限的关系
//		repairUserRole();// 修复用户和角色的关系
//		repairDict();// 修复字典
//		repairOrg();// 修复组织机构
	}

/** 
	 * @Description 
	 * @author tanghan 2013-7-28  
	 */
	private void repairCgFormField() {
		<#list cghead as hd>
			//表单[${hd.content}] - 字段清单
			CgFormHeadEntity ${hd.tableName} = commonDao.findByProperty(CgFormHeadEntity.class, "tableName", "${hd.tableName}").get(0);
		<#list hd.columns as f>
	        CgFormFieldEntity ${hd.tableName}_${f.fieldName} = new CgFormFieldEntity();
	        ${hd.tableName}_${f.fieldName}.setFieldName("${f.fieldName}");
	        ${hd.tableName}_${f.fieldName}.setTable(${hd.tableName});
	        ${hd.tableName}_${f.fieldName}.setFieldLength(${f.fieldLength});
	        ${hd.tableName}_${f.fieldName}.setIsKey("${f.isKey}");
	        ${hd.tableName}_${f.fieldName}.setIsNull("${f.isNull}");
	        ${hd.tableName}_${f.fieldName}.setIsQuery("${f.isQuery}");
	        ${hd.tableName}_${f.fieldName}.setIsShow("${f.isShow}");
	        ${hd.tableName}_${f.fieldName}.setShowType("${f.showType}");
	        ${hd.tableName}_${f.fieldName}.setLength(${f.length});
	        ${hd.tableName}_${f.fieldName}.setType("${f.type}");
	        ${hd.tableName}_${f.fieldName}.setOrderNum(${f.orderNum});
	        ${hd.tableName}_${f.fieldName}.setPointLength(${f.pointLength});
	        ${hd.tableName}_${f.fieldName}.setQueryMode("${f.queryMode}");
	        ${hd.tableName}_${f.fieldName}.setContent("${f.content}");
	        ${hd.tableName}_${f.fieldName}.setCreateBy("admin");
	        ${hd.tableName}_${f.fieldName}.setCreateDate(new Date());
	        ${hd.tableName}_${f.fieldName}.setCreateName("管理员");
	        ${hd.tableName}_${f.fieldName}.setDictField("${f.dictField}");
	        ${hd.tableName}_${f.fieldName}.setDictTable("${f.dictTable}");
	        ${hd.tableName}_${f.fieldName}.setMainTable("${f.mainTable}");
	        ${hd.tableName}_${f.fieldName}.setMainField("${f.mainField}");
	        commonDao.saveOrUpdate(${hd.tableName}_${f.fieldName});
	        
        </#list>
	  	</#list>
	}


    	/** 
	 * @Description 
	 * @author tanghan 2013-7-28  
	 */
	private void repairFormHead() {
	  <#list cghead as hd>
	 	CgFormHeadEntity cgHead${hd.id}  = new CgFormHeadEntity();
		cgHead${hd.id}.setTableName("${hd.tableName}");
		cgHead${hd.id}.setIsTree("${hd.isTree}");
		cgHead${hd.id}.setIsPagination("${hd.isPagination}");
		cgHead${hd.id}.setIsCheckbox("${hd.isCheckbox}");
		cgHead${hd.id}.setQuerymode("${hd.querymode}");
		cgHead${hd.id}.setIsDbSynch("N");
		cgHead${hd.id}.setContent("${hd.content}");
		cgHead${hd.id}.setCreateBy("admin");
		cgHead${hd.id}.setCreateDate(new Date());
		cgHead${hd.id}.setJsPlugIn("0");
		cgHead${hd.id}.setSqlPlugIn("0");
		cgHead${hd.id}.setCreateName("管理员");
		cgHead${hd.id}.setJformVersion("${hd.jformVersion}");
		cgHead${hd.id}.setJformType(${hd.jformType});
		commonDao.saveOrUpdate(cgHead${hd.id});
		
	   </#list>
	}

		/** 
		 * @Description 
		 * @author tanghan 2013-7-28  
		 */
		private void repairCkEditor() {
		}
 

    /** 
	 * @Description 
	 * @author tanghan 2013-7-28  
	 */
	private void repairLog() {
		TSUser admin = commonDao.findByProperty(TSUser.class, "signatureFile", "images/renfang/qm/licf.gif").get(0);
		try {
        <#list log as ll>
          TSLog log${ll.id} = new TSLog();
          log${ll.id}.setLogcontent("${ll.logcontent}");
          log${ll.id}.setBroswer("${ll.broswer}");
          log${ll.id}.setNote("${ll.note}");
          log${ll.id}.setTSUser(admin);
          log${ll.id}.setOperatetime(DataUtils.parseTimestamp("${ll.operatetime}", "yyyy-MM-dd HH:mm"));
          log${ll.id}.setOperatetype((short)${ll.operatetype});
          log${ll.id}.setLoglevel((short)${ll.loglevel});
          commonDao.saveOrUpdate(log${ll.id});
          
        </#list>
        } catch (ParseException e) {
			e.printStackTrace();
		}
	}

    /** 
	 * @Description 
	 * @author tanghan 2013-7-22  
	 */
	private void repairBaseUser() {
		TSDepart eiu = commonDao.findByProperty(TSDepart.class, "departname", "信息部").get(0);
		TSDepart RAndD = commonDao.findByProperty(TSDepart.class, "departname", "信息部").get(0);
	 <#list baseuser as bb>
        TSBaseUser tsBaseUser${bb.id} = new TSBaseUser();
        tsBaseUser${bb.id}.setStatus((short)${bb.status});
        tsBaseUser${bb.id}.setRealName("${bb.realName}");
        tsBaseUser${bb.id}.setUserName("${bb.userName}");
        tsBaseUser${bb.id}.setPassword("${bb.password}");
        tsBaseUser${bb.id}.setTSDepart(eiu);
        tsBaseUser${bb.id}.setActivitiSync((short)${bb.activitiSync});
        commonDao.saveOrUpdate(tsBaseUser${bb.id});
        
      </#list>
	}
 

    /** 
	 * @Description 
	 * @author tanghan 2013-7-22  
	 */
	private void repairType() {
	  <#list type as t>
         TSType type${t.id} = new TSType();
         type${t.id}.setTypename("${t.typename}");
         type${t.id}.setTypecode("${t.typecode}");
         commonDao.saveOrUpdate(type${t.id});
         
      </#list>
	}

	private void repairTypeAndGroup() {
	  <#list typegroup as p>
		TSTypegroup tsTypegroup${p.id} = new TSTypegroup();
		tsTypegroup${p.id}.setTypegroupname("${p.typegroupname}");
		tsTypegroup${p.id}.setTypegroupcode("${p.typegroupcode}");
		commonDao.saveOrUpdate(tsTypegroup${p.id});
	   </#list>
	}
	 
	/** 
	 * @Description 
	 * @author tanghan 2013-7-20  
	 */
	private void repairUser() {
	 <#list suser as pp>
       TSUser suser${pp.id} = new TSUser();
       suser${pp.id}.setMobilePhone("${pp.mobilePhone}");
       suser${pp.id}.setOfficePhone("${pp.officePhone}");
       suser${pp.id}.setEmail("${pp.email}");
       commonDao.saveOrUpdate(suser${pp.id});
      </#list>
	}
	 
	/** 
	 * @Description 
	 * @author tanghan 2013-7-20  
	 */
	  	
	private void repairRole() {
	  <#list role as p>
		TSRole tsRole${p.id} = new TSRole();
        tsRole${p.id}.setRoleName("${p.roleName}");
		tsRole${p.id}.setRoleCode("${p.roleCode}");
		commonDao.saveOrUpdate(tsRole${p.id});
      </#list>
	}

	 
	/** 
	 * @Description 
	 * @author tanghan 2013-7-20  
	 */
	private void repairDepart() {
	  <#list depart as po>
		TSDepart tsDepart${po.id} = new TSDepart();
	    tsDepart${po.id}.setDepartname("${po.departname}");
	    tsDepart${po.id}.setDescription("${po.description}");
        commonDao.saveOrUpdate(tsDepart${po.id});	
      </#list>	
	}

	 
	/** 
	 * @Description 
	 * @author tanghan 2013-7-20  
	 */
	  	
	private void repareAttachment() {
       <#list animals as being>
         TSAttachment tsAttachment${being.id}  = new TSAttachment();
         tsAttachment${being.id}.setAttachmenttitle("${being.attachmenttitle}");
         tsAttachment${being.id}.setRealpath("${being.realpath}");
         tsAttachment${being.id}.setSwfpath("${being.swfpath}");
         tsAttachment${being.id}.setExtend("${being.extend}");
         commonDao.saveOrUpdate(tsAttachment${being.id});
        </#list>
	}


	/** 
	 * @Description 
	 * @author tanghan 2013-7-19  
	 */
	private void repaireIcon() {
		System.out.println("修复图标中");
		TSIcon back = new TSIcon();
		back.setIconName("返回");
		back.setIconType((short)1);
		back.setIconPath("plug-in/accordion/images/back.png");
        back.setIconClas("back");	
        back.setExtend("png");
        commonDao.saveOrUpdate(back);
        
        TSIcon pie = new TSIcon();
        
        pie.setIconName("饼图");
        pie.setIconType((short)1);
        pie.setIconPath("plug-in/accordion/images/pie.png");
        pie.setIconClas("pie");	
        pie.setExtend("png");
        commonDao.saveOrUpdate(pie);
        
        TSIcon pictures = new TSIcon();
        pictures.setIconName("图片");
        pictures.setIconType((short)1);
        pictures.setIconPath("plug-in/accordion/images/pictures.png");
        pictures.setIconClas("pictures");	
        pictures.setExtend("png");
        commonDao.saveOrUpdate(pictures);
        
        TSIcon pencil = new TSIcon();
        pencil.setIconName("笔");
        pencil.setIconType((short)1);
        pencil.setIconPath("plug-in/accordion/images/pencil.png");
        pencil.setIconClas("pencil");	
        pencil.setExtend("png");
        commonDao.saveOrUpdate(pencil);
        
        TSIcon map = new TSIcon();
        map.setIconName("地图");
        map.setIconType((short)1);
        map.setIconPath("plug-in/accordion/images/map.png");
        map.setIconClas("map");	
        map.setExtend("png");
        commonDao.saveOrUpdate(map);
        
        TSIcon group_add = new TSIcon();
        group_add.setIconName("组");
        group_add.setIconType((short)1);
        group_add.setIconPath("plug-in/accordion/images/group_add.png");
        group_add.setIconClas("group_add");	
        group_add.setExtend("png");
        commonDao.saveOrUpdate(group_add);
        
        TSIcon calculator = new TSIcon();
        calculator.setIconName("计算器");
        calculator.setIconType((short)1);
        calculator.setIconPath("plug-in/accordion/images/calculator.png");
        calculator.setIconClas("calculator");	
        calculator.setExtend("png");
        commonDao.saveOrUpdate(calculator);
        
        TSIcon folder = new TSIcon();
        folder.setIconName("文件夹");
        folder.setIconType((short)1);
        folder.setIconPath("plug-in/accordion/images/folder.png");
        folder.setIconClas("folder");	
        folder.setExtend("png");
        commonDao.saveOrUpdate(folder);
	}

	/** 
	 * @Description 修复菜单权限
	 * @author tanghan 2013-7-19  
	 */
	  	
	private void repairMenu() {
	  <#list menu as mm>
 		TSFunction tsFunction${mm.id} = new TSFunction();
		tsFunction${mm.id}.setFunctionName("${mm.functionName}");
		tsFunction${mm.id}.setFunctionUrl("${mm.functionUrl}");
		tsFunction${mm.id}.setFunctionLevel((short)${mm.functionLevel});
		tsFunction${mm.id}.setFunctionOrder("${mm.functionOrder}");
        commonDao.saveOrUpdate(tsFunction${mm.id});	
      </#list>	
		
	}
	 

}
