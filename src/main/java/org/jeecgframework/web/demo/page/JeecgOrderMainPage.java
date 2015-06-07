package org.jeecgframework.web.demo.page;

import java.util.ArrayList;
import java.util.List;

import org.jeecgframework.web.demo.entity.test.JeecgOrderCustomEntity;
import org.jeecgframework.web.demo.entity.test.JeecgOrderProductEntity;

/**   
 * @Title: Entity
 * @Description: 订单信息 VO
 * @author 张代浩
 * @date 2013-03-19 22:01:34
 * @version V1.0   
 *
 */
@SuppressWarnings("serial")
public class JeecgOrderMainPage implements java.io.Serializable {
	/**订单客户明细*/
	private List<JeecgOrderCustomEntity> jeecgOrderCustomList = new ArrayList<JeecgOrderCustomEntity>();
	public List<JeecgOrderCustomEntity> getJeecgOrderCustomList() {
		return jeecgOrderCustomList;
	}
	public void setJeecgOrderCustomList(List<JeecgOrderCustomEntity> jeecgOrderCustomList) {
		this.jeecgOrderCustomList = jeecgOrderCustomList;
	}
	/**订单产品明细*/
	private List<JeecgOrderProductEntity> jeecgOrderProductList = new ArrayList<JeecgOrderProductEntity>();
	public List<JeecgOrderProductEntity> getJeecgOrderProductList() {
		return jeecgOrderProductList;
	}
	public void setJeecgOrderProductList(List<JeecgOrderProductEntity> jeecgOrderProductList) {
		this.jeecgOrderProductList = jeecgOrderProductList;
	}
}
