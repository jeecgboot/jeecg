package org.jeecgframework.web.system.sms.util.msg.util;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import org.jeecgframework.web.system.sms.util.msg.domain.MsgCommand;
import org.jeecgframework.web.system.sms.util.msg.domain.MsgConnect;
import org.jeecgframework.web.system.sms.util.msg.domain.MsgHead;
import org.jeecgframework.web.system.sms.util.msg.domain.MsgSubmit;


/**
 * 短信接口容器，单例获得链接对象.
 * 
 * @author 张科伟 2011-08-22 14:20
 * 
 */
public class MsgContainer {
	private static Logger logger = Logger.getLogger(MsgContainer.class);
	private static Socket msgSocket;
	private static DataInputStream in;
	private static DataOutputStream out;

	/**
	 * .
	 * 
	 * @return DataInputStream
	 */
	public static DataInputStream getSocketDIS() {
		if (in == null || null == msgSocket || msgSocket.isClosed()
				|| !msgSocket.isConnected()) {
			try {
				in = new DataInputStream(MsgContainer.getSocketInstance()
						.getInputStream());
			} catch (IOException e) {
				in = null;
			}
		}
		return in;
	}

	/**
	 * .
	 * 
	 * @return DataOutputStream
	 */
	public static DataOutputStream getSocketDOS() {
		if (out == null || null == msgSocket || msgSocket.isClosed()
				|| !msgSocket.isConnected()) {
			try {
				out = new DataOutputStream(MsgContainer.getSocketInstance()
						.getOutputStream());
			} catch (IOException e) {
				out = null;
			}
		}
		return out;
	}

	/**
	 * .
	 * 
	 * @return Socket
	 */
	public static Socket getSocketInstance() {
		if (null == msgSocket || msgSocket.isClosed()
				|| !msgSocket.isConnected()) {
			try {
				in = null;
				out = null;
				msgSocket = new Socket(MsgConfig.getIsmgIp(),
						MsgConfig.getIsmgPort());
				msgSocket.setKeepAlive(true);
				in = getSocketDIS();
				out = getSocketDOS();
				int count = 0;
				boolean result = connectISMG();
				logger.info("result" + result);
				while (!result) {
					count++;
					result = connectISMG();
					if (count >= (MsgConfig.getConnectCount() - 1)) {// 如果再次连接次数超过两次则终止连接
						break;
					}
				}// */
			} catch (UnknownHostException e) {
				logger.error("Socket链接短信网关端口号不正确：" + e.getMessage());
				// 链接短信网关
			} catch (IOException e) {
				logger.error("Socket链接短信网关失败：" + e.getMessage());
			}
		}
		return msgSocket;
	}

	/**
	 * 创建Socket链接后请求链接ISMG.
	 * 
	 * @return boolean
	 */
	private static boolean connectISMG() {
		MsgConnect connect = new MsgConnect();
		connect.setTotalLength(12 + 6 + 16 + 1 + 4);// 消息总长度，级总字节数:4+4+4(消息头)+6+16+1+4(消息主体)
		connect.setCommandId(MsgCommand.CMPP_CONNECT);// 标识创建连接
		connect.setSequenceId(MsgUtils.getSequence());// 序列，由我们指定
		connect.setSourceAddr(MsgConfig.getSpId());// 我们的企业代码
		connect.setAuthenticatorSource(MsgUtils.getAuthenticatorSource(
				MsgConfig.getSpId(), MsgConfig.getSpSharedSecret()));// md5(企业代码+密匙+时间戳)
		connect.setTimestamp(Integer.parseInt(MsgUtils.getTimestamp()));// 时间戳(MMDDHHMMSS)
		// connect.setTimestamp(1104230904);//时间戳(MMDDHHMMSS)423202240
		connect.setVersion((byte) 0x30);// 版本号 高4bit为3，低4位为0
		logger.error("消息长度:" + connect.getTotalLength());
		logger.error("标识:" + connect.getCommandId());
		logger.error("序列:" + connect.getSequenceId());
		logger.error("企业id:" + connect.getSourceAddr());
		logger.error("md5:" + connect.getAuthenticatorSource().length);
		logger.error("时间戳:" + connect.getTimestamp());
		logger.error("版本号:" + connect.getVersion());
		List<byte[]> dataList = new ArrayList<byte[]>();
		dataList.add(connect.toByteArry());
		CmppSender sender = new CmppSender(getSocketDOS(), getSocketDIS(),
				dataList);
		try {
			sender.start();
			return true;
		} catch (Exception e) {
			try {
				out.close();
			} catch (IOException e1) {
				out = null;
			}
			return false;
		}
	}

