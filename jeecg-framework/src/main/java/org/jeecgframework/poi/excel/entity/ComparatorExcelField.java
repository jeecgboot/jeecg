package org.jeecgframework.poi.excel.entity;

import java.util.Comparator;

/**
 * 按照升序排序
 * @author jueyue
 *
 */
public class ComparatorExcelField implements Comparator<ExcelExportEntity> {

	
	public int compare(ExcelExportEntity prev,ExcelExportEntity next) {
		return prev.getOrderNum() - next.getOrderNum();
	}

}
