package org.jeecgframework.tag.vo.superquery;

import org.jeecgframework.jwt.util.GsonUtil;

public class TestMain {

	public static void main(String[] args) {
		SuperQueryJson sqm = new SuperQueryJson();
		sqm.setType("M");
		Table t = new Table();
		t.setIsMain("Y");
		t.setTable("jeecg_order_main");
		
		
		//表结构配置
		Table sb1 = new Table();
		sb1.setIsMain("N");
		sb1.setTable("jeecg_order_product");
		
//		Table sb2 = new Table();
//		sb2.setIsMain("Y");
//		sb2.setTable("jeecg_order_custom");
		
		
		sqm.addTable(t);
		sqm.addTable(sb1);
		
		//订单表字段配置
		TConfig tc = new TConfig();
		tc.setTable("jeecg_order_main");
		Field f = new Field();
		f.setName("GO_ORDER_CODE");
		f.setTxt("订单号");
		f.setDtype("c");
		f.setStype("input");
		f.setSeq(1);
		Field f1 = new Field();
		f1.setName("GODER_TYPE");
		f1.setDtype("c");
		f1.setTxt("订单类型");
		f1.setStype("select");
		f1.setDicCode("sex");
		f1.setSeq(2);
		Field f2 = new Field();
		f2.setName("CREATE_DT");
		f2.setDtype("d");
		f2.setTxt("订单时间");
		f2.setStype("date");
		f2.setSeq(3);
		tc.addField(f);
		tc.addField(f1);
		tc.addField(f2);
		
		
		//订单表字段配置
		TConfig tc1 = new TConfig();
		tc1.setTable("jeecg_order_product");
		Field ff = new Field();
		ff.setName("GOP_PRODUCT_NAME");
		ff.setTxt("产品名称");
		ff.setDtype("c");
		ff.setStype("input");
		ff.setSeq(1);
		Field ff1 = new Field();
		ff1.setName("GOP_PRODUCT_TYPE");
		ff1.setTxt("产品类型");
		ff1.setDtype("c");
		ff1.setStype("select");
		ff1.setDicCode("sex");
		ff1.setSeq(2);
		Field ff2 = new Field();
		ff2.setName("MODIFY_DT");
		ff2.setDtype("d");
		ff2.setStype("date");
		ff2.setTxt("产品出厂时间");
		ff2.setSeq(3);
		tc1.addField(ff);
		tc1.addField(ff1);
		tc1.addField(ff2);
		
		sqm.addTconfig(tc);
		sqm.addTconfig(tc);
		
		System.out.println(GsonUtil.toJson(sqm));
	}
}
