package test;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jeecgframework.web.cgform.entity.config.CgFormFieldEntity;
import org.jeecgframework.web.cgform.entity.config.CgFormHeadEntity;
import org.jeecgframework.web.system.pojo.base.TSAttachment;
import org.jeecgframework.web.system.pojo.base.TSBaseUser;
import org.jeecgframework.web.system.pojo.base.TSDepart;
import org.jeecgframework.web.system.pojo.base.TSFunction;
import org.jeecgframework.web.system.pojo.base.TSLog;
import org.jeecgframework.web.system.pojo.base.TSRole;
import org.jeecgframework.web.system.pojo.base.TSType;
import org.jeecgframework.web.system.pojo.base.TSTypegroup;
import org.jeecgframework.web.system.pojo.base.TSUser;
import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;


/** 
 * @Description 
 * @ClassName: JeecgInitDB
 * @author tanghan
 * @date 2013-7-19 下午04:24:51  
 */

public class JeecgInitDB {
   
    private static Connection con=null;
    
    
	public static Connection getConnection() throws ClassNotFoundException, SQLException{
		if(con == null){
			Class.forName("com.mysql.jdbc.Driver");
            con=DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/jeecg", "root","root");
		}
		return con;
	}
	
	public static void main(String[] args) throws Exception {
		Configuration cfg = new Configuration();
		String sql1="select * from t_s_attachment";
		String sql2="select * from t_s_base_user";
		String sql3="select * from t_s_depart";
		String sql4="select * from t_s_role";
		String sql5="select * from t_s_user";
		String sql6="select * from t_s_typegroup";
		String sql7 = "select * from t_s_function";
		String sql8 = "select * from t_s_type";
		String sql9 = "select * from t_s_log limit 100";
		String sql10 = "select * from cgform_field where table_id =";  //此处由于需要更具cgform_head生成，故只能单个生成
		String sql11 = "select * from cgform_head ";
        Statement st=null;
        ResultSet rs=null;
		try {
			cfg.setDirectoryForTemplateLoading(new File("E:/Workspace-jeecg/jeecg-v3-simple-new/src/test"));
			cfg.setObjectWrapper(new DefaultObjectWrapper());
			Template temp = cfg.getTemplate("init.ftl","UTF-8");
            con=getConnection();
            st=con.createStatement();
            rs=st.executeQuery(sql1);
            int i=1;
            Map<String, Object> root = new HashMap<String, Object>();
            List att = new ArrayList();
            while(rs.next())
            {
                 TSAttachment tsAttachment = new TSAttachment();
            	 tsAttachment.setId(i+"");
            	 tsAttachment.setAttachmenttitle(rs.getString("attachmenttitle"));
            	 tsAttachment.setRealpath(rs.getString("attachmenttitle"));
            	 tsAttachment.setSwfpath(rs.getString("swfpath"));
            	 tsAttachment.setExtend(rs.getString("extend"));
            	 att.add(tsAttachment);
                 i++;
            }
            root.put("animals", att);
            
            
            rs=st.executeQuery(sql2);
            i=1;
            List user = new ArrayList();
            while(rs.next())
            {
                 TSBaseUser baseUser = new TSBaseUser();
                 baseUser.setId(i+"");
                 baseUser.setUserKey(rs.getString("userkey"));
                 baseUser.setStatus(rs.getShort("status"));
                 baseUser.setRealName(rs.getString("realname"));
                 baseUser.setUserName(rs.getString("username"));
                 baseUser.setPassword(rs.getString("password"));
                 baseUser.setActivitiSync(rs.getShort("activitisync"));
                 user.add(baseUser);
                 i++;
            }
            root.put("baseuser", user);
            
            
            rs=st.executeQuery(sql3);
            List dep = new ArrayList();
            i=1;
            while(rs.next())
            {
                 TSDepart tsDepart = new TSDepart();
                 tsDepart.setId(i+"");
                 tsDepart.setDepartname(rs.getString("departname"));
                 tsDepart.setDescription(rs.getString("description"));
                 dep.add(tsDepart);
                 i++;
            }
            root.put("depart", dep);    
            
            
            rs=st.executeQuery(sql4);
            List role = new ArrayList();
            i=1;
            while(rs.next())
            {
            	org.jeecgframework.core.util.LogUtil.info(rs.getString("rolename"));
                 TSRole tsRole = new TSRole();
                 tsRole.setId(i+"");
                 tsRole.setRoleName(rs.getString("rolename"));
                 tsRole.setRoleCode(rs.getString("rolecode"));
                 role.add(tsRole);
                 i++;
            }
            root.put("role", role);
            
            rs=st.executeQuery(sql5);
            List susers = new ArrayList();
            i=1;
            while(rs.next())
            {
                 TSUser suer = new TSUser();
                 suer.setId(i+"");
//                 org.jeecgframework.core.util.LogUtil.info(rs.getString("signaturefile"));
//                 suer.setSignatureFile(rs.getString("signaturefile"));
                 suer.setMobilePhone(rs.getString("mobilephone"));
                 suer.setOfficePhone(rs.getString("officephone"));
                 suer.setEmail(rs.getString("email"));
                 susers.add(suer);
                 i++;
            }
            root.put("suser", susers);
            
            rs=st.executeQuery(sql6);
            List typegroup = new ArrayList();
            i=1;
            while(rs.next())
            {
                 TSTypegroup tsTypegroup = new TSTypegroup();
                 tsTypegroup.setId(i+"");
//                 org.jeecgframework.core.util.LogUtil.info(rs.getString("signaturefile"));
//                 suer.setSignatureFile(rs.getString("signaturefile"));
                 tsTypegroup.setTypegroupname(rs.getString("typegroupname"));
                 tsTypegroup.setTypegroupcode(rs.getString("typegroupcode"));
                 typegroup.add(tsTypegroup);
                 i++;
            }
            root.put("typegroup", typegroup);
            
            rs=st.executeQuery(sql7);
            List function = new ArrayList();
            i=1;
            while(rs.next())
            {
                 TSFunction tsFunction = new TSFunction();
                 tsFunction.setId(i+"");
                 tsFunction.setFunctionName(rs.getString("functionName"));
                 tsFunction.setFunctionUrl(rs.getString("functionUrl"));
                 tsFunction.setFunctionLevel(rs.getShort("functionLevel"));
                 tsFunction.setFunctionOrder(rs.getString("functionOrder"));
                 function.add(tsFunction);
                 i++;
            }
            root.put("menu", function);
            
            rs=st.executeQuery(sql8);
            List type = new ArrayList();
            i=1;
            while(rs.next())
            {
                 TSType tsType = new TSType();
                 tsType.setId(i+"");
//                 org.jeecgframework.core.util.LogUtil.info(rs.getString("signaturefile"));
//                 suer.setSignatureFile(rs.getString("signaturefile"));
                 tsType.setTypename(rs.getString("typename"));
                 tsType.setTypecode(rs.getString("typecode"));
                 type.add(tsType);
                 i++;
            }
            root.put("type", type);
            
            rs=st.executeQuery(sql9);
            List log = new ArrayList();
            i=1;
            while(rs.next())
            {
                TSLog slog = new TSLog();
                slog.setId(i+"");
//                 org.jeecgframework.core.util.LogUtil.info(rs.getString("signaturefile"));
//                 suer.setSignatureFile(rs.getString("signaturefile"));
//                 tsType.setTypename(rs.getString("typename"));
//                 tsType.setTypecode(rs.getString("typecode"));
//                 type.add(tsType);
                   slog.setId(i+"");
//                   org.jeecgframework.core.util.LogUtil.info(rs.getString("logcontent"));
                   slog.setLogcontent(rs.getString("logcontent"));
                   slog.setLoglevel(rs.getShort("loglevel"));
                   slog.setBroswer(rs.getString("broswer"));
                   slog.setNote(rs.getString("note"));
                   slog.setOperatetime(rs.getTimestamp("operatetime"));
                   slog.setOperatetype(rs.getShort("operatetype"));
                   log.add(slog);
                 i++;
            }
            root.put("log", log);
            
            rs=st.executeQuery(sql11);
            List cghead = new ArrayList();
            i=1;
            while(rs.next())
            {
                CgFormHeadEntity head = new CgFormHeadEntity();
                head.setId(i+"");
                head.setTableName(rs.getString("table_name"));
                head.setIsTree(rs.getString("is_tree"));
                head.setIsPagination(rs.getString("is_pagination"));
                head.setQuerymode(rs.getString("queryMode"));
                head.setIsCheckbox(rs.getString("is_checkbox"));
                head.setIsDbSynch(rs.getString("is_dbsynch"));
                head.setContent(rs.getString("content"));
                head.setJformVersion(rs.getString("JFORM_VERSION"));
                head.setJformType(rs.getInt("jform_type"));
                head.setColumns(getCgFormItem(sql10, rs.getString("id")));
                cghead.add(head);
                i++;
            }
            root.put("cghead", cghead);
//            rs=st.executeQuery(sql10);
//            List cgfield = new ArrayList();
//            i=1;
//            while(rs.next())
//            {
//            	CgFormFieldEntity filed = new CgFormFieldEntity();
//                filed.setFieldName(rs.getString("field_name"));
//                filed.setLength(rs.getInt("length"));
//                filed.setType(rs.getString("type"));
//                filed.setPointLength(rs.getInt("point_length"));
//                filed.setIsNull(rs.getString("is_null"));
//                filed.setIsKey(rs.getString("is_key"));
//                filed.setIsQuery(rs.getString("is_query"));
//                filed.setIsShow(rs.getString("is_show"));
//                filed.setShowType(rs.getString("show_type"));
//                filed.setOrderNum(rs.getInt("order_num"));
//                filed.setFieldHref(rs.getString("field_href"));
//                filed.setFieldLength(rs.getInt("field_length"));
//                filed.setFieldValidType(rs.getString("field_valid_type"));
//                filed.setQueryMode(rs.getString("query_mode"));
//                filed.setContent(rs.getString("content"));
//                filed.setDictTable(rs.getString("dict_table"));
//                filed.setDictField(rs.getString("dict_field"));
//                filed.setMainField(rs.getString("main_field"));
//                filed.setMainTable(rs.getString("main_table"));
//                cgfield.add(filed);
//                i++;
//            }
//            root.put("cgfield", cgfield);
            
            
            Writer out = new OutputStreamWriter(new FileOutputStream("RepairServiceImpl.java"), "UTF-8");
            temp.process(root, out);
            out.flush();
            out.close();
            org.jeecgframework.core.util.LogUtil.info("Successfull................");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	
	/**
	 * 获取表单字段方法
	 * @param sql10
	 * @param cgformhead_id
	 * @return
	 * @throws Exception
	 */
	public static List getCgFormItem(String sql10,String cgformhead_id) throws Exception{
		Statement st =con.createStatement();
		ResultSet rs = st.executeQuery(sql10+"'"+cgformhead_id.trim()+"'");
        List cgfield = new ArrayList();
        int i=1;
        while(rs.next())
        {
        	CgFormFieldEntity filed = new CgFormFieldEntity();
            filed.setFieldName(rs.getString("field_name"));
            filed.setLength(rs.getInt("length"));
            filed.setType(rs.getString("type"));
            filed.setPointLength(rs.getInt("point_length"));
            filed.setIsNull(rs.getString("is_null"));
            filed.setIsKey(rs.getString("is_key"));
            filed.setIsQuery(rs.getString("is_query"));
            filed.setIsShow(rs.getString("is_show"));
            filed.setShowType(rs.getString("show_type"));
            filed.setOrderNum(rs.getInt("order_num"));
            filed.setFieldHref(rs.getString("field_href"));
            filed.setFieldLength(rs.getInt("field_length"));
            filed.setFieldValidType(rs.getString("field_valid_type"));
            filed.setQueryMode(rs.getString("query_mode"));
            filed.setContent(rs.getString("content"));
            filed.setDictTable(rs.getString("dict_table"));
            filed.setDictField(rs.getString("dict_field"));
            filed.setMainField(rs.getString("main_field"));
            filed.setMainTable(rs.getString("main_table"));
            cgfield.add(filed);
            i++;
        }
        return cgfield;
	}
	
}
