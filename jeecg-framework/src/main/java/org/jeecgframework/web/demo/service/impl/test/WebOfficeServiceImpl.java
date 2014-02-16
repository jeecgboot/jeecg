package org.jeecgframework.web.demo.service.impl.test;

import java.io.IOException;
import java.sql.Blob;
import java.util.Date;

import org.jeecgframework.web.demo.entity.test.WebOfficeEntity;
import org.jeecgframework.web.demo.service.test.WebOfficeServiceI;

import org.hibernate.LobHelper;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.util.StringUtil;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service("webOfficeService")
@Transactional
public class WebOfficeServiceImpl extends CommonServiceImpl implements WebOfficeServiceI {
	
	public void saveObj(WebOfficeEntity docObj, MultipartFile file) {
		WebOfficeEntity obj = null;
		if (StringUtil.isNotEmpty(docObj.getId())) {
			obj = commonDao.getEntity(WebOfficeEntity.class, docObj.getId());
			if (obj == null) {
				return;//fail
			}
		} else {
			obj = new WebOfficeEntity();
			BeanUtils.copyProperties(docObj, obj);
			String sFileName = file.getOriginalFilename();
			int iPos = sFileName.lastIndexOf('.');
			if (iPos >= 0) {
				obj.setDoctype(sFileName.substring(iPos+1));
			}
		}
		obj.setDocdate(new Date());
		LobHelper lobHelper = commonDao.getSession().getLobHelper();
		Blob data;
		try {
			data = lobHelper.createBlob(file.getInputStream(), 0);
			obj.setDoccontent(data);
		} catch (IOException e) {
			e.printStackTrace();
		}
		super.save(obj);
	}
}