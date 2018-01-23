package org.jeecgframework.core.interceptors;

import com.alibaba.fastjson.JSONObject;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.web.cgform.util.SignatureUtil;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by dangzhenghui on 2017-4-1.
 */
public class SignInterceptor implements HandlerInterceptor {
    private static final String SIGN_KEY = "26F72780372E84B6CFAED6F7B19139CC47B1912B6CAED753";

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {

            JSONObject j=new JSONObject();
        try {
            String sign= request.getHeader("X-JEECG-SIGN");
            String body=request.getParameter("body");
            if (StringUtil.isEmpty(sign)) {
                throw new BusinessException("sign不能为空");
            }
            if (StringUtil.isEmpty(body)){
                throw new BusinessException("body不能为空");
            }
            Map<String, String> paramMap =new HashMap<String, String>();
            paramMap.put("body",body);
            if(!SignatureUtil.checkSign(paramMap, SIGN_KEY, sign)){
                throw new BusinessException("签名验证失败");
            }
        } catch (BusinessException e) {
            j.put("success","false");
            j.put("msg",e.getMessage());
            response.getWriter().print(j.toJSONString());
            return false;

        }


        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
