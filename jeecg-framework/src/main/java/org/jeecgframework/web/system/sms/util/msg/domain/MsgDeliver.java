package org.jeecgframework.web.system.sms.util.msg.domain;

import java.io.ByteArrayInputStream;
import java.io.DataInputStream;
import java.io.IOException;

import org.apache.log4j.Logger;

/**
 * CMPP_DELIVER操作的目的是ISMG把从短信中心或其它ISMG转发来的短信送交SP，SP以CMPP_DELIVER_RESP消息回应.
 */
public class MsgDeliver extends MsgHead {
	private static Logger logger = Logger.getLogger(MsgDeliver.class);
	private long msgId;
	private String destId;// 21 目的号码 String
	private String serviceId;// 10 业务标识 String
	private byte tPPid = 0;
	private byte tPUdhi = 0;
	private byte msgFmt = 15;
	private String srcTerminalId;// 源终端MSISDN号码
	private byte srcTerminalType = 0;// 源终端号码类型，0：真实号码；1：伪码
	private byte registeredDelivery = 0;// 是否为状态报告 0：非状态报告1：状态报告
	private byte msgLength;// 消息长度
	private String msgContent;// 消息长度
	private String linkID;

	private long msgIdReport;
	private String stat;
	private String submitTime;
	private String doneTime;
	private String destTerminalId;
	private int sMSCSequence;
	private int result;// 解析结果

	/**
	 * .
	 * 
	 * @param data
	 *            byte[]
	 */
	public MsgDeliver(byte[] data) {
		if (data.length > 8 + 8 + 21 + 10 + 1 + 1 + 1 + 32 + 1 + 1 + 1 + 20) {// +Msg_length+
			String fmtStr = "gb2312";
			ByteArrayInputStream bins = new ByteArrayInputStream(data);
			DataInputStream dins = new DataInputStream(bins);
			try {
				this.setTotalLength(data.length + 4);
				this.setCommandId(dins.readInt());
				this.setSequenceId(dins.readInt());
				this.msgId = dins.readLong();// Msg_Id
				byte[] destIdByte = new byte[21];
				dins.read(destIdByte);
				this.destId = new String(destIdByte);// 21 目的号码 String
				byte[] service_IdByte = new byte[10];
				dins.read(service_IdByte);
				this.serviceId = new String(service_IdByte);// 10 业务标识 String
				this.tPPid = dins.readByte();
				this.tPUdhi = dins.readByte();
				this.msgFmt = dins.readByte();
				fmtStr = this.msgFmt == 8 ? "utf-8" : "gb2312";
				byte[] src_terminal_IdByte = new byte[32];
				dins.read(src_terminal_IdByte);
				this.srcTerminalId = new String(src_terminal_IdByte);// 源终端MSISDN号码
				this.srcTerminalType = dins.readByte();// 源终端号码类型，0：真实号码；1：伪码
				this.registeredDelivery = dins.readByte();// 是否为状态报告
															// 0：非状态报告1：状态报告
				this.msgLength = dins.readByte();// 消息长度
				byte[] msg_ContentByte = new byte[msgLength];
				dins.read(msg_ContentByte);
				if (registeredDelivery == 1) {
					this.msgContent = new String(msg_ContentByte, fmtStr);// 消息长度
					if (msgLength == 8 + 7 + 10 + 10 + 21 + 4) {
						ByteArrayInputStream binsC = new ByteArrayInputStream(
								data);
						DataInputStream dinsC = new DataInputStream(binsC);
						this.msgIdReport = dinsC.readLong();
						byte[] startByte = new byte[7];
						dinsC.read(startByte);
						this.stat = new String(startByte, fmtStr);
						byte[] submit_timeByte = new byte[10];
						dinsC.read(submit_timeByte);
						this.submitTime = new String(submit_timeByte, fmtStr);
						byte[] done_timeByte = new byte[7];
						dinsC.read(done_timeByte);
						this.doneTime = new String(done_timeByte, fmtStr);
						byte[] dest_terminal_IdByte = new byte[21];
						dinsC.read(dest_terminal_IdByte);
						this.destTerminalId = new String(dest_terminal_IdByte,
								fmtStr);
						this.sMSCSequence = dinsC.readInt();
						dinsC.close();
						binsC.close();
						this.result = 0;// 正确
					} else {
						this.result = 1;// 消息结构错
					}
				} else {
					this.msgContent = new String(msg_ContentByte, fmtStr);// 消息长度
				}
				byte[] linkIDByte = new byte[20];
				this.linkID = new String(linkIDByte);
				this.result = 0;// 正确
				dins.close();
				bins.close();
			} catch (IOException e) {
				this.result = 8;// 消息结构错
			}
		} else {
			this.result = 1;// 消息结构错
			logger.info("短信网关CMPP_DELIVER,解析数据包出错，包长度不一致。长度为:" + data.length);
		}
	}

	/**
	 * .
	 * 
	 * @return long
	 */
	public long getMsgId() {
		return msgId;
	}

	/**
	 * .
	 * 
	 * @param msgId
	 *            long
	 */
	public void setMsgId(long msgId) {
		this.msgId = msgId;
	}

	/**
	 * .
	 * 
	 * @return String
	 */
	public String getDestId() {
		return destId;
	}

