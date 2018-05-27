package org.jeecgframework.web.system.sms.util.msg.domain;

import java.io.ByteArrayInputStream;
import java.io.DataInputStream;
import java.io.IOException;

import org.apache.log4j.Logger;

/**
 * 提交代码后的应答消息解析.
 * 
 * @author 程川 <br />
 *         邮箱： cmzcheng@gmail.com <br />
 *         描述： <br />
 * @version:1.0.0 <br />
 *                日期： 2013-4-24 下午2:22:49 <br />
 *                CopyRight © 2012 chinaMobile.ahcmcc
 */
public class MsgSubmitResp extends MsgHead {
	private static Logger logger = Logger.getLogger(MsgSubmitResp.class);
	private long msgId;
	private int result;// 结果 0：正确 1：消息结构错 2：命令字错 3：消息序号重复 4：消息长度错 5：资费代码错
						// 6：超过最大信息长 7：业务代码错 8：流量控制错 9：本网关不负责服务此计费号码 10：Src_Id错误
						// 11：Msg_src错误 12：Fee_terminal_Id错误
						// 13：Dest_terminal_Id错误

	/**
	 * .
	 * 
	 * @param data
	 *            byte[]
	 */
	public MsgSubmitResp(byte[] data) {
		if (data.length == 8 + 8 + 4) {
			ByteArrayInputStream bins = new ByteArrayInputStream(data);
			DataInputStream dins = new DataInputStream(bins);
			try {
				this.setTotalLength(data.length + 4);
				this.setCommandId(dins.readInt());
				this.setSequenceId(dins.readInt());
				this.msgId = dins.readLong();
				this.result = dins.readInt();
				dins.close();
				bins.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			logger.info("发送短信IMSP回复,解析数据包出错，包长度不一致。长度为:" + data.length);
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
