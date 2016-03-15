<html xmlns:m="http://schemas.microsoft.com/office/2004/12/omml">
<head>
	<title>员工入职单</title>
	<style type="text/css">body{font-size:12px;}table{border: 1px solid #000000;padding:0; margin:0 auto;border-collapse: collapse;width:100%;align:right;}td {border: 1px solid #000000;background: #fff;font-size:12px;padding: 3px 3px 3px 8px;color: #000000;word-break: keep-all;}
	</style>
	${config_iframe}
</head>
<body>
  <form id="formobj" action="cgFormBuildController.do?saveOrUpdate" name="formobj" method="post">
			<input type="hidden" id="btn_sub" class="btn_sub"/>
			<input type="hidden" name="tableName" value="${tableName?if_exists?html}" >
			<input type="hidden" name="id" value="${id?if_exists?html}" >
			<#list columnhidden as po>
			  <input type="hidden" id="${po.field_name}" name="${po.field_name}" value="${data['${tableName}']['${po.field_name}']?if_exists?html}" >
			</#list>
<table border="0" cellpadding="0" cellspacing="0" class="MsoNormalTable" style="width:675.75pt;" width="901">
	<tbody>
		<tr style="mso-yfti-irow:0;mso-yfti-firstrow:yes;height:8.25pt">
			<td colspan="7" nowrap="nowrap" style="width: 675.75pt; padding: 0cm 5.4pt; height: 8.25pt; background-color: rgb(0, 176, 240);" width="901">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 宋体;">　<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:1;height:36.75pt">
			<td colspan="7" nowrap="nowrap" style="width:675.75pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:36.75pt" width="901">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size:18.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;mso-bidi-font-family:
  宋体;color:#00B0F0;mso-font-kerning:0pt">员工入职单<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:2;height:16.5pt">
			<td colspan="5" nowrap="nowrap" style="width: 453.9pt; border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-color: rgb(0, 176, 240); border-bottom-width: 1pt; padding: 0cm 5.4pt; height: 16.5pt;" width="605">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">　<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td nowrap="nowrap" style="width: 101.4pt; border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-color: rgb(0, 176, 240); border-bottom-width: 1pt; padding: 0cm 5.4pt; height: 16.5pt;" width="135">
			<p align="right" class="MsoNormal" style="text-align:right;mso-pagination:widow-orphan;
  word-break:break-all"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">填表日期：<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td nowrap="nowrap" style="width: 120.45pt; border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-color: rgb(0, 176, 240); border-bottom-width: 1pt; padding: 0cm 5.4pt; height: 16.5pt;" width="161">
			<p align="left" class="MsoNormal"><span lang="EN-US">
			<input name="create_date" id="create_date" datatype="*" class="inputxt" value="${data['${tableName}']['create_date']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">填表日期</label>
			</span><span lang="EN-US" style="font-size: 11pt; font-family: 微软雅黑, sans-serif;"><o:p></o:p></span></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:3;height:25.5pt">
			<td colspan="7" nowrap="nowrap" style="width: 675.75pt; border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-color: rgb(0, 176, 240); border-bottom-width: 1.5pt; padding: 0cm 5.4pt; height: 25.5pt;" width="901">
			<p align="left" class="MsoNormal"><b><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">基本信息<span lang="EN-US"><o:p></o:p></span></span></b></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:4;height:24.75pt">
			<td nowrap="nowrap" style="width: 92.9pt; border-right-color: rgb(165, 165, 165); border-bottom-color: rgb(165, 165, 165); border-left-color: rgb(165, 165, 165); border-right-width: 1pt; border-bottom-width: 1pt; border-left-width: 1pt; border-top-style: none; padding: 0cm 5.4pt; height: 24.75pt; background-color: rgb(242, 242, 242);" width="124">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">姓名<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td style="width: 160px; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 24px; white-space: nowrap;">
			<p align="left" class="MsoNormal"><span lang="EN-US">
			<input name="employee_name" id="employee_name" datatype="*" class="inputxt" value="${data['${tableName}']['employee_name']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">姓名</label>
			</span></p>
			</td>
			<td nowrap="nowrap" style="width: 78.8pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 24.75pt; background-color: rgb(242, 242, 242);" width="105">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">部门<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td style="width: 160px; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 24px; white-space: nowrap;">
			<p align="left" class="MsoNormal"><span lang="EN-US">
			<input name="employee_depart" id="employee_depart" datatype="*" class="inputxt" value="${data['${tableName}']['employee_depart']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">部门</label>
			</span></p>
			</td>
			<td nowrap="nowrap" style="width: 91.65pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 24.75pt; background-color: rgb(242, 242, 242);" width="122">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">职务<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td style="width: 160px; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 24px; white-space: nowrap;">
			<p align="left" class="MsoNormal"><span lang="EN-US">
			<input name="employee_job" id="employee_job" datatype="*" class="inputxt" value="${data['${tableName}']['employee_job']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">职务</label>
			</span><span lang="EN-US" style="font-size: 11pt; font-family: 微软雅黑, sans-serif;"><o:p></o:p></span></p>
			</td>
			<td nowrap="nowrap" rowspan="5" style="width: 120.45pt; border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-color: rgb(0, 176, 240); border-bottom-width: 1pt; padding: 0cm 5.4pt; height: 24.75pt;" width="161">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">　<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:5;height:22.5pt">
			<td nowrap="nowrap" style="width: 92.9pt; border-right-color: rgb(165, 165, 165); border-bottom-color: rgb(165, 165, 165); border-left-color: rgb(165, 165, 165); border-right-width: 1pt; border-bottom-width: 1pt; border-left-width: 1pt; border-top-style: none; padding: 0cm 5.4pt; height: 22.5pt; background-color: rgb(242, 242, 242);" width="124">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">生日<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td style="width: 3px; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 22px; white-space: nowrap; vertical-align: middle;">
			<p align="left" class="MsoNormal"><span lang="EN-US">
			<input name="employee_birthday" id="employee_birthday" datatype="*" class="Wdate" onClick="WdatePicker()"  value="${data['${tableName}']['employee_birthday']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">生日</label>
			</span></p>
			</td>
			<td nowrap="nowrap" style="width: 78.8pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 22.5pt; background-color: rgb(242, 242, 242);" width="105">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">籍贯<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td colspan="3" nowrap="nowrap" style="width: 298.55pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 22.5pt;" width="398">
			<p class="MsoNormal"><span lang="EN-US">
			<input name="employee_origin" id="employee_origin" datatype="*" class="inputxt"  value="${data['${tableName}']['employee_origin']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">籍贯</label>
			</span><span lang="EN-US" style="font-size: 11pt; font-family: 微软雅黑, sans-serif;"><o:p></o:p></span></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:6;height:21.75pt">
			<td nowrap="nowrap" style="width: 92.9pt; border-right-color: rgb(165, 165, 165); border-bottom-color: rgb(165, 165, 165); border-left-color: rgb(165, 165, 165); border-right-width: 1pt; border-bottom-width: 1pt; border-left-width: 1pt; border-top-style: none; padding: 0cm 5.4pt; height: 21.75pt; background-color: rgb(242, 242, 242);" width="124">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">学历<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td nowrap="nowrap" style="width: 3cm; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 21.75pt;" width="113">
			<p align="left" class="MsoNormal"><span lang="EN-US">
			<input name="employee_degree" id="employee_degree" datatype="*" class="inputxt"  value="${data['${tableName}']['employee_degree']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">学历</label>
			</span></p>
			</td>
			<td nowrap="nowrap" style="width: 78.8pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 21.75pt; background-color: rgb(242, 242, 242);" width="105">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">身份证<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td colspan="3" nowrap="nowrap" style="width: 298.55pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 21.75pt;" width="398">
			<p class="MsoNormal"><span lang="EN-US">
			<input name="employee_identification" id="employee_identification" datatype="*" class="inputxt"  value="${data['${tableName}']['employee_identification']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">身份证</label>
			</span><span lang="EN-US" style="font-size: 11pt; font-family: 微软雅黑, sans-serif;"><o:p></o:p></span></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:7;height:24.0pt">
			<td nowrap="nowrap" style="width: 92.9pt; border-right-color: rgb(165, 165, 165); border-bottom-color: rgb(165, 165, 165); border-left-color: rgb(165, 165, 165); border-right-width: 1pt; border-bottom-width: 1pt; border-left-width: 1pt; border-top-style: none; padding: 0cm 5.4pt; height: 24pt; background-color: rgb(242, 242, 242);" width="124">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">入职日期<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td nowrap="nowrap" style="width: 3cm; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 24pt;" width="113">
			<p align="left" class="MsoNormal"><span lang="EN-US">
			<input name="employee_entry_date" id="employee_entry_date" datatype="*" class="Wdate" onClick="WdatePicker()"  value="${data['${tableName}']['employee_entry_date']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">入职日期</label>
			</span></p>
			</td>
			<td nowrap="nowrap" style="width: 78.8pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 24pt; background-color: rgb(242, 242, 242);" width="105">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">工号<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td nowrap="nowrap" style="width: 105.5pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 24pt;" width="141">
			<p align="left" class="MsoNormal"><span lang="EN-US">
			<input name="employee_code" id="employee_code" datatype="*" class="inputxt"  value="${data['${tableName}']['employee_code']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">工号</label>
			</span></p>
			</td>
			<td nowrap="nowrap" style="width: 91.65pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 24pt; background-color: rgb(242, 242, 242);" width="122">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">手机<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td nowrap="nowrap" style="width: 101.4pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 24pt;" width="135">
			<p align="left" class="MsoNormal"><span lang="EN-US">
			<input name="employee_phone" id="employee_phone" datatype="*" class="inputxt"  value="${data['${tableName}']['employee_phone']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">手机</label>
			</span><span lang="EN-US" style="font-size: 11pt; font-family: 微软雅黑, sans-serif;"><o:p></o:p></span></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:8;height:23.25pt">
			<td nowrap="nowrap" style="width: 92.9pt; border-top-style: none; border-left-color: rgb(165, 165, 165); border-left-width: 1pt; border-bottom-color: rgb(0, 176, 240); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 23.25pt; background-color: rgb(242, 242, 242);" width="124">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">邮箱<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td colspan="2" nowrap="nowrap" style="width: 163.85pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(0, 176, 240); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 23.25pt;" width="218">
			<p class="MsoNormal"><span lang="EN-US">
			<input name="employee_mail" id="employee_mail" datatype="*" class="inputxt"  value="${data['${tableName}']['employee_mail']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">邮箱</label>
			</span><span lang="EN-US" style="font-size: 11pt; font-family: 微软雅黑, sans-serif;"><o:p></o:p></span></p>
			</td>
			<td nowrap="nowrap" style="width: 105.5pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(0, 176, 240); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 23.25pt; background-color: rgb(242, 242, 242);" width="141">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span lang="EN-US" style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">MSN<o:p></o:p></span></p>
			</td>
			<td colspan="2" nowrap="nowrap" style="width: 193.05pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(0, 176, 240); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 23.25pt;" width="257">
			<p class="MsoNormal"><span lang="EN-US">
			<input name="employee_msn" id="employee_msn" datatype="*" class="inputxt"  value="${data['${tableName}']['employee_msn']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">MSN</label>
			</span><span lang="EN-US" style="font-size: 11pt; font-family: 微软雅黑, sans-serif;"><o:p></o:p></span></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:9;height:26.25pt">
			<td colspan="7" nowrap="nowrap" style="width: 675.75pt; border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-color: rgb(0, 176, 240); border-bottom-width: 1.5pt; padding: 0cm 5.4pt; height: 26.25pt;" width="901">
			<p align="left" class="MsoNormal"><b><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">人事部<span lang="EN-US"><o:p></o:p></span></span></b></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:10;height:21.0pt">
			<td nowrap="nowrap" style="width: 92.9pt; border-right-color: rgb(165, 165, 165); border-bottom-color: rgb(165, 165, 165); border-left-color: rgb(165, 165, 165); border-right-width: 1pt; border-bottom-width: 1pt; border-left-width: 1pt; border-top-style: none; padding: 0cm 5.4pt; height: 21pt; background-color: rgb(242, 242, 242);" width="124">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">照片<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td nowrap="nowrap" style="width: 3cm; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 21pt;" width="113">
			<p align="left" class="MsoNormal"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">　<span lang="EN-US">
			<@DictData name="sf_yn" var="dataList">
				<#list dataList as dictdata> 
				<input value="${dictdata.typecode?if_exists?html}" name="hr_pic" type="radio"
					<#if dictdata_index==0>datatype="*"</#if> 
					<#if dictdata.typecode?if_exists?html=="${data['${tableName}']['hr_pic']?if_exists?html}"> checked="true" </#if>>
					${dictdata.typename?if_exists?html}
				</#list> 
			</@DictData>
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">照片</label>
			</span></span></p>
			</td>
			<td nowrap="nowrap" style="width: 78.8pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 21pt; background-color: rgb(242, 242, 242);" width="105">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">档案表<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td nowrap="nowrap" style="width: 105.5pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 21pt;" width="141">
			<p align="left" class="MsoNormal"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">　<span lang="EN-US">
			<@DictData name="sf_yn" var="dataList">
				<#list dataList as dictdata> 
				<input value="${dictdata.typecode?if_exists?html}" name="hr_archives" type="radio"
				<#if dictdata_index==0>datatype="*"</#if> 
				<#if dictdata.typecode?if_exists?html=="${data['${tableName}']['hr_archives']?if_exists?html}"> checked="true" </#if>>
					${dictdata.typename?if_exists?html}
				</#list> 
			</@DictData>
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">档案表</label>
			</span></span></p>
			</td>
			<td nowrap="nowrap" style="width: 91.65pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 21pt; background-color: rgb(242, 242, 242);" width="122">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">身份证<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td colspan="2" nowrap="nowrap" style="width: 221.85pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 21pt;" width="296">
			<p class="MsoNormal"><span lang="EN-US">
			<@DictData name="sf_yn" var="dataList">
				<#list dataList as dictdata> 
				<input value="${dictdata.typecode?if_exists?html}" name="hr_identification" type="radio"
				<#if dictdata_index==0>datatype="*"</#if> 
				<#if dictdata.typecode?if_exists?html=="${data['${tableName}']['hr_identification']?if_exists?html}"> checked="true" </#if>>
					${dictdata.typename?if_exists?html}
				</#list> 
			</@DictData>
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">身份证</label>
			</span><span lang="EN-US" style="font-size: 11pt; font-family: 微软雅黑, sans-serif;"><o:p></o:p></span></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:11;height:21pt">
			<td nowrap="nowrap" style="width: 92.9pt; border-right-color: rgb(165, 165, 165); border-bottom-color: rgb(165, 165, 165); border-left-color: rgb(165, 165, 165); border-right-width: 1pt; border-bottom-width: 1pt; border-left-width: 1pt; border-top-style: none; padding: 0cm 5.4pt; height: 16.5pt; background-color: rgb(242, 242, 242);" width="124">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">学位证<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td nowrap="nowrap" style="width: 3cm; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 16.5pt;" width="113">
			<p align="left" class="MsoNormal"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">　<span lang="EN-US">
			<@DictData name="sf_yn" var="dataList">
				<#list dataList as dictdata> 
				<input value="${dictdata.typecode?if_exists?html}" name="hr_degree" type="radio"
				<#if dictdata_index==0>datatype="*"</#if> 
				<#if dictdata.typecode?if_exists?html=="${data['${tableName}']['hr_degree']?if_exists?html}"> checked="true" </#if>>
					${dictdata.typename?if_exists?html}
				</#list> 
			</@DictData>
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">学位证</label>
			</span></span></p>
			</td>
			<td nowrap="nowrap" style="width: 78.8pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 16.5pt; background-color: rgb(242, 242, 242);" width="105">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">其他证件<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td nowrap="nowrap" style="width: 105.5pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 16.5pt;" width="141">
			<p align="left" class="MsoNormal"><span lang="EN-US">
			<input name="hr_other" id="hr_other" datatype="*" class="inputxt"  value="${data['${tableName}']['hr_other']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">其他证件</label>
			</span><span lang="EN-US" style="font-size: 11pt; font-family: 微软雅黑, sans-serif;"><o:p></o:p></span></p>
			</td>
			<td nowrap="nowrap" style="width: 91.65pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 16.5pt; background-color: rgb(242, 242, 242);" width="122">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">分配电话<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td colspan="2" nowrap="nowrap" style="width: 221.85pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 16.5pt;" width="296">
			<p class="MsoNormal"><span lang="EN-US">
			<input name="hr_tel" id="hr_tel" datatype="*" class="inputxt"  value="${data['${tableName}']['hr_tel']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">分配电话</label>
			</span><span lang="EN-US" style="font-size: 11pt; font-family: 微软雅黑, sans-serif;"><o:p></o:p></span></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:12;height:59.25pt">
			<td colspan="7" nowrap="nowrap" style="width:675.75pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:59.25pt" width="901">&nbsp;</td>
		</tr>
		<tr style="mso-yfti-irow:13;height:16.5pt">
			<td colspan="7" nowrap="nowrap" style="width:675.75pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:16.5pt" width="901">
			<p align="right" class="MsoNormal" style="text-align:right;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">
			经办人：<span lang="EN-US">&nbsp;&nbsp;
			<input name="hr_op_user" id="hr_op_user" datatype="*" class="inputxt"  value="${data['${tableName}']['hr_op_user']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">经办人</label>
			&nbsp;&nbsp; </span>
			日期：<span lang="EN-US">&nbsp;&nbsp;
			<input name="hr_op_date" id="hr_op_date" datatype="*" class="Wdate" onClick="WdatePicker()"  value="${data['${tableName}']['hr_op_date']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">日期</label>
			&nbsp;&nbsp; </span></span></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:14;height:17.25pt">
			<td colspan="7" nowrap="nowrap" style="width: 675.75pt; border-top-color: rgb(191, 191, 191); border-top-width: 1pt; border-left-style: none; border-bottom-color: rgb(0, 176, 240); border-bottom-width: 1.5pt; border-right-style: none; padding: 0cm 5.4pt; height: 17.25pt;" width="901">
			<p align="left" class="MsoNormal"><b><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">部门意见<span lang="EN-US"><o:p></o:p></span></span></b></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:15;height:66.0pt">
			<td colspan="7" nowrap="nowrap" style="width:675.75pt;padding:0cm 5.4pt 0cm 5.4pt;height:66.0pt" width="901">&nbsp;
			<textarea id="depart_opinion" name="depart_opinion" 
			style="width: 900px" class="inputxt" rows="6">${data['${tableName}']['depart_opinion']?if_exists?html}</textarea>
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">部门意见</label>
			</td>
		</tr>
		<tr style="mso-yfti-irow:16;height:16.5pt">
			<td colspan="7" nowrap="nowrap" style="width:675.75pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:16.5pt" width="901">
			<p align="right" class="MsoNormal" style="text-align:right;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">
			经办人：<span lang="EN-US">&nbsp;&nbsp;
			<input name="depart_op_user" id="depart_op_user" datatype="*" class="inputxt"  value="${data['${tableName}']['depart_op_user']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">经办人</label>
			&nbsp;&nbsp; </span>
			日期：<span lang="EN-US">&nbsp;&nbsp;
			<input name="depart_op_date" id="depart_op_date" datatype="*" class="Wdate" onClick="WdatePicker()"  value="${data['${tableName}']['depart_op_date']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">日期</label>
			&nbsp;&nbsp; </span></span></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:17;height:17.25pt">
			<td colspan="7" nowrap="nowrap" style="width: 675.75pt; border-top-color: rgb(191, 191, 191); border-top-width: 1pt; border-left-style: none; border-bottom-color: rgb(0, 176, 240); border-bottom-width: 1.5pt; border-right-style: none; padding: 0cm 5.4pt; height: 17.25pt;" width="901">
			<p align="left" class="MsoNormal"><b><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">总经理意见<span lang="EN-US"><o:p></o:p></span></span></b></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:18;height:63.75pt">
			<td colspan="7" nowrap="nowrap" style="width:675.75pt;padding:0cm 5.4pt 0cm 5.4pt;height:63.75pt" width="901">&nbsp;
			<textarea id="manager_opinion" name="manager_opinion" 
			style="width: 900px" class="inputxt" rows="6">${data['${tableName}']['manager_opinion']?if_exists?html}</textarea>
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">总经理意见</label>
			</td>
		</tr>
		<tr style="mso-yfti-irow:19;height:16.5pt">
			<td colspan="7" nowrap="nowrap" style="width:675.75pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:16.5pt" width="901">
			<p align="right" class="MsoNormal" style="text-align:right;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">
			经办人：<span lang="EN-US">&nbsp;&nbsp;
			<input name="manager_op_user" id="manager_op_user" datatype="*" class="inputxt"  value="${data['${tableName}']['manager_op_user']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">经办人</label>
			&nbsp;&nbsp; </span>
			日期：<span lang="EN-US">&nbsp;&nbsp;
			<input name="manager_op_date" id="manager_op_date" datatype="*" class="Wdate" onClick="WdatePicker()"  value="${data['${tableName}']['manager_op_date']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">日期</label>
			&nbsp;&nbsp; <o:p></o:p></span></span></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:20;height:17.25pt">
			<td colspan="7" nowrap="nowrap" style="width: 675.75pt; border-top-color: rgb(191, 191, 191); border-top-width: 1pt; border-left-style: none; border-bottom-color: rgb(0, 176, 240); border-bottom-width: 1.5pt; border-right-style: none; padding: 0cm 5.4pt; height: 17.25pt;" width="901">
			<p align="left" class="MsoNormal"><b><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">新员工意见<span lang="EN-US"><o:p></o:p></span></span></b></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:21;height:77.25pt">
			<td colspan="7" nowrap="nowrap" style="width:675.75pt;padding:0cm 5.4pt 0cm 5.4pt;height:77.25pt" width="901">&nbsp;
			<textarea id="employee_opinion" name="employee_opinion" 
			style="width: 900px" class="inputxt" rows="6">${data['${tableName}']['employee_opinion']?if_exists?html}</textarea>
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">新员工意见</label>
			</td>
		</tr>
		<tr style="mso-yfti-irow:22;height:16.5pt">
			<td colspan="7" nowrap="nowrap" style="width:675.75pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:16.5pt" width="901">
			<p align="right" class="MsoNormal" style="text-align:right;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">
			经办人：<span lang="EN-US">&nbsp;&nbsp;
			<input name="employee_op_user" id="employee_op_user" datatype="*" class="inputxt"  value="${data['${tableName}']['employee_op_user']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">经办人</label>
			&nbsp;&nbsp; </span>
			日期：<span lang="EN-US">&nbsp;&nbsp;
			<input name="employee_op_date" id="employee_op_date" datatype="*" class="Wdate" onClick="WdatePicker()"  value="${data['${tableName}']['employee_op_date']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">日期</label>
			&nbsp;&nbsp; </span></span></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:23;mso-yfti-lastrow:yes;height:6.0pt">
			<td colspan="7" nowrap="nowrap" style="width: 675.75pt; padding: 0cm 5.4pt; height: 6pt; background-color: rgb(0, 176, 240);" width="901">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">　<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
		</tr>
	</tbody>
</table>
<script type="text/javascript">$(function(){$("#formobj").Validform({tiptype:1,btnSubmit:"#btn_sub",btnReset:"#btn_reset",ajaxPost:true,usePlugin:{passwordstrength:{minLen:6,maxLen:18,trigger:function(obj,error){if(error){obj.parent().next().find(".Validform_checktip").show();obj.find(".passwordStrength").hide();}else{$(".passwordStrength").show();obj.parent().next().find(".Validform_checktip").hide();}}}},callback:function(data){if(data.success==true){uploadFile(data);}else{if(data.responseText==''||data.responseText==undefined){$.messager.alert('错误', data.msg);$.Hidemsg();}else{try{var emsg = data.responseText.substring(data.responseText.indexOf('错误描述'),data.responseText.indexOf('错误信息')); $.messager.alert('错误',emsg);$.Hidemsg();}catch(ex){$.messager.alert('错误',data.responseText+'');}} return false;}if(!neibuClickFlag){var win = frameElement.api.opener; win.reloadTable();}}});});</script>
	</form>
	<script type="text/javascript">
		function uploadFile(data){
				frameElement.api.opener.reloadTable();
				frameElement.api.close();

		}
		function getChecked(checkName,inputID){
			var checkObj=  $("input[type='checkbox'][name='"+checkName+"']:checked");
			var val="";
			$.each(checkObj,function(i,f){
				val+=","+ f.value;
			});
			$("#"+inputID).val(val);
		}
	   $(function(){
		//查看模式情况下,删除和上传附件功能禁止使用
		if(location.href.indexOf("load=detail")!=-1){
			$(".jeecgDetail").hide();
		}
		
		if(location.href.indexOf("mode=read")!=-1){
			//查看模式控件禁用
			$("#formobj").find(":input").attr("disabled","disabled");
		}
		if(location.href.indexOf("mode=onbutton")!=-1){
			//其他模式显示提交按钮
			$("#sub_tr").show();
		}
	   });

	  var neibuClickFlag = false;
	  function neibuClick() {
		  neibuClickFlag = true; 
		  $('#btn_sub').trigger('click');
	  }


		$.dialog.setting.zIndex =1990;
		function del(url,obj){
			$.dialog.confirm("确认删除该条记录?", function(){
				$.ajax({
					async : false,
					cache : false,
					type : 'POST',
					url : url,// 请求的action路径
					error : function() {// 请求失败处理函数
					},
					success : function(data) {
						var d = $.parseJSON(data);
						if (d.success) {
							var msg = d.msg;
							tip(msg);
							$(obj).closest("tr").hide("slow");
						}
					}
				});  
			}, function(){
		});
	}

	<#--add-start--Author:钟世云  Date:20150614 for：online支持树配置-->
	/**树形列表数据转换**/
	function convertTreeData(rows, textField) {
		for(var i = 0; i < rows.length; i++) {
			var row = rows[i];
			row.text = row[textField];
			if(row.children) {
				row.state = "open";
				convertTreeData(row.children, textField);
			}
		}
	}
	/**树形列表加入子元素**/
	function joinTreeChildren(arr1, arr2) {
		for(var i = 0; i < arr1.length; i++) {
			var row1 = arr1[i];
			for(var j = 0; j < arr2.length; j++) {
				if(row1.id == arr2[j].id) {
					var children = arr2[j].children;
					if(children) {
						row1.children = children;
					}
					
				}
			}
		}
	}
	</script>
	<script type="text/javascript">${js_plug_in?if_exists}</script>		
 </body>
</html>
