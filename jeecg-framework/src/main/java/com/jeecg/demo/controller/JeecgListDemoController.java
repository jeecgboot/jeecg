package com.jeecg.demo.controller;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.StringReader;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolation;
import javax.validation.Validator;

import org.apache.batik.transcoder.Transcoder;
import org.apache.batik.transcoder.TranscoderException;
import org.apache.batik.transcoder.TranscoderInput;
import org.apache.batik.transcoder.TranscoderOutput;
import org.apache.batik.transcoder.image.JPEGTranscoder;
import org.apache.batik.transcoder.image.PNGTranscoder;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.fop.svg.PDFTranscoder;
import org.apache.log4j.Logger;
import org.jeecgframework.core.beanvalidator.BeanValidators;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.dao.jdbc.JdbcDao;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.common.model.json.Highchart;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.DBTypeUtil;
import org.jeecgframework.core.util.DateUtils;
import org.jeecgframework.core.util.ExceptionUtil;
import org.jeecgframework.core.util.JeecgDataAutorUtils;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.jwt.util.GsonUtil;
import org.jeecgframework.jwt.util.ResponseMessage;
import org.jeecgframework.jwt.util.Result;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.jeecgframework.poi.excel.ExcelImportUtil;
import org.jeecgframework.poi.excel.entity.ExportParams;
import org.jeecgframework.poi.excel.entity.ImportParams;
import org.jeecgframework.poi.excel.entity.vo.NormalExcelConstants;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.tag.vo.datatable.SortDirection;
import org.jeecgframework.web.system.enums.InterfaceEnum;
import org.jeecgframework.web.system.pojo.base.InterfaceRuleDto;
import org.jeecgframework.web.system.pojo.base.TSDepart;
import org.jeecgframework.web.system.pojo.base.TSLog;
import org.jeecgframework.web.system.service.MutiLangServiceI;
import org.jeecgframework.web.system.service.SystemService;
import org.jeecgframework.web.system.util.InterfaceUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriComponentsBuilder;

import com.alibaba.fastjson.JSONArray;
import com.jeecg.demo.dao.JeecgMinidaoDao;
import com.jeecg.demo.entity.JeecgDemoEntity;
import com.jeecg.demo.entity.JeecgDemoPage;
import com.jeecg.demo.entity.JeecgLogReport;
import com.jeecg.demo.service.JeecgDemoServiceI;

/**   
 * @Title: Controller  
 * @Description: jeecg_demo
 * @author onlineGenerator
 * @date 2017-03-22 20:11:23
 * @version V1.0   
 *
 */
