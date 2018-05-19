package org.jeecgframework.core.util;

import java.util.List;

import org.jeecgframework.web.system.pojo.base.TSFunction;


public class ListtoJson {

	public static String getJsonData(@SuppressWarnings("rawtypes") List list) {

		StringBuffer buffer = new StringBuffer();

		buffer.append("[");

		iterGet(list, "0", buffer);

		buffer.append("]");

		// 将,\n]替换成\n]

		String tmp = buffer.toString();

		tmp = tmp.replaceAll(",\n]", "\n]");

		return tmp;

	}

	static int count = 0;

	/**
	 * 
	 * 递归生成json格式的数据{id:1,text:'',children:[]}
	 * 
	 * @param args
	 */

	static void iterGet(List<TSFunction> list, String pid, StringBuffer buffer) {
		for (TSFunction node : list) {

			// 查找所有父节点为pid的所有对象，然后拼接为json格式的数据
			if(node.getTSFunction()!=null)
			{			
			if (pid.equals(oConvertUtils.getString(node.getTSFunction().getId())))
			{
				count++;
				buffer.append("{\'id\':" + node.getId() + ",\'text\':\'"
						+ node.getFunctionName() + "\',\'children\':[");
				// 递归
				iterGet(list, node.getId(), buffer);
				buffer.append("]},\n");
				count--;

			}
			}
		}

	}

}
