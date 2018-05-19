// ~ CopyRight © 2012 USTC SINOVATE  SOFTWARE CO.LTD All Rights Reserved.

package org.jeecgframework.web.system.sms.util;

import java.util.Date;
import java.util.Properties;

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.jeecgframework.core.util.PropertiesUtil;


/*
 * 邮箱发送辅助类
 * @author skycc
 * @date 2014-11-16
 */
public class MailUtil {

	/**
	 * 发送电子邮件
	 * 
	 * @param smtpHost
	 *            发信主机
	 * @param receiver
	 *            邮件接收者
	 * @param title
	 *            邮件的标题
	 * @param content
	 *            邮件的内容
	 * @param sender
	 *            邮件发送者
	 * @param user
	 *            发送者邮箱用户名
	 * @param pwd
	 *            发送者邮箱密码
	 * @throws MessagingException 
	 */
	public static void sendEmail(String smtpHost, String receiver,
			String title, String content, String sender, String user, String pwd) throws MessagingException
			 {
		Properties props = new Properties();
		props.put("mail.host", smtpHost);
		props.put("mail.transport.protocol", "smtp");
		// props.put("mail.smtp.host",smtpHost);//发信的主机，这里要把您的域名的SMTP指向正确的邮件服务器上，这里一般不要动！
		props.put("mail.smtp.auth", "true");
		Session s = Session.getDefaultInstance(props);
		s.setDebug(true);
		MimeMessage message = new MimeMessage(s);
		// 给消息对象设置发件人/收件人/主题/发信时间
		// 发件人的邮箱
		InternetAddress from = new InternetAddress(sender);
		message.setFrom(from);
		InternetAddress to = new InternetAddress(receiver);
		message.setRecipient(Message.RecipientType.TO, to);
		message.setSubject(title);
		message.setSentDate(new Date());
		// 给消息对象设置内容
		BodyPart mdp = new MimeBodyPart();// 新建一个存放信件内容的BodyPart对象
		mdp.setContent(content, "text/html;charset=gb2312");// 给BodyPart对象设置内容和格式/编码方式防止邮件出现乱码
		Multipart mm = new MimeMultipart();// 新建一个MimeMultipart对象用来存放BodyPart对
		// 象(事实上可以存放多个)
		mm.addBodyPart(mdp);// 将BodyPart加入到MimeMultipart对象中(可以加入多个BodyPart)
		message.setContent(mm);// 把mm作为消息对象的内容

		message.saveChanges();
		Transport transport = s.getTransport("smtp");
		transport.connect(smtpHost, user, pwd);// 设置发邮件的网关，发信的帐户和密码，这里修改为您自己用的
		transport.sendMessage(message, message.getAllRecipients());
		transport.close();
	}

	/**
	 * 发送电子邮件
	 * 
	 * @param smtpHost
	 *            发信主机
	 * @param receiver
	 *            邮件接收者
	 * @param copy
	 *            抄送列表
	 * @param title
	 *            邮件的标题
	 * @param content
	 *            邮件的内容
	 * @param sender
	 *            邮件发送者
	 * @param user
	 *            发送者邮箱用户名
	 * @param pwd
	 *            发送者邮箱密码
	 * @throws Exception
	 */
	public static void sendEmail(String smtpHost, String receiver, String copy,
			String title, String content, String sender, String user, String pwd)
			throws Exception {
		Properties props = new Properties();
		props.put("mail.host", smtpHost);
		props.put("mail.transport.protocol", "smtp");
		// props.put("mail.smtp.host",smtpHost);//发信的主机，这里要把您的域名的SMTP指向正确的邮件服务器上，这里一般不要动！
		props.put("mail.smtp.auth", "true");
		Session s = Session.getDefaultInstance(props);
		s.setDebug(true);
		MimeMessage message = new MimeMessage(s);
		// 给消息对象设置发件人/收件人/主题/发信时间
		// 发件人的邮箱
		InternetAddress from = new InternetAddress(sender);
		message.setFrom(from);
		String[] receivers = receiver.split(",");
		InternetAddress[] to = new InternetAddress[receivers.length];
		for (int i = 0; i < receivers.length; i++) {
			to[i] = new InternetAddress(receivers[i]);
		}
		message.setRecipients(Message.RecipientType.TO, to);

		String[] copys = copy.split(",");
		InternetAddress[] cc = new InternetAddress[copys.length];
		for (int i = 0; i < copys.length; i++) {
			cc[i] = new InternetAddress(copys[i]);
		}
		message.setRecipients(Message.RecipientType.CC, cc);

		message.setSubject(title);
		message.setSentDate(new Date());
		// 给消息对象设置内容
		BodyPart mdp = new MimeBodyPart();// 新建一个存放信件内容的BodyPart对象
		mdp.setContent(content, "text/html;charset=gb2312");// 给BodyPart对象设置内容和格式/编码方式防止邮件出现乱码
		Multipart mm = new MimeMultipart();// 新建一个MimeMultipart对象用来存放BodyPart对
		// 象(事实上可以存放多个)
		mm.addBodyPart(mdp);// 将BodyPart加入到MimeMultipart对象中(可以加入多个BodyPart)
		message.setContent(mm);// 把mm作为消息对象的内容

		message.saveChanges();
		Transport transport = s.getTransport("smtp");
		transport.connect(smtpHost, user, pwd);// 设置发邮件的网关，发信的帐户和密码，这里修改为您自己用的
		transport.sendMessage(message, message.getAllRecipients());
		transport.close();
	}
	
	public static void main(String[] args) {
		try {
//			sendEmail("smtp.126.com", "411944058@qq.com", "系统测试邮件", 
//					"hi,all,I am AnChao!111", "anchaodaren@126.com", 
//					"anchaodaren", "*******************");
			
			sendEmail("smtp.163.com", "418799587@qq.com", "系统测试邮件", 
					"hi,all,I am AnChao!111", "tjrzlm@163.com", 
					"tjrzlm", "tj123456");
//			PropertiesUtil util = new PropertiesUtil("sysConfig.properties");
//			sendEmail(util.readProperty("mail.smtpHost"), "411944058@qq.com","系统测试邮件", 
//					"hi,all,I am AnChao!nana", util.readProperty("mail.sender"), 
//					util.readProperty("mail.user"), util.readProperty("mail.pwd"));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
