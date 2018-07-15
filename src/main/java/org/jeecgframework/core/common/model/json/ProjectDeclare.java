package org.jeecgframework.core.common.model.json;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties(value = { "hibernateLazyInitializer" })
public class ProjectDeclare {
	
	private Integer detialid;//明细编号
	private Integer declareid;//申报编号
	private String constructionunit;//建设单位
	private String projectname;//项目名称
	private String statusid;//状态
	private String buildingno;//栋号
	private Double undergroundconstructionarea;//地下建筑面积
	private String geom;
	public Integer getDetialid() {
		return detialid;
	}
	public void setDetialid(Integer detialid) {
		this.detialid = detialid;
	}
	public Integer getDeclareid() {
		return declareid;
	}
	public void setDeclareid(Integer declareid) {
		this.declareid = declareid;
	}
	public String getConstructionunit() {
		return constructionunit;
	}
	public void setConstructionunit(String constructionunit) {
		this.constructionunit = constructionunit;
	}
	public String getProjectname() {
		return projectname;
	}
	public void setProjectname(String projectname) {
		this.projectname = projectname;
	}
	public String getStatusid() {
		return statusid;
	}
	public void setStatusid(String statusid) {
		this.statusid = statusid;
	}
	public String getBuildingno() {
		return buildingno;
	}
	public void setBuildingno(String buildingno) {
		this.buildingno = buildingno;
	}
	public Double getUndergroundconstructionarea() {
		return undergroundconstructionarea;
	}
	public void setUndergroundconstructionarea(Double undergroundconstructionarea) {
		this.undergroundconstructionarea = undergroundconstructionarea;
	}
	public String getGeom() {
		return geom;
	}
	public void setGeom(String geom) {
		this.geom = geom;
	}
}
