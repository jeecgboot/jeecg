<#setting number_format="0.#####################">
<!DOCTYPE html>
<html>
 <head>
  <base href="${basePath}/"/>
  <title></title>
  ${config_iframe}
  <script type="text/javascript">
	<!--
		$(function(){
			$("tbody > tr > td[align='right']").css("text-align","center");
			$("tbody > tr > td[align='right']:last").css("text-align","right").css("padding-right","50px");
		});
	//-->
	</script>
 </head>
 <body style="overflow-y: hidden; overflow-x: hidden;" scroll="no">
  <form id="formobj" action="${basePath}/cgFormBuildController.do?saveOrUpdate" name="formobj" method="post">
			<input type="hidden" id="btn_sub" class="btn_sub"/>
			<input type="hidden" name="tableName" value="${tableName?if_exists?html}" >
			<input type="hidden" name="id" value="${id?if_exists?html}" >
			<#list columnhidden as po>
			  <input type="hidden" id="${po.field_name}" name="${po.field_name}" value="${data['${tableName}']['${po.field_name}']?if_exists?html}" >
			</#list>
			<table cellpadding="0" cellspacing="1" class="formtable">
            <tbody>
				<tr>
					<td colspan='6' align="center" ><strong>客户追踪记录表</strong></td>
				</tr>
				<!-- line.1 -->
                <tr>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">* 客户编号</span>
                    </td>
                    <td class="value" width="20%">
						<input name="custom_id" id="custom_id" datatype="*" class="inputxt" value="${data['${tableName}']['custom_id']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">客户编号</label>
                    </td>
					<td align="right" height="40" width="10%">
						<span class="filedzt">负责人</span>
                    </td>
                    <td class="value" width="20%">
						<input name="header" id="header" datatype="*" class="inputxt" value="${data['${tableName}']['header']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">负责人</label>
                    </td>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">成立日期</span>
                    </td>
                    <td class="value" width="30%">
						<input name="establish_date" id="establish_date" datatype="*" class="Wdate" onClick="WdatePicker()"  value="${data['${tableName}']['establish_date']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">成立日期</label>
                    </td>
                </tr>
				<!-- line.2 -->
                <tr>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">客户名称</span>
                    </td>
                    <td class="value" width="20%" colspan="3">
						<input name="custom_name" id="custom_name" datatype="*" class="inputxt" value="${data['${tableName}']['custom_name']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">客户名称</label>
                    </td>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">资本额</span>
                    </td>
                    <td class="value" width="30%">
						<input name="capital_lines" id="capital_lines" datatype="*" class="inputxt" value="${data['${tableName}']['capital_lines']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">资本额</label>
                    </td>
                </tr>
				<!-- line.3 -->
                <tr>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">地    址</span>
                    </td>
                    <td class="value" width="20%" colspan="3">
						<input name="address" id="address" datatype="*" class="inputxt" value="${data['${tableName}']['address']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">地    址</label>
                    </td>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">电  话</span>
                    </td>
                    <td class="value" width="30%">
						<input name="phone" id="phone" datatype="*" class="inputxt" value="${data['${tableName}']['phone']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">电    话</label>
                    </td>
                </tr>
				<!-- line.4 -->
                <tr>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">营业类型</span>
                    </td>
                    <td class="value" width="20%" colspan="3">
						<input name="business_type" id="business_type" datatype="*" class="inputxt" value="${data['${tableName}']['business_type']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">营业类型</label>
                    </td>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">传  真</span>
                    </td>
                    <td class="value" width="30%">
						<input name="fax" id="fax" datatype="*" class="inputxt" value="${data['${tableName}']['fax']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">传  真</label>
                    </td>
                </tr>
				<!-- line.5 -->
                <tr>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">主要往来银行</span>
                    </td>
                    <td class="value" width="20%" colspan="5">
						<input name="banks" id="banks" datatype="*" class="inputxt" value="${data['${tableName}']['banks']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">主要往来银行</label>
                    </td>
                </tr>
				<!-- line.6 -->
                <tr>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">其他投资事业</span>
                    </td>
                    <td class="value" width="30%" colspan="2">
						<input name="other_business" id="other_business" datatype="*" class="inputxt" value="${data['${tableName}']['other_business']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">其他投资事业</label>
                    </td>
                    <td align="right" height="40" width="20%">
						<span class="filedzt">平均每日营业额</span>
                    </td>
                    <td class="value" width="30%" colspan="2">
						<input name="turnover" id="turnover" datatype="*" class="inputxt" value="${data['${tableName}']['turnover']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">平均每日营业额</label>
                    </td>
                </tr>
				<!-- line.7 -->
                <tr>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">主要业务往来</span>
                    </td>
                    <td class="value" width="30%" colspan="2">
						<input name="business" id="business" datatype="*" class="inputxt" value="${data['${tableName}']['business']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">主要业务往来</label>
                    </td>
                    <td align="right" height="40" width="20%">
						<span class="filedzt">付款方式</span>
                    </td>
                    <td class="value" width="30%" colspan="2">
						<input type="hidden" id="pay_type" name="pay_type"  value="${data['${tableName}']['pay_type']?if_exists?html}"  />
						<input type="checkbox" name="pay_type_c" value="a" <#if (data['${tableName}']['pay_type']?if_exists?index_of('a') gt 0)>checked</#if>  onclick="getChecked(this.name,'pay_type')" >现金</input>
                        <input type="checkbox" name="pay_type_c" value="b" <#if (data['${tableName}']['pay_type']?if_exists?index_of('b') gt 0)>checked</#if> onclick="getChecked(this.name,'pay_type')" >支票</input>
                        <input type="checkbox" name="pay_type_c" value="c" <#if (data['${tableName}']['pay_type']?if_exists?index_of('c') gt 0)>checked</#if> onclick="getChecked(this.name,'pay_type')" >客票</input>
                        <input type="checkbox" name="pay_type_c" value="d" <#if (data['${tableName}']['pay_type']?if_exists?index_of('d') gt 0)>checked</#if> onclick="getChecked(this.name,'pay_type')" >其他</input>
                    </td>
                </tr>
				<!-- line.8 -->
                <tr>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">与本公司往来</span>
                    </td>
                    <td class="value" width="30%" colspan="2">
						<input name="business_contacts" id="business_contacts" datatype="*" class="inputxt" value="${data['${tableName}']['business_contacts']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">与本公司往来</label>
                    </td>
                    <td align="right" height="40" width="20%">
						<span class="filedzt">收款记录</span>
                    </td>
                    <td class="value" width="30%" colspan="2">						
						<input type="hidden" id="collection" name="collection"  value="${data['${tableName}']['collection']?if_exists?html}"  />
						<input type="checkbox" name="collection_c" value="a" <#if (data['${tableName}']['collection']?if_exists?index_of('a') gt 0)>checked</#if>  onclick="getChecked(this.name,'collection')" >优秀</input>
                        <input type="checkbox" name="collection_c" value="b" <#if (data['${tableName}']['collection']?if_exists?index_of('b') gt 0)>checked</#if> onclick="getChecked(this.name,'collection')" >良好</input>
                        <input type="checkbox" name="collection_c" value="c" <#if (data['${tableName}']['collection']?if_exists?index_of('c') gt 0)>checked</#if> onclick="getChecked(this.name,'collection')" >一般</input>
                        <input type="checkbox" name="collection_c" value="d" <#if (data['${tableName}']['collection']?if_exists?index_of('d') gt 0)>checked</#if> onclick="getChecked(this.name,'collection')" >很差</input>
                    </td>
                </tr>
				<!-- line.9 -->
                <tr>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">最近与本公司往来重要记录</span>
                    </td>
                    <td class="value" width="20%" colspan="5">
						<input name="business_important_contacts" id="business_important_contacts" datatype="*" class="inputxt" value="${data['${tableName}']['business_important_contacts']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">最近与本公司往来重要记录</label>
                    </td>
                </tr>
				<!-- line.10 -->
                <tr>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">最近交易数据跟踪</span>
                    </td>
                    <td class="value" width="20%" colspan="5">
						<input name="business_record" id="business_record" datatype="*" class="inputxt" value="${data['${tableName}']['business_record']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">最近交易数据跟踪</label>
                    </td>
                </tr>				
				<!-- line.11 -->
                <tr>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">客  户  意  见</span>
                    </td>
                    <td class="value" width="20%" colspan="5">
						<input name="customer_opinion" id="customer_opinion" datatype="*" class="inputxt" value="${data['${tableName}']['customer_opinion']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">客  户  意  见</label>
                    </td>
                </tr>
				<!-- line.12 -->
                <tr>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">信  用  评  定</span>
                    </td>
                    <td class="value" width="20%" colspan="5">
						<input name="credit_evaluation" id="credit_evaluation" datatype="*" class="inputxt" value="${data['${tableName}']['credit_evaluation']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">信  用  评  定</label>
                    </td>
                </tr>
				<!-- line.13 -->
                <tr>
                    <td align="right" height="40" width="70%" colspan="4">
						<span class="filedzt">填表人</span>
                    </td>
					<td class="value" width="30%" colspan="2">
						<input name="preparer" id="preparer" datatype="*" class="inputxt" value="${data['${tableName}']['preparer']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">填表人</label>
                    </td>
                </tr>
				<tr id = "sub_tr" style="display: none;">
				  <td colspan="2" align="center">
				  <input type="button" value="提交" onclick="neibuClick();" class="ui_state_highlight">
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