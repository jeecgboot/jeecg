package org.jeecgframework.tag.core.factory;

import java.util.HashMap;
import java.util.Map;

import org.jeecgframework.core.util.MutiLangUtil;
import org.jeecgframework.tag.core.easyui.DataGridTag;
import org.jeecgframework.tag.core.factory.util.ComponentTools;

public class BootstrapTableComponent extends ComponentFactory{

	@Override
	protected Map<String, Object> getData(DataGridTag dataGridTag) {
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("dataGrid", dataGridTag);
		data.put("ComponentTools", new ComponentTools());
		data.put("MutiLangUtil", new MutiLangUtil());
		return data;
	}

}
