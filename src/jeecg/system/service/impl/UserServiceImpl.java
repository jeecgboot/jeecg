package jeecg.system.service.impl;

import jeecg.system.pojo.base.TSRoleUser;
import jeecg.system.pojo.base.TSUser;
import jeecg.system.service.UserService;

import org.hibernate.Criteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service("userService")
@Transactional
public class UserServiceImpl extends CommonServiceImpl implements UserService {

	public TSUser checkUserExits(TSUser user){
		return this.commonDao.getUserByUserIdAndUserNameExits(user);
	}
	public String getUserRole(TSUser user){
		return this.commonDao.getUserRole(user);
	}
	@Override
	public void pwdInit(TSUser user,String newPwd) {
			this.commonDao.pwdInit(user,newPwd);
	}
	@Override
	public int getUsersOfThisRole(String id) {
		Criteria criteria = getSession().createCriteria(TSRoleUser.class);
		criteria.add(Restrictions.eq("TSRole.id", id));
		int allCounts = ((Long) criteria.setProjection(
				Projections.rowCount()).uniqueResult()).intValue();
		return allCounts;
	}
	
}
