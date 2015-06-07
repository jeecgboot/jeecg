package org.jeecgframework.web.demo.controller.test;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jeecgframework.web.system.service.MutiLangServiceI;
import org.jeecgframework.web.system.service.SystemService;
import org.apache.batik.transcoder.Transcoder;
import org.apache.batik.transcoder.TranscoderException;
import org.apache.batik.transcoder.TranscoderInput;
import org.apache.batik.transcoder.TranscoderOutput;
import org.apache.batik.transcoder.image.JPEGTranscoder;
import org.apache.batik.transcoder.image.PNGTranscoder;
import org.apache.fop.svg.PDFTranscoder;
import org.apache.log4j.Logger;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.dao.jdbc.JdbcDao;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.common.model.json.Highchart;
import org.jeecgframework.core.util.DBTypeUtil;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


/**
 * 报表demo控制器
 * 
 * @author xiehs
 * 
 */
@Controller
@RequestMapping("/reportDemoController")
public class ReportDemoController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(ReportDemoController.class);
    //班级学生人数比例分析国际化Key
    private static final String CLASS_STUDENT_COUNT_ANALYSIS = "class.student.count.analysis";

	private SystemService systemService;

    @Autowired
    private MutiLangServiceI mutiLangService;

	@Autowired
	public void setSystemService(SystemService systemService) {
		this.systemService = systemService;
	}

	
	@RequestMapping(params = "listAllStatisticByJdbc")
	public void listAllStatisticByJdbc(HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		List<Map<String,Object>> maplist=systemService.findForJdbc("SELECT s.classname classname ,count(className) personcount FROM T_s_Student s group by s.className", null);
		Long countSutent = systemService.getCountForJdbc("SELECT COUNT(1) FROM T_S_student WHERE 1=1");
		for(Map map:maplist){
			Long personcount = Long.parseLong(map.get("personcount").toString());
			Double  percentage = 0.0;
			if (personcount != null && personcount.intValue() != 0) {
				percentage = new Double(personcount)/countSutent;
			}
			
			map.put("rate", String.format("%.2f", percentage*100)+"%");
		}
		Long count = 0L;
		if(JdbcDao.DATABSE_TYPE_SQLSERVER.equals(DBTypeUtil.getDBType())){
			count = systemService.getCountForJdbcParam("select count(0) from (SELECT s.className  classname ,count(className) totalclass FROM T_s_Student  s group by s.className) as t( classname, totalclass)",null);
		}else{
			count = systemService.getCountForJdbcParam("select count(0) from (SELECT s.className ,count(className) FROM T_s_Student s group by s.className)t",null);
		}
		
		dataGrid.setTotal(count.intValue());
		dataGrid.setResults(maplist);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 统计集合页面
	 * 
	 * @return
	 */
	@RequestMapping(params = "studentStatisticTabs")
	public ModelAndView studentStatisticTabs(HttpServletRequest request) {
		return new ModelAndView("jeecg/demo/base/report/reportDemo");
	}
	

	/**
	 * 报表数据生成
	 * 
	 * @return
	 */
	@RequestMapping(params = "studentCount")
	@ResponseBody
	public List<Highchart> studentCount(HttpServletRequest request,String reportType, HttpServletResponse response) {
		List<Highchart> list = new ArrayList<Highchart>();
		Highchart hc = new Highchart();
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT className ,count(className) FROM TSStudent group by className");
		List userBroswerList = systemService.findByQueryString(sb.toString());
		Long count = systemService.getCountForJdbc("SELECT COUNT(1) FROM T_S_student WHERE 1=1");
		List lt = new ArrayList();
		hc = new Highchart();
		hc.setName(mutiLangService.getLang(CLASS_STUDENT_COUNT_ANALYSIS));
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
}