	/**
	 * 短信发送请求可直接调用此进行短信发送.
	 * 
	 * @param msg
	 *            String
	 * @param cusMsisdn
	 *            String
	 * @return boolean
	 */
	public static boolean sendMsg(String msg, String cusMsisdn) {
		try {
			if (msg.getBytes("utf-8").length < 140) {// 短短信
				boolean result = sendShortMsg(msg, cusMsisdn);
				int count = 0;
				while (!result) {
					count++;
					result = sendShortMsg(msg, cusMsisdn);
					if (count >= (MsgConfig.getConnectCount() - 1)) {// 如果再次连接次数超过两次则终止连接
						break;
					}
				}
				return result;
			} else {// 长短信
				boolean result = sendLongMsg(msg, cusMsisdn);
				int count = 0;
				while (!result) {
					count++;
					result = sendLongMsg(msg, cusMsisdn);
					if (count >= (MsgConfig.getConnectCount() - 1)) {// 如果再次连接次数超过两次则终止连接
						break;
					}
				}
				return result;
			}
		} catch (Exception e) {
			try {
				out.close();
			} catch (IOException e1) {
				out = null;
			}
			return false;
		}
	}

	/**
	 * 发送web push短信.
	 * 
	 * @param url
	 *            wap网址
	 * @param desc
	 *            描述
	 * @param cusMsisdn
	 *            短信
	 * @return boolean
	 */
	public static boolean sendWapPushMsg(String url, String desc,
			String cusMsisdn) {
		try {
			int msgContent = 12 + 9 + 9 + url.getBytes("utf-8").length + 3
					+ desc.getBytes("utf-8").length + 3;
			if (msgContent < 140) {
				boolean result = sendShortWapPushMsg(url, desc, cusMsisdn);
				int count = 0;
				while (!result) {
					count++;
					result = sendShortWapPushMsg(url, desc, cusMsisdn);
					if (count >= (MsgConfig.getConnectCount() - 1)) {// 如果再次连接次数超过两次则终止连接
						break;
					}
				}
				return result;
			} else {
				boolean result = sendLongWapPushMsg(url, desc, cusMsisdn);
				int count = 0;
				while (!result) {
					count++;
					result = sendLongWapPushMsg(url, desc, cusMsisdn);
					if (count >= (MsgConfig.getConnectCount() - 1)) {// 如果再次连接次数超过两次则终止连接
						break;
					}
				}
				return result;
			}
		} catch (Exception e) {
			try {
				out.close();
			} catch (IOException e1) {
				out = null;
			}
			logger.error("发送web push短信:" + e.getMessage());
			return false;
		}
	}

	/**
	 * 发送短短信.
	 * 
	 * @param msg
	 *            String
	 * @param cusMsisdn
	 *            String
	 * @return boolean
	 */
	private static boolean sendShortMsg(String msg, String cusMsisdn) {
		try {
			int seq = MsgUtils.getSequence();
			MsgSubmit submit = new MsgSubmit();
			submit.setTotalLength(12 + 8 + 1 + 1 + 1 + 1 + 10 + 1 + 32 + 1 + 1
					+ 1 + 1 + 6 + 2 + 6 + 17 + 17 + 21 + 1 + 32 + 1 + 1
					+ msg.length() * 2 + 20);
			submit.setCommandId(MsgCommand.CMPP_SUBMIT);
			submit.setSequenceId(seq);
			submit.setPkTotal((byte) 0x01);
			submit.setPkNumber((byte) 0x01);
			submit.setRegisteredDelivery((byte) 0x00);
			submit.setMsgLevel((byte) 0x01);
			submit.setFeeUserType((byte) 0x00);
			submit.setFeeTerminalId("");
			submit.setFeeTerminalType((byte) 0x00);
			submit.setTpPId((byte) 0x00);
			submit.setTpUdhi((byte) 0x00);
			submit.setMsgFmt((byte) 0x0f);
			submit.setMsgSrc(MsgConfig.getSpId());
			submit.setSrcId(MsgConfig.getSpCode());
			submit.setDestTerminalId(cusMsisdn);
			submit.setMsgLength((byte) (msg.length() * 2));
			submit.setMsgContent(msg.getBytes("gb2312"));

			List<byte[]> dataList = new ArrayList<byte[]>();
			dataList.add(submit.toByteArry());
			CmppSender sender = new CmppSender(getSocketDOS(), getSocketDIS(),
					dataList);
			sender.start();
			logger.info("数据乐园于"
					+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
							.format(new Date()) + "向" + cusMsisdn
					+ "下发短短信，序列号为:" + seq);
			return true;
		} catch (Exception e) {
			try {
				out.close();
			} catch (IOException e1) {
				out = null;
			}
			logger.error("发送短短信" + e.getMessage());
			return false;
		}
	}

