package org.jeecgframework.core.common.hibernate.qbc;

import java.util.Map;
/**
 * 标签生成类(不使用分页标签)
 * @author jeecg
 * @version1.0
 */
public class Pager {
	private int curPageNO = 1; // 当前页
	private int pageSize; // 每页显示的记录数
	private int rowsCount; // 记录行数
	private int pageCount; // 页数
	private Map<String, Object> map;// 封装查询条件

	/**
	 * @param allCount
	 *            记录行数
	 * @param offset
	 *            记录开始数目
	 * @param pageSize
	 *            每页显示的记录数
	 */
	public Pager(int allCount,int curPagerNo, int pageSize, Map<String, Object> map) {
		this.curPageNO = curPagerNo;
		this.pageSize = pageSize;
		this.rowsCount = allCount;
		this.map = map;
		this.pageCount = (int) Math.ceil((double) allCount / pageSize);
	}

	public Pager() {
	}
	// getPageSize：返回分页大小
	public int getPageSize() {
		return pageSize;
	}

	// getRowsCount：返回总记录行数
	public int getRowsCount() {
		return rowsCount;
	}

	// getPageCount：返回总页数
	public int getPageCount() {
		return pageCount;
	}

	// 第一页
	public int first() {
		return 1;
	}

	// 最后一页
	public int last() {
		return pageCount;
	}

	// 上一页
	public int previous() {
		return (curPageNO - 1 < 1) ? 1 : curPageNO - 1;
	}

	// 下一页
	public int next() {
		return (curPageNO + 1 > pageCount) ? pageCount : curPageNO + 1;
	}

	// 第一页
	public boolean isFirst() {
		return (curPageNO == 1) ? true : false;
	}

	// 最后一页
	public boolean isLast() {
		return (curPageNO == pageCount) ? true : false;
	}
	public String toString() {
		return "Pager的值为 " + " curPageNO = " + curPageNO + " limit = " + pageSize + " rowsCount = " + rowsCount + " pageCount = " + pageCount;
	}

	/**
	 * 获取工具条 不用图片的，用下拉框
	 * 
	 * @return String
	 */
	public String getToolBar(String url) {

		String temp = "";
		String conditions = "";
		if (map.size() > 0) {

			for (Map.Entry<String, Object> entry : map.entrySet()) {
				conditions += "&" + entry.getKey() + "=" + entry.getValue();
			}
		}
		if (url.indexOf("?") == -1) {
			temp = "?";
		} else {
			temp = "&";
		}
		String str = "";
		str += "";
		if (isFirst())
			str += "第" + curPageNO + "页&nbsp;共" + pageCount + "页&nbsp;首页 上一页&nbsp;";
		else {
			str += "第" + curPageNO + "页&nbsp;共" + pageCount + "页&nbsp;<a href='" + url + temp + "curPageNO=1" + conditions + "'>首页</a>&nbsp;";
			str += "<a href='" + url + temp + "curPageNO=" + previous() + conditions + "' onMouseMove=\"style.cursor='hand'\" alt=\"上一页\">上一页</a>&nbsp;";
		}
		if (isLast() || rowsCount == 0)
			str += "下一页 尾页&nbsp;";
		else {
			str += "<a href='" + url + temp + "curPageNO=" + next() + conditions + "' onMouseMove=\"style.cursor='hand'\" >下一页</a>&nbsp;";
			str += "<a href='" + url + temp + "curPageNO=" + pageCount + conditions + "'>尾页</a>&nbsp;";
		}
		str += "&nbsp;共" + rowsCount + "条记录&nbsp;";
		
		str += "&nbsp;转到<select name='page' onChange=\"location='" + url + temp + "curPageNO='+this.options[this.selectedIndex].value\">"; int begin = (curPageNO > 10) ? curPageNO - 10 : 1; int end = (pageCount - curPageNO > 10) ? curPageNO + 10 : pageCount; for (int i = begin; i <= end; i++) { if (i == curPageNO) str += "<option value='" + i + "' selected>第" + i + "页</option>"; else str += "<option value='" + i + "'>第" + i + "页</option>"; } str += "</select>";
		
		return str;
	}

	/**
	 * 获取工具条
	 * 
	 * @return String
	 */
	public String getToolBar(String myaction, String myform) {
		String str = "";
		str += "<script language='javascript'>" + "\n";
		str += "function commonSubmit(val){" + "\n";
		// 校验是否全由数字组成
		str += "var patrn=/^[0-9]{1,20}$/;" + "\n";
		str += "if (!patrn.exec(val)){" + "\n";
		str += " alert(\"请输入有效页号！\");" + "\n";
		str += " return false ;" + "\n";
		str += " }else{" + "\n";
		str += "    document." + myform + ".action='" + myaction + "&curPageNO='+val;" + "\n";
		str += "    document." + myform + ".submit();" + "\n";
		str += "    return true ;" + "\n";
		str += "} " + "\n";
		str += " }" + "\n";
		str += "</script>" + "\n";
		str += "&nbsp;<DIV class=pageArea id=pageArea>共<b>" + rowsCount + "</b>条&nbsp;当前第" + curPageNO + "/" + pageCount + "页&nbsp;&nbsp;&nbsp;";
		if (curPageNO == 1 || curPageNO == 0)
			str += "<a class=pageFirstDisable title=首页 onMouseMove=\"style.cursor='hand'\">&nbsp;<a class=pagePreviousDisable title=上一页 onMouseMove=\"style.cursor='hand'\"></a>";
		else {
			str += "<a class=pageFirst title=首页 onMouseMove=\"style.cursor='hand'\" onclick=\"commonSubmit(1)\"></a>";
			str += "<a class=pagePrevious title=上一页 onMouseMove=\"style.cursor='hand'\" onclick=\"commonSubmit(" + (curPageNO - 1) + ")\"></a>";
		}
		if (curPageNO - pageCount == 0 || pageCount == 0 || pageCount == 1)
			str += "<a class=pageNextDisable  title=下一页 onMouseMove=\"style.cursor='hand'\">&nbsp;<a class=pageLastDisable title=尾页 onMouseMove=\"style.cursor='hand'\"></a>&nbsp;";
		else {
			str += "<a class=pageNext title=下一页 onMouseMove=\"style.cursor='hand'\" onclick=\"commonSubmit(" + (curPageNO + 1) + ")\"></a>";
			str += "<a class=pageLast title=尾页 onMouseMove=\"style.cursor='hand'\" onclick=\"commonSubmit(" + pageCount + ")\"></a>";
		}

		if (pageCount == 1 || pageCount == 0) {
			str += " &nbsp;转到:<input class=SmallInput type=text style=TEXT-ALIGN: center maxLength=5 name=\"pageroffsetll\" size=3 onKeyPress=\"if (event.keyCode == 13) return commonSubmit(document.all.pageroffsetll.value)\" > 页&nbsp;";
			str += "<A class=pageGoto id=pageGoto title=转到 onclick='return commonSubmit()'></A></DIV>";
		} else {
			str += " &nbsp;转到:<input class=SmallInput type=text style=TEXT-ALIGN: center maxLength=5 name=\"pageroffsetll\" size=3 onKeyPress=\"if (event.keyCode == 13) return commonSubmit(document.all.pageroffsetll.value)\" > 页&nbsp;";
			str += "<A class=pageGoto id=pageGoto title=转到 onclick='commonSubmit(document.all.pageroffsetll.value)'></A></DIV>";
		}
		return str;
	}
}
