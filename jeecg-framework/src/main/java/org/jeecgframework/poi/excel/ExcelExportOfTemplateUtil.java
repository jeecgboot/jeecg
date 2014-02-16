package org.jeecgframework.poi.excel;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFClientAnchor;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.ClientAnchor;
import org.apache.poi.ss.usermodel.Drawing;
import org.apache.poi.ss.usermodel.RichTextString;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFClientAnchor;
import org.apache.poi.xssf.usermodel.XSSFRichTextString;
import org.jeecgframework.poi.excel.annotation.Excel;
import org.jeecgframework.poi.excel.annotation.ExcelCollection;
import org.jeecgframework.poi.excel.annotation.ExcelTarget;
import org.jeecgframework.poi.excel.entity.ComparatorExcelField;
import org.jeecgframework.poi.excel.entity.ExcelExportEntity;
import org.jeecgframework.poi.excel.entity.TemplateExportParams;
/**
 * Excel 导出根据模板导出
 * @author JueYue
 * @date 2013-10-17
 * @version 1.0
 */
public final class ExcelExportOfTemplateUtil {

	/**
	 * 导出文件通过模板解析
	 * 
	 * @param entity  导出参数类
	 * @param pojoClass 对应实体
	 * @param dataSet 实体集合
	 * @param map 模板集合
	 * @return
	 */
	public static Workbook exportExcel(TemplateExportParams params,
			Class<?> pojoClass, Collection<?> dataSet, Map<String, Object> map) {
		return createSheetInUserModel2FileByTemplate(params, pojoClass,
				dataSet, map);
	}
	
	/**
	 * 导出文件通过模板解析只有模板,没有集合
	 * 
	  * @param entity  导出参数类
	 * @param pojoClass 对应实体
	 * @param map 模板集合
	 * @return
	 */
	public static Workbook exportExcel(TemplateExportParams params,
			Map<String, Object> map) {
		return createSheetInUserModel2FileByTemplate(params, null,
				null, map);
	}

