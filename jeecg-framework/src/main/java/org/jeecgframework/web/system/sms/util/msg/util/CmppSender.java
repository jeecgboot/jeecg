package org.jeecgframework.web.system.sms.util.msg.util;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.EOFException;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import org.jeecgframework.web.system.sms.util.msg.domain.MsgActiveTestResp;
import org.jeecgframework.web.system.sms.util.msg.domain.MsgCommand;
import org.jeecgframework.web.system.sms.util.msg.domain.MsgConnectResp;
import org.jeecgframework.web.system.sms.util.msg.domain.MsgDeliver;
import org.jeecgframework.web.system.sms.util.msg.domain.MsgDeliverResp;
import org.jeecgframework.web.system.sms.util.msg.domain.MsgHead;
import org.jeecgframework.web.system.sms.util.msg.domain.MsgSubmitResp;



/**
 * 启动一个线程去接收和发送数据，如果队列处理完毕就关闭线程.
 * 
 * @author 、skycc
 * @date 2014-11-17
 */
public class CmppSender {
	private static Logger logger = Logger.getLogger(CmppSender.class);
	private List<byte[]> sendData = new ArrayList<byte[]>();// 需要发出的二进制数据队列
	private List<byte[]> getData = new ArrayList<byte[]>();// 需要接受的二进制队列
	private DataOutputStream out;
	private DataInputStream in;

	/**
	 * .
	 * 
	 * @param out
	 *            DataOutputStream
	 * @param in
	 *            DataInputStream
	 * @param sendData
	 *            List<byte[]>
	 */
	public CmppSender(DataOutputStream out, DataInputStream in,
			List<byte[]> sendData) {
		super();
		this.sendData = sendData;
		this.out = out;
		this.in = in;
	}

