package org.jeecgframework.web.cgform.enhance;

import org.jeecgframework.core.common.exception.BusinessException;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * Created by zzl_h on 2015/11/24.
 */
@Service("cgformJavaInterDemo")
public class CgformJavaInterDemo implements CgformEnhanceJavaInter {
    @Override
    public void execute(Map map) throws BusinessException {
        System.out.println("============调用[java增强]成功!==============");
    }
}
