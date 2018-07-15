package org.jeecgframework.web.system.sms.util.msg.domain;

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;

import org.apache.log4j.Logger;

import org.jeecgframework.web.system.sms.util.msg.util.MsgUtils;



/**
 * 提交短信的消息格式.
 * 
 * @author 程川 <br />
 *         邮箱： cmzcheng@gmail.com <br />
 *         描述： <br />
 * @version:1.0.0 <br />
 *                日期： 2013-4-24 下午2:22:28 <br />
 *                CopyRight © 2012 chinaMobile.ahcmcc
 */
public class MsgSubmit extends MsgHead {
	private static Logger logger = Logger.getLogger(MsgSubmit.class);
	private long msgId = 0;
	private byte pkTotal = 0x01;
	private byte pkNumber = 0x01;
	private byte registeredDelivery = 0x00;
	private byte msgLevel = 0x01;
	private String serviceId = "";
	private byte feeUserType = 0x00;// 谁接收，计谁的费
	private String feeTerminalId = "";
	private byte feeTerminalType = 0x00;
	private byte tpPId = 0x00;
	private byte tpUdhi = 0x00;
	private byte msgFmt = 0x0f;
	private String msgSrc;
	// 01：对“计费用户号码”免费；
	// 02：对“计费用户号码”按条计信息费；
	// 03：对“计费用户号码”按包月收取信息费

	private String feeType = "01";// 默认为按条
	private String feeCode = "000000";
	private String valIdTime = "";// 暂不支持
	private String atTime = "";// 暂不支持
	// SP的服务代码或前缀为服务代码的长号码,
	// 网关将该号码完整的填到SMPP协议Submit_SM消息相应的source_addr字段，该号码最终在用户手机上显示为短消息的主叫号码。
	private String srcId;
	private byte destUsrTl = 0x01;// 不支持群发
	private String destTerminalId;// 接收手机号码，
	private byte destTerminalType = 0x00;// 真实号码
	private byte msgLength;
	private byte[] msgContent;
	// 点播业务使用的LinkID，非点播类业务的MT流程不使用该字段
	private String linkID = "";

