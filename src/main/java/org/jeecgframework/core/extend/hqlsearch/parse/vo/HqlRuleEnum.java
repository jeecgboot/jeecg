package org.jeecgframework.core.extend.hqlsearch.parse.vo;

/**
 * HQL 规则 常量
 * Created by jue on 14-8-23.
 */
public enum HqlRuleEnum {

    GT(">","大于"),
    GE(">=","大于等于"),
    LT("<","小于"),
    LE("<=","小于等于"),
    EQ("=","等于"),
    NE("!=","不等于"),
    IN("IN","包含"),
    LIKE("LIKE","左右模糊"),
    LEFT_LIKE("LEFT_LIKE","左模糊"),
    RIGHT_LIKE("RIGHT_LIKE","右模糊");

    private String value;

    private String msg;

    HqlRuleEnum(String value, String msg){
        this.value = value;
        this.msg = msg;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public static HqlRuleEnum getByValue(String value){
        for(HqlRuleEnum val :values()){
            if (val.getValue().equals(value)){
                return val;
            }
        }
        return  null;
    }
}
