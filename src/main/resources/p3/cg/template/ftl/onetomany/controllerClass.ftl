package ${controllerPackage};

import java.util.UUID;
import java.util.List;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import org.apache.commons.lang.StringUtils;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.velocity.VelocityContext;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.jeecgframework.p3.core.common.utils.AjaxJson;
import org.jeecgframework.p3.core.page.SystemTools;
import org.jeecgframework.p3.core.util.plugin.ViewVelocity;
import org.jeecgframework.p3.core.web.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import ${domainPackage}.${className}Entity;
import ${pagePackage}.${className}Page;
import ${servicePackage}.${className}Service;
<#list subEntityList as sub>
import ${sub.paramData.domainPackage}.${sub.paramData.className}Entity;
import ${sub.paramData.servicePackage}.${sub.paramData.className}Service;
</#list>
 /**
 * 描述：${codeName}
 * @author: ${author}
 * @since：${nowDate}
 * @version:1.0
 */
@Controller
@RequestMapping("/${projectName}/${lowerName}")
public class ${className}Controller extends BaseController{
  @Autowired
  private ${className}Service ${lowerName}Service;
  <#list subEntityList as sub>
  @Autowired
  private ${sub.paramData.className}Service ${sub.paramData.lowerName}Service;
  </#list>
	/**
	  * 列表页面
	  * @return
	  */
	@RequestMapping(params = "list",method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute ${className}Entity query,HttpServletRequest request,HttpServletResponse response,
			@RequestParam(required = false, value = "pageNo", defaultValue = "1") int pageNo,
			@RequestParam(required = false, value = "pageSize", defaultValue = "10") int pageSize) throws Exception{
			try {
			 	LOG.info(request, " back list");
			 	//分页数据
				MiniDaoPage<${className}Entity> list =  ${lowerName}Service.getAll(query,pageNo,pageSize);
				VelocityContext velocityContext = new VelocityContext();
				velocityContext.put("${lowerName}",query);
				velocityContext.put("pageInfos",SystemTools.convertPaginatedList(list));
				String viewName = "${projectName}/${bussPackage}/${lowerName}-list.vm";
				ViewVelocity.view(request,response,viewName,velocityContext);
			} catch (Exception e) {
			e.printStackTrace();
			}
}

	 /**
	  * 详情
	  * @return
	  */
	@RequestMapping(params="toDetail",method = RequestMethod.GET)
	public void ${lowerName}Detail(@RequestParam(required = true, value = "id" ) String id,HttpServletResponse response,HttpServletRequest request)throws Exception{
			VelocityContext velocityContext = new VelocityContext();
			String viewName = "${projectName}/${bussPackage}/${lowerName}-detail.vm";
			${className}Entity ${lowerName} = ${lowerName}Service.get(id);
			velocityContext.put("${lowerName}",${lowerName});
			<#list subEntityList as sub>
			List<${sub.paramData.className}Entity> ${sub.paramData.lowerName}Entities = this.${sub.paramData.lowerName}Service.getBy${sub.paramData.foreignKeyUpper}(${lowerName}.get${sub.paramData.mainForeignKeyUpper}());	
			velocityContext.put("${sub.paramData.lowerName}Entities", ${sub.paramData.lowerName}Entities);
			</#list>
			ViewVelocity.view(request,response,viewName,velocityContext);
	}

	/**
	 * 跳转到添加页面
	 * @return
	 */
	@RequestMapping(params = "toAdd",method ={RequestMethod.GET, RequestMethod.POST})
	public void toAddDialog(HttpServletRequest request,HttpServletResponse response)throws Exception{
		 VelocityContext velocityContext = new VelocityContext();
		 String viewName = "${projectName}/${bussPackage}/${lowerName}-add.vm";
		 ViewVelocity.view(request,response,viewName,velocityContext);
	}

