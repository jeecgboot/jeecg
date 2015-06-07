package org.jeecgframework.web.demo.service.impl.test;

import java.util.List;

import org.jeecgframework.web.demo.entity.test.JeecgOrderCustomEntity;
import org.jeecgframework.web.demo.entity.test.JeecgOrderMainEntity;
import org.jeecgframework.web.demo.entity.test.JeecgOrderProductEntity;
import org.jeecgframework.web.demo.service.test.JeecgOrderMainServiceI;

import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("jeecgOrderMainService")
@Transactional
public class JeecgOrderMainServiceImpl extends CommonServiceImpl implements JeecgOrderMainServiceI {

	
	public void addMain(JeecgOrderMainEntity jeecgOrderMain,
			List<JeecgOrderProductEntity> jeecgOrderProducList,
			List<JeecgOrderCustomEntity> jeecgOrderCustomList){
		//保存订单主信息
		this.save(jeecgOrderMain);
		//保存订单产品明细
		for(JeecgOrderProductEntity product:jeecgOrderProducList){
			//外键设置
			product.setGoOrderCode(jeecgOrderMain.getGoOrderCode());
			this.save(product);
		}
		//保存订单客户明细
		for(JeecgOrderCustomEntity custom:jeecgOrderCustomList){
			//外键设置
			custom.setGoOrderCode(jeecgOrderMain.getGoOrderCode());
			this.save(custom);
		}
	}

	
	public void updateMain(JeecgOrderMainEntity jeecgOrderMain,
			List<JeecgOrderProductEntity> jeecgOrderProducList,
			List<JeecgOrderCustomEntity> jeecgOrderCustomList,
			boolean jeecgOrderCustomShow) {
		//保存订单主信息
		this.saveOrUpdate(jeecgOrderMain);
		//删除订单产品明细
		this.commonDao.deleteAllEntitie(this.findByProperty(JeecgOrderProductEntity.class, "goOrderCode", jeecgOrderMain.getGoOrderCode()));
		//保存订单产品明细
		for(JeecgOrderProductEntity product:jeecgOrderProducList){
			//外键设置
			product.setGoOrderCode(jeecgOrderMain.getGoOrderCode());
			this.save(product);
		}
		if(jeecgOrderCustomShow){
			//删除订单客户明细
			this.commonDao.deleteAllEntitie(this.findByProperty(JeecgOrderCustomEntity.class, "goOrderCode", jeecgOrderMain.getGoOrderCode()));
			//保存订单客户明细
			for(JeecgOrderCustomEntity custom:jeecgOrderCustomList){
				//外键设置
				custom.setGoOrderCode(jeecgOrderMain.getGoOrderCode());
				this.save(custom);
			}
		}
	}

	
	public void delMain(JeecgOrderMainEntity jeecgOrderMain) {
		//删除主表信息
		this.delete(jeecgOrderMain);
		//删除订单产品明细
		this.deleteAllEntitie(this.findByProperty(JeecgOrderProductEntity.class, "goOrderCode", jeecgOrderMain.getGoOrderCode()));
		//删除订单客户明细
		this.commonDao.deleteAllEntitie(this.findByProperty(JeecgOrderCustomEntity.class, "goOrderCode", jeecgOrderMain.getGoOrderCode()));
	}
}