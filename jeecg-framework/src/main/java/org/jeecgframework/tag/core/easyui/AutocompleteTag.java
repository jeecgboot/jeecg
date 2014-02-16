package org.jeecgframework.tag.core.easyui;

import java.io.IOException;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.jeecgframework.core.util.StringUtil;


/**
 * 
 * 自动补全
 * jquery ui Autocomplete
 * @author:  张代浩
 * @date： 日期：2012-12-7 时间：上午10:17:45
 * @version 1.0
 */
public class AutocompleteTag extends TagSupport {
	private static final long serialVersionUID = 1L;
	private String name;//控件名称
	private String dataSource = "commonController.do?getAutoList";//数据源
	private Integer minLength=2;//触发提示文字长度
	private String labelField;//提示显示的字段
	private String searchField;//查询关键字字段
	private String valueField;//传递后台的字段
	private String entityName;//实体名称
	private String selectfun;//选中后调用的函数
	private String label;//传入显示值
	private String value;//传入隐藏域值
	private String datatype = "*";//数据验证类型
	private String nullmsg = "";//数据为空时验证
	private String errormsg = "输入格式不对";//数据格式不对时验证
	private String closefun;//没有选择下拉项目的处理函数
	private String parse; 
	private String formatItem; 
	private String result; 
	private Integer maxRows = 10;//显示的最多的条数
	
	public void setClosefun(String closefun) {
		this.closefun = closefun;
	}
	public void setDatatype(String datatype) {
		this.datatype = datatype;
	}
	public void setNullmsg(String nullmsg) {
		this.nullmsg = nullmsg;
	}
	public void setErrormsg(String errormsg) {
		this.errormsg = errormsg;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public void setValue(String value) {
		this.value = value;
	}
	
	public int doStartTag() throws JspTagException {
		return EVAL_PAGE;
	}
	public int doEndTag() throws JspTagException {
		try {
			JspWriter out = this.pageContext.getOut();
			out.print(end().toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return EVAL_PAGE;
	}
	public StringBuffer end() {
		StringBuffer nsb = new StringBuffer();
		nsb.append("<script type=\"text/javascript\">");
		nsb.append("$(document).ready(function() {") 
		.append("$(\"#"+name+"\").autocomplete(\""+dataSource+"\",{")
		.append("max: 5,minChars: "+minLength+",width: 200,scrollHeight: 100,matchContains: true,autoFill: false,extraParams:{")
        .append("featureClass : \"P\",style : \"full\",	maxRows : "+maxRows+",labelField : \""+labelField+"\",valueField : \""+valueField+"\",")
		.append("searchField : \""+searchField+"\",entityName : \""+entityName+"\",trem: getTremValue}");
		if(StringUtil.isNotEmpty(parse)){
			nsb.append(",parse:function(data){return "+parse+".call(this,data);}");
		}
		if(StringUtil.isNotEmpty(formatItem)){
			nsb.append(",formatItem:function(row, i, max){return "+formatItem+".call(this,row, i, max);} ");
		}
		nsb.append("}).result(function (event, row, formatted) {");
		if(StringUtil.isNotEmpty(result)){
			nsb.append(result+".call(this,row); ");
		}
		nsb.append("}); });")
		.append("function getTremValue(){return $(\"#"+name+"\").val();}")
        .append("</script>")
        .append("<input type=\"text\" id=\""+name+"\" datatype=\""+datatype+"\" nullmsg=\""+nullmsg+"\" errormsg=\""+errormsg+"\"/>");
		if(StringUtil.isNotEmpty(label)){
			nsb.append(" value="+label+" readonly=true");
		}
		nsb.append("<input type=\"hidden\" id=\""+valueField+"\" name=\""+valueField+"\"/>");
		return nsb;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setParse(String parse) {
		this.parse = parse;
	}
	public void setFormatItem(String formatItem) {
		this.formatItem = formatItem;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public void setDataSource(String dataSource) {
		this.dataSource = dataSource;
	}
	public void setMinLength(Integer minLength) {
		this.minLength = minLength;
	}
	public void setLabelField(String labelField) {
		this.labelField = labelField;
	}
	public void setValueField(String valueField) {
		this.valueField = valueField;
	}
	public void setEntityName(String entityName) {
		this.entityName = entityName;
	}
	public void setSearchField(String searchField) {
		this.searchField = searchField;
	}
	public void setSelectfun(String selectfun) {
		this.selectfun = selectfun;
	}
	public void setMaxRows(Integer maxRows){
		if(maxRows==null){
			maxRows = 10;
		}
		this.maxRows = maxRows;
	}
}
