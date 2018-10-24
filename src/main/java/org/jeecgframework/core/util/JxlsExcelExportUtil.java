package org.jeecgframework.core.util;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;

import net.sf.jxls.exception.ParsePropertyException;
import net.sf.jxls.transformer.XLSTransformer;

public class JxlsExcelExportUtil {
	
	public static void export(Map<String,Object> beans,String exportFileName,String templateFilePath, HttpServletRequest request,HttpServletResponse response) throws ParsePropertyException, InvalidFormatException, IOException{
		XLSTransformer transformer = new XLSTransformer();
		InputStream is = new BufferedInputStream(new FileInputStream(templateFilePath));
        org.apache.poi.ss.usermodel.Workbook workbook = transformer.transformXLS(is, beans);
        //设置导出
        response.addHeader("Cache-Control","no-cache");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/octet-stream;charset=UTF-8");
        String ua = request.getHeader("user-agent");
        ua = ua == null ? null : ua.toLowerCase();
       
        if(ua != null && (ua.indexOf("firefox") > 0 || ua.indexOf("safari")>0)){
        	try {
        		exportFileName = new String(exportFileName.getBytes(),"ISO8859-1");
        		response.addHeader("Content-Disposition","attachment;filename=" + exportFileName);
			} catch (Exception e) {
			}
        }else{
        	try {
        		exportFileName = URLEncoder.encode(exportFileName, "utf-8");
		        response.addHeader("Content-Disposition","attachment;filename=" + exportFileName);
			} catch (Exception e) {
			}
        }
        ServletOutputStream out = response.getOutputStream();
		workbook.write(out);
		out.flush();
	}

}
