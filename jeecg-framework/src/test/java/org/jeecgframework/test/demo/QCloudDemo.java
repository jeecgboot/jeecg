package org.jeecgframework.test.demo;

import com.alibaba.fastjson.JSONObject;
import org.jeecgframework.core.util.QCloudUtils;

public class QCloudDemo {

    public static void main(String[] args) {

        String cosFilePath = "/jeewx_logo.jpg";
        String localFilePath1 = "C:\\Users\\qinfeng\\Desktop\\jeewx_logo.jpg";
        //上传文件
        JSONObject getFileResult= QCloudUtils.upload(cosFilePath,localFilePath1);

        //获取文档列表
        //JSONObject getFileResult= QCloudUtils.listByFoler("/");
        System.out.println(getFileResult);
    }


}