	/**
	 * 发送长短信.
	 * 
	 * @param msg
	 *            String
	 * @param cusMsisdn
	 *            String
	 * @return boolean
	 */
	private static boolean sendLongMsg(String msg, String cusMsisdn) {
		try {
			byte[] allByte = msg.getBytes("UTF-16BE");
			List<byte[]> dataList = new ArrayList<byte[]>();
			int msgLength = allByte.length;
			int maxLength = 140;
			int msgSendCount = msgLength % (maxLength - 6) == 0 ? msgLength
					/ (maxLength - 6) : msgLength / (maxLength - 6) + 1;
			// 短信息内容头拼接
			byte[] msgHead = new byte[6];
			msgHead[0] = 0x05;
			msgHead[1] = 0x00;
			msgHead[2] = 0x03;
			msgHead[3] = (byte) MsgUtils.getSequence();
			msgHead[4] = (byte) msgSendCount;
			msgHead[5] = 0x01;
			int seqId = MsgUtils.getSequence();
			for (int i = 0; i < msgSendCount; i++) {
				// msgHead[3]=(byte)MsgUtils.getSequence();
				msgHead[5] = (byte) (i + 1);
				byte[] needMsg = null;
				// 消息头+消息内容拆分
				if (i != msgSendCount - 1) {
					int start = (maxLength - 6) * i;
					int end = (maxLength - 6) * (i + 1);
					needMsg = MsgUtils.getMsgBytes(allByte, start, end);
				} else {
					int start = (maxLength - 6) * i;
					int end = allByte.length;
					needMsg = MsgUtils.getMsgBytes(allByte, start, end);
				}
				int subLength = needMsg.length + msgHead.length;
				byte[] sendMsg = new byte[needMsg.length + msgHead.length];
				System.arraycopy(msgHead, 0, sendMsg, 0, 6);
				System.arraycopy(needMsg, 0, sendMsg, 6, needMsg.length);
				MsgSubmit submit = new MsgSubmit();
				submit.setTotalLength(12 + 8 + 1 + 1 + 1 + 1 + 10 + 1 + 32 + 1
						+ 1 + 1 + 1 + 6 + 2 + 6 + 17 + 17 + 21 + 1 + 32 + 1 + 1
						+ subLength + 20);
				submit.setCommandId(MsgCommand.CMPP_SUBMIT);
				submit.setSequenceId(seqId);
				submit.setPkTotal((byte) msgSendCount);
				submit.setPkNumber((byte) (i + 1));
				submit.setRegisteredDelivery((byte) 0x00);
				submit.setMsgLevel((byte) 0x01);
				submit.setFeeUserType((byte) 0x00);
				submit.setFeeTerminalId("");
				submit.setFeeTerminalType((byte) 0x00);
				submit.setTpPId((byte) 0x00);
				submit.setTpUdhi((byte) 0x01);
				submit.setMsgFmt((byte) 0x08);
				submit.setMsgSrc(MsgConfig.getSpId());
				submit.setSrcId(MsgConfig.getSpCode());
				submit.setDestTerminalId(cusMsisdn);
				submit.setMsgLength((byte) subLength);
				submit.setMsgContent(sendMsg);
				dataList.add(submit.toByteArry());
			}
			CmppSender sender = new CmppSender(getSocketDOS(), getSocketDIS(),
					dataList);
			sender.start();
			logger.info("数据乐园于"
					+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
							.format(new Date()) + "向" + cusMsisdn
					+ "下发长短信，序列号为:" + seqId);
			return true;
		} catch (Exception e) {
			try {
				out.close();
			} catch (IOException e1) {
				out = null;
			}
			logger.error("发送长短信" + e.getMessage());
			return false;
		}
	}

