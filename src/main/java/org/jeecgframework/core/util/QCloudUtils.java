package org.jeecgframework.core.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.qcloud.cos.COSClient;
import com.qcloud.cos.ClientConfig;
import com.qcloud.cos.request.*;
import com.qcloud.cos.sign.Credentials;

public class QCloudUtils {
    private static long appId = 1251108935;
    private static String secretId = "?";
    private static String secretKey = "?";
    private static String bucketName="jeecg";
    private  static Credentials cred=new Credentials(appId, secretId, secretKey);
    private static ClientConfig clientConfig = new ClientConfig();
    private static COSClient cosClient;
    static {

        clientConfig.setRegion("tj");
        cosClient = new COSClient(clientConfig, cred);
    }
    /*上传文件*/
    public static JSONObject upload(String cosFilePath, String localFilePath1){
        UploadFileRequest uploadFileRequest =
                new UploadFileRequest(bucketName, cosFilePath, localFilePath1);
        uploadFileRequest.setEnableShaDigest(false);
        String uploadFileRet = cosClient.uploadFile(uploadFileRequest);
        return  JSONObject.parseObject(uploadFileRet);
    }
    /*上传文件*/
    public static JSONObject upload(String cosFilePath, byte[] contentBuffer){
        UploadFileRequest uploadFileRequest =
                new UploadFileRequest(bucketName, cosFilePath, contentBuffer);
        uploadFileRequest.setEnableShaDigest(false);
        String uploadFileRet = cosClient.uploadFile(uploadFileRequest);
        return  JSONObject.parseObject(uploadFileRet);
    }

    /*下载文件*/
    public static JSONObject download(String cosFilePath,String localPathDown){
        GetFileLocalRequest getFileLocalRequest =
                new GetFileLocalRequest(bucketName, cosFilePath, localPathDown);
        getFileLocalRequest.setUseCDN(false);
        getFileLocalRequest.setReferer("*.myweb.cn");
        String getFileResult = cosClient.getFileLocal(getFileLocalRequest);
        return JSON.parseObject(getFileResult);
    }

    /*list目录, 获取目录下的成员*/
    public static JSONObject listByFoler(String cosFolderPath){
        ListFolderRequest listFolderRequest = new ListFolderRequest(bucketName, cosFolderPath);
        String listFolderRet = cosClient.listFolder(listFolderRequest);
        return JSON.parseObject(listFolderRet);
    }

    /*删除文件*/
    public static JSONObject delFile(String cosFilePath){
        DelFileRequest delFileRequest = new DelFileRequest(bucketName, cosFilePath);
        String delFileRet = cosClient.delFile(delFileRequest);
        return JSON.parseObject(delFileRet);
    }
    /*删除文件夹*/
    public static JSONObject delFolder(String cosFolderPath){
        DelFolderRequest delFolderRequest = new DelFolderRequest(bucketName, cosFolderPath);
        String delFolderRet = cosClient.delFolder(delFolderRequest);
        return JSON.parseObject(delFolderRet);
    }


}
