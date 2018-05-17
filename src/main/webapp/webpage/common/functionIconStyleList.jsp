<%--
update---Author:chenj  Date:20160729 for：增加图标样式预览页面
 --%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 <%@ page import = "java.io.*" %>
 <%@ page import = "java.util.ArrayList,java.util.List" %>
 <%@include file="/context/mytags.jsp"%>
 <%
 		String param = request.getParameter("style");
 		
 		 List<String> list =new ArrayList<String>();
		 //File file = new File("E:/marsWS/jeecg-framework/src/main/webapp/plug-in/ace/assets/css/font-awesome.min.css");
		 
	    BufferedReader reader = null;
 		
 		if(param!=null&&param.equals("ace")){
 			String filePath  = application.getRealPath("/") + "/plug-in/ace/assets/css/font-awesome.min.css";
 			File file = new File(filePath);
 			reader = new BufferedReader(new FileReader(file));
 		}

 		if(param!=null&&param.equals("urlfont")){
 			String filePath  = application.getRealPath("/") + "/plug-in/ace/css/font-awesome.css";
 			File file = new File(filePath);
 			reader = new BufferedReader(new FileReader(file));
 		}

 		 //返回读取指定资源的输入流  
		 if(param!=null&&param.equals("hplus")){
	 			//filePath = application.getRealPath("/") + "/plug-in/hplus/font-awesome.css";

	 			InputStream is=this.getClass().getResourceAsStream("/plug-in/hplus/css/font-awesome.css");

	 			reader=new BufferedReader(new InputStreamReader(is));  
	 		}  
		
		 try {
		     //System.out.println("以行为单位读取文件内容，一次读一整行：");
		     String tempString = null;
		     int line = 1;
		     // 一次读入一行，直到读入null为文件结束
		     while ((tempString = reader.readLine()) != null) {
		         // 显示行号
		         //System.out.println("line " + line + ": " + tempString);
		         if(tempString !=null&&!tempString.trim().equals("")){
		         	if(tempString.indexOf(":before")>-1&&tempString.indexOf(".")>-1){
		         		int start = tempString.indexOf(".");
		         		int end = tempString.indexOf(":before");
		         		String subStr = tempString.substring(start+1, end);
		         		if(param!=null&&(param.equals("hplus")||param.equals("urlfont"))){
		         			subStr = "fa "+subStr;
		         		}
		        		//out.println("start:"+start);
		         		//out.println("end:"+end);
		         		//out.println("subStr:"+subStr);
						if(param!=null&&(param.equals("ace"))&&tempString.indexOf("content:")==-1)
						{
							continue;
						}
		         		list.add(subStr);
		         	}
		         }
		         line++;
		     }
		     reader.close();
		 } catch (IOException e) {
		     e.printStackTrace();
		 } finally {
		     if (reader != null) {
		         try {
		             reader.close();
		         } catch (IOException e1) {
		         }
		     }
		 }
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
	if(param!=null&&param.equals("ace")){
%>
	<link rel="stylesheet" href="<%=basePath %>/plug-in/ace/assets/css/font-awesome.min.css" />
<%}else if(param!=null&&param.equals("hplus")){ %>
	<link rel="stylesheet" href="<%=basePath %>/plug-in/hplus/css/font-awesome.min.css?v=4.4.0" />
<%}else if(param!=null&&param.equals("urlfont")){ %>
	<link rel="stylesheet" href="<%=basePath %>/plug-in/ace/css/font-awesome.css" />
<%} %>

<title>菜单图标样式</title>
</head>
<body>
      <h1><%=param%>图标样式</h1>
		<table>
			<%
				if(list.size()>0){
					for(String style:list){
						String c = style;
						if(param!=null&&(param.equals("hplus")||param.equals("urlfont"))){
							 c = style.replace("fa ","");
		         		}
						
			%>
					<tr><td><i class=" <%=style%>"></i></td> <td><%=c %></td></tr>
			<%
					} 
				}
			%>
		</table>
</body>
</html>