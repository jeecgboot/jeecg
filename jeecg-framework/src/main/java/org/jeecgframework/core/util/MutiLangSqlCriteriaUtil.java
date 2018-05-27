package org.jeecgframework.core.util;

import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 多语言sql的查询参数工具类
 * <p/>
 * <p><b>User:</b> zhanggm <a href="mailto:guomingzhang2008@163.com">guomingzhang2008@gmail.com</a></p>
 * <p><b>Date:</b> 2014-08-07 16:00</p>
 *
 * @author 张国明
 */
public class MutiLangSqlCriteriaUtil {
    /**
     * 组装查询条件：对多语言字段进行 查询条件的组装
     * @param fieldLangKeyList 待查询字段对应的语言key列表
     * @param cq 查询条件实体 - CriteriaQuery
     * @param fieldName 待查询字段名称
     * @param fieldValue 待查询字段值 - 页面传入
     */
    public static void assembleCondition(List<String> fieldLangKeyList, CriteriaQuery cq, String fieldName, String fieldValue) {
        Map<String,String> fieldLangMap = new HashMap<String, String>();
        for (String nameKey : fieldLangKeyList) {
            String name = MutiLangUtil.getLang(nameKey);
            fieldLangMap.put(nameKey, name);
        }

        if("*".equals(fieldValue)) {
            fieldValue = "**";
        }
        List<String> paramValueList = new ArrayList<String>();
        for (Map.Entry<String, String> entry : fieldLangMap.entrySet()) {
            String fieldLangKey = entry.getKey();
            String fieldLangValue = entry.getValue();
            if (fieldValue.startsWith("*") && fieldValue.endsWith("*")) {
                if (fieldLangValue.contains(fieldValue.substring(1, fieldValue.length() -1))) {
                    paramValueList.add(fieldLangKey);
                }
            } else if(fieldValue.startsWith("*")) {
                if (fieldLangValue.endsWith(fieldValue.substring(1))) {
                    paramValueList.add(fieldLangKey);
                }
            } else if(fieldValue.endsWith("*")) {
                if (fieldLangValue.startsWith(fieldValue.substring(0, fieldValue.length() -1))) {
                    paramValueList.add(fieldLangKey);
                }
            } else {
                if (fieldLangValue.equals(fieldValue)) {
                    paramValueList.add(fieldLangKey);
                }
            }
        }

        if (paramValueList.size() == 0) {
            paramValueList.add("~!@#$%_()*&^"); // 设置一个错误的key值。
        }
        cq.in(fieldName, paramValueList.toArray());
        cq.add();
    }
}