	private static Workbook createSheetInUserModel2FileByTemplate(
			TemplateExportParams params, Class<?> pojoClass,
			Collection<?> dataSet, Map<String, Object> map) {
		// step 1. 判断模板的地址
		if (StringUtils.isEmpty(params.getTemplateUrl())) {
			return null;
		}
		Workbook wb = null;
		// step 2. 判断模板的Excel类型,解析模板
		try {
			wb = getCloneWorkBook(params);
			// step 3. 删除其他的sheet
			for (int i = wb.getNumberOfSheets()-1; i >= 0; i--) {
				if (i != params.getSheetNum()) {
					wb.removeSheetAt(i);
				}
			}
			if(StringUtils.isNotEmpty(params.getSheetName())){
				wb.setSheetName(0, params.getSheetName());
			}
			// step 4. 解析模板
			parseTemplate(wb.getSheetAt(0), map);
			if(dataSet != null){
				// step 5. 正常的数据填充
				addDataToSheet(params, pojoClass, dataSet, wb.getSheetAt(0), wb);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return wb;
	}
	/**
	 * 克隆excel防止操作原对象,workbook无法克隆,只能对excel进行克隆
	 * @param params 
	 * @throws Exception 
	 *@Author JueYue
	 *@date   2013-11-11
	 */
	private static Workbook getCloneWorkBook(TemplateExportParams params) throws Exception {
		Workbook wb = null;
		String path = Thread.currentThread().getContextClassLoader().getResource("").toURI().getPath();
		path = path.replace("WEB-INF/classes/","");
		path = path.replace("file:/","")+params.getTemplateUrl();
		FileInputStream fileis  = new FileInputStream(path);
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
	    byte[] buffer = new byte[1024];
	    int len;
	    while ((len = fileis.read(buffer)) > -1 ) {
	        baos.write(buffer, 0, len);
	    }
	    baos.flush();
	    InputStream is = new ByteArrayInputStream(baos.toByteArray()); 
	    wb = WorkbookFactory.create(is);
	    //关闭用到的流
		baos.close();
	    fileis.close();
	    is.close();
		return wb;
		
	}

	/**
	 * 往Sheet 填充正常数据
	 * 
	 * @param params
	 * @param pojoClass
	 * @param dataSet
	 * @param workbook
	 */
	private static void addDataToSheet(TemplateExportParams params,
			Class<?> pojoClass, Collection<?> dataSet, Sheet sheet,
			Workbook workbook) throws Exception {
		Drawing patriarch = sheet.createDrawingPatriarch();
		List<ExcelExportEntity> excelParams = new ArrayList<ExcelExportEntity>();
		// 得到所有字段
		Field fileds[] = ExcelPublicUtil.getClassFields(pojoClass);
		ExcelTarget etarget = pojoClass.getAnnotation(ExcelTarget.class);
		String targetId = null;
		if (etarget != null) {
			targetId = etarget.id();
		}
		getAllExcelField(targetId, fileds, excelParams, pojoClass, null);
		sortAllParams(excelParams);
		Iterator<?> its = dataSet.iterator();
		int index = sheet.getLastRowNum();
		while (its.hasNext()) {
			Object t = its.next();
			index += createCells(patriarch, index, t, excelParams, sheet,
					workbook);
		}
	}

	private static void parseTemplate(Sheet sheet, Map<String, Object> map)
			throws Exception {
		Iterator<Row> rows = sheet.rowIterator();
		Row row;
		while (rows.hasNext()) {
			row = rows.next();
			for (int i = row.getFirstCellNum(); i < row.getLastCellNum(); i++) {
				setValueForCellByMap(row.getCell(i), map);
			}
		}
	}

	/**
	 * 给每个Cell通过解析方式set值
	 * 
	 * @param cell
	 * @param map
	 */
	private static void setValueForCellByMap(Cell cell, Map<String, Object> map)
			throws Exception {
		String oldString;
		try {//step 1. 判断这个cell里面是不是函数
			oldString = cell.getStringCellValue();
		} catch (Exception e) {
			return;
		}
		if(oldString!=null&&oldString.indexOf("{{") != -1){
			// setp 2. 判断是否含有解析函数
			String params;
			while (oldString.indexOf("{{") != -1) {
				params = oldString.substring(oldString.indexOf("{{")+2,
						oldString.indexOf("}}"));
				oldString = oldString.replace("{{"+params+"}}",
						getParamsValue(params.trim(), map));
			}
			cell.setCellValue(oldString);
		}
	}

	/**
	 * 获取参数值
	 * 
	 * @param params
	 * @param map
	 * @return
	 */
	private static String getParamsValue(String params, Map<String, Object> map)
			throws Exception {
		if (params.indexOf(".") != -1) {
			String[] paramsArr = params.split("\\.");
			return getValueDoWhile(map.get(paramsArr[0]), paramsArr, 1);
		}
		return map.containsKey(params)?map.get(params).toString():"";
	}

	/**
	 * 通过遍历过去对象值
	 * 
	 * @param object
	 * @param paramsArr
	 * @param index
	 * @return
	 * @throws Exception
	 * @throws InvocationTargetException
	 * @throws IllegalAccessException
	 * @throws IllegalArgumentException
	 */
	@SuppressWarnings("rawtypes")
	private static String getValueDoWhile(Object object, String[] paramsArr,
			int index) throws Exception {
		if(object == null){return "";}
		if (object instanceof Map) {
			object = ((Map) object).get(paramsArr[index]);
		} else {
			object = ExcelPublicUtil.getMethod(paramsArr[index],
					object.getClass()).invoke(object, new Object[] {});
		}
		return (index == paramsArr.length - 1) ? (object == null?"":object.toString())
				: getValueDoWhile(object, paramsArr, ++index);
	}

	/**
	 * 对字段根据用户设置排序
	 */
	private static void sortAllParams(List<ExcelExportEntity> excelParams) {
		Collections.sort(excelParams, new ComparatorExcelField());
		for (ExcelExportEntity entity : excelParams) {
			if (entity.getList() != null) {
				Collections.sort(entity.getList(), new ComparatorExcelField());
			}
		}
	}

	/**
	 * 创建 最主要的 Cells
	 * 
	 * @param styles
	 * @throws Exception
	 */
	private static int createCells(Drawing patriarch, int index, Object t,
			List<ExcelExportEntity> excelParams, Sheet sheet, Workbook workbook)
			throws Exception {
		ExcelExportEntity entity;
		Row row = sheet.createRow(index);
		row.setHeight((short) 350);
		int maxHeight = 1, cellNum = 0;
		for (int k = 0, paramSize = excelParams.size(); k < paramSize; k++) {
			entity = excelParams.get(k);
			if (entity.getList() != null) {
				Collection<?> list = (Collection<?>) entity.getGetMethod()
						.invoke(t, new Object[] {});
				int listC = 0;
				for (Object obj : list) {
					createListCells(patriarch, index + listC, cellNum, obj,
							entity.getList(), sheet, workbook);
					listC++;
				}
				cellNum += entity.getList().size();
				if (list != null && list.size() > maxHeight) {
					maxHeight = list.size();
				}
			} else {
				Object value = getCellValue(entity, t);
				if (entity.getType() != 2) {
					createStringCell(row, cellNum++, value.toString(), entity,
							workbook);
				} else {
					createImageCell(patriarch, entity, row, cellNum++,
							value == null ? "" : value.toString(), t, workbook);
				}
			}
		}
		// 合并需要合并的单元格
		cellNum = 0;
		for (int k = 0, paramSize = excelParams.size(); k < paramSize; k++) {
			entity = excelParams.get(k);
			if (entity.getList() != null) {
				cellNum += entity.getList().size();
			} else if (entity.isNeedMerge()) {
				sheet.addMergedRegion(new CellRangeAddress(index, index
						+ maxHeight - 1, cellNum, cellNum));
				cellNum++;
			}
		}
		return maxHeight;

	}

	/**
	 * 获取填如这个cell的值,提供一些附加功能
	 * 
	 * @param entity
	 * @param obj
	 * @return
	 * @throws Exception
	 */
	private static Object getCellValue(ExcelExportEntity entity, Object obj)
			throws Exception {
		Object value = entity.getGetMethods() != null ? getFieldBySomeMethod(
				entity.getGetMethods(), obj) : entity.getGetMethod().invoke(
				obj, new Object[] {});
		// step 1 判断是不是日期,需不需要格式化
		if (StringUtils.isNotEmpty(entity.getExportFormat())
				&& StringUtils.isNotEmpty(entity.getDatabaseFormat())) {
			Date temp = null;
			if (value instanceof String) {
				SimpleDateFormat format = new SimpleDateFormat(
						entity.getDatabaseFormat());
				temp = format.parse(value.toString());
			} else if (value instanceof Date) {
				temp = (Date) value;
			}
			if (temp != null) {
				SimpleDateFormat format = new SimpleDateFormat(
						entity.getExportFormat());
				value = format.format(temp);
			}
		}
		return value == null ? "" : value.toString();
	}

	/**
	 * 创建List之后的各个Cells
	 * 
	 * @param styles
	 */
	private static void createListCells(Drawing patriarch, int index,
			int cellNum, Object obj, List<ExcelExportEntity> excelParams,
			Sheet sheet, Workbook workbook) throws Exception {
		ExcelExportEntity entity;
		Row row;
		if (sheet.getRow(index) == null) {
			row = sheet.createRow(index);
			row.setHeight((short) 350);
		} else {
			row = sheet.getRow(index);
		}
		for (int k = 0, paramSize = excelParams.size(); k < paramSize; k++) {
			entity = excelParams.get(k);
			Object value = getCellValue(entity, obj);
			if (entity.getType() != 2) {
				createStringCell(row, cellNum++,
						value == null ? "" : value.toString(), entity, workbook);
			} else {
				createImageCell(patriarch, entity, row, cellNum++,
						value == null ? "" : value.toString(), obj, workbook);
			}
		}
	}

	/**
	 * 多个反射获取值
	 * 
	 * @param list
	 * @param t
	 * @return
	 * @throws Exception
	 */
	private static Object getFieldBySomeMethod(List<Method> list, Object t)
			throws Exception {
		for (Method m : list) {
			if (t == null) {
				t = "";
				break;
			}
			t = m.invoke(t, new Object[] {});
		}
		return t;
	}

	/**
	 * 创建文本类型的Cell
	 * 
	 * @param row
	 * @param index
	 * @param text
	 * @param style
	 * @param entity
	 * @param workbook
	 */
	private static void createStringCell(Row row, int index, String text,
			ExcelExportEntity entity, Workbook workbook) {
		Cell cell = row.createCell(index);
		switch (entity.getType()) {
		case 1:
			RichTextString Rtext = workbook instanceof HSSFWorkbook ? new HSSFRichTextString(
					text) : new XSSFRichTextString(text);
			cell.setCellValue(Rtext);
			break;
		case 2:
			cell.setCellType(Cell.CELL_TYPE_FORMULA);
			cell.setCellFormula(entity.getCellFormula());
			break;
		}
	}

	/**
	 * 图片类型的Cell
	 * 
	 * @param patriarch
	 * 
	 * @param entity
	 * @param row
	 * @param i
	 * @param string
	 * @param obj
	 * @param workbook
	 * @throws Exception
	 */
	private static void createImageCell(Drawing patriarch,
			ExcelExportEntity entity, Row row, int i, String field,
			Object obj, Workbook workbook) throws Exception {
		if(StringUtils.isEmpty(field)){return;}
		row.setHeight((short) (50 * entity.getHeight()));
		row.createCell(i);
		ClientAnchor anchor = workbook instanceof HSSFWorkbook?
				new HSSFClientAnchor(0, 0, 0, 0, (short) i,
				row.getRowNum(), (short) (i + 1), row.getRowNum() + 1):
					new XSSFClientAnchor(0, 0, 0, 0, (short) i,
							row.getRowNum(), (short) (i + 1), row.getRowNum() + 1);
		if (entity.getExportImageType() == 1) {
			ByteArrayOutputStream byteArrayOut = new ByteArrayOutputStream();
			BufferedImage bufferImg;
			try {
				String path = ExcelExportOfTemplateUtil.class.getClassLoader()
						.getResource("") + field;
				path = path.replace("WEB-INF/classes/", "");
				path = path.replace("file:/", "");
				bufferImg = ImageIO.read(new File(path));
				ImageIO.write(
						bufferImg,
						field.substring(field.indexOf(".") + 1,
								field.length()), byteArrayOut);
				patriarch.createPicture(
						anchor,
						row.getSheet()
								.getWorkbook()
								.addPicture(byteArrayOut.toByteArray(),
										Workbook.PICTURE_TYPE_JPEG));
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			byte[] value = (byte[]) (entity.getGetMethods() != null ? getFieldBySomeMethod(
					entity.getGetMethods(), obj) : entity.getGetMethod()
					.invoke(obj, new Object[] {}));
			if (value != null) {
				patriarch.createPicture(anchor, row.getSheet().getWorkbook()
						.addPicture(value, Workbook.PICTURE_TYPE_JPEG));
			}
		}

	}

	/**
	 * 获取需要导出的全部字段
	 * 
	 * @param targetId
	 *            目标ID
	 * @param filed
	 * @throws Exception
	 */
	private static void getAllExcelField(String targetId, Field[] fields,
			List<ExcelExportEntity> excelParams, Class<?> pojoClass,
			List<Method> getMethods) throws Exception {
		// 遍历整个filed
		ExcelExportEntity excelEntity;
		for (int i = 0; i < fields.length; i++) {
			Field field = fields[i];
			// 先判断是不是collection,在判断是不是java自带对象,之后就是我们自己的对象了
			if (ExcelPublicUtil.isNotUserExcelUserThis(field, targetId)) {
				continue;
			}
			if (ExcelPublicUtil.isCollection(field.getType())) {
				ExcelCollection excel = field
						.getAnnotation(ExcelCollection.class);
				ParameterizedType pt = (ParameterizedType) field
						.getGenericType();
				Class<?> clz = (Class<?>) pt.getActualTypeArguments()[0];
				List<ExcelExportEntity> list = new ArrayList<ExcelExportEntity>();
				getExcelFieldList(targetId,
						ExcelPublicUtil.getClassFields(clz), clz, list, null);
				excelEntity = new ExcelExportEntity();
				excelEntity.setName(getExcelName(excel.exportName(), targetId));
				excelEntity
						.setOrderNum(getCellOrder(excel.orderNum(), targetId));
				excelEntity.setGetMethod(ExcelPublicUtil.getMethod(
						field.getName(), pojoClass));
				excelEntity.setList(list);
				excelParams.add(excelEntity);
			} else if (ExcelPublicUtil.isJavaClass(field)) {
				Excel excel = field.getAnnotation(Excel.class);
				excelEntity = new ExcelExportEntity();
				excelEntity.setType(excel.exportType());
				getExcelField(targetId, field, excelEntity, excel, pojoClass);
				if (getMethods != null) {
					List<Method> newMethods = new ArrayList<Method>();
					newMethods.addAll(getMethods);
					newMethods.add(excelEntity.getGetMethod());
					excelEntity.setGetMethods(newMethods);
				}
				excelParams.add(excelEntity);
			} else {
				List<Method> newMethods = new ArrayList<Method>();
				if (getMethods != null) {
					newMethods.addAll(getMethods);
				}
				newMethods.add(ExcelPublicUtil.getMethod(field.getName(),
						pojoClass));
				getAllExcelField(targetId,
						ExcelPublicUtil.getClassFields(field.getType()),
						excelParams, field.getType(), newMethods);
			}
		}
	}

	/**
	 * 判断在这个单元格显示的名称
	 * 
	 * @param exportName
	 * @param targetId
	 * @return
	 */
	private static String getExcelName(String exportName, String targetId) {
		if (exportName.indexOf(",") < 0) {
			return exportName;
		}
		String[] arr = exportName.split(",");
		for (String str : arr) {
			if (str.indexOf(targetId) != -1) {
				return str.split("_")[0];
			}
		}
		return null;
	}

	/**
	 * 获取这个字段的顺序
	 * 
	 * @param orderNum
	 * @param targetId
	 * @return
	 */
	private static int getCellOrder(String orderNum, String targetId) {
		if (isInteger(orderNum) || targetId == null) {
			return Integer.valueOf(orderNum);
		}
		String[] arr = orderNum.split(",");
		for (String str : arr) {
			if (str.indexOf(targetId) != -1) {
				return Integer.valueOf(str.split("_")[0]);
			}
		}
		return 0;
	}

	/**
	 * 判断字符串是否是整数
	 */
	private static boolean isInteger(String value) {
		try {
			Integer.parseInt(value);
			return true;
		} catch (NumberFormatException e) {
			return false;
		}
	}

	/**
	 * 
	 * @param targetId
	 * @param fields
	 * @param pojoClass
	 * @param list
	 * @param getMethods
	 * @throws Exception
	 */
	private static void getExcelFieldList(String targetId, Field[] fields,
			Class<?> pojoClass, List<ExcelExportEntity> list,
			List<Method> getMethods) throws Exception {
		ExcelExportEntity excelEntity;
		for (int i = 0; i < fields.length; i++) {
			Field field = fields[i];
			if (ExcelPublicUtil.isNotUserExcelUserThis(field, targetId)) {
				continue;
			}
			if (ExcelPublicUtil.isJavaClass(field)) {
				Excel excel = field.getAnnotation(Excel.class);
				excelEntity = new ExcelExportEntity();
				getExcelField(targetId, field, excelEntity, excel, pojoClass);
				if (getMethods != null) {
					List<Method> newMethods = new ArrayList<Method>();
					newMethods.addAll(getMethods);
					newMethods.add(excelEntity.getGetMethod());
					excelEntity.setGetMethods(newMethods);
				}
				list.add(excelEntity);
			} else {
				List<Method> newMethods = new ArrayList<Method>();
				if (getMethods != null) {
					newMethods.addAll(getMethods);
				}
				newMethods.add(ExcelPublicUtil.getMethod(field.getName(),
						pojoClass));
				getExcelFieldList(targetId,
						ExcelPublicUtil.getClassFields(field.getType()),
						field.getType(), list, newMethods);
			}
		}
	}

	/**
	 * 
	 * @param targetId
	 * @param field
	 * @param excelEntity
	 * @param excel
	 * @param pojoClass
	 * @throws Exception
	 */
	private static void getExcelField(String targetId, Field field,
			ExcelExportEntity excelEntity, Excel excel, Class<?> pojoClass)
			throws Exception {
		excelEntity.setName(getExcelName(excel.exportName(), targetId));
		excelEntity.setWidth(excel.exportFieldWidth());
		excelEntity.setHeight(excel.exportFieldHeight());
		excelEntity.setNeedMerge(excel.needMerge());
		excelEntity.setOrderNum(getCellOrder(excel.orderNum(), targetId));
		excelEntity.setWrap(excel.isWrap());
		excelEntity.setExportImageType(excel.imageType());
		excelEntity.setType(excel.exportType());
		excelEntity.setCellFormula(excel.cellFormula());
		String fieldname = field.getName();
		excelEntity.setGetMethod(ExcelPublicUtil
				.getMethod(fieldname, pojoClass));
		if (excel.exportConvertSign() == 1 || excel.imExConvert() == 1) {
			StringBuffer getConvertMethodName = new StringBuffer("convertGet");
			getConvertMethodName
					.append(fieldname.substring(0, 1).toUpperCase());
			getConvertMethodName.append(fieldname.substring(1));
			Method getConvertMethod = pojoClass.getMethod(
					getConvertMethodName.toString(), new Class[] {});
			excelEntity.setGetMethod(getConvertMethod);
		}
	}

}
