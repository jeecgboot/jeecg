package org.jeecgframework.core.util;

import java.util.ArrayList;
import java.util.List;

import jeecg.system.pojo.base.TSRole;

import org.jeecgframework.core.common.model.json.ComboBox;


public class RoletoJson {

	/**
	 * 手工拼接JSON
	 */
	public static String getComboBoxJson(List<TSRole> list, List<TSRole> roles) {
		StringBuffer buffer = new StringBuffer();
		buffer.append("[");
		for (TSRole node : list) {
			if (roles.size() > 0) {
				buffer.append("{\"id\":" + node.getId() + ",\"text\":\"" + node.getRoleName() + "\"");
				for (TSRole node1 : roles) {
					if (node.getId() == node1.getId()) {
						buffer.append(",\"selected\":true");
					}
				}
				buffer.append("},");
			} else {
				buffer.append("{\"id\":" + node.getId() + ",\"text\":\"" + node.getRoleName() + "\"},");
			}

		}
		buffer.append("]");

		// 将,\n]替换成\n]

		String tmp = buffer.toString();
		tmp = tmp.replaceAll(",]", "]");
		return tmp;

	}
	/**
	 * 根据模型生成JSON
	 */
	public static List<ComboBox> getComboBox(List<TSRole> list, List<TSRole> roles) {
		StringBuffer buffer = new StringBuffer();
		List<ComboBox> comboxBoxs = new ArrayList<ComboBox>();
		buffer.append("[");
		for (TSRole node : list) {
			ComboBox box = new ComboBox();
			box.setId(node.getId().toString());
			box.setText(node.getRoleName());
			if (roles.size() > 0) {
				for (TSRole node1 : roles) {
					if (node.getId() == node1.getId()) {
						box.setSelected(true);
					}
				}
			}
			comboxBoxs.add(box);
		}
		return comboxBoxs;

	}
}
