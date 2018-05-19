package org.jeecgframework.core.common.model.json;
import java.util.List;
/**
 *  统计报表模型
 * @author 张代浩
 *
 */
public class Highchart {
private String name;
private String type;//类型
private List data;//数据
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public List getData() {
	return data;
}
public void setData(List data) {
	this.data = data;
}
public String getType() {
	return type;
}
public void setType(String type) {
	this.type = type;
}

}
