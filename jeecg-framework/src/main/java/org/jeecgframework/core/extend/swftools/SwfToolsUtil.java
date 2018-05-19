package org.jeecgframework.core.extend.swftools;

import org.jeecgframework.core.util.FileUtils;
/**
 * 文件转换调用接口
 * @author 张代浩
 *
 */
public class SwfToolsUtil {
	public static void convert2SWF(String inputFile) {
		
		String extend=FileUtils.getExtend(inputFile);
		PDFConverter pdfConverter = new OpenOfficePDFConverter();
		SWFConverter swfConverter = new SWFToolsSWFConverter();
		if(extend.equals("pdf"))
		{
			swfConverter.convert2SWF(inputFile,extend);
		}
		if(extend.equals("doc")||extend.equals("docx")||extend.equals("xls")||extend.equals("pptx")||extend.equals("xlsx")||extend.equals("ppt")||extend.equals("txt")||extend.equals("odt"))
		{
			DocConverter converter = new DocConverter(pdfConverter,swfConverter);
			converter.convert(inputFile,extend);
		}
		
	}
}