	/**
	 * 保存信息
	 * @return
	 */
	@RequestMapping(params = "doAdd",method ={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public AjaxJson doAdd(@ModelAttribute ${className}Entity ${lowerName},
			@ModelAttribute ${className}Page ${lowerName}Page){
		AjaxJson j = new AjaxJson();
		try {
			
			<#list subEntityList as sub>
			List<${sub.paramData.className}Entity> ${sub.paramData.lowerName}Entities = ${lowerName}Page.get${sub.paramData.className}Entities();
			if(${sub.paramData.lowerName}Entities.size() <= 0){
				j.setMsg("请至少添加一个${sub.paramData.codeName}详情");
				j.setSuccess(false);
				return j;
			}
			</#list>
		    String randomSeed = UUID.randomUUID().toString().replaceAll("-", "").toUpperCase();
		    ${lowerName}.setId(randomSeed);
			${lowerName}Service.insert(${lowerName});
			
			<#list subEntityList as sub>
			for (${sub.paramData.className}Entity entity : ${sub.paramData.lowerName}Entities) {
				randomSeed = UUID.randomUUID().toString().replaceAll("-", "").toUpperCase();
				entity.setId(randomSeed);
				if(StringUtils.isEmpty(${lowerName}.getGoOrderCode())){
			    	j.setMsg("关联外键不能为空");
					j.setSuccess(false);
					return j;
			    }
				entity.set${sub.paramData.foreignKeyUpper}(${lowerName}.get${sub.paramData.mainForeignKeyUpper}());
				${sub.paramData.lowerName}Service.insert(entity);
			}
			</#list>
			j.setMsg("保存成功");
		} catch (Exception e) {
		    log.info(e.getMessage());
			j.setSuccess(false);
			j.setMsg("保存失败");
		}
		return j;
	}

	/**
	 * 跳转到编辑页面
	 * @return
	 */
	@RequestMapping(params="toEdit",method = RequestMethod.GET)
	public void toEdit(@RequestParam(required = true, value = "id" ) String id,HttpServletResponse response,HttpServletRequest request) throws Exception{
			 VelocityContext velocityContext = new VelocityContext();
			 ${className}Entity ${lowerName} = ${lowerName}Service.get(id);
			 velocityContext.put("${lowerName}",${lowerName});
			 <#list subEntityList as sub>
			 List<${sub.paramData.className}Entity> ${sub.paramData.lowerName}Entities = this.${sub.paramData.lowerName}Service.getBy${sub.paramData.foreignKeyUpper}(${lowerName}.get${sub.paramData.mainForeignKeyUpper}());	
			 velocityContext.put("${sub.paramData.lowerName}Entities", ${sub.paramData.lowerName}Entities);
			 </#list>
			 String viewName = "${projectName}/${bussPackage}/${lowerName}-edit.vm";
			 ViewVelocity.view(request,response,viewName,velocityContext);
	}

	/**
	 * 编辑
	 * @return
	 */
	@RequestMapping(params = "doEdit",method ={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public AjaxJson doEdit(@ModelAttribute ${className}Entity ${lowerName},
			@ModelAttribute ${className}Page ${lowerName}Page){
		AjaxJson j = new AjaxJson();
		try {
			<#list subEntityList as sub>
			List<${sub.paramData.className}Entity> ${sub.paramData.lowerName}Entities = ${lowerName}Page.get${sub.paramData.className}Entities();
			if(${sub.paramData.lowerName}Entities.size() <= 0){
				j.setMsg("请至少添加一个${sub.paramData.codeName}详情");
				j.setSuccess(false);
				return j;
			}
			</#list>
		
			${lowerName}Service.update(${lowerName});
			
			${className}Entity temp${className}Entity = this.${lowerName}Service.get(${lowerName}.getId());
			<#list subEntityList as sub>
			Map<String,${sub.paramData.className}Entity> old${sub.paramData.className}EntityMap = new HashMap<String, ${sub.paramData.className}Entity>();
			if(!temp${className}Entity.get${sub.paramData.foreignKeyUpper}().equals(${lowerName}.get${sub.paramData.foreignKeyUpper}())){
				this.${sub.paramData.lowerName}Service.deleteBy${sub.paramData.foreignKeyUpper}(temp${className}Entity.get${sub.paramData.foreignKeyUpper}());
			}else{
				List<${sub.paramData.className}Entity> old${sub.paramData.className}EntityList = this.${sub.paramData.lowerName}Service.getBy${sub.paramData.foreignKeyUpper}(${lowerName}.get${sub.paramData.foreignKeyUpper}());
				for(${sub.paramData.className}Entity po:old${sub.paramData.className}EntityList){
					old${sub.paramData.className}EntityMap.put(po.getId(), po);
				}
			}
			</#list>
			
			<#list subEntityList as sub>
			for(${sub.paramData.className}Entity entity : ${sub.paramData.lowerName}Entities){
				if(StringUtils.isEmpty(entity.getId())){
					String randomSeed = UUID.randomUUID().toString().replaceAll("-", "").toUpperCase();
					entity.setId(randomSeed);
					entity.set${sub.paramData.foreignKeyUpper}(${lowerName}.get${sub.paramData.mainForeignKeyUpper}());
					this.${sub.paramData.lowerName}Service.insert(entity);
				}else{
					this.${sub.paramData.lowerName}Service.update(entity);
					//剔除已经更新了的数据
	        		if(old${sub.paramData.className}EntityMap.size()>0&&old${sub.paramData.className}EntityMap.containsKey(entity.getId())){
	        			old${sub.paramData.className}EntityMap.remove(entity.getId());
	        		}
				}
			}
			//old${sub.paramData.className}EntityMap中剩余的数据就是删除的数据
	        if(old${sub.paramData.className}EntityMap.size()>0){
	        	Iterator itSub=old${sub.paramData.className}EntityMap.entrySet().iterator();
		    	while(itSub.hasNext()){
		    		Map.Entry entrySub=(Map.Entry)itSub.next();
		    		this.${sub.paramData.lowerName}Service.delete((${sub.paramData.className}Entity)entrySub.getValue());
		    	}
	        }
			</#list>
			j.setMsg("编辑成功");
		} catch (Exception e) {
		    log.info(e.getMessage());
			j.setSuccess(false);
			j.setMsg("编辑失败");
		}
		return j;
	}


	/**
	 * 删除
	 * @return
	 */
	@RequestMapping(params="doDelete",method = RequestMethod.GET)
	@ResponseBody
	public AjaxJson doDelete(@RequestParam(required = true, value = "id" ) String id){
			AjaxJson j = new AjaxJson();
			try {
			    ${className}Entity ${lowerName} = new ${className}Entity();
				${lowerName}.setId(id);
				${lowerName}Service.delete(${lowerName});
				
				<#list subEntityList as sub>
				this.${sub.paramData.lowerName}Service.delBy${sub.paramData.foreignKeyUpper}(${lowerName}.get${sub.paramData.mainForeignKeyUpper}());
				</#list>
				j.setMsg("删除成功");
			} catch (Exception e) {
			    log.info(e.getMessage());
				j.setSuccess(false);
				j.setMsg("删除失败");
			}
			return j;
	}


}

