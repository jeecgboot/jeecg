<html xmlns:m="http://schemas.microsoft.com/office/2004/12/omml">
<head>
	<base href="${basePath}/"/>
	<title>员工费用报销单</title>
	<style type="text/css">body{font-size:12px;}table{border: 1px solid #000000;padding:0; margin:0 auto;border-collapse: collapse;width:100%;align:right;}td {border: 1px solid #000000;background: #fff;font-size:12px;padding: 3px 3px 3px 8px;color: #000000;word-break: keep-all;}
	</style>
	${config_iframe}
	<link rel="stylesheet" href="${basePath}/plug-in/Formdesign/js/ueditor/formdesign/bootstrap/css/bootstrap.css">
</head>
<body>
  <form id="formobj" action="${basePath}/cgFormBuildController.do?saveOrUpdateMore" name="formobj" method="post">
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
			<td colspan="4" nowrap="nowrap" style="width:675.75pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:36.75pt" width="901">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size:18.0pt;font-family:&quot;微软雅黑&quot;,&quot;sans-serif&quot;;mso-bidi-font-family:
  宋体;color:#00B0F0;mso-font-kerning:0pt">员工费用报销单<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:2;height:16.5pt">
			<td colspan="3" nowrap="nowrap" style="width: 453.9pt; border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-color: rgb(0, 176, 240); border-bottom-width: 1pt; padding: 0cm 5.4pt; height: 16.5pt;" width="605">
			<p align="center" class="MsoNormal" style="text-align:right;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">　<span lang="EN-US"><o:p>填表日期</o:p></span></span></p>
			</td>
			<td nowrap="nowrap" style="width: 120.45pt; border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-color: rgb(0, 176, 240); border-bottom-width: 1pt; padding: 0cm 5.4pt; height: 16.5pt;" width="161">
			<p align="left" class="MsoNormal"><span lang="EN-US">
			<input name="fill_time" id="fill_time" datatype="*" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  value="${data['${tableName}']['fill_time']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">填表日期</label>
			</span><span lang="EN-US" style="font-size: 11pt; font-family: 微软雅黑, sans-serif;"><o:p></o:p></span></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:4;height:24.75pt">
			<td nowrap="nowrap" style="width: 92.9pt; border-right-color: rgb(165, 165, 165); border-bottom-color: rgb(165, 165, 165); border-left-color: rgb(165, 165, 165); border-right-width: 1pt; border-bottom-width: 1pt; border-left-width: 1pt; border-top-style: none; padding: 0cm 5.4pt; height: 24.75pt; background-color: rgb(242, 242, 242);" width="124">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">职工姓名<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td style="width: 160px; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 24px; white-space: nowrap;">
			<p align="left" class="MsoNormal"><span lang="EN-US">
			<input name="staff_name" id="staff_name" datatype="*" class="inputxt" value="${data['${tableName}']['staff_name']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">职工姓名</label>
			</span></p>
			</td>
			<td nowrap="nowrap" style="width: 78.8pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 24.75pt; background-color: rgb(242, 242, 242);" width="105">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">部门<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td style="width: 160px; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 24px; white-space: nowrap;">
			<p align="left" class="MsoNormal"><span lang="EN-US">
			<input name="depart" id="depart" datatype="*" class="inputxt" value="${data['${tableName}']['depart']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">部门</label>
			</span></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:5;height:22.5pt">
			<td nowrap="nowrap" style="width: 78.8pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 22.5pt; background-color: rgb(242, 242, 242);" width="105">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">员工编号<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td nowrap="nowrap" style="width: 298.55pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 22.5pt;" width="398">
			<p class="MsoNormal"><span lang="EN-US">
			<input name="staff_no" id="staff_no" datatype="*" class="inputxt"  value="${data['${tableName}']['staff_no']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">员工编号</label>
			</span><span lang="EN-US" style="font-size: 11pt; font-family: 微软雅黑, sans-serif;"><o:p></o:p></span></p>
			</td>
			<td nowrap="nowrap" style="width: 78.8pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 22.5pt; background-color: rgb(242, 242, 242);" width="105">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">职位<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td nowrap="nowrap" style="width: 298.55pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 22.5pt;" width="398">
			<p class="MsoNormal"><span lang="EN-US">
			<input name="staff_post" id="staff_post" datatype="*" class="inputxt"  value="${data['${tableName}']['staff_post']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">职位</label>
			</span><span lang="EN-US" style="font-size: 11pt; font-family: 微软雅黑, sans-serif;"><o:p></o:p></span></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:6;height:21.75pt">
			<td nowrap="nowrap" style="width: 92.9pt; border-right-color: rgb(165, 165, 165); border-bottom-color: rgb(165, 165, 165); border-left-color: rgb(165, 165, 165); border-right-width: 1pt; border-bottom-width: 1pt; border-left-width: 1pt; border-top-style: none; padding: 0cm 5.4pt; height: 21.75pt; background-color: rgb(242, 242, 242);" width="124">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">打款方式<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td nowrap="nowrap" style="width: 3cm; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 21.75pt;" width="113">
			<p align="left" class="MsoNormal"><span lang="EN-US">
			<input name="pay_way" id="pay_way" datatype="*" class="inputxt"  value="${data['${tableName}']['pay_way']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">打款方式</label>
			</span></p>
			</td>
			<td nowrap="nowrap" style="width: 78.8pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 21.75pt; background-color: rgb(242, 242, 242);" width="105">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">开户行<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td nowrap="nowrap" style="width: 298.55pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 21.75pt;" width="398">
			<p class="MsoNormal"><span lang="EN-US">
			<input name="acct_bank" id="acct_bank" datatype="*" class="inputxt"  value="${data['${tableName}']['acct_bank']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">开户行</label>
			</span><span lang="EN-US" style="font-size: 11pt; font-family: 微软雅黑, sans-serif;"><o:p></o:p></span></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:7;height:24.0pt">
			<td nowrap="nowrap" style="width: 92.9pt; border-right-color: rgb(165, 165, 165); border-bottom-color: rgb(165, 165, 165); border-left-color: rgb(165, 165, 165); border-right-width: 1pt; border-bottom-width: 1pt; border-left-width: 1pt; border-top-style: none; padding: 0cm 5.4pt; height: 24pt; background-color: rgb(242, 242, 242);" width="124">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">卡号<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td nowrap="nowrap" style="width: 3cm; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 24pt;" width="113">
			<p align="left" class="MsoNormal"><span lang="EN-US">
			<input name="card_no" id="card_no" datatype="*" class="inputxt"  value="${data['${tableName}']['card_no']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">卡号</label>
			</span></p>
			</td>
			<td nowrap="nowrap" style="width: 78.8pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 24pt; background-color: rgb(242, 242, 242);" width="105">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">联系手机号<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td nowrap="nowrap" style="width: 105.5pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 24pt;" width="141">
			<p align="left" class="MsoNormal"><span lang="EN-US">
			<input name="tele_no" id="tele_no" datatype="*" class="inputxt"  value="${data['${tableName}']['tele_no']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">联系手机号</label>
			</span></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:9;height:26.25pt">
			<td colspan="4" nowrap="nowrap" style="width: 675.75pt; border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-color: rgb(0, 176, 240); border-bottom-width: 1.5pt; padding: 0cm 5.4pt; height: 26.25pt;" width="901">
			<p align="left" class="MsoNormal"><b><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">餐费明细<span lang="EN-US"><o:p></o:p></span></span></b></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:10;height:21.0pt">
			<td colspan="4" rowspan="2" style="width:518.2500pt;padding:0.7500pt 0.7500pt 0.7500pt 0.7500pt ;border-left:0.5000pt solid rgb(164,164,164);mso-border-left-alt:0.5000pt solid rgb(164,164,164);border-right:0.5000pt solid rgb(164,164,164);mso-border-right-alt:0.5000pt solid rgb(164,164,164);border-top:none;;mso-border-top-alt:none;;border-bottom:0.5000pt solid rgb(164,164,164);mso-border-bottom-alt:0.5000pt solid rgb(164,164,164);" valign="center" width="691">
			<table class="MsoTableGrid" style="border-collapse:collapse; width:99%;margin-left:5.6500pt;mso-table-layout-alt:fixed;mso-padding-alt:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;">
				<thead>
					<tr>
						<td colspan="6" style="padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="689">
						<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:right;vertical-align:middle;"><span style="mso-spacerun:'yes';font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
							<button class="btn btn-small btn-success listAdd" type="button" onclick="addRow('mealsCostTab','add_meals_cost_template')">添加一行</button>
						</span></p>
						</td>
					</tr>
					<tr>
						<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
						<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="mso-spacerun:'yes';font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">日期</span></p>
						</td>
						<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
						<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="mso-spacerun:'yes';font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">餐费</span></p>
						</td>
						<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
						<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="mso-spacerun:'yes';font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">吃饭地点</span></p>
						</td>
						<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
						<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="mso-spacerun:'yes';font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">同行人数</span></p>
						</td>
						<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
						<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="mso-spacerun:'yes';font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">备注</span></p>
						</td>
						<td style="width:15%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
						<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="mso-spacerun:'yes';font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;width:60px;display:block;">操作</span></p>
						</td>
					</tr>
				</thead>
				<tbody id="mealsCostTab">
					<#assign subTableStr>${head.subTableStr?if_exists?html}</#assign>
					<#assign subtablelist=subTableStr?split(",")>
					<#list subtablelist as sub >
					<#if sub?index_of("meals")!=-1 && data['${sub}']?exists&&(data['${sub}']?size>0) >
				    <#list data['${sub}']  as subTableData>
						<tr>
							<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
								<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
									<input name="jform_employee_meals_cost[${subTableData_index}].meals_date" datatype="*" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  value="${subTableData['meals_date']?if_exists?html}" ignore="ignore">
								</span></p>
							</td>
							<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
								<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
									<input name="jform_employee_meals_cost[${subTableData_index}].meals_cost"  datatype="*" class="inputxt"  value="${subTableData['meals_cost']?if_exists?html}" ignore="ignore">
								</span></p>
							</td>
							<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
								<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
									<input name="jform_employee_meals_cost[${subTableData_index}].meals_addr"  datatype="*" class="inputxt"  value="${subTableData['meals_addr']?if_exists?html}" ignore="ignore">
								</span></p>
							</td>
							<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
								<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
									<input name="jform_employee_meals_cost[${subTableData_index}].meals_number"  datatype="*" class="inputxt"  value="${subTableData['meals_number']?if_exists?html}" ignore="ignore">
								</span></p>
							</td>
							<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
								<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
									<input name="jform_employee_meals_cost[${subTableData_index}].comments"  datatype="*" class="inputxt"  value="${subTableData['comments']?if_exists?html}" ignore="ignore">
								</span></p>
							</td>
							<td style="width:15%;"><button class='btn btn-small btn-success delrow' type='button'>删除</button></td>
						</tr>
					</#list>
					<#elseif sub?index_of("meals")!=-1 >
						<tr>
							<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
								<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
									<input name="jform_employee_meals_cost[0].meals_date" datatype="*" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  value="" ignore="ignore">
								</span></p>
							</td>
							<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
								<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
									<input name="jform_employee_meals_cost[0].meals_cost"  datatype="*" class="inputxt"  value="" ignore="ignore">
								</span></p>
							</td>
							<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
								<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
									<input name="jform_employee_meals_cost[0].meals_addr"  datatype="*" class="inputxt"  value="" ignore="ignore">
								</span></p>
							</td>
							<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
								<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
									<input name="jform_employee_meals_cost[0].meals_number"  datatype="*" class="inputxt"  value="" ignore="ignore">
								</span></p>
							</td>
							<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
								<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
									<input name="jform_employee_meals_cost[0].comments"  datatype="*" class="inputxt"  value="" ignore="ignore">
								</span></p>
							</td>
							<td style="width:15%;"><button class='btn btn-small btn-success delrow' type='button'>删除</button></td>
						</tr>
					</#if>
					</#list>
				</tbody>
			</table>
		</tr>
		<tr style="height:14.2500pt;">
		</tr>
		<tr style="mso-yfti-irow:9;height:26.25pt">
			<td colspan="4" nowrap="nowrap" style="width: 675.75pt; border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-color: rgb(0, 176, 240); border-bottom-width: 1.5pt; padding: 0cm 5.4pt; height: 26.25pt;" width="901">
			<p align="left" class="MsoNormal"><b><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">其他费用<span lang="EN-US"><o:p></o:p></span></span></b></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:10;height:21.0pt">
			<td colspan="4" rowspan="2" style="width:518.2500pt;padding:0.7500pt 0.7500pt 0.7500pt 0.7500pt ;border-left:0.5000pt solid rgb(164,164,164);mso-border-left-alt:0.5000pt solid rgb(164,164,164);border-right:0.5000pt solid rgb(164,164,164);mso-border-right-alt:0.5000pt solid rgb(164,164,164);border-top:none;;mso-border-top-alt:none;;border-bottom:0.5000pt solid rgb(164,164,164);mso-border-bottom-alt:0.5000pt solid rgb(164,164,164);" valign="center" width="691">
			<table class="MsoTableGrid" style="border-collapse:collapse; width:99%;margin-left:5.6500pt;mso-table-layout-alt:fixed;mso-padding-alt:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;">
				<thead>
						<tr>
							<td colspan="6" style="padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="689">
							<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:right;vertical-align:middle;"><span style="mso-spacerun:'yes';font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
								<button class="btn btn-small btn-success listAdd" type="button" onclick="addRow('otherCostTab','add_other_cost_template')">添加一行</button>
							</span></p>
							</td>
						</tr>
						<tr>
							<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
							<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="mso-spacerun:'yes';font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">事项</span></p>
							</td>
							<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
							<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="mso-spacerun:'yes';font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">费用</span></p>
							</td>
							<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
							<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="mso-spacerun:'yes';font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">开始时间</span></p>
							</td>
							<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
							<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="mso-spacerun:'yes';font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">结束时间</span></p>
							</td>
							<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
							<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="mso-spacerun:'yes';font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">备注</span></p>
							</td>
							<td style="width:15%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
							<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="mso-spacerun:'yes';font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">操作</span></p>
							</td>
						</tr>
				</thead>
				<tbody id="otherCostTab">
					<#assign subTableStr>${head.subTableStr?if_exists?html}</#assign>
					<#assign subtablelist=subTableStr?split(",")>
					<#list subtablelist as sub >
					<#if sub?index_of("other")!=-1 && data['${sub}']?exists&&(data['${sub}']?size>0) >
				    <#list data['${sub}']  as subTableData>
						<tr>
							<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
								<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
									<input name="jform_employee_other_cost[${subTableData_index}].item" datatype="*" class="inputxt"  value="${subTableData['item']?if_exists?html}" ignore="ignore">
								</span></p>
							</td>
							<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
								<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
									<input name="jform_employee_other_cost[${subTableData_index}].cost" datatype="*" class="inputxt"  value="${subTableData['cost']?if_exists?html}" ignore="ignore">
								</span></p>
							</td>
							<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
								<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
									<input name="jform_employee_other_cost[${subTableData_index}].begin_time" datatype="*" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  value="${subTableData['begin_time']?if_exists?html}" ignore="ignore">
								</span></p>
							</td>
							<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
								<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
									<input name="jform_employee_other_cost[${subTableData_index}].end_time" datatype="*" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  value="${subTableData['end_time']?if_exists?html}" ignore="ignore">
								</span></p>
							</td>
							<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
								<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
									<input name="jform_employee_other_cost[${subTableData_index}].comments"  datatype="*" class="inputxt"  value="${subTableData['comments']?if_exists?html}" ignore="ignore">
								</span></p>
							</td>
							<td style="width:15%;"><button class='btn btn-small btn-success delrow' type='button'>删除</button></td>
						</tr>
					</#list>
					<#elseif sub?index_of("other")!=-1>
					<tr>
							<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
								<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
									<input name="jform_employee_other_cost[0].item" datatype="*" class="inputxt"  value="" ignore="ignore">
								</span></p>
							</td>
							<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
								<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
									<input name="jform_employee_other_cost[0].cost" datatype="*" class="inputxt"  value="" ignore="ignore">
								</span></p>
							</td>
							<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
								<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
									<input name="jform_employee_other_cost[0].begin_time" datatype="*" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  value="" ignore="ignore">
								</span></p>
							</td>
							<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
								<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
									<input name="jform_employee_other_cost[0].end_time" datatype="*" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  value="" ignore="ignore">
								</span></p>
							</td>
							<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
								<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
									<input name="jform_employee_other_cost[0].comments"  datatype="*" class="inputxt"  value="" ignore="ignore">
								</span></p>
							</td>
							<td style="width:15%;"><button class='btn btn-small btn-success delrow' type='button'>删除</button></td>
						</tr>
					</#if>
					</#list>	
				</tbody>
			</table>
			</td>
		</tr>
		<tr style="height:14.2500pt;">
		</tr>
		<tr style="mso-yfti-irow:14;height:17.25pt">
			<td colspan="4" nowrap="nowrap" style="width: 675.75pt; border-top-color: rgb(191, 191, 191); border-top-width: 1pt; border-left-style: none; border-bottom-color: rgb(0, 176, 240); border-bottom-width: 1.5pt; border-right-style: none; padding: 0cm 5.4pt; height: 17.25pt;" width="901">
			<p align="left" class="MsoNormal"><b><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">部门审批<span lang="EN-US"><o:p></o:p></span></span></b></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:15;height:66.0pt">
			<td colspan="4" nowrap="nowrap" style="width:675.75pt;padding:0cm 5.4pt 0cm 5.4pt;height:66.0pt" width="901">&nbsp;
			<textarea id="depart_approve" name="depart_approve" 
			style="width: 900px" class="inputxt" rows="6">${data['${tableName}']['depart_approve']?if_exists?html}</textarea>
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">部门审批</label>
			</td>
		</tr>
		<tr style="mso-yfti-irow:14;height:17.25pt">
			<td colspan="4" nowrap="nowrap" style="width: 675.75pt; border-top-color: rgb(191, 191, 191); border-top-width: 1pt; border-left-style: none; border-bottom-color: rgb(0, 176, 240); border-bottom-width: 1.5pt; border-right-style: none; padding: 0cm 5.4pt; height: 17.25pt;" width="901">
			<p align="left" class="MsoNormal"><b><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">财务审批<span lang="EN-US"><o:p></o:p></span></span></b></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:15;height:66.0pt">
			<td colspan="4" nowrap="nowrap" style="width:675.75pt;padding:0cm 5.4pt 0cm 5.4pt;height:66.0pt" width="901">&nbsp;
			<textarea id="finance_approve" name="finance_approve" 
			style="width: 900px" class="inputxt" rows="6">${data['${tableName}']['finance_approve']?if_exists?html}</textarea>
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">财务审批</label>
			</td>
		</tr>
		<tr style="mso-yfti-irow:17;height:17.25pt">
			<td colspan="4" nowrap="nowrap" style="width: 675.75pt; border-top-color: rgb(191, 191, 191); border-top-width: 1pt; border-left-style: none; border-bottom-color: rgb(0, 176, 240); border-bottom-width: 1.5pt; border-right-style: none; padding: 0cm 5.4pt; height: 17.25pt;" width="901">
			<p align="left" class="MsoNormal"><b><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">总经理审批<span lang="EN-US"><o:p></o:p></span></span></b></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:18;height:63.75pt">
			<td colspan="4" nowrap="nowrap" style="width:675.75pt;padding:0cm 5.4pt 0cm 5.4pt;height:63.75pt" width="901">&nbsp;
			<textarea id="mgr_approve" name="mgr_approve" 
			style="width: 900px" class="inputxt" rows="6">${data['${tableName}']['mgr_approve']?if_exists?html}</textarea>
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">总经理审批</label>
			</td>
		</tr>
		<tr style="mso-yfti-irow:20;height:17.25pt">
			<td colspan="4" nowrap="nowrap" style="width: 675.75pt; border-top-color: rgb(191, 191, 191); border-top-width: 1pt; border-left-style: none; border-bottom-color: rgb(0, 176, 240); border-bottom-width: 1.5pt; border-right-style: none; padding: 0cm 5.4pt; height: 17.25pt;" width="901">
			<p align="left" class="MsoNormal"><b><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">出纳<span lang="EN-US"><o:p></o:p></span></span></b></p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:21;height:77.25pt">
			<td colspan="4" nowrap="nowrap" style="width:675.75pt;padding:0cm 5.4pt 0cm 5.4pt;height:77.25pt" width="901">&nbsp;
			<textarea id="treasurer" name="treasurer" 
			style="width: 900px" class="inputxt" rows="6">${data['${tableName}']['treasurer']?if_exists?html}</textarea>
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">新员工意见</label>
			</td>
		</tr>
		<tr style="mso-yfti-irow:7;height:24.0pt">
			<td nowrap="nowrap" style="width: 92.9pt; border-right-color: rgb(165, 165, 165); border-bottom-color: rgb(165, 165, 165); border-left-color: rgb(165, 165, 165); border-right-width: 1pt; border-bottom-width: 1pt; border-left-width: 1pt; border-top-style: none; padding: 0cm 5.4pt; height: 24pt; background-color: rgb(242, 242, 242);" width="124">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">申请人<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td nowrap="nowrap" style="width: 3cm; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 24pt;" width="113">
			<p align="left" class="MsoNormal"><span lang="EN-US">
			<input name="apply_by" id="apply_by" datatype="*" class="inputxt"  value="${data['${tableName}']['apply_by']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">申请人</label>
			</span></p>
			</td>
			<td nowrap="nowrap" style="width: 78.8pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 24pt; background-color: rgb(242, 242, 242);" width="105">
			<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan"><span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">申请时间<span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
			<td nowrap="nowrap" style="width: 105.5pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(165, 165, 165); border-bottom-width: 1pt; border-right-color: rgb(165, 165, 165); border-right-width: 1pt; padding: 0cm 5.4pt; height: 24pt;" width="141">
			<p align="left" class="MsoNormal"><span lang="EN-US">
			<input name="apply_time" id="apply_time" datatype="*" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  value="${data['${tableName}']['apply_time']?if_exists?html}" ignore="ignore">
			<span class="Validform_checktip"></span>
			<label class="Validform_label" style="display: none;">申请时间</label>
			</span></p>
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
		if(location.href.indexOf("goDetail.do")!=-1){
			$(".jeecgDetail").hide();
		}
		
		if(location.href.indexOf("goDetail.do")!=-1){
			//查看模式控件禁用
			$("#formobj").find(":input").attr("disabled","disabled");
		}
		if(location.href.indexOf("goAddButton.do")!=-1||location.href.indexOf("goUpdateButton.do")!=-1){
			//其他模式显示提交按钮
			$("#sub_tr").show();
		}
		
		$(".delrow").click(function(){
			var tabid = $(this).parent().parent().parent().attr('id');
			$(this).parent().parent().remove();resetTrNum(tabid);
		});
	   
	 });
		
	  function addRow(tabid,templateid){
	  		var tbHtml =$("#"+templateid).html();
	  		$("#"+tabid).append(tbHtml);
			$(".delrow").die().live("click",function(){
				var curtabid = $(this).parent().parent().parent().attr('id');
			    $(this).parent().parent().remove();resetTrNum(curtabid);
			});
			resetTrNum(tabid);
	  }
		
	  var neibuClickFlag = false;
	  function neibuClick() {
		  neibuClickFlag = true; 
		  $('#btn_sub').trigger('click');
	  }
	  
	  function resetTrNum(tableId) {
		$('#'+tableId + ' tr').each(function(i) {
	    	$(':input, select,a', this).each(function() {
	    	var $this = $(this), name = $this.attr('name'), val = $this.val();
			if (name != null) {
				if (name.indexOf("#index#") >= 0){
						$this.attr("name",name.replace('#index#',i));
				} else {
					var s = name.indexOf("[");
					var e = name.indexOf("]");
					var new_name = name.substring(s+1,e);
					$this.attr("name",name.replace(new_name,i));
				}
			 }
		 });
		});
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
	
	<table style="display:none">
		<tbody id="add_meals_cost_template">
			<tr>
				<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
					<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
						<input name="jform_employee_meals_cost[#index#].meals_date" datatype="*" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  value="${data['${tableName}']['apply_time']?if_exists?html}" ignore="ignore">
					</span></p>
				</td>
				<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
					<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
						<input name="jform_employee_meals_cost[#index#].meals_cost"  datatype="*" class="inputxt"  value="${data['${tableName}']['tele_no']?if_exists?html}" ignore="ignore">
					</span></p>
				</td>
				<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
					<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
						<input name="jform_employee_meals_cost[#index#].meals_addr"  datatype="*" class="inputxt"  value="${data['${tableName}']['tele_no']?if_exists?html}" ignore="ignore">
					</span></p>
				</td>
				<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
					<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
						<input name="jform_employee_meals_cost[#index#].meals_number"  datatype="*" class="inputxt"  value="${data['${tableName}']['tele_no']?if_exists?html}" ignore="ignore">
					</span></p>
				</td>
				<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
					<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
						<input name="jform_employee_meals_cost[#index#].comments"  datatype="*" class="inputxt"  value="${data['${tableName}']['tele_no']?if_exists?html}" ignore="ignore">
					</span></p>
				</td>
				<td sytle="width:15%;"><button class='btn btn-small btn-success delrow' type='button'>删除</button></td>
			</tr>
		</tbody>
		<tbody id="add_other_cost_template">
			<tr>
				<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
					<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
						<input name="jform_employee_other_cost[#index#].item" datatype="*" class="inputxt"  value="${data['${tableName}']['tele_no']?if_exists?html}" ignore="ignore">
					</span></p>
				</td>
				<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
					<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
						<input name="jform_employee_other_cost[#index#].cost" datatype="*" class="inputxt"  value="${data['${tableName}']['tele_no']?if_exists?html}" ignore="ignore">
					</span></p>
				</td>
				<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
					<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
						<input name="jform_employee_other_cost[#index#].begin_time" datatype="*" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  value="${data['${tableName}']['apply_time']?if_exists?html}" ignore="ignore">
					</span></p>
				</td>
				<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
					<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
						<input name="jform_employee_other_cost[#index#].end_time" datatype="*" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  value="${data['${tableName}']['apply_time']?if_exists?html}" ignore="ignore">
					</span></p>
				</td>
				<td style="width:17%;padding: 1px;border:solid #add9c0; border-left-width: 1px; border-left-color: rgb(164, 164, 164); border-right-width: 1px; border-right-color: rgb(164, 164, 164); border-top-style: none; border-bottom-width: 1px; border-bottom-color: rgb(164, 164, 164);" valign="top" width="114">
					<p class="MsoNormal" style="mso-pagination:widow-orphan;text-align:center;vertical-align:middle;"><span style="font-family:微软雅黑;color:rgb(0,0,0);font-style:normal;font-size:11.0000pt;mso-font-kerning:0.0000pt;">
						<input name="jform_employee_other_cost[#index#].comments"  datatype="*" class="inputxt"  value="${data['${tableName}']['tele_no']?if_exists?html}" ignore="ignore">
					</span></p>
				</td>
				<td style="width:15%;"><button class='btn btn-small btn-success delrow' type='button'>删除</button></td>
			</tr>
		</tbody>
	</table>
	
 </body>
</html>