	/**
	 * .
	 * 
	 * @throws Exception
	 *             Exception
	 */
	public void start() throws Exception {
		if (out != null && null != sendData) {
			for (byte[] data : sendData) {
				logger.info("发送的二进制队列里data长度====" + data.length);
				sendMsg(data);
				byte[] returnData = getInData();
				logger.info("发送的二进制队列里响应值的长度====" + returnData.length);
				if (null != returnData) {
					getData.add(returnData);
				}
			}
		}
		if (in != null && null != getData) {
			for (byte[] data : getData) {
				logger.info("接收的二进制队列里data长度====" + data.length);
				if (data.length >= 8) {
					MsgHead head = new MsgHead(data);
					switch (head.getCommandId()) {
					case MsgCommand.CMPP_CONNECT_RESP:
						logger.info("链接至短信网关之前data长度====" + data.length);
						MsgConnectResp connectResp = new MsgConnectResp(data);
						logger.info("快消平台"
								+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
										.format(new Date()) + "链接短信网关,状态:"
								+ connectResp.getStatusStr() + " 序列号："
								+ connectResp.getSequenceId());
						break;
					case MsgCommand.CMPP_ACTIVE_TEST_RESP:
						MsgActiveTestResp activeResp = new MsgActiveTestResp(
								data);
						logger.info("快消平台"
								+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
										.format(new Date()) + "短信网关与短信网关进行连接检查"
								+ " 序列号：" + activeResp.getSequenceId());
						break;
					case MsgCommand.CMPP_SUBMIT_RESP:
						MsgSubmitResp submitResp = new MsgSubmitResp(data);
						logger.info("快消平台"
								+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
										.format(new Date()) + "向用户下发短信，状态码:"
								+ submitResp.getResult() + " 序列号："
								+ submitResp.getSequenceId());
						break;
					case MsgCommand.CMPP_TERMINATE_RESP:
						logger.info("快消平台"
								+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
										.format(new Date()) + "拆除与ISMG的链接"
								+ " 序列号：" + head.getSequenceId());
						break;
					case MsgCommand.CMPP_CANCEL_RESP:
						logger.info("CMPP_CANCEL_RESP 序列号："
								+ head.getSequenceId());
						break;
					case MsgCommand.CMPP_CANCEL:
						logger.info("CMPP_CANCEL 序列号：" + head.getSequenceId());
						break;
					case MsgCommand.CMPP_DELIVER:
						MsgDeliver msgDeliver = new MsgDeliver(data);
						if (msgDeliver.getResult() == 0) {
							logger.info("CMPP_DELIVER 序列号："
									+ head.getSequenceId()
									+ "，是否消息回复"
									+ (msgDeliver.getRegisteredDelivery() == 0 ? "不是,消息内容："
											+ msgDeliver.getMsgContent()
											: "是，目的手机号："
													+ msgDeliver
															.getDestTerminalId()));
						} else {
							logger.info("CMPP_DELIVER 序列号："
									+ head.getSequenceId());
						}
						MsgDeliverResp msgDeliverResp = new MsgDeliverResp();
						msgDeliverResp.setTotalLength(12 + 8 + 4);
						msgDeliverResp
								.setCommandId(MsgCommand.CMPP_DELIVER_RESP);
						msgDeliverResp.setSequenceId(MsgUtils.getSequence());
						msgDeliverResp.setMsgId(msgDeliver.getMsgId());
						msgDeliverResp.setResult(msgDeliver.getResult());
						sendMsg(msgDeliverResp.toByteArry());// 进行回复
						break;
					case MsgCommand.CMPP_DELIVER_RESP:
						logger.info("CMPP_DELIVER_RESP 序列号："
								+ head.getSequenceId());
						break;
					case MsgCommand.CMPP_QUERY:
						logger.info("CMPP_QUERY 序列号：" + head.getSequenceId());
						break;
					case MsgCommand.CMPP_QUERY_RESP:
						logger.info("CMPP_QUERY_RESP 序列号："
								+ head.getSequenceId());
						break;
					case MsgCommand.CMPP_TERMINATE:
						logger.info("CMPP_TERMINATE 序列号："
								+ head.getSequenceId());
						break;
					case MsgCommand.CMPP_CONNECT:
						logger.info("CMPP_CONNECT 序列号：" + head.getSequenceId());
						break;
					case MsgCommand.CMPP_ACTIVE_TEST:
						logger.info("CMPP_ACTIVE_TEST 序列号："
								+ head.getSequenceId());
						break;
					case MsgCommand.CMPP_SUBMIT:
						logger.info("CMPP_SUBMIT 序列号：" + head.getSequenceId());
						break;
					default:
						logger.error("无法解析IMSP返回的包结构：包长度为"
								+ head.getTotalLength());
						break;
					}
				}
			}
		}
	}

	/**
	 * .
	 * 
	 * @return List<byte[]>
	 */
	public List<byte[]> getGetData() {
		return getData;
	}

	/**
	 * 在本连结上发送已打包后的消息的字节.
	 * 
	 * @param data
	 *            :要发送消息的字节
	 * @return boolean
	 * 
	 * @exception Exception Exception
	 */
	private boolean sendMsg(byte[] data) throws Exception {
		try {
			out.write(data);
			out.flush();
			return true;
		} catch (NullPointerException ef) {
			logger.error("在本连结上发送已打包后的消息的字节:无字节输入");
		}
		return false;
	}
/**
 * .
 * @return byte[]
 * @throws IOException IOException
 * 
 */
	private byte[] getInData() throws IOException {
		try {
			int len = in.readInt();
			logger.info("输入的流里读取的len==" + len);
			if (null != in && 0 != len) {
				byte[] data = new byte[len - 4];
				in.read(data);
				return data;
			} else {
				return null;
			}
		} catch (NullPointerException ef) {
			logger.error("在本连结上接受字节消息:无流输入");
			return null;
		} catch (EOFException eof) {
			logger.error("在本连结上接受字节消息:" + eof.getMessage());
			return null;
		}
	}
}
