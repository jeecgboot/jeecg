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

import org.jeecgframework.core.common.entity.IdEntity;

/**
 * 例子演示
 * @author  张代浩
 */
@Entity
@Table(name = "t_s_demo")
public class TSDemo extends IdEntity implements java.io.Serializable {
	private String demotitle;//DEMO标题
	private String demourl;//DEMO地址
	private TSDemo TSDemo;//上级
	private Short demoorder;//DEMO排序
	private String democode;//例子代码
	private List<TSDemo> tsDemos = new ArrayList<TSDemo>();
	@Column(name = "demotitle", length = 200)
	public String getDemotitle() {
		return demotitle;
	}

	public void setDemotitle(String demotitle) {
		this.demotitle = demotitle;
	}

	@Column(name = "demourl", length = 200)
	public String getDemourl() {
		return demourl;
	}

	public void setDemourl(String demourl) {
		this.demourl = demourl;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "demopid")
	public TSDemo getTSDemo() {
		return TSDemo;
	}

	public void setTSDemo(TSDemo tSDemo) {
		TSDemo = tSDemo;
	}

	@Column(name = "demoorder")
	public Short getDemoorder() {
		return demoorder;
	}

	public void setDemoorder(Short demoorder) {
		this.demoorder = demoorder;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "TSDemo")
	public List<TSDemo> getTsDemos() {
		return tsDemos;
	}

	public void setTsDemos(List<TSDemo> tsDemos) {
		this.tsDemos = tsDemos;
	}
	@Column(name = "democode", length = 8000)
	public String getDemocode() {
		return democode;
	}

	public void setDemocode(String democode) {
		this.democode = democode;
	}
}