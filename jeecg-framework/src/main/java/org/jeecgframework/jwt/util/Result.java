package org.jeecgframework.jwt.util;

import org.jeecgframework.jwt.util.menu.ResponseMessageCodeEnum;

/**
 * restful 接口响应返回结果工具类
 * @author scott
 *
 */
public class Result {

	private static final ResponseMessage RESPONSE_MESSAGE_SUCCESS = new ResponseMessage(ResponseMessageCodeEnum.SUCCESS, "成功",true,null);

    public static ResponseMessage success() {
        return RESPONSE_MESSAGE_SUCCESS;
    }
    
    public static <T> ResponseMessage<T> success(T t) {
        return new ResponseMessage(ResponseMessageCodeEnum.SUCCESS, "成功", true, t);
    }
    
    public static <T> ResponseMessage<T> success(ResponseMessageCodeEnum codeEnum, T t) {
        return new ResponseMessage(codeEnum, "", true, t);
    }

    public static <T> ResponseMessage<T> success(ResponseMessageCodeEnum codeEnum, String message, T t) {
        return new ResponseMessage(codeEnum, message, true, t);
    }

    public static ResponseMessage error() {
        return error("失败");
    }

    public static ResponseMessage error(String message) {
        return error(ResponseMessageCodeEnum.ERROR, message);
    }

    public static ResponseMessage error(ResponseMessageCodeEnum codeEnum, String message) {
        return error(codeEnum, message, null);
    }

    public static <T> ResponseMessage<T> error(ResponseMessageCodeEnum codeEnum, String message, T t) {
        return new ResponseMessage(codeEnum, message, false, t);
    }
    
    /**
     * 校验失败错误结果
     * @param <T>
     * @param t
     * @return
     */
    public static <T> ResponseMessage<T> errorValid(T t) {
    	return new ResponseMessage(ResponseMessageCodeEnum.VALID_ERROR, "校验失败", false, t);
    }
}
