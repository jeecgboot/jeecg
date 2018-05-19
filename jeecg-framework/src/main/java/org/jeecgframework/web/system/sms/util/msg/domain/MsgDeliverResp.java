package org.jeecgframework.web.system.sms.util.msg.domain;

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;

import org.apache.log4j.Logger;

/**
 * 
 * SP以CMPP_DELIVER_RESP消息回应.
 * 
 * @author 程川 <br />
 *         邮箱： cmzcheng@gmail.com <br />
 *         描述： <br />
 * @version:1.0.0 <br />
 *                日期： 2013-4-24 下午2:20:07 <br />
 *                CopyRight © 2012 chinaMobile.ahcmcc
 */
public class MsgDeliverResp extends MsgHead {
	private static Logger logger = Logger.getLogger(MsgDeliverResp.class);
	private long msgId;// 信息标识（CMPP_DELIVER中的Msg_Id字段）
	private int result;// 结果 0：正确 1：消息结构错 2：命令字错 3：消息序号重复 4：消息长度错 5：资费代码错
						// 6：超过最大信息长 7：业务代码错8: 流量控制错9~ ：其他错误

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
			dous.writeLong(this.msgId);
			dous.writeInt(this.result);
			dous.close();
		} catch (IOException e) {
			logger.error("封装链接二进制数组失败。");
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
