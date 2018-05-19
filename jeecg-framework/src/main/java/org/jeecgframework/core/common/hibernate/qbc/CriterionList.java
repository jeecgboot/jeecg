package org.jeecgframework.core.common.hibernate.qbc;

import java.util.ArrayList;

import org.hibernate.criterion.Criterion;
/**
* @ClassName: CriterionList 
* @Description: TODO(查询条件集合) 
* @author jeecg 
* @date 2012-10-25 上午09:32:20 
*
 */
public class CriterionList extends ArrayList<Object> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public final Criterion getParas(final int index) {
		return (Criterion) super.get(index);
	}

	public final void addPara(final int index, final Criterion p) {
		super.add(index, p);
	}

	public final void addPara(final Criterion p) {
		super.add(p);
	}

	public final int indexofPara(final Criterion p) {
		return super.indexOf(p);
	}

	public final void removePara(final int index) {
		super.remove(index);
	}
}