	/**
	 * 拆除与ISMG的链接.
	 * 
	 * @return boolean
	 */
	public static boolean cancelISMG() {
		try {
			MsgHead head = new MsgHead();
			head.setTotalLength(12);// 消息总长度，级总字节数:4+4+4(消息头)+6+16+1+4(消息主体)
			head.setCommandId(MsgCommand.CMPP_TERMINATE);// 标识创建连接
			head.setSequenceId(MsgUtils.getSequence());// 序列，由我们指定

			List<byte[]> dataList = new ArrayList<byte[]>();
			dataList.add(head.toByteArry());
			CmppSender sender = new CmppSender(getSocketDOS(), getSocketDIS(),
					dataList);
			sender.start();
			getSocketInstance().close();
			out.close();
			in.close();
			return true;
		} catch (Exception e) {
			try {
				out.close();
				in.close();
			} catch (IOException e1) {
				in = null;
				out = null;
			}
			logger.error("拆除与ISMG的链接" + e.getMessage());
			return false;
		}
	}

	/**
	 * 链路检查.
	 * 
	 * @return boolean
	 */
	public static boolean activityTestISMG() {
		try {
			logger.info("activityTestISMG================start");
			MsgHead head = new MsgHead();
			head.setTotalLength(12);// 消息总长度，级总字节数:4+4+4(消息头)+6+16+1+4(消息主体)
			head.setCommandId(MsgCommand.CMPP_ACTIVE_TEST);// 标识创建连接
			head.setSequenceId(MsgUtils.getSequence());// 序列，由我们指定
			List<byte[]> dataList = new ArrayList<byte[]>();
			dataList.add(head.toByteArry());
			CmppSender sender = new CmppSender(getSocketDOS(), getSocketDIS(),
					dataList);
			sender.start();
			logger.info("activityTestISMG================end");
			return true;
		} catch (Exception e) {
			try {
				out.close();
				logger.info("activityTestISMG================end");
			} catch (IOException e1) {
				out = null;
			}
			logger.error("链路检查" + e.getMessage());
			return false;
		}
	}

