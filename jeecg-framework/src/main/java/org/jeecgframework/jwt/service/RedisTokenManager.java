package org.jeecgframework.jwt.service;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import java.util.Date;
import java.util.concurrent.TimeUnit;

import org.jeecgframework.jwt.def.JwtConstants;
import org.jeecgframework.jwt.model.TokenModel;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

/**
 * 通过Redis存储和验证token的实现类
 * @author ScienJus
 * @date 2015/7/31.
 */
@Component
public class RedisTokenManager implements TokenManager {
	@Autowired
    private StringRedisTemplate redisTemplate;

    /**
     * 生成TOKEN
     */
    public String createToken(TSUser user) {
        //使用uuid作为源token
        String token = Jwts.builder().setId(user.getUserName()).setSubject(user.getUserName()).setIssuedAt(new Date()).signWith(SignatureAlgorithm.HS256, JwtConstants.JWT_SECRET).compact();
        //存储到redis并设置过期时间
        redisTemplate.boundValueOps(user.getUserName()).set(token, JwtConstants.TOKEN_EXPIRES_HOUR, TimeUnit.HOURS);
        return token;
    }
    
    public TokenModel getToken(String token,String userid) {
        return new TokenModel(userid, token);
    }

    public boolean checkToken(TokenModel model) {
        if (model == null) {
            return false;
        }
        String token = (String) redisTemplate.boundValueOps(model.getUsername()).get();
        if (token == null || !token.equals(model.getToken())) {
            return false;
        }
        //如果验证成功，说明此用户进行了一次有效操作，延长token的过期时间
        redisTemplate.boundValueOps(model.getUsername()).expire(JwtConstants.TOKEN_EXPIRES_HOUR, TimeUnit.HOURS);
        return true;
    }

    public void deleteToken(String username) {
        redisTemplate.delete(username);
    }
}