	/**
	 * .
	 * 
	 * @param destId
	 *            String
	 */
	public void setDestId(String destId) {
		this.destId = destId;
	}

	/**
	 * .
	 * 
	 * @return String
	 */
	public String getServiceId() {
		return serviceId;
	}

	/**
	 * .
	 * 
	 * @param serviceId
	 *            String
	 */
	public void setServiceId(String serviceId) {
		this.serviceId = serviceId;
	}

	/**
	 * .
	 * 
	 * @return byte
	 */
	public byte getTPPid() {
		return tPPid;
	}

	/**
	 * .
	 * 
	 * @param tpPid
	 *            byte
	 */
	public void setTPPid(byte tpPid) {
		tPPid = tpPid;
	}

	/**
	 * .
	 * 
	 * @return byte
	 */
	public byte getTPUdhi() {
		return tPUdhi;
	}

	/**
	 * .
	 * 
	 * @param tpUdhi
	 *            byte
	 */
	public void setTPUdhi(byte tpUdhi) {
		tPUdhi = tpUdhi;
	}

	/**
	 * .
	 * 
	 * @return byte
	 */
	public byte getMsgFmt() {
		return msgFmt;
	}

	/**
	 * .
	 * 
	 * @param msgFmt
	 *            byte
	 */
	public void setMsgFmt(byte msgFmt) {
		this.msgFmt = msgFmt;
	}

	/**
	 * .
	 * 
	 * @return String
	 */
	public String getSrcTerminalId() {
		return srcTerminalId;
	}

	/**
	 * .
	 * 
	 * @param srcTerminalId
	 *            String
	 */
	public void setSrcTerminalId(String srcTerminalId) {
		this.srcTerminalId = srcTerminalId;
	}

	/**
	 * .
	 * 
	 * @return byte
	 */
	public byte getSrcTerminalType() {
		return srcTerminalType;
	}

	/**
	 * .
	 * 
	 * @param srcTerminalType
	 *            byte
	 */
	public void setSrcTerminalType(byte srcTerminalType) {
		this.srcTerminalType = srcTerminalType;
	}

	/**
	 * .
	 * 
	 * @return byte
	 */
	public byte getRegisteredDelivery() {
		return registeredDelivery;
	}

	/**
	 * .
	 * 
	 * @param registeredDelivery
	 *            byte
	 */
	public void setRegisteredDelivery(byte registeredDelivery) {
		this.registeredDelivery = registeredDelivery;
	}

	/**
	 * .
	 * 
	 * @return byte
	 */
	public byte getMsgLength() {
		return msgLength;
	}

	/**
	 * .
	 * 
	 * @param msgLength
	 *            byte
	 */
	public void setMsgLength(byte msgLength) {
		this.msgLength = msgLength;
	}

	/**
	 * .
	 * 
	 * @return byte
	 */
	public String getMsgContent() {
		return msgContent;
	}

	/**
	 * .
	 * 
	 * @param msgContent
	 *            String
	 */
	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
	}

	/**
	 * .
	 * 
	 * @return String
	 */
	public String getLinkID() {
		return linkID;
	}

	/**
	 * .
	 * 
	 * @param linkID
	 *            String
	 */
	public void setLinkID(String linkID) {
		this.linkID = linkID;
	}

	/**
	 * .
	 * 
	 * @return long
	 */
	public long getMsgIdReport() {
		return msgIdReport;
	}

	/**
	 * .
	 * 
	 * @param msgIdReport
	 *            long
	 */
	public void setMsgIdReport(long msgIdReport) {
		this.msgIdReport = msgIdReport;
	}

	/**
	 * .
	 * 
	 * @return String
	 */
	public String getStat() {
		return stat;
	}

	/**
	 * .
	 * 
	 * @param stat
	 *            String
	 */
	public void setStat(String stat) {
		this.stat = stat;
	}

	/**
	 * .
	 * 
	 * @return String
	 */
	public String getSubmitTime() {
		return submitTime;
	}

	/**
	 * .
	 * 
	 * @param submitTime
	 *            String
	 */
	public void setSubmitTime(String submitTime) {
		this.submitTime = submitTime;
	}

	/**
	 * .
	 * 
	 * @return String
	 */
	public String getDoneTime() {
		return doneTime;
	}

	/**
	 * .
	 * 
	 * @param doneTime
	 *            String
	 */
	public void setDoneTime(String doneTime) {
		this.doneTime = doneTime;
	}

	/**
	 * .
	 * 
	 * @return String
	 */
	public String getDestTerminalId() {
		return destTerminalId;
	}

	/**
	 * .
	 * 
	 * @param destTerminalId
	 *            String
	 */
	public void setDestTerminalId(String destTerminalId) {
		this.destTerminalId = destTerminalId;
	}

	/**
	 * .
	 * 
	 * @return String
	 */
	public int getSMSCSequence() {
		return sMSCSequence;
	}

	/**
	 * .
	 * 
	 * @param sMSCSequence
	 *            int
	 */
	public void setSMSCSequence(int sMSCSequence) {
		this.sMSCSequence = sMSCSequence;
	}

	/**
	 * .
	 * 
	 * @return int
	 */
	public int getResult() {
		return result;
	}

	/**
	 * .
	 * 
	 * @param result
	 *            int
	 */
	public void setResult(int result) {
		this.result = result;
	}
}
