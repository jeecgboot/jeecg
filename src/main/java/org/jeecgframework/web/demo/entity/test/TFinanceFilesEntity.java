package org.jeecgframework.web.demo.entity.test;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.jeecgframework.web.system.pojo.base.TSAttachment;

/**   
 * @Title: Entity
 * @Description: 资金管理附件
 * @author tanghong
 * @date 2013-06-26 23:57:04
 * @version V1.0   
 *
 */
@Entity
@Table(name = "t_finance_files", schema = "")
@PrimaryKeyJoinColumn(name = "id")
@SuppressWarnings("serial")
public class TFinanceFilesEntity extends TSAttachment implements java.io.Serializable {
	
	private TFinanceEntity finance;
	

	@ManyToOne(cascade = {CascadeType.PERSIST,CascadeType.MERGE, CascadeType.REFRESH},fetch = FetchType.LAZY)
	@JoinColumn(name = "financeId")
	public TFinanceEntity getFinance() {
		return finance;
	}

	public void setFinance(TFinanceEntity finance) {
		this.finance = finance;
	}
	
}
