<html xmlns:m="http://schemas.microsoft.com/office/2004/12/omml">
<head>
	<title>员工请假单</title>
	<style type="text/css">body {
		font-size: 12px;
	}

	table {
		border: 1px solid #000000;
		padding: 0;
		margin: 0 auto;
		border-collapse: collapse;
		width: 100%;
		align: right;
	}

	td {
		border: 1px solid #000000;
		background: #fff;
		font-size: 12px;
		padding: 3px 3px 3px 8px;
		color: #000000;
		word-break: keep-all;
	}
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
	<table border="0" cellpadding="0" cellspacing="0" class="MsoNormalTable" style="width: 367pt;" width="489">
		<tbody>
			<tr style="mso-yfti-irow:0;mso-yfti-firstrow:yes;height:8.25pt">
				<td colspan="4" nowrap="nowrap" style="width: 367pt; padding: 0cm 5.4pt; height: 8.25pt; background-color: rgb(0, 176, 240);" width="489">
					<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan">
						<span style="font-size: 11pt; font-family: 宋体;"><span lang="EN-US"><o:p></o:p></span></span>
					</p>
				</td>
			</tr>
			<tr style="mso-yfti-irow:1;height:36.75pt">
				<td colspan="4" nowrap="nowrap" style="width:367.0pt;padding:0cm 5.4pt 0cm 5.4pt; height:36.75pt" width="489">
					<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan">
						<span mso-bidi-font-family:="" style="font-size:18.0pt;font-family:">请假申请单<span lang="EN-US"><o:p></o:p></span></span>
					</p>
				</td>
			</tr>
			<tr style="mso-yfti-irow:2;height:24.75pt">
				<td nowrap="nowrap" style="width: 78pt; border-top-color: rgb(0, 176, 240); border-top-width: 1pt; border-left-style: none; border-bottom-color: rgb(98, 185, 106); border-bottom-width: 1pt; border-right-color: rgb(98, 185, 106); border-right-width: 1pt; padding: 0cm 5.4pt; height: 24.75pt; background-color: rgb(188, 224, 191);" width="104">
				<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan">
					<span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">标题<span lang="EN-US"><o:p></o:p></span></span>
				</p>
			</td>
			<td nowrap="nowrap" style="width: 124.1pt; border-top-color: rgb(0, 176, 240); border-top-width: 1pt; border-left-style: none; border-bottom-color: rgb(98, 185, 106); border-bottom-width: 1pt; border-right-color: rgb(98, 185, 106); border-right-width: 1pt; padding: 0cm 5.4pt; height: 24.75pt;" width="165">
				<p align="left" class="MsoNormal">
					<span lang="EN-US">
						<input name="title" id="title" datatype="*" class="inputxt"  value="${data['${tableName}']['title']?if_exists?html}" ignore="ignore">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">标题</label>
					</span>
				</p>
			</td>
			<td nowrap="nowrap" style="width: 60.15pt; border-top-color: rgb(0, 176, 240); border-top-width: 1pt; border-left-style: none; border-bottom-color: rgb(98, 185, 106); border-bottom-width: 1pt; border-right-color: rgb(98, 185, 106); border-right-width: 1pt; padding: 0cm 5.4pt; height: 24.75pt; background-color: rgb(188, 224, 191);" width="80">
				<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan">
					<span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">申请人<span lang="EN-US"><o:p></o:p></span></span>
				</p>
			</td>
			<td nowrap="nowrap" style="width: 104.75pt; border-top-color: rgb(98, 185, 106); border-top-width: 1pt; border-left-style: none; border-bottom-color: rgb(98, 185, 106); border-bottom-width: 1pt; border-right-style: none; padding: 0cm 5.4pt; height: 24.75pt;" width="140">
				<p align="left" class="MsoNormal">
					<span lang="EN-US">
						<input name="people" id="people" datatype="*" class="Wdate" onClick="WdatePicker()"  value="${data['${tableName}']['people']?if_exists?html}" ignore="ignore">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">申请人</label>
					</span>
				</p>
			</td>
		</tr>

		<tr style="mso-yfti-irow:4;height:22.5pt">
			<td nowrap="nowrap" style="width: 78pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(98, 185, 106); border-bottom-width: 1pt; border-right-color: rgb(98, 185, 106); border-right-width: 1pt; padding: 0cm 5.4pt; height: 22.5pt; background-color: rgb(188, 224, 191);" width="104">
				<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan">
					<span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">性别<span lang="EN-US"><o:p></o:p></span></span>
				</p>
			</td>
			<td colspan="3" nowrap="nowrap" style="width: 289pt; border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-color: rgb(98, 185, 106); border-bottom-width: 1pt; padding: 0cm 5.4pt; height: 22.5pt;" width="385">
				<p align="left" class="MsoNormal">
					<span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">
						<span lang="EN-US">
							<@DictData name="sex" var="dataList">
								<#list dataList as dictdata>
								<input value="${dictdata.typecode?if_exists?html}" name="sex" type="radio"
									<#if dictdata_index==0>datatype="*"</#if> 
									<#if dictdata.typecode?if_exists?html=="${data['${tableName}']['sex']?if_exists?html}"> checked="true" </#if>>
									${dictdata.typename?if_exists?html}
								</#list> 
							</@DictData>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">性别</label>
						</span>
					</span>
				</p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:5;height:22.5pt">
			<td nowrap="nowrap" style="width: 78pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(98, 185, 106); border-bottom-width: 1pt; border-right-color: rgb(98, 185, 106); border-right-width: 1pt; padding: 0cm 5.4pt; height: 22.5pt; background-color: rgb(188, 224, 191);" width="104">
				<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan">
					<span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">请假原因<span lang="EN-US"><o:p></o:p></span></span>
				</p>
			</td>
			<td colspan="3" nowrap="nowrap" style="width: 289pt; border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-color: rgb(98, 185, 106); border-bottom-width: 1pt; padding: 0cm 5.4pt; height: 22.5pt;" width="385">
				<p align="left" class="MsoNormal">
					<span lang="EN-US">
						<textarea id="hol_reson" name="hol_reson" style="width: 900px" class="inputxt" rows="6">${data['${tableName}']['hol_reson']?if_exists?html}</textarea>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">请假原因</label>
					</span>
				</p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:6;height:22.5pt">
			<td nowrap="nowrap" style="width: 78pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(98, 185, 106); border-bottom-width: 1pt; border-right-color: rgb(98, 185, 106); border-right-width: 1pt; padding: 0cm 5.4pt; height: 22.5pt; background-color: rgb(188, 224, 191);" width="104">
				<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan">
					<span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">开始时间<span lang="EN-US"><o:p></o:p></span></span>
				</p>
			</td>
			<td colspan="3" nowrap="nowrap" style="width: 289pt; border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-color: rgb(98, 185, 106); border-bottom-width: 1pt; padding: 0cm 5.4pt; height: 22.5pt;" width="385">
				<p align="left" class="MsoNormal">
					<span lang="EN-US">
						<input name="begindate" id="begindate" datatype="*" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  value="${data['${tableName}']['begindate']?if_exists?html}" ignore="ignore">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">开始时间</label>
					</span>
				</p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:7;height:22.5pt">
			<td nowrap="nowrap" style="width: 78pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(98, 185, 106); border-bottom-width: 1pt; border-right-color: rgb(98, 185, 106); border-right-width: 1pt; padding: 0cm 5.4pt; height: 22.5pt; background-color: rgb(188, 224, 191);" width="104">
				<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan">
					<span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">结束时间<span lang="EN-US"><o:p></o:p></span></span>
				</p>
			</td>
			<td colspan="3" nowrap="nowrap" style="width: 289pt; border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-color: rgb(98, 185, 106); border-bottom-width: 1pt; padding: 0cm 5.4pt; height: 22.5pt;" width="385">
				<p align="left" class="MsoNormal">
					<span lang="EN-US">
						<input name="enddate" id="enddate" datatype="*" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  value="${data['${tableName}']['enddate']?if_exists?html}" ignore="ignore">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">结束时间</label>
					</span>
				</p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:8;height:22.5pt">
			<td nowrap="nowrap" style="width: 78pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(98, 185, 106); border-bottom-width: 1pt; border-right-color: rgb(98, 185, 106); border-right-width: 1pt; padding: 0cm 5.4pt; height: 22.5pt; background-color: rgb(188, 224, 191);" width="104">
				<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan">
					<span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">请假天数<span lang="EN-US"><o:p></o:p></span></span>
				</p>
			</td>
			<td colspan="3" nowrap="nowrap" style="width: 289pt; border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-color: rgb(98, 185, 106); border-bottom-width: 1pt; padding: 0cm 5.4pt; height: 22.5pt;" width="385">
				<p align="left" class="MsoNormal">
					<span lang="EN-US">
						<input name="day_num" id="day_num" datatype="*" class="inputxt"  value="${data['${tableName}']['day_num']?if_exists?html}" ignore="ignore">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">请假天数</label>
					</span>
				</p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:9;height:22.5pt">
			<td nowrap="nowrap" style="width: 78pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(98, 185, 106); border-bottom-width: 1pt; border-right-color: rgb(98, 185, 106); border-right-width: 1pt; padding: 0cm 5.4pt; height: 22.5pt; background-color: rgb(188, 224, 191);" width="104">
				<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan">
					<span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">所属部门<span lang="EN-US"><o:p></o:p></span></span>
				</p>
			</td>
			<td colspan="3" nowrap="nowrap" style="width: 289pt; border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-color: rgb(98, 185, 106); border-bottom-width: 1pt; padding: 0cm 5.4pt; height: 22.5pt;" width="385">
				<p align="left" class="MsoNormal">
					<span lang="EN-US">
						<input name="hol_dept" id="hol_dept" datatype="*" class="inputxt"  value="${data['${tableName}']['hol_dept']?if_exists?html}" ignore="ignore">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">所属部门</label>
					</span>
				</p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:10;height:22.5pt">
			<td nowrap="nowrap" style="width: 78pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(98, 185, 106); border-bottom-width: 1pt; border-right-color: rgb(98, 185, 106); border-right-width: 1pt; padding: 0cm 5.4pt; height: 22.5pt; background-color: rgb(188, 224, 191);" width="104">
				<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan">
					<span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">部门审批人<span lang="EN-US"><o:p></o:p></span></span>
				</p>
			</td>
			<td colspan="3" nowrap="nowrap" style="width: 289pt; border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-color: rgb(98, 185, 106); border-bottom-width: 1pt; padding: 0cm 5.4pt; height: 22.5pt;" width="385">
				<p align="left" class="MsoNormal">
					<span lang="EN-US">
						<input name="dep_leader" id="dep_leader" datatype="*" class="inputxt"  value="${data['${tableName}']['dep_leader']?if_exists?html}" ignore="ignore">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">部门审批人</label>
					</span>
				</p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:11;height:22.5pt">
			<td nowrap="nowrap" style="width: 78pt; border-top-style: none; border-left-style: none; border-bottom-color: rgb(98, 185, 106); border-bottom-width: 1pt; border-right-color: rgb(98, 185, 106); border-right-width: 1pt; padding: 0cm 5.4pt; height: 22.5pt; background-color: rgb(188, 224, 191);" width="104">
				<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan">
					<span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;">部门审批意见<span lang="EN-US"><o:p></o:p></span></span>
				</p>
			</td>
			<td colspan="3" nowrap="nowrap" style="width: 289pt; border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-color: rgb(98, 185, 106); border-bottom-width: 1pt; padding: 0cm 5.4pt; height: 22.5pt;" width="385">
				<p align="left" class="MsoNormal">
					<span lang="EN-US">
						<textarea id="content" name="content" style="width: 900px" class="inputxt" rows="6">${data['${tableName}']['content']?if_exists?html}</textarea>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">部门审批意见</label>
					</span>
				</p>
			</td>
		</tr>
		<tr style="mso-yfti-irow:15;mso-yfti-lastrow:yes;height:6.0pt">
			<td colspan="4" nowrap="nowrap" style="width: 367pt; border-top-style: none; border-right-style: none; border-bottom-style: none; border-left-color: rgb(128, 198, 135); border-left-width: 1pt; padding: 0cm 5.4pt; height: 6pt; background-color: rgb(0, 176, 240);" width="489">
				<p align="center" class="MsoNormal" style="text-align:center;mso-pagination:widow-orphan">
					<span style="font-size: 11pt; font-family: 微软雅黑, sans-serif;"><span lang="EN-US"><o:p></o:p></span></span></p>
			</td>
		</tr>
	</tbody>
