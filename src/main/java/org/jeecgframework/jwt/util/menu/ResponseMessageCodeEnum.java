package org.jeecgframework.jwt.util.menu;

/**
 * 接口返回状态码
 * @author scott
 *
 */
public enum ResponseMessageCodeEnum {

    SUCCESS("0"),
    ERROR("-1"),
    VALID_ERROR("1000"),//校验失败
    SAVE_SUCCESS("r0001"),
    UPDATE_SUCCESS("r0002"),
    REMOVE_SUCCESS("r0003");

    private String code;

    ResponseMessageCodeEnum(String code) {
        this.code = code;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
}