@Controller
@RequestMapping("/jeecgListDemoController")
@Api(value="JeecgDemo",description="Angular JeecgDemo接口",tags="AngularJeecgDemoAPI")
public class JeecgListDemoController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(JeecgListDemoController.class);

	@Autowired
	private JeecgDemoServiceI jeecgDemoService;
	@Autowired
	private SystemService systemService;

	@Autowired
	private Validator validator;

	
	@Autowired
	private JeecgMinidaoDao jeecgMinidaoDao;

    private static final String BROSWER_COUNT_ANALYSIS = "broswer.count.analysis";
    @Autowired
    private MutiLangServiceI mutiLangService;

	
	/**
	 * 采用minidao查询数据
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "minidaoListDemo")
	public ModelAndView minidaoListDemo(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/taglist_minidao");
	}
	
	/**
	 * 行编辑列表
	 */
	@RequestMapping(params = "rowListDemo")
	public ModelAndView rowListDemo(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/list_rowedtior");
	}
	
	/**
	 * jeecg_demo列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "list")
	public ModelAndView list(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/jeecgDemoList");
	}

	@RequestMapping(params = "vueList")
	public ModelAndView vueList(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/vueList");
	}
	@RequestMapping(params = "vueNewList")
	public ModelAndView vueNewList(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/vueNewList");
	}

	@RequestMapping(params = "vueBootstrapTableList")
	public ModelAndView vueBootstrapTableList(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/vueBootstrapTableList");
	}
	@RequestMapping(params = "vueBootstrapTableAdd")
	public ModelAndView vueBootstrapTableAdd(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/vueBootstrapTableAdd");
	}
	@RequestMapping(params = "vueBootstrapTableEdit")
	public ModelAndView vueBootstrapTableEdit(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/vueBootstrapTableEdit");
	}
	@RequestMapping(params = "vueBootstrapTableGet")
	@ResponseBody
	public AjaxJson vueBootstrapTableGet(String id,HttpServletRequest request) {
		AjaxJson json=new AjaxJson();
		if(org.apache.commons.lang.StringUtils.isNotBlank(id)) {
			JeecgDemoEntity t = jeecgDemoService.get(JeecgDemoEntity.class, id);
			json.setObj(t);
		}
		json.setMsg("查询成功！");
		return json;
	}

	@RequestMapping(params = "multiHeaList")
	public ModelAndView multiHeaList(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/jeecgDemoList-multihead");
	}

	/**
	 * 自定义查询条件
	 */
	@RequestMapping(params = "mysearchListDemo")
	public ModelAndView mysearchListDemo(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/taglist_mysearch");
	}

	/**
	 * 自定义查询条件二
	 */
	@RequestMapping(params = "mysearchListDemo2")
	public ModelAndView mysearchListDemo2(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/taglist_mysearch2");
	}


	/**
	 * 综合报表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "broswerStatisticTabs")
	public ModelAndView broswerStatisticTabs(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/reportDemo");
	}

	/**
	 * 多条件动态查询Demo
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "querysBuilder")
	public ModelAndView querysBuilder(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/querysBuilderDemo");
	}

	/**
	 * 多条件动态查询弹框式选择
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "goFormQuerysBuilder")
	public ModelAndView goFormQuerysBuilder(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/form_querysBuilder");
	}

	/**
	 * 仪表图
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "InstrumentDiagram")
	public ModelAndView InstrumenDtiagram(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/echartsDemo/InstrumentDiagram");
	}
	/**
	 * 日程图
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "Schedule")
	public ModelAndView Schedule(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/echartsDemo/Schedule");
	}
	 /**
	  * 柱状图1
	  * @param request
   	  * @return
	  */
	@RequestMapping(params = "BarGraph1")
	public ModelAndView BarGraph1(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/echartsDemo/BarGraph1");
	}	
	/**
	  * 柱状图2
	  * @param request
  	  * @return
	  */
	@RequestMapping(params = "BarGraph2")
	public ModelAndView BarGraph2(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/echartsDemo/BarGraph2");
	}	
	/**
	  * 柱状图3
	  * @param request
  	  * @return
	  */
	@RequestMapping(params = "BarGraph3")
	public ModelAndView BarGraph3(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/echartsDemo/BarGraph3");
	}
	/**
	  * 柱状图4
	  * @param request
 	  * @return
	  */
	@RequestMapping(params = "BarGraph4")
	public ModelAndView BarGraph4(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/echartsDemo/BarGraph4");
	}
	/**
	  * 漏斗图1
	  * @param request
	  * @return
	  */
	@RequestMapping(params = "funnelPlot1")
	public ModelAndView funnelPlot1(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/echartsDemo/funnelPlot1");
	}
	/**
	  * 漏斗图2
	  * @param request
	  * @return
	  */
	@RequestMapping(params = "funnelPlot2")
	public ModelAndView funnelPlot2(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/echartsDemo/funnelPlot2");
	}
	/**
	  * 折线图1
	  * @param request
	  * @return
	  */
	@RequestMapping(params = "lineChart1")
	public ModelAndView lineChart1(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/echartsDemo/lineChart1");
	}
	/**
	  * 折线图2
	  * @param request
	  * @return
	  */
	@RequestMapping(params = "lineChart2")
	public ModelAndView lineChart2(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/echartsDemo/lineChart2");
	}
	/**
	  * 折线图3
	  * @param request
	  * @return
	  */
	@RequestMapping(params = "lineChart3")
	public ModelAndView lineChart3(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/echartsDemo/lineChart3");
	}/**
	  * 折线图4
	  * @param request
	  * @return
	  */
	@RequestMapping(params = "lineChart4")
	public ModelAndView lineChart4(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/echartsDemo/lineChart4");
	}/**
	  * 折线图5
	  * @param request
	  * @return
	  */
	@RequestMapping(params = "lineChart5")
	public ModelAndView lineChart5(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/echartsDemo/lineChart5");
	}
	/**
	  * 饼图1
	  * @param request
	  * @return
	  */
	@RequestMapping(params = "PieChart1")
	public ModelAndView PieChart1(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/echartsDemo/PieChart1");
	}
	/**
	  * 饼图2
	  * @param request
	  * @return
	  */
	@RequestMapping(params = "PieChart2")
	public ModelAndView PieChart2(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/echartsDemo/PieChart2");
	}
	/**
	  * 点状图1
	  * @param request
	  * @return
	  */
	@RequestMapping(params = "PointChart1")
	public ModelAndView PointChart1(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/echartsDemo/PointChart1");
	}
	/**
	  * 点状图2
	  * @param request
	  * @return
	  */
	@RequestMapping(params = "PointChart2")
	public ModelAndView PointChart2(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/echartsDemo/PointChart2");
	}
	/**
	  * 点状图3
	  * @param request
	  * @return
	  */
	@RequestMapping(params = "PointChart3")
	public ModelAndView PointChart3(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/echartsDemo/PointChart3");
	}
	/**
	  * 矩形图
	  * @param request
	  * @return
	  */
	@RequestMapping(params = "RectangularGraph")
	public ModelAndView RectangularGraph(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/echartsDemo/RectangularGraph");
	}
	/**
	  * 其他1
	  * @param request
	  * @return
	  */
	@RequestMapping(params = "other1")
	public ModelAndView other1(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/echartsDemo/other1");
	}
	
	/**
	  * 综合报表
	  * @param request
	  * @return
	  */
	@RequestMapping(params = "TotalReport")
	public ModelAndView TotalReport(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/echartsDemo/TotalReport");
	}
	/**
	  * 综合报表
	  * @param request
	  * @return
	  */
	@RequestMapping(params = "getTotalReport")
	@ResponseBody
	public String getTotalReport(HttpServletRequest request) {
		List<Map<String,Object>> maplist=systemService.findForJdbc("select l.broswer broswer ,count(broswer) broswercount from t_s_log l group by l.broswer", null);
		Long countSutent = systemService.getCountForJdbc("select count(*) from t_s_log where 1=1");
		for(Map map:maplist){
			Long personcount = Long.parseLong(map.get("broswercount").toString());
			Double  percentage = 0.0;
			if (personcount != null && personcount.intValue() != 0) {
				percentage = new Double(personcount)/countSutent;
			}
			
			map.put("rate", String.format("%.2f", percentage*100)+"%");
		}
		Long count = 0L;
		if(JdbcDao.DATABSE_TYPE_SQLSERVER.equals(DBTypeUtil.getDBType())){
			count = systemService.getCountForJdbcParam("select count(0) from (select l." +
					"  broswer ,count(broswer) broswercount from t_s_log  l group by l.broswer) as t( broswer, broswercount)",null);
		}else{
			count = systemService.getCountForJdbcParam("select count(0) from (select l.broswer broswer ,count(broswer) broswercount from t_s_log l group by l.broswer)t",null);
		}
		
		StringBuffer strb =new StringBuffer();
		strb.append("{\"title\": {\"text\": \"浏览器登录次数统计\",\"subtext\": \"测试数据\"},\"toolbox\": {\"show\": true,\"feature\": {\"restore\": {\"show\": true,\"title\": \"还原\"},\"saveAsImage\": {\"show\": true,\"title\": \"保存为图片\",\"type\": \"png\",\"lang\": [\"点击保存\"]},}},\"series\": [{\"data\": [");
		for (Map map:maplist) {
			strb.append("{\"value\": \" " +map.get("broswercount")+
					"\",\"name\": \"" +map.get("broswer")+
					"\"},");
			}
		strb.append("],\"type\": \"pie\"}]}");
		String option =strb.toString();
		
		return option;
	}

	
	/**
	 * 综合报表 datagrid
	 * 
	 * @return
	 */
	@RequestMapping(params = "listAllStatisticByJdbc")
	public void listAllStatisticByJdbc(HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		List<Map<String,Object>> maplist=systemService.findForJdbc("select l.broswer broswer ,count(broswer) broswercount from t_s_log l group by l.broswer", null);
		Long countSutent = systemService.getCountForJdbc("select count(*) from t_s_log where 1=1");
		for(Map map:maplist){
			Long personcount = Long.parseLong(map.get("broswercount").toString());
			Double  percentage = 0.0;
			if (personcount != null && personcount.intValue() != 0) {
				percentage = new Double(personcount)/countSutent;
			}
			
			map.put("rate", String.format("%.2f", percentage*100)+"%");
		}
		Long count = 0L;
		if(JdbcDao.DATABSE_TYPE_SQLSERVER.equals(DBTypeUtil.getDBType())){
			count = systemService.getCountForJdbcParam("select count(0) from (select l." +
					"  broswer ,count(broswer) broswercount from t_s_log  l group by l.broswer) as t( broswer, broswercount)",null);
		}else{
			count = systemService.getCountForJdbcParam("select count(0) from (select l.broswer broswer ,count(broswer) broswercount from t_s_log l group by l.broswer)t",null);
		}
		
		dataGrid.setTotal(count.intValue());
		dataGrid.setResults(maplist);
		TagUtil.datagrid(response, dataGrid);
	}

	
	/**
	 * highchart
	 * 
	 * @return
	 */
	@RequestMapping(params = "broswerCount")
	@ResponseBody
	public List<Highchart> studentCount(HttpServletRequest request,String reportType, HttpServletResponse response) {
		List<Highchart> list = new ArrayList<Highchart>();
		Highchart hc = new Highchart();
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT broswer as className ,count(broswer)  FROM TSLog group by broswer");
		List userBroswerList = systemService.findByQueryString(sb.toString());
		Long count = systemService.getCountForJdbc("SELECT COUNT(1) FROM T_S_Log WHERE 1=1");
		List lt = new ArrayList();
		hc = new Highchart();
		hc.setName(mutiLangService.getLang(BROSWER_COUNT_ANALYSIS));
		hc.setType(reportType);
		Map<String, Object> map;
		if (userBroswerList.size() > 0) {
			for (Object object : userBroswerList) {
				map = new HashMap<String, Object>();
				Object[] obj = (Object[]) object;
				map.put("name", obj[0]);
				map.put("y", obj[1]);
				Long groupCount = (Long) obj[1];
				Double  percentage = 0.0;
				if (count != null && count.intValue() != 0) {
					percentage = new Double(groupCount)/count;
				}
				map.put("percentage", percentage*100);
				lt.add(map);
			}
		}
		hc.setData(lt);
		list.add(hc);
		return list;
	}
	
	/**
	 * 报表打印
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(params = "export")
	public void export(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String type = request.getParameter("type");
		String svg = request.getParameter("svg");
		String filename = request.getParameter("filename");

		filename = filename == null ? "chart" : filename;
		ServletOutputStream out = response.getOutputStream();
		try {
			if (null != type && null != svg) {
				svg = svg.replaceAll(":rect", "rect");
				String ext = "";
				Transcoder t = null;
				if (type.equals("image/png")) {
					ext = "png";
					t = new PNGTranscoder();
				} else if (type.equals("image/jpeg")) {
					ext = "jpg";
					t = new JPEGTranscoder();
				} else if (type.equals("application/pdf")) {
					ext = "pdf";
					t = (Transcoder) new PDFTranscoder();
				} else if (type.equals("image/svg+xml"))
					ext = "svg";
				response.addHeader("Content-Disposition",
						"attachment; filename=" + new String(filename.getBytes("GBK"),"ISO-8859-1") + "." + ext);
				response.addHeader("Content-Type", type);

				if (null != t) {
					TranscoderInput input = new TranscoderInput(
							new StringReader(svg));
					TranscoderOutput output = new TranscoderOutput(out);

					try {
						t.transcode(input, output);
					} catch (TranscoderException e) {
						out
								.print("Problem transcoding stream. See the web logs for more details.");
						e.printStackTrace();
					}
				} else if (ext.equals("svg")) {
					// out.print(svg);
					OutputStreamWriter writer = new OutputStreamWriter(out,
							"UTF-8");
					writer.append(svg);
					writer.close();
				} else
					out.print("Invalid type: " + type);
			} else {
				response.addHeader("Content-Type", "text/html");
				out
						.println("Usage:\n\tParameter [svg]: The DOM Element to be converted."
								+ "\n\tParameter [type]: The destination MIME type for the elment to be transcoded.");
			}
		} finally {
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
	
	
	@RequestMapping(params = "minidaoDatagrid")
	public void minidaoDatagrid(JeecgDemoEntity jeecgDemo,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		/**
		 * 注意：minidao会遵循springjdbc规则，会自动把数据库以下划线的字段，转化为驼峰写法
		 * 例如数据库表字段：{user_name}
		 * 转化实体对应字段：{userName}
		 */
		
		//step.1 获取数据权限SQL片段
		String authSql = JeecgDataAutorUtils.loadDataSearchConditonSQLString();
		
		//step.2 将权限SQL片段注入到业务SQL中
		MiniDaoPage<JeecgDemoEntity> list = jeecgMinidaoDao.getAllEntities(jeecgDemo, dataGrid.getPage(), dataGrid.getRows(),authSql);
		dataGrid.setTotal(list.getTotal());
		dataGrid.setResults(list.getResults());
		
		 //step.3 合计，格式为 字段名:值(可选，不写该值时为分页数据的合计) 多个合计 以 , 分割
		String total_salary = String.valueOf(jeecgMinidaoDao.getSumSalary());
		dataGrid.setFooter("salary:"+(total_salary.equalsIgnoreCase("null")?"0.0":total_salary)+",age,email:合计");
		TagUtil.datagrid(response, dataGrid);
	}
	

	/**
	 * easyui AJAX请求数据
	 * 
	 * @param request
	 * @param response
	 * @param dataGrid
	 * @param user
	 */

	@RequestMapping(params = "datagrid")
	public void datagrid(JeecgDemoEntity jeecgDemo,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(JeecgDemoEntity.class, dataGrid);
		if(oConvertUtils.isNotEmpty(dataGrid.getSqlbuilder())) {
			if(dataGrid.getSqlbuilder().indexOf("≤") > 0) {
				dataGrid.setSqlbuilder(dataGrid.getSqlbuilder().replace("≤", "<="));
			}
		}
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, jeecgDemo, request.getParameterMap());
		try{
		//自定义追加查询条件
		}catch (Exception e) {
			throw new BusinessException(e.getMessage());
		}
		cq.add();
		this.jeecgDemoService.getDataGridReturn(cq, true);
		//String total_salary = String.valueOf(jeecgMinidaoDao.getSumSalary());
		/*
		 * 说明：格式为 字段名:值(可选，不写该值时为分页数据的合计) 多个合计 以 , 分割
		 */
		//dataGrid.setFooter("salary:"+(total_salary.equalsIgnoreCase("null")?"0.0":total_salary)+",age,email:合计");
		List<JeecgDemoEntity> list = dataGrid.getResults();
		Map<String,Map<String,Object>> extMap = new HashMap<String, Map<String,Object>>();
		for(JeecgDemoEntity temp:list){
		        //此为针对原来的行数据，拓展的新字段
		        Map m = new HashMap();
		        m.put("extField",this.jeecgMinidaoDao.getOrgCode(temp.getDepId()));
		        extMap.put(temp.getId(), m);
		}
