package org.jeecgframework.core.extend.swftools;
import org.jeecgframework.core.util.FileUtils;
public class DocConverter {

	private PDFConverter pdfConverter;
	private SWFConverter swfConverter;
	
	
	public DocConverter(PDFConverter pdfConverter, SWFConverter swfConverter) {
		super();
		this.pdfConverter = pdfConverter;
		this.swfConverter = swfConverter;
	}


	public  void convert(String inputFile,String swfFile,String extend){
		this.pdfConverter.convert2PDF(inputFile,extend);
		String pdfFile = FileUtils.getFilePrefix(inputFile)+".pdf";
		this.swfConverter.convert2SWF(pdfFile, swfFile);
	}
	
	public void convert(String inputFile,String extend){
		this.pdfConverter.convert2PDF(inputFile,extend);
		String pdfFile = FileUtils.getFilePrefix2(inputFile)+".pdf";
		extend=FileUtils.getExtend(pdfFile);
		this.swfConverter.convert2SWF(pdfFile,extend);
		
	}
	
}
