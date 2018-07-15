package org.jeecgframework.jwt.util;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.SignatureException;

import org.jeecgframework.jwt.def.JwtConstants;

public class TestJwtSignToken {

	public static void main1(String[] args) {
		// 生成JWT签名
		String compactJws = Jwts.builder().setId("8a8ab0b246dc81120146dc8181950052").setSubject("admin").claim("age", "999").signWith(SignatureAlgorithm.HS512, JwtConstants.JWT_SECRET).compact();

		System.out.println(compactJws);

		try {
			// 验证JWT签名
			Jws<Claims> parseClaimsJws = Jwts.parser().setSigningKey(JwtConstants.JWT_SECRET).parseClaimsJws(compactJws);// compactJws为jwt字符串
			Claims body = parseClaimsJws.getBody();// 得到body后我们可以从body中获取我们需要的信息
			// 比如 获取主题,当然，这是我们在生成jwt字符串的时候就已经存进来的
			String subject = body.getSubject();
			System.out.println("subject:" + subject);
			System.out.println("body:" + body);
			System.out.println("id:" + body.getId());

			// OK, we can trust this JWT

		} catch (SignatureException e) {
			// TODO: handle exception
			// don't trust the JWT!
			// jwt 解析错误
			e.printStackTrace();
		} catch (ExpiredJwtException e) {
			// TODO: handle exception
			// jwt
			// 已经过期，在设置jwt的时候如果设置了过期时间，这里会自动判断jwt是否已经过期，如果过期则会抛出这个异常，我们可以抓住这个异常并作相关处理。
			e.printStackTrace();
		}
	}
}