//		dataGrid.setFooter("salary,age,name:合计");
		dataGrid.setFooter("[{'salary':'','age':'','name':'合计'}]");
		TagUtil.datagrid(response, dataGrid, extMap);
	}
	
	@RequestMapping(params = "addTab")
	public ModelAndView addTab(HttpServletRequest request) {
		String type = oConvertUtils.getString(request.getParameter("type"));
		return new ModelAndView("com/jeecg/demo/demoTab");
		
	}
	
	@RequestMapping(params = "goCheck")
	public ModelAndView goCheck( HttpServletRequest request) {
		logger.info("----审核-----");
		String id=request.getParameter("id");
		if (StringUtil.isNotEmpty(id)) {
			JeecgDemoEntity jeecgDemo = jeecgDemoService.getEntity(JeecgDemoEntity.class, id);
			request.setAttribute("jeecgDemoPage", jeecgDemo);
		}
		return new ModelAndView("com/jeecg/demo/jeecgDemo-check");
		
	}

	/**
	 * 自定义查询
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "goBuilderDemo")
	public ModelAndView goBuilderDemo( HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/superQueryDemo");
		
	}

	
	@RequestMapping(params = "doCheck")
	@ResponseBody
	public AjaxJson doCheck(String content,String id,String status) {
		logger.info("-------审核意见:"+content);//demo简单作打印,实际项目可酌情处理
		String message = null;
		AjaxJson j = new AjaxJson();
		JeecgDemoEntity jeecgDemo = systemService.getEntity(JeecgDemoEntity.class, id);
		message = "审核成功";
		try{
			jeecgDemo.setStatus(status);
			this.jeecgDemoService.updateEntitie(jeecgDemo);
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "审核失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	@RequestMapping(params = "addWithbtn")
	public ModelAndView addWithbtn(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/jeecgDemo-add-btn");
		
	}
	
	/**
	 * JeecgDemo 打印预览跳转
	 * @param jeecgDemo
	 * @param req
	 * @return
	 */
	@RequestMapping(params = "print")
	public ModelAndView print(JeecgDemoEntity jeecgDemo, HttpServletRequest req) {
		// 获取部门信息
		List<TSDepart> departList = systemService.getList(TSDepart.class);
		req.setAttribute("departList", departList);

		if (StringUtil.isNotEmpty(jeecgDemo.getId())) {
			jeecgDemo = jeecgDemoService.getEntity(JeecgDemoEntity.class, jeecgDemo.getId());
			req.setAttribute("jgDemo", jeecgDemo);
			if ("0".equals(jeecgDemo.getSex()))
				req.setAttribute("sex", "男");
			if ("1".equals(jeecgDemo.getSex()))
				req.setAttribute("sex", "女");
		}
		return new ModelAndView("com/jeecg/demo/jeecgDemo-print");
	}
	
	/**
	 * 删除jeecg_demo
	 * 
	 * @return
	 */
	@RequestMapping(params = "doDel")
	@ResponseBody
	public AjaxJson doDel(JeecgDemoEntity jeecgDemo, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		jeecgDemo = systemService.getEntity(JeecgDemoEntity.class, jeecgDemo.getId());
		message = "删除成功";
		try{
			jeecgDemoService.delete(jeecgDemo);
			systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 批量删除jeecg_demo
	 * 
	 * @return
	 */
	 @RequestMapping(params = "doBatchDel")
	@ResponseBody
	public AjaxJson doBatchDel(String ids,HttpServletRequest request){
		String message = null;
		AjaxJson j = new AjaxJson();
		message = "删除成功";
		try{
			for(String id:ids.split(",")){
				JeecgDemoEntity jeecgDemo = systemService.getEntity(JeecgDemoEntity.class, 
				id
				);
				jeecgDemoService.delete(jeecgDemo);
				systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
			}
		}catch(Exception e){
			e.printStackTrace();
			message = "删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}


	/**
	 * 添加jeecg_demo
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doAdd")
	@ResponseBody
	public AjaxJson doAdd(JeecgDemoEntity jeecgDemo, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		message = "添加成功";
		try{
			jeecgDemoService.save(jeecgDemo);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "添加失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 更新jeecg_demo
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doUpdate")
	@ResponseBody
	public AjaxJson doUpdate(JeecgDemoEntity jeecgDemo, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		message = "更新成功";
		JeecgDemoEntity t = jeecgDemoService.get(JeecgDemoEntity.class, jeecgDemo.getId());
		try {
			MyBeanUtils.copyBeanNotNull2Bean(jeecgDemo, t);
			jeecgDemoService.saveOrUpdate(t);
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		} catch (Exception e) {
			e.printStackTrace();
			message = "更新失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	

	/**
	 * jeecg_demo新增页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goAdd")
	public ModelAndView goAdd(JeecgDemoEntity jeecgDemo, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(jeecgDemo.getId())) {
			jeecgDemo = jeecgDemoService.getEntity(JeecgDemoEntity.class, jeecgDemo.getId());
			req.setAttribute("jeecgDemoPage", jeecgDemo);
		}
		return new ModelAndView("com/jeecg/demo/jeecgDemo-add");
	}
	/**
	 * jeecg_demo编辑页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goUpdate")
	public ModelAndView goUpdate(JeecgDemoEntity jeecgDemo, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(jeecgDemo.getId())) {
			jeecgDemo = jeecgDemoService.getEntity(JeecgDemoEntity.class, jeecgDemo.getId());
			req.setAttribute("jeecgDemoPage", jeecgDemo);
		}
		return new ModelAndView("com/jeecg/demo/jeecgDemo-update");
	}
	
	/**
	 * 导入功能跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "upload")
	public ModelAndView upload(HttpServletRequest req) {
		req.setAttribute("controller_name","jeecgListDemoController");
		return new ModelAndView("common/upload/pub_excel_upload");
	}
	
	/**
	 * 导出excel
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "exportXls")
	public String exportXls(JeecgDemoEntity jeecgDemo,HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid,ModelMap modelMap) {
		CriteriaQuery cq = new CriteriaQuery(JeecgDemoEntity.class, dataGrid);
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, jeecgDemo, request.getParameterMap());
		List<JeecgDemoEntity> jeecgDemos = this.jeecgDemoService.getListByCriteriaQuery(cq,false);
		modelMap.put(NormalExcelConstants.FILE_NAME,"jeecg_demo");
		modelMap.put(NormalExcelConstants.CLASS,JeecgDemoEntity.class);
		modelMap.put(NormalExcelConstants.PARAMS,new ExportParams("jeecg_demo列表", "导出人:"+ResourceUtil.getSessionUser().getRealName(),"导出信息"));
		modelMap.put(NormalExcelConstants.DATA_LIST,jeecgDemos);
		return NormalExcelConstants.JEECG_EXCEL_VIEW;
	}
	/**
	 * 导出excel 使模板
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "exportXlsByT")
	public String exportXlsByT(JeecgDemoEntity jeecgDemo,HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid,ModelMap modelMap) {
    	modelMap.put(NormalExcelConstants.FILE_NAME,"jeecg_demo");
    	modelMap.put(NormalExcelConstants.CLASS,JeecgDemoEntity.class);
    	modelMap.put(NormalExcelConstants.PARAMS,new ExportParams("jeecg_demo列表", "导出人:"+ResourceUtil.getSessionUser().getRealName(),
    	"导出信息"));
    	modelMap.put(NormalExcelConstants.DATA_LIST,new ArrayList());
    	return NormalExcelConstants.JEECG_EXCEL_VIEW;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "importExcel", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson importExcel(HttpServletRequest request, HttpServletResponse response) {
		AjaxJson j = new AjaxJson();
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
			MultipartFile file = entity.getValue();// 获取上传文件对象
			ImportParams params = new ImportParams();
			params.setTitleRows(2);
			params.setHeadRows(1);
			params.setNeedSave(true);
			try {
				List<JeecgDemoEntity> listJeecgDemoEntitys = ExcelImportUtil.importExcel(file.getInputStream(),JeecgDemoEntity.class,params);
				for (JeecgDemoEntity jeecgDemo : listJeecgDemoEntitys) {
					jeecgDemoService.save(jeecgDemo);
				}
				j.setMsg("文件导入成功！");
			} catch (Exception e) {
				j.setMsg("文件导入失败！");
				logger.error(ExceptionUtil.getExceptionMessage(e));
			}finally{
				try {
					file.getInputStream().close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return j;
	}
	
	@RequestMapping(method = RequestMethod.GET)
	@ResponseBody
	public List<JeecgDemoEntity> list() {
		List<JeecgDemoEntity> listJeecgDemos=jeecgDemoService.getList(JeecgDemoEntity.class);
		return listJeecgDemos;
	}
	
	/**
	 * 保存新增/更新的行数据
	 * @param page
	 * @return
	 */
	@RequestMapping(params = "saveRows")
	@ResponseBody
	public AjaxJson saveRows(JeecgDemoPage page){
		String message = null;
		List<JeecgDemoEntity> demos=page.getDemos();
		AjaxJson j = new AjaxJson();
		if(CollectionUtils.isNotEmpty(demos)){
			for(JeecgDemoEntity jeecgDemo:demos){
				if (StringUtil.isNotEmpty(jeecgDemo.getId())) {
					JeecgDemoEntity t =jeecgDemoService.get(JeecgDemoEntity.class, jeecgDemo.getId());
					try {
						message = "JeecgDemo例子: " + jeecgDemo.getName() + "被更新成功";
						MyBeanUtils.copyBeanNotNull2Bean(jeecgDemo, t);
						jeecgDemoService.saveOrUpdate(t);
						systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
					} catch (Exception e) {
						message = "JeecgDemo例子: " + jeecgDemo.getName() + "更新失败!!";
						e.printStackTrace();
					}
				} else {
					try {
						message = "JeecgDemo例子: " + jeecgDemo.getName() + "被添加成功";
						//jeecgDemo.setStatus("0");
						jeecgDemoService.save(jeecgDemo);
						systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
					} catch (Exception e) {
						message = "JeecgDemo例子: " + jeecgDemo.getName() + "添加失败!!";
						e.printStackTrace();
					}
					
				}
			}
		}
		return j;
	}
	
	//jeecgListDemoController.do?log
	@RequestMapping(params = "log")
	public ModelAndView log() {
		return new ModelAndView("com/jeecg/demo/logList");
	}
	
	//jeecgListDemoController.do?logDatagrid
	@RequestMapping(params = "logDatagrid")
	public void logDatagrid(HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(TSLog.class, dataGrid);
		
		//日志级别查询条件
		String loglevel = request.getParameter("loglevel");
		if (loglevel != null && !"0".equals(loglevel)) {
			cq.eq("loglevel", org.jeecgframework.core.util.oConvertUtils.getShort(loglevel));
			cq.add();
		}
		//时间范围查询条件
        String operatetime_begin = request.getParameter("operatetime_begin");
        String operatetime_end = request.getParameter("operatetime_end");
        if(oConvertUtils.isNotEmpty(operatetime_begin)){
        	try {
				cq.ge("operatetime", DateUtils.parseDate(operatetime_begin, "yyyy-MM-dd hh:mm:ss"));
			} catch (ParseException e) {
				logger.error(e);
			}
        	cq.add();
        }
        if(oConvertUtils.isNotEmpty(operatetime_end)){
        	try {
				cq.le("operatetime", DateUtils.parseDate(operatetime_end, "yyyy-MM-dd hh:mm:ss"));
			} catch (ParseException e) {
				logger.error(e);
			}
        	cq.add();
        }
        this.systemService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}
	
	@RequestMapping(params = "goOnlyData")
	public ModelAndView goOnlyData(HttpServletRequest req,JeecgLogReport log) {
		return new ModelAndView("com/jeecg/demo/logrp-onlyData");
	}
	
	@RequestMapping(params = "logrpDatagrid")
	public void logrpDatagrid(HttpServletResponse response,JeecgLogReport log, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(JeecgLogReport.class, dataGrid);
		List<JeecgLogReport> list=this.jeecgMinidaoDao.getLogReportData(log);
		dataGrid.setResults(list);
		TagUtil.datagrid(response, dataGrid);
	}
	
	@RequestMapping(params = "goChart")
	public ModelAndView goChart(HttpServletRequest req,JeecgLogReport log) {
		List<Map<String, Object>> list=this.jeecgMinidaoDao.getLogChartData(log);
		net.sf.json.JSONArray arr=net.sf.json.JSONArray.fromObject(list);
		req.setAttribute("logs",arr);
		return new ModelAndView("com/jeecg/demo/logrp-chart");
	}

	/**
	 * 批量添加
	 * @param request
	 * @return
	 * 2017年6月9日--下午4:33:30
	 */
	@RequestMapping(params = "jdbcBatchSave")
	@ResponseBody
	public AjaxJson jdbcBatchSave(HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		String message = "springjdbc 批处理添加测试用户成功";
			try{
				jeecgDemoService.jdbcBatchSave();
				systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
			}catch(Exception e){
				e.printStackTrace();
				message = "springjdbc 批处理添加测试用户失败";
				throw new BusinessException(e.getMessage());
			}
		logger.info(message);
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 调用存储过程
	 * @param request
	 * @return
	 * 2017年6月9日--下午4:33:43
	 */
	@RequestMapping(params = "jdbcProcedure")
	@ResponseBody
	public AjaxJson jdbcProcedure(HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		String message = "jdbc调用存储过程成功";
			try{
				jeecgDemoService.jdbcProcedure();
				systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
			}catch(Exception e){
				e.printStackTrace();
				message = "jdbc调用存储过程失败";
				throw new BusinessException(e.getMessage());
			}
		
		j.setMsg(message);
		return j;
	}

	@RequestMapping(params = "echartDemo")
	public ModelAndView echartDemo(HttpServletRequest req) {
		return new ModelAndView("com/jeecg/demo/echartsDemo");
	}

	@RequestMapping(value="/list",method = RequestMethod.GET)
	@ResponseBody
	@ApiOperation(value="jeecgDemo列表信息",produces="application/json",httpMethod="GET")
	public ResponseMessage<Map<String,Object>> list(@RequestParam("pageNo") int pageNo, @RequestParam("pageSize") int pageSize,JeecgDemoEntity entity,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		InterfaceRuleDto interfaceRuleDto = InterfaceUtil.getInterfaceRuleDto(request, InterfaceEnum.jeecgdemo_list);
		if(interfaceRuleDto==null){
			return Result.error("您没有该接口的权限！");
		}
		CriteriaQuery query = new CriteriaQuery(JeecgDemoEntity.class, dataGrid);
		InterfaceUtil.installCriteriaQuery(query, interfaceRuleDto, InterfaceEnum.jeecgdemo_list);
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(query, entity, request.getParameterMap());
		query.setCurPage(pageNo<=0?1:pageNo);
		query.setPageSize(pageSize);
		query.addOrder("createDate", SortDirection.desc);
		query.add();
		this.jeecgDemoService.getDataGridReturn(query, true);
		Map<String,Object> resultMap=new HashMap<String, Object>();
		resultMap.put("data", dataGrid.getResults());
		resultMap.put("total", dataGrid.getTotal());
		return Result.success(resultMap);
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	@ResponseBody
	@ApiOperation(value="根据ID获取jeecgDemo信息",notes="根据ID获取jeecgDemo信息",httpMethod="GET",produces="application/json")
	public ResponseMessage<?> get(@ApiParam(required=true,name="id",value="ID")@PathVariable("id") String id,HttpServletRequest request) {
		InterfaceRuleDto interfaceRuleDto = InterfaceUtil.getInterfaceRuleDto(request, InterfaceEnum.jeecgdemo_get);
		if(interfaceRuleDto==null){
			return Result.error("您没有该接口的权限！");
		}
		JeecgDemoEntity task = this.jeecgDemoService.get(JeecgDemoEntity.class, id);
		if (task == null) {
			return Result.error("根据ID获取jeecgDemo信息为空");
		}
		return Result.success(task);
	}

	@RequestMapping(method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	@ApiOperation(value="创建jeecgDemo")
	public ResponseMessage<?> create(@ApiParam(name="jeecgDemo对象")@RequestBody JeecgDemoEntity jeecgDemo, UriComponentsBuilder uriBuilder,HttpServletRequest request) {
		InterfaceRuleDto interfaceRuleDto = InterfaceUtil.getInterfaceRuleDto(request, InterfaceEnum.jeecgdemo_add);
		if(interfaceRuleDto==null){
			return Result.error("您没有该接口的权限！");
		}
		logger.info("create[{}]" + GsonUtil.toJson(jeecgDemo));
		
		//调用JSR303 Bean Validator进行校验，如果出错返回含400错误码及json格式的错误信息.
		Set<ConstraintViolation<JeecgDemoEntity>> failures = validator.validate(jeecgDemo);
		if (!failures.isEmpty()) {
			return Result.error(JSONArray.toJSONString(BeanValidators.extractPropertyAndMessage(failures)));
		}

		//保存
		try{
			jeecgDemo.setCreateDate(new Date());
			this.jeecgDemoService.save(jeecgDemo);
		} catch (Exception e) {
			e.printStackTrace();
			return Result.error("jeecgDemo信息保存失败");
		}
		return Result.success(jeecgDemo);
	}

	@RequestMapping(method = RequestMethod.PUT, consumes = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	@ApiOperation(value="更新jeecgDemo",notes="更新jeecgDemo")
	public ResponseMessage<?> update(@RequestBody JeecgDemoEntity jeecgDemo,HttpServletRequest request) {
		InterfaceRuleDto interfaceRuleDto = InterfaceUtil.getInterfaceRuleDto(request, InterfaceEnum.jeecgdemo_edit);
		if(interfaceRuleDto==null){
			return Result.error("您没有该接口的权限！");
		}
		logger.info("update[{}]" + GsonUtil.toJson(jeecgDemo));
		//调用JSR303 Bean Validator进行校验，如果出错返回含400错误码及json格式的错误信息.
		Set<ConstraintViolation<JeecgDemoEntity>> failures = validator.validate(jeecgDemo);
		if (!failures.isEmpty()) {
			return Result.error(JSONArray.toJSONString(BeanValidators.extractPropertyAndMessage(failures)));
		}

		//保存
		try{
			this.jeecgDemoService.saveOrUpdate(jeecgDemo);
		} catch (Exception e) {
			e.printStackTrace();
			return Result.error("更新jeecgDemo信息失败");
		}

		//按Restful约定，返回204状态码, 无内容. 也可以返回200状态码.
		return Result.success("更新jeecgDemo信息成功");
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	@ApiOperation(value="删除jeecgDemo")
	@ResponseBody
	public ResponseMessage<?> delete(@ApiParam(name="id",value="ID",required=true)@PathVariable("id") String id,HttpServletRequest request) {
		InterfaceRuleDto interfaceRuleDto = InterfaceUtil.getInterfaceRuleDto(request, InterfaceEnum.jeecgdemo_delete);
		if(interfaceRuleDto==null){
			return Result.error("您没有该接口的权限！");
		}
		logger.info("delete[{}]" + id);
		// 验证
		if (StringUtils.isEmpty(id)) {
			return Result.error("ID不能为空");
		}
		try {
			this.jeecgDemoService.deleteEntityById(JeecgDemoEntity.class, id);
		} catch (Exception e) {
			e.printStackTrace();
			return Result.error("jeecgDemo删除失败");
		}

		return Result.success();
	}

	/**
	 * jeecgDemo-bootstrap-list
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "bootTableDemo")
	public ModelAndView bootTableDemo(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/jeecgDemo-bootstrap-list");
	}
	
	/**
	 * jeecgDemo-bootstrap编辑页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goBootStrapTableUpdate")
	public ModelAndView goBootStrapTableUpdate(JeecgDemoEntity jeecgDemo, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(jeecgDemo.getId())) {
			jeecgDemo = jeecgDemoService.getEntity(JeecgDemoEntity.class, jeecgDemo.getId());
			req.setAttribute("jeecgDemoPage", jeecgDemo);
		}
		return new ModelAndView("com/jeecg/demo/jeecgDemo-bootstrap-update");
	}
	
	/**
	 * jeecgDemo-bootstrap新增页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goBootStrapTableAdd")
	public ModelAndView goBootStrapTableAdd(JeecgDemoEntity jeecgDemo, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(jeecgDemo.getId())) {
			jeecgDemo = jeecgDemoService.getEntity(JeecgDemoEntity.class, jeecgDemo.getId());
			req.setAttribute("jeecgDemoPage", jeecgDemo);
		}
		return new ModelAndView("com/jeecg/demo/jeecgDemo-bootstrap-add");
	}

		/**
		 * list
		 * @param request
		 * @return
		 */
		@RequestMapping(params = "natureAceTableDemo")
		public ModelAndView natureAceTableDemo(HttpServletRequest request) {
			return new ModelAndView("com/jeecg/demo/jeecgDemo-nature-ace-list");
		}
		
		/**
		 * 编辑页面跳转
		 * @return
		 */
		@RequestMapping(params = "goNatureAceTableUpdate")
		public ModelAndView goNatureAceTableUpdate(JeecgDemoEntity jeecgDemo, HttpServletRequest req) {
			if (StringUtil.isNotEmpty(jeecgDemo.getId())) {
				jeecgDemo = jeecgDemoService.getEntity(JeecgDemoEntity.class, jeecgDemo.getId());
				req.setAttribute("jeecgDemoPage", jeecgDemo);
			}
			return new ModelAndView("com/jeecg/demo/jeecgDemo-nature-ace-update");
		}
		
		/**
		 * 新增页面跳转
		 * @return
		 */
		@RequestMapping(params = "goNatureAceTableAdd")
		public ModelAndView goNatureAceTableAdd(JeecgDemoEntity jeecgDemo, HttpServletRequest req) {
			if (StringUtil.isNotEmpty(jeecgDemo.getId())) {
				jeecgDemo = jeecgDemoService.getEntity(JeecgDemoEntity.class, jeecgDemo.getId());
				req.setAttribute("jeecgDemoPage", jeecgDemo);
			}
			return new ModelAndView("com/jeecg/demo/jeecgDemo-nature-ace-add");
		}


		/**
		 * jeecgDemo-bootstrap-list-tag
		 * @param request
		 * @return
		 */
		@RequestMapping(params = "bootstrapTableTagDemo")
		public ModelAndView bootstrapTableTagDemo(HttpServletRequest request) {
			return new ModelAndView("com/jeecg/demo/jeecgDemo-bootstrap-list-tag");
		}

		/**
		 * jeecgDemo-bootstrap-list-tag
		 * @param request
		 * @return
		 */
		@RequestMapping(params = "bootstrapTableTagDemo2")
		public ModelAndView bootstrapTableTagDemo2(HttpServletRequest request) {
			return new ModelAndView("com/jeecg/demo/jeecgDemo-bootstrap-list-tag2");
		}
		
		/**
		 * jeecgDemo-bootstrap编辑页面跳转
		 * 
		 * @return
		 */
		@RequestMapping(params = "goBootStrapTableUpdate2")
		public ModelAndView goBootStrapTableUpdate2(JeecgDemoEntity jeecgDemo, HttpServletRequest req) {
			if (StringUtil.isNotEmpty(jeecgDemo.getId())) {
				jeecgDemo = jeecgDemoService.getEntity(JeecgDemoEntity.class, jeecgDemo.getId());
				req.setAttribute("jeecgDemoPage", jeecgDemo);
			}
			return new ModelAndView("com/jeecg/demo/jeecgDemo-bootstrap-update2");
		}
		
		/**
		 * jeecgDemo-bootstrap新增页面跳转
		 * 
		 * @return
		 */
		@RequestMapping(params = "goBootStrapTableAdd2")
		public ModelAndView goBootStrapTableAdd2(JeecgDemoEntity jeecgDemo, HttpServletRequest req) {
			if (StringUtil.isNotEmpty(jeecgDemo.getId())) {
				jeecgDemo = jeecgDemoService.getEntity(JeecgDemoEntity.class, jeecgDemo.getId());
				req.setAttribute("jeecgDemoPage", jeecgDemo);
			}
			return new ModelAndView("com/jeecg/demo/jeecgDemo-bootstrap-add2");
		}

		@RequestMapping(params = "bootStrapEchartsDemo")
		public ModelAndView bootStrapEchartsDemo(HttpServletRequest request) {
			return new ModelAndView("com/jeecg/demo/echartsDemo/bootstrap-echarts");
		}

		
}