</table>
	<script type = "text/javascript">
		$(function() {
			$("#formobj").Validform({
				tiptype: 1,
				btnSubmit: "#btn_sub",
				btnReset: "#btn_reset",
				ajaxPost: true,
				usePlugin: {
					passwordstrength: {
						minLen: 6,
						maxLen: 18,
						trigger: function(obj, error) {
							if (error) {
								obj.parent().next().find(".Validform_checktip").show();
								obj.find(".passwordStrength").hide();
							} else {
								$(".passwordStrength").show();
								obj.parent().next().find(".Validform_checktip").hide();
							}
						}
					}
				},
				callback: function(data) {
					if (data.success == true) {
						uploadFile(data);
					} else {
						if (data.responseText == '' || data.responseText == undefined) {
							$.messager.alert('错误', data.msg);
							$.Hidemsg();
						} else {
							try {
								var emsg = data.responseText.substring(data.responseText.indexOf('错误描述'), data.responseText.indexOf('错误信息'));
								$.messager.alert('错误', emsg);
								$.Hidemsg();
							} catch(ex) {
								$.messager.alert('错误', data.responseText + '');
							}
						}
						return false;
					}
					if (!neibuClickFlag) {
						var win = frameElement.api.opener;
						win.reloadTable();
					}
				}
			});
		});
	</script>
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
