package ${pagePackage};

import java.util.List;
import java.util.ArrayList;
import java.io.Serializable;
import java.util.Date;
import java.math.BigDecimal;
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
public class ${className}Page implements Serializable{
	private static final long serialVersionUID = 1L;
	
	<#list subEntityList as sub>
	private List<${sub.paramData.className}Entity> ${sub.paramData.lowerName}Entities = new ArrayList<${sub.paramData.className}Entity>();
	</#list>
	
	
	<#list subEntityList as sub>
	public List<${sub.paramData.className}Entity> get${sub.paramData.className}Entities() {
		return ${sub.paramData.lowerName}Entities;
	}
	public void set${sub.paramData.className}Entities(
			List<${sub.paramData.className}Entity> ${sub.paramData.lowerName}Entities) {
		this.${sub.paramData.lowerName}Entities = ${sub.paramData.lowerName}Entities;
	}
	</#list>
}

