package org.jeecgframework.web.system.pojo.base;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.ForeignKey;
import org.jeecgframework.core.common.entity.IdEntity;

/**
 *地域管理表
 * @author  张代浩
 */
@Entity
@Table(name = "t_s_territory")
public class TSTerritory extends IdEntity implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	private TSTerritory TSTerritory;//父地域
	private String territoryName;//地域名称
	private Short territoryLevel;//等级
	private String territorySort;//同区域中的显示顺序
	private String territoryCode;//区域码
	private String territoryPinyin;//区域名称拼音
	private double xwgs84;//wgs84格式经度(mapabc 的坐标系)
	private double ywgs84;//wgs84格式纬度(mapabc 的坐标系)
	private List<TSTerritory> TSTerritorys = new ArrayList<TSTerritory>();

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "territoryparentid")
	@ForeignKey(name="null")//取消hibernate的外键生成
	public TSTerritory getTSTerritory() {
		return this.TSTerritory;
	}
	public void setTSTerritory(TSTerritory TSTerritory) {
		this.TSTerritory = TSTerritory;
	}
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "TSTerritory")
	public List<TSTerritory> getTSTerritorys() {
		return TSTerritorys;
	}
	public void setTSTerritorys(List<TSTerritory> TSTerritorys) {
		this.TSTerritorys = TSTerritorys;
	}
	@Column(name = "territoryname", nullable = false, length = 50)
	public String getTerritoryName() {
		return territoryName;
	}

	public void setTerritoryName(String territoryName) {
		this.territoryName = territoryName;
	}

	@Column(name = "territorysort",nullable = false,length = 3)
	public String getTerritorySort() {
		return territorySort;
	}

	public void setTerritorySort(String territorySort) {
		this.territorySort = territorySort;
	}
	@Column(name = "territorylevel",nullable = false,length = 1)
	public Short getTerritoryLevel() {
		return territoryLevel;
	}
	public void setTerritoryLevel(Short territoryLevel) {
		this.territoryLevel = territoryLevel;
	}
	@Column(name = "territorycode",nullable = false,length = 10)
	public String getTerritoryCode() {
		return territoryCode;
	}
	public void setTerritoryCode(String territoryCode) {
		this.territoryCode = territoryCode;
	}
	@Column(name = "territory_pinyin",nullable = true,length = 40)
	public String getTerritoryPinyin() {
		return territoryPinyin;
	}
	public void setTerritoryPinyin(String territoryPinyin) {
		this.territoryPinyin = territoryPinyin;
	}
	@Column(name = "x_wgs84",nullable = false,length = 40)
	public double getXwgs84() {
		return xwgs84;
	}
	public void setXwgs84(double xwgs84) {
		this.xwgs84 = xwgs84;
	}
	@Column(name = "y_wgs84",nullable = false,length = 40)
	public double getYwgs84() {
		return ywgs84;
	}
	public void setYwgs84(double ywgs84) {
		this.ywgs84 = ywgs84;
	}

}