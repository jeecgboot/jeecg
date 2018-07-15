package org.jeecgframework.web.system.sms.util.msg.domain;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;

import org.apache.log4j.Logger;

/**
 * . 所有请求的消息头<br/>
 * totalLength 消息总长度<br/>
 * commandId 命令类型<br/>
 * sequenceId 消息流水号,顺序累加,步长为1,循环使用（一对请求和应答消息的流水号必须相同）<br/>
 * Unsigned Integer 无符号整数<br/>
 * Integer 整数，可为正整数、负整数或零<br/>
 * Octet String 定长字符串，位数不足时，如果左补0则补ASCII表示的零以填充，如果右补0则补二进制的零以表示字符串的结束符
 * 
 * @author skycc
 * 2014-11-17 11:34 
 */

public class MsgHead {
	private Logger logger = Logger.getLogger(MsgHead.class);
	private int totalLength;// Unsigned Integer 消息总长度
	private int commandId;// Unsigned Integer 命令类型
	private int sequenceId;// Unsigned Integer
							// 消息流水号,顺序累加,步长为1,循环使用（一对请求和应答消息的流水号必须相同）

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
			dous.close();
		} catch (IOException e) {
			logger.error("封装CMPP消息头二进制数组失败。");
		}
		return bous.toByteArray();
	}

	/**
	 * .
	 * 
	 * @param data
	 *            byte[]
	 */
	public MsgHead(byte[] data) {
		ByteArrayInputStream bins = new ByteArrayInputStream(data);
		DataInputStream dins = new DataInputStream(bins);
		try {
			this.setTotalLength(data.length + 4);
			this.setCommandId(dins.readInt());
			this.setSequenceId(dins.readInt());
			dins.close();
			bins.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * .
	 */
	public MsgHead() {
		super();
	}

	/**
	 * .
	 * 
	 * @return int
	 */
	public int getTotalLength() {
		return totalLength;
	}

	/**
	 * .
	 * 
	 * @param totalLength
	 *            int
	 */
	public void setTotalLength(int totalLength) {
		this.totalLength = totalLength;
	}

	/**
	 * .
	 * 
	 * @return int
	 */
	public int getCommandId() {
		return commandId;
	}

	/**
	 * .
	 * 
	 * @param commandId
	 *            int
	 */
	public void setCommandId(int commandId) {
		this.commandId = commandId;
	}

	/**
	 * .
	 * 
	 * @return int
	 */
	public int getSequenceId() {
		return sequenceId;
	}

	/**
	 * .
	 * 
	 * @param sequenceId
	 *            int
	 */
	public void setSequenceId(int sequenceId) {
		this.sequenceId = sequenceId;
	}
}
