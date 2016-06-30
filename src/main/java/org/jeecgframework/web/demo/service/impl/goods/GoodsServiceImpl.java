package org.jeecgframework.web.demo.service.impl.goods;
import org.jeecgframework.web.demo.entity.goods.GoodsEntity;
import org.jeecgframework.web.demo.service.goods.GoodsServiceI;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.UUID;
import java.io.Serializable;

@Service("goodsService")
@Transactional
public class GoodsServiceImpl extends CommonServiceImpl implements GoodsServiceI {

	
 	public <T> void delete(T entity) {
 		super.delete(entity);
 		//执行删除操作配置的sql增强
		this.doDelSql((GoodsEntity)entity);
 	}
 	
 	public <T> Serializable save(T entity) {
 		Serializable t = super.save(entity);
 		//执行新增操作配置的sql增强
 		this.doAddSql((GoodsEntity)entity);
 		return t;
 	}
 	
 	public <T> void saveOrUpdate(T entity) {
 		super.saveOrUpdate(entity);
 		//执行更新操作配置的sql增强
 		this.doUpdateSql((GoodsEntity)entity);
 	}
 	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param id
	 * @return
	 */
 	public boolean doAddSql(GoodsEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param id
	 * @return
	 */
 	public boolean doUpdateSql(GoodsEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param id
	 * @return
	 */
 	public boolean doDelSql(GoodsEntity t){
	 	return true;
 	}
 	
 	/**
	 * 替换sql中的变量
	 * @param sql
	 * @return
	 */
 	public String replaceVal(String sql,GoodsEntity t){
 		sql  = sql.replace("#{id}",String.valueOf(t.getId()));
 		sql  = sql.replace("#{create_name}",String.valueOf(t.getCreateName()));
 		sql  = sql.replace("#{create_by}",String.valueOf(t.getCreateBy()));
 		sql  = sql.replace("#{create_date}",String.valueOf(t.getCreateDate()));
 		sql  = sql.replace("#{update_name}",String.valueOf(t.getUpdateName()));
 		sql  = sql.replace("#{update_by}",String.valueOf(t.getUpdateBy()));
 		sql  = sql.replace("#{update_date}",String.valueOf(t.getUpdateDate()));
 		sql  = sql.replace("#{sys_org_code}",String.valueOf(t.getSysOrgCode()));
 		sql  = sql.replace("#{sys_company_code}",String.valueOf(t.getSysCompanyCode()));
 		sql  = sql.replace("#{bpm_status}",String.valueOf(t.getBpmStatus()));
 		sql  = sql.replace("#{name}",String.valueOf(t.getName()));
 		sql  = sql.replace("#{code}",String.valueOf(t.getCode()));
 		sql  = sql.replace("#{full_name}",String.valueOf(t.getFullName()));
 		sql  = sql.replace("#{outside_code}",String.valueOf(t.getOutsideCode()));
 		sql  = sql.replace("#{manufacturers_no}",String.valueOf(t.getManufacturersNo()));
 		sql  = sql.replace("#{supplier}",String.valueOf(t.getSupplier()));
 		sql  = sql.replace("#{product_unit}",String.valueOf(t.getProductUnit()));
 		sql  = sql.replace("#{product_owner}",String.valueOf(t.getProductOwner()));
 		sql  = sql.replace("#{brand}",String.valueOf(t.getBrand()));
 		sql  = sql.replace("#{annual}",String.valueOf(t.getAnnual()));
 		sql  = sql.replace("#{season}",String.valueOf(t.getSeason()));
 		sql  = sql.replace("#{product_type}",String.valueOf(t.getProductType()));
 		sql  = sql.replace("#{series_name}",String.valueOf(t.getSeriesName()));
 		sql  = sql.replace("#{size_length}",String.valueOf(t.getSizeLength()));
 		sql  = sql.replace("#{size_width}",String.valueOf(t.getSizeWidth()));
 		sql  = sql.replace("#{size_height}",String.valueOf(t.getSizeHeight()));
 		sql  = sql.replace("#{size_volume}",String.valueOf(t.getSizeVolume()));
 		sql  = sql.replace("#{time_to_market}",String.valueOf(t.getTimeToMarket()));
 		sql  = sql.replace("#{price_cost}",String.valueOf(t.getPriceCost()));
 		sql  = sql.replace("#{price_drop}",String.valueOf(t.getPriceDrop()));
 		sql  = sql.replace("#{price_standard_sell}",String.valueOf(t.getPriceStandardSell()));
 		sql  = sql.replace("#{price_standard_bid}",String.valueOf(t.getPriceStandardBid()));
 		sql  = sql.replace("#{price_trade}",String.valueOf(t.getPriceTrade()));
 		sql  = sql.replace("#{price_proxy}",String.valueOf(t.getPriceProxy()));
 		sql  = sql.replace("#{price_platform}",String.valueOf(t.getPricePlatform()));
 		sql  = sql.replace("#{gift}",String.valueOf(t.getGift()));
 		sql  = sql.replace("#{product_virtual}",String.valueOf(t.getProductVirtual()));
 		sql  = sql.replace("#{product_cost}",String.valueOf(t.getProductCost()));
 		sql  = sql.replace("#{point_pack}",String.valueOf(t.getPointPack()));
 		sql  = sql.replace("#{point_sell}",String.valueOf(t.getPointSell()));
 		sql  = sql.replace("#{product_uniqueness_code}",String.valueOf(t.getProductUniquenessCode()));
 		sql  = sql.replace("#{batch_manage}",String.valueOf(t.getBatchManage()));
 		sql  = sql.replace("#{product_single_code}",String.valueOf(t.getProductSingleCode()));
 		sql  = sql.replace("#{expiration_date}",String.valueOf(t.getExpirationDate()));
 		sql  = sql.replace("#{supply_of_material_round}",String.valueOf(t.getSupplyOfMaterialRound()));
 		sql  = sql.replace("#{safety_inventory}",String.valueOf(t.getSafetyInventory()));
 		sql  = sql.replace("#{international_code}",String.valueOf(t.getInternationalCode()));
 		sql  = sql.replace("#{remark}",String.valueOf(t.getRemark()));
 		sql  = sql.replace("#{product_state}",String.valueOf(t.getProductState()));
 		sql  = sql.replace("#{UUID}",UUID.randomUUID().toString());
 		return sql;
 	}
}