package org.jeecgframework.jwt.service;

import org.jeecgframework.jwt.model.TokenModel;
import org.jeecgframework.web.system.pojo.base.TSUser;

/**
 * 对token进行操作的接口
 * @author ScienJus
 * @date 2015/7/31.
 */
public interface TokenManager {

    /**
     * 创建一个token关联上指定用户
     * @param username  用户账号
     * @param userpaswd 用户密码
     * @return 生成的token
     */
    public String createToken(TSUser user);

    /**
     * 检查token是否有效
     * @param model token
     * @return 是否有效
     */
    public boolean checkToken(TokenModel model);

    /**
     * 从字符串中解析token
     * @param authentication 加密后的字符串
     * @return
     */
    public TokenModel getToken(String token,String userid);

    /**
     * 清除token
     * @param username 登录用户账号
     */
    public void deleteToken(String username);

}