	/**
	 * 发送web push 短短信.
	 * 
	 * @param url
	 *            wap网址
	 * @param desc
	 *            描述
	 * @param cusMsisdn
	 *            短信
	 * @return boolean
	 */
	private static boolean sendShortWapPushMsg(String url, String desc,
			String cusMsisdn) {
		try {
			// length 12
			byte[] szWapPushHeader1 = { 0x0B, 0x05, 0x04, 0x0B, (byte) 0x84,
					0x23, (byte) 0xF0, 0x00, 0x03, 0x03, 0x01, 0x01 };
			// length 9
			byte[] szWapPushHeader2 = { 0x29, 0x06, 0x06, 0x03, (byte) 0xAE,
					(byte) 0x81, (byte) 0xEA, (byte) 0x8D, (byte) 0xCA };
			// length 9
			byte[] szWapPushIndicator = { 0x02, 0x05, 0x6A, 0x00, 0x45,
					(byte) 0xC6, 0x08, 0x0C, 0x03 };
			// 去除了http://前缀的UTF8编码的Url地址"的二进制编码
			byte[] szWapPushUrl = url.getBytes("utf-8");
			// length 3
			byte[] szWapPushDisplayTextHeader = { 0x00, 0x01, 0x03 };
			// 想在手机上显示的关于这个URL的文字说明,UTF8编码的二进制
			byte szMsg[] = desc.getBytes("utf-8");
			// length 3
			byte[] szEndOfWapPush = { 0x00, 0x01, 0x01 };
			int msgLength = 12 + 9 + 9 + szWapPushUrl.length + 3 + szMsg.length
					+ 3;
			int seq = MsgUtils.getSequence();
			MsgSubmit submit = new MsgSubmit();
			submit.setTotalLength(12 + 8 + 1 + 1 + 1 + 1 + 10 + 1 + 32 + 1 + 1
					+ 1 + 1 + 6 + 2 + 6 + 17 + 17 + 21 + 1 + 32 + 1 + 1
					+ msgLength + 20);
			submit.setCommandId(MsgCommand.CMPP_SUBMIT);
			submit.setSequenceId(seq);
			submit.setPkTotal((byte) 0x01);
			submit.setPkNumber((byte) 0x01);
			submit.setRegisteredDelivery((byte) 0x00);
			submit.setMsgLevel((byte) 0x01);
			submit.setFeeUserType((byte) 0x00);
			submit.setFeeTerminalId("");
			submit.setFeeTerminalType((byte) 0x00);
			submit.setTpPId((byte) 0x00);
			submit.setTpUdhi((byte) 0x01);
			submit.setMsgFmt((byte) 0x04);
			submit.setMsgSrc(MsgConfig.getSpId());
			submit.setSrcId(MsgConfig.getSpCode());
			submit.setDestTerminalId(cusMsisdn);
			submit.setMsgLength((byte) msgLength);
			byte[] sendMsg = new byte[12 + 9 + 9 + szWapPushUrl.length + 3
					+ szMsg.length + 3];
			System.arraycopy(szWapPushHeader1, 0, sendMsg, 0, 12);
			System.arraycopy(szWapPushHeader2, 0, sendMsg, 12, 9);
			System.arraycopy(szWapPushIndicator, 0, sendMsg, 12 + 9, 9);
			System.arraycopy(szWapPushUrl, 0, sendMsg, 12 + 9 + 9,
					szWapPushUrl.length);
			System.arraycopy(szWapPushDisplayTextHeader, 0, sendMsg,
					12 + 9 + 9 + szWapPushUrl.length, 3);
			System.arraycopy(szMsg, 0, sendMsg, 12 + 9 + 9
					+ szWapPushUrl.length + 3, szMsg.length);
			System.arraycopy(szEndOfWapPush, 0, sendMsg, 12 + 9 + 9
					+ szWapPushUrl.length + 3 + szMsg.length, 3);
			submit.setMsgContent(sendMsg);
			List<byte[]> dataList = new ArrayList<byte[]>();
			dataList.add(submit.toByteArry());
			CmppSender sender = new CmppSender(getSocketDOS(), getSocketDIS(),
					dataList);
			sender.start();
			logger.info("数据乐园于"
					+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
							.format(new Date()) + "向" + cusMsisdn
					+ "下发web push短短信，序列号为:" + seq);
			return true;
		} catch (Exception e) {
			try {
				out.close();
			} catch (IOException e1) {
				out = null;
			}
			logger.error("发送web push短短信" + e.getMessage());
			return false;
		}
	}

