package jeecg.demo.service.impl.test;

import java.io.IOException;
import java.sql.Blob;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import jeecg.demo.entity.test.JeecgBlobDataEntity;
import jeecg.demo.service.test.JeecgBlobDataServiceI;

import org.hibernate.LobHelper;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;

@Service("jeecgBlobDataService")
@Transactional
public class JeecgBlobDataServiceImpl extends CommonServiceImpl implements JeecgBlobDataServiceI {
	@Override
	public void saveObj(String documentTitle, MultipartFile file) {
		JeecgBlobDataEntity obj = new JeecgBlobDataEntity();
		LobHelper lobHelper = commonDao.getSession().getLobHelper();
		Blob data;
		try {
			data = lobHelper.createBlob(file.getInputStream(), 0);
			obj.setAttachmentcontent(data);
		} catch (IOException e) {
			e.printStackTrace();
		}
		obj.setAttachmenttitle(documentTitle);
		String sFileName = file.getOriginalFilename();
		int iPos = sFileName.lastIndexOf('.');
		if (iPos >= 0) {
			obj.setExtend(sFileName.substring(iPos+1));
		}
		super.save(obj);
	}
}