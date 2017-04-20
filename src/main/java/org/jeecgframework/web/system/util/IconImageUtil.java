package org.jeecgframework.web.system.util;

import org.jeecgframework.web.system.pojo.base.TSIcon;
import org.jeecgframework.core.common.model.json.DataGrid;

import javax.imageio.stream.FileImageOutputStream;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.util.List;
import java.util.UUID;

/**
 * User: MaCiCi
 * Date: 13-7-26
 * Time: 下午2:07
 */
public class IconImageUtil {
    /**
     * 把数据库中图片byte，存到项目temp目录下，并且把路径返设置给TsIcon
     * @param dataGrid
     * @param request
     */
    public static void convertDataGrid(DataGrid dataGrid,HttpServletRequest request){
        String fileDirName=request.getSession().getServletContext().getRealPath("")+File.separator+"temp";
        delFolder(fileDirName);
        File fileDir = new File(fileDirName);
        if (!fileDir.exists()) {
            fileDir.mkdirs();
        }
        try {
            List list=dataGrid.getResults();
            for(Object obj:list){
                TSIcon icon=(TSIcon)obj;
                String fileName="icon"+ UUID.randomUUID()+"."+icon.getExtend();
                File tempFile=new File(fileDirName+File.separator+fileName);
                if(icon.getIconContent()!=null){
                byte2image(icon.getIconContent(),tempFile);
                icon.setIconPath("temp/"+fileName);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //byte数组到图片
    private static void byte2image(byte[] data,File file){
        if( data.length < 3 ) return;
        FileImageOutputStream imageOutput = null;
        String fileName=null;
        try {
            imageOutput = new FileImageOutputStream(file);
            imageOutput.write(data, 0, data.length);
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                imageOutput.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 删除文件夹
     * @param folderPath 文件夹完整绝对路径
     */
    private static void delFolder(String folderPath) {
        try {
            delAllFile(folderPath); //删除完里面所有内容
            File folder = new File(folderPath);
            folder.delete(); //删除空文件夹
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    /**
     * 删除指定文件夹下所有文件
     * @param path 文件夹完整绝对路径
     * @return
     */
    private static boolean delAllFile(String path) {
        boolean flag = false;
        File file = new File(path);
        if (!file.exists()) {
            return flag;
        }
        if (!file.isDirectory()) {
            return flag;
        }
        String[] tempList = file.list();
        File temp = null;
        for (int i = 0; i < tempList.length; i++) {
            if (path.endsWith(File.separator)) {
                temp = new File(path + tempList[i]);
            } else {
                temp = new File(path + File.separator + tempList[i]);
            }
            if (temp.isFile()) {
                temp.delete();
            }
            if (temp.isDirectory()) {
                delAllFile(path + "/" + tempList[i]);//先删除文件夹里面的文件
                delFolder(path + "/" + tempList[i]);//再删除空文件夹
                flag = true;
            }
        }
        return flag;
    }
}