	/**
	 * 发送web push 长短信.
	 * 
	 * @param url
	 *            wap网址
	 * @param desc
	 *            描述
	 * @param cusMsisdn
	 *            短信
	 * @return boolean
	 */
	private static boolean sendLongWapPushMsg(String url, String desc,
			String cusMsisdn) {
		try {
			List<byte[]> dataList = new ArrayList<byte[]>();
			// length 12
			byte[] wdp = { 0x0B, 0x05, 0x04, 0x0B, (byte) 0x84, 0x23,
					(byte) 0xF0, 0x00, 0x03, 0x03, 0x01, 0x01 };
			// 需要拆分的部分
			// length 9
			byte[] wsp = { 0x29, 0x06, 0x06, 0x03, (byte) 0xAE, (byte) 0x81,
					(byte) 0xEA, (byte) 0x8D, (byte) 0xCA };
			// length 9
			byte[] szWapPushIndicator = { 0x02, 0x05, 0x6A, 0x00, 0x45,
					(byte) 0xC6, 0x08, 0x0C, 0x03 };
			// 去除了http://前缀的UTF8编码的Url地址"的二进制编码
			byte[] szWapPushUrl = url.getBytes("utf-8");
			// length 3
			byte[] szWapPushDisplayTextHeader = { 0x00, 0x01, 0x03 };
			// 想在手机上显示的关于这个URL的文字说明,UTF8编码的二进制
			byte szMsg[] = desc.getBytes("utf-8");
			// length 3
			byte[] szEndOfWapPush = { 0x00, 0x01, 0x01 };
			byte[] allByte = new byte[9 + 9 + szWapPushUrl.length + 3
					+ szMsg.length + 3];

			System.arraycopy(wsp, 0, allByte, 0, 9);
			System.arraycopy(szWapPushIndicator, 0, allByte, 9, 9);
			System.arraycopy(szWapPushUrl, 0, allByte, 18, szWapPushUrl.length);
			System.arraycopy(szWapPushDisplayTextHeader, 0, allByte,
					18 + szWapPushUrl.length, 3);
			System.arraycopy(szMsg, 0, allByte, 18 + szWapPushUrl.length + 3,
					szMsg.length);
			System.arraycopy(szEndOfWapPush, 0, allByte, 18
					+ szWapPushUrl.length + 3 + szMsg.length, 3);
			int msgMax = 140;
			int msgCount = allByte.length % (msgMax - wdp.length) == 0 ? allByte.length
					/ (msgMax - wdp.length)
					: allByte.length / (msgMax - wdp.length) + 1;
			wdp[10] = (byte) msgCount;
			int seqId = MsgUtils.getSequence();
			for (int i = 0; i < msgCount; i++) {
				wdp[11] = (byte) (i + 1);
				byte[] needMsg = null;
				// 消息头+消息内容拆分
				if (i != msgCount - 1) {
					int start = (msgMax - wdp.length) * i;
					int end = (msgMax - wdp.length) * (i + 1);
					needMsg = MsgUtils.getMsgBytes(allByte, start, end);
				} else {
					int start = (msgMax - wdp.length) * i;
					int end = allByte.length;
					needMsg = MsgUtils.getMsgBytes(allByte, start, end);
				}
				int msgLength = needMsg.length + wdp.length;
				MsgSubmit submit = new MsgSubmit();
				submit.setTotalLength(12 + 8 + 1 + 1 + 1 + 1 + 10 + 1 + 32 + 1
						+ 1 + 1 + 1 + 6 + 2 + 6 + 17 + 17 + 21 + 1 + 32 + 1 + 1
						+ msgLength + 20);
				submit.setCommandId(MsgCommand.CMPP_SUBMIT);
				submit.setSequenceId(seqId);
				submit.setPkTotal((byte) msgCount);
				submit.setPkNumber((byte) (i + 1));
				submit.setRegisteredDelivery((byte) 0x00);
				submit.setMsgLevel((byte) 0x01);
				submit.setFeeUserType((byte) 0x00);
				submit.setFeeTerminalId("");
				submit.setFeeTerminalType((byte) 0x00);
				submit.setTpPId((byte) 0x00);
				submit.setTpUdhi((byte) 0x01);
				submit.setMsgFmt((byte) 0x04);
				submit.setMsgSrc(MsgConfig.getSpId());
				submit.setSrcId(MsgConfig.getSpCode());
				submit.setDestTerminalId(cusMsisdn);
				submit.setMsgLength((byte) msgLength);
				byte[] sendMsg = new byte[wdp.length + needMsg.length];
				System.arraycopy(wdp, 0, sendMsg, 0, wdp.length);
				System.arraycopy(needMsg, 0, sendMsg, wdp.length,
						needMsg.length);
				submit.setMsgContent(sendMsg);
				dataList.add(submit.toByteArry());
			}
			CmppSender sender = new CmppSender(getSocketDOS(), getSocketDIS(),
					dataList);
			sender.start();
			logger.info("数据乐园于"
					+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
							.format(new Date()) + "向" + cusMsisdn
					+ "下发web pus长短信，序列号为:" + seqId);
			return true;
		} catch (Exception e) {
			try {
				out.close();
			} catch (IOException e1) {
				out = null;
			}
			logger.error("发送web push长短信" + e.getMessage());
			return false;
		}
	}
}