	/**
	 * .
	 * 
	 * @return byte[]
	 */
	public byte[] toByteArry() {
		ByteArrayOutputStream bous = new ByteArrayOutputStream();
		DataOutputStream dous = new DataOutputStream(bous);
		try {
			dous.writeInt(this.getTotalLength());
			dous.writeInt(this.getCommandId());
			dous.writeInt(this.getSequenceId());
			dous.writeLong(this.msgId);// Msg_Id 信息标识，由SP接入的短信网关本身产生，本处填空
			dous.writeByte(this.pkTotal);// Pk_total 相同Msg_Id的信息总条数
			dous.writeByte(this.pkNumber);// Pk_number 相同Msg_Id的信息序号，从1开始
			dous.writeByte(this.registeredDelivery);// Registered_Delivery
													// 是否要求返回状态确认报告
			dous.writeByte(this.msgLevel);// Msg_level 信息级别
			MsgUtils.writeString(dous, this.serviceId, 10);// Service_Id
															// 业务标识，是数字、字母和符号的组合。
			dous.writeByte(this.feeUserType);// Fee_UserType 计费用户类型字段
												// 0：对目的终端MSISDN计费；
												// 1：对源终端MSISDN计费；
												// 2：对SP计费;
												// 3：表示本字段无效，对谁计费参见Fee_terminal_Id字段。
			MsgUtils.writeString(dous, this.feeTerminalId, 32);// Fee_terminal_Id
																// 被计费用户的号码
			dous.writeByte(this.feeTerminalType);// Fee_terminal_type
													// 被计费用户的号码类型，0：真实号码；1：伪码
			dous.writeByte(this.tpPId);// TP_pId
			dous.writeByte(this.tpUdhi);// TP_udhi
			dous.writeByte(this.msgFmt);// Msg_Fmt
			MsgUtils.writeString(dous, this.msgSrc, 6);// Msg_src 信息内容来源(SP_Id)
			MsgUtils.writeString(dous, this.feeType, 2);// FeeType 资费类别
			MsgUtils.writeString(dous, this.feeCode, 6);// FeeCode
			MsgUtils.writeString(dous, this.valIdTime, 17);// 存活有效期
			MsgUtils.writeString(dous, this.atTime, 17);// 定时发送时间
			MsgUtils.writeString(dous, this.srcId, 21);// Src_Id spCode
			dous.writeByte(this.destUsrTl);// DestUsr_tl
			MsgUtils.writeString(dous, this.destTerminalId, 32);// Dest_terminal_Id
			dous.writeByte(this.destTerminalType);// Dest_terminal_type
													// 接收短信的用户的号码类型，0：真实号码；1：伪码
			dous.writeByte(this.msgLength);// Msg_Length
			dous.write(this.msgContent);// 信息内容
			MsgUtils.writeString(dous, this.linkID, 20);// 点播业务使用的LinkID
			dous.close();
		} catch (IOException e) {
			logger.error("封装短信发送二进制数组失败。");
		}
		return bous.toByteArray();
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
	 * @return long
	 */
	public long getPkTotal() {
		return pkTotal;
	}

	/**
	 * .
	 * 
	 * @param pkTotal
	 *            byte
	 */
	public void setPkTotal(byte pkTotal) {
		this.pkTotal = pkTotal;
	}

	/**
	 * .
	 * 
	 * @return byte
	 */
	public byte getPkNumber() {
		return pkNumber;
	}

	/**
	 * .
	 * 
	 * @param pkNumber
	 *            byte
	 */
	public void setPkNumber(byte pkNumber) {
		this.pkNumber = pkNumber;
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
	public byte getMsgLevel() {
		return msgLevel;
	}

	/**
	 * .
	 * 
	 * @param msgLevel
	 *            byte
	 */
	public void setMsgLevel(byte msgLevel) {
		this.msgLevel = msgLevel;
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
	public byte getFeeUserType() {
		return feeUserType;
	}

	/**
	 * .
	 * 
	 * @param feeUserType
	 *            byte
	 */
	public void setFeeUserType(byte feeUserType) {
		this.feeUserType = feeUserType;
	}

	/**
	 * .
	 * 
	 * @return String
	 */
	public String getFeeTerminalId() {
		return feeTerminalId;
	}

	/**
	 * .
	 * 
	 * @param feeTerminalId
	 *            String
	 */
	public void setFeeTerminalId(String feeTerminalId) {
		this.feeTerminalId = feeTerminalId;
	}

	/**
	 * .
	 * 
	 * @return byte
	 */
	public byte getFeeTerminalType() {
		return feeTerminalType;
	}

	/**
	 * .
	 * 
	 * @param feeTerminalType
	 *            byte
	 */
	public void setFeeTerminalType(byte feeTerminalType) {
		this.feeTerminalType = feeTerminalType;
	}

	/**
	 * .
	 * 
	 * @return byte
	 */
	public byte getTpPId() {
		return tpPId;
	}

	/**
	 * .
	 * 
	 * @param tpPId
	 *            byte
	 */
	public void setTpPId(byte tpPId) {
		this.tpPId = tpPId;
	}

	/**
	 * .
	 * 
	 * @return byte
	 */
	public byte getTpUdhi() {
		return tpUdhi;
	}

	/**
	 * .
	 * 
	 * @param tpUdhi
	 *            byte
	 */
	public void setTpUdhi(byte tpUdhi) {
		this.tpUdhi = tpUdhi;
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
	public String getMsgSrc() {
		return msgSrc;
	}

	/**
	 * .
	 * 
	 * @param msgSrc
	 *            String
	 */
	public void setMsgSrc(String msgSrc) {
		this.msgSrc = msgSrc;
	}

	/**
	 * .
	 * 
	 * @return String
	 */
	public String getFeeType() {
		return feeType;
	}

	/**
	 * .
	 * 
	 * @param feeType
	 *            String
	 */
	public void setFeeType(String feeType) {
		this.feeType = feeType;
	}

	/**
	 * .
	 * 
	 * @return String
	 */
	public String getFeeCode() {
		return feeCode;
	}

	/**
	 * .
	 * 
	 * @param feeCode
	 *            String
	 */
	public void setFeeCode(String feeCode) {
		this.feeCode = feeCode;
	}

	/**
	 * .
	 * 
	 * @return String
	 */
	public String getValIdTime() {
		return valIdTime;
	}

	/**
	 * .
	 * 
	 * @param valIdTime
	 *            String
	 */
	public void setValIdTime(String valIdTime) {
		this.valIdTime = valIdTime;
	}

	/**
	 * .
	 * 
	 * @return String
	 */
	public String getAtTime() {
		return atTime;
	}

	/**
	 * .
	 * 
	 * @param atTime
	 *            String
	 */
	public void setAtTime(String atTime) {
		this.atTime = atTime;
	}

	/**
	 * .
	 * 
	 * @return String
	 */
	public String getSrcId() {
		return srcId;
	}

	/**
	 * .
	 * 
	 * @param srcId
	 *            String
	 */
	public void setSrcId(String srcId) {
		this.srcId = srcId;
	}

	/**
	 * .
	 * 
	 * @return String
	 */
	public byte getDestUsrTl() {
		return destUsrTl;
	}

	/**
	 * .
	 * 
	 * @param destUsrTl
	 *            String
	 */
	public void setDestUsrTl(byte destUsrTl) {
		this.destUsrTl = destUsrTl;
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
	 * @return byte
	 */
	public byte getDestTerminalType() {
		return destTerminalType;
	}

	/**
	 * .
	 * 
	 * @param destTerminalType
	 *            byte
	 */
	public void setDestTerminalType(byte destTerminalType) {
		this.destTerminalType = destTerminalType;
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
	 * @return byte[]
	 */
	public byte[] getMsgContent() {
		return msgContent;
	}

	/**
	 * .
	 * 
	 * @param msgContent
	 *            byte[]
	 */
	public void setMsgContent(byte[] msgContent) {
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
}
