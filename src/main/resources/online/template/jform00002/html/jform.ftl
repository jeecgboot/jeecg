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
 <body style="overflow-x: hidden;" scroll="yes">
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
					<td colspan='6' align="center" ><strong>员工离职申请单</strong></td>
				</tr>
				<!-- line.1 -->
                <tr>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">姓名</span>
                    </td>
                    <td class="value" width="20%" colspan="2">
						<input name="name" id="name" datatype="*" class="inputxt" value="${data['${tableName}']['name']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">姓名</label>
                    </td>
					<td align="right" height="40" width="10%">
						<span class="filedzt">员工编号</span>
                    </td>
                    <td class="value" width="30%" colspan="2">
						<input name="code" id="code" datatype="*" class="inputxt" value="${data['${tableName}']['code']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">员工编号</label>
                    </td>
				</tr>
				<!-- line.2 -->
                <tr>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">职务</span>
                    </td>
                    <td class="value" width="20%" colspan="2">
						<input name="job" id="job" datatype="*" class="inputxt" value="${data['${tableName}']['job']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">职务</label>
                    </td>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">入职时间</span>
                    </td>
                    <td class="value" width="30%" colspan="2">
						<input name="join_time" id="join_time" datatype="*" class="inputxt" value="${data['${tableName}']['join_time']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">入职时间</label>
                    </td>
                </tr>
				<!-- line.3 -->
                <tr>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">离职方式</span>
                    </td>
                    <td class="value" width="75%" colspan="5">
						<input type="hidden" id="out_type" name="out_type"  value="${data['${tableName}']['out_type']?if_exists?html}"  />
						<input type="radio" name="out_type_r" value="cigong" <#if (data['${tableName}']['out_type']?if_exists?index_of('a') gt 0)>checked</#if>  onclick="getChecked(this.name,'out_type')" >辞工</input>
                        <input type="checkbox" name="out_type_r" value="jicigong" <#if (data['${tableName}']['out_type']?if_exists?index_of('b') gt 0)>checked</#if> onclick="getChecked(this.name,'out_type')" >急辞工</input>
                        <input type="checkbox" name="out_type_r" value="citui" <#if (data['${tableName}']['out_type']?if_exists?index_of('c') gt 0)>checked</#if> onclick="getChecked(this.name,'out_type')" >辞退</input>
                        <input type="checkbox" name="out_type_r" value="kaichu" <#if (data['${tableName}']['out_type']?if_exists?index_of('d') gt 0)>checked</#if> onclick="getChecked(this.name,'out_type')" >开除</input>						
                        <input type="checkbox" name="out_type_r" value="zidonglizhi" <#if (data['${tableName}']['out_type']?if_exists?index_of('d') gt 0)>checked</#if> onclick="getChecked(this.name,'out_type')" >自动离职</input>
                    </td>
                </tr>
				<!-- line.4 -->
                <tr>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">申请离职日期</span>
                    </td>
                    <td class="value" width="20%" colspan="2">
						<input name="apply_out_time" id="apply_out_time" datatype="*" class="inputxt" value="${data['${tableName}']['apply_out_time']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">申请离职日期</label>
                    </td>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">正式离职日期</span>
                    </td>
                    <td class="value" width="30%" colspan="2">
						<input name="out_time" id="out_time" datatype="*" class="inputxt" value="${data['${tableName}']['out_time']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">正式离职日期</label>
                    </td>
                </tr>
				<!-- line.5 -->
                <tr>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">领工资人及身份证号</span>
                    </td>
                    <td class="value" width="75%" colspan="5">
						<input name="id_card" id="id_card" datatype="*" class="inputxt" value="${data['${tableName}']['id_card']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">领工资人及身份证号</label>
                    </td>
                </tr>
				<!-- line.6 -->
                <tr>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">离职须知</span>
                    </td>
                    <td class="value" width="75%" colspan="5">
						<textarea name="out_content" id="out_content" rows="3" class="inputxt" datatype="*" style="width: 95%;">${data['${tableName}']['out_content']?if_exists?html}</textarea>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">离职须知</label>
                    </td>
                </tr>
				<!-- line.7 -->
                <tr>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">离职原因</span>
                    </td>
                    <td class="value" width="75%" colspan="5">
						<textarea name="out_reason" id="out_reason" rows="3" class="inputxt" datatype="*" style="width: 95%;">${data['${tableName}']['out_reason']?if_exists?html}</textarea>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">离职原因</label>
                    </td>
                </tr>
				<!-- line.8 -->
                <tr>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">面谈记录和意见</span>
                    </td>
                    <td class="value" width="75%" colspan="5">
						<textarea name="interview_record" id="interview_record" rows="3" class="inputxt" datatype="*" style="width: 95%;">${data['${tableName}']['interview_record']?if_exists?html}</textarea>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">面谈记录和意见</label>
                    </td>
                </tr>
				<!-- line.9 -->
                <tr>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">办公用品移交</span>
                    </td>
                    <td class="value" width="75%" colspan="5">
						<textarea name="office_change" id="office_change" rows="3" class="inputxt" datatype="*" style="width: 95%;">${data['${tableName}']['office_change']?if_exists?html}</textarea>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">办公用品移交</label>
                    </td>
                </tr>
				<!-- line.10 -->
                <tr>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">人力资源部审核</span>
                    </td>
                    <td class="value" width="75%" colspan="5">
						<textarea name="hr_check" id="hr_check" rows="3" class="inputxt" datatype="*" style="width: 95%;">${data['${tableName}']['hr_check']?if_exists?html}</textarea>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">人力资源部审核</label>
                    </td>
                </tr>				
				<!-- line.11-->
                <tr>
                    <td align="right" height="40" width="10%" rowspan="2">
						<span class="filedzt">财务部</span>
                    </td>
					<td align="right" height="40" width="10%">
						<span class="filedzt">应发薪资</span>
                    </td>
                    <td class="value" width="20%">
						<input name="should_send_salary" id="should_send_salary" datatype="*" class="inputxt" value="${data['${tableName}']['should_send_salary']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">应发薪资</label>
                    </td>
					<td align="right" height="40" width="10%">
						<span class="filedzt">应扣薪资</span>
                    </td>
                    <td class="value" width="20%">
						<input name="should_deduct_pay" id="should_deduct_pay" datatype="*" class="inputxt" value="${data['${tableName}']['should_deduct_pay']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">应扣薪资</label>
                    </td>
                </tr>
				<!-- line.12 -->
                <tr>
                    <td align="right" height="40" width="10%">
						<span class="filedzt">实发薪资</span>
                    </td>
                    <td class="value" width="20%">
						<input name="pay" id="pay" datatype="*" class="inputxt" value="${data['${tableName}']['pay']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">实发薪资</label>
                    </td>
					<td align="right" height="40" width="10%">
						<span class="filedzt">领取日期</span>
                    </td>
                    <td class="value" width="20%">
						<input name="get_time" id="get_time" datatype="*" class="inputxt" value="${data['${tableName}']['get_time']?if_exists?html}" >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">领取日期</label>
                    </td>
                </tr>
				<!-- line.13 -->
                <tr>
					<td align="right" height="40" width="10%">
						<span class="filedzt">总经理审批</span>
                    </td>
                    <td class="value" width="75%" colspan="5">
						<textarea name="boss_check" id="boss_check" rows="3" class="inputxt" datatype="*" style="width: 95%;">${data['${tableName}']['boss_check']?if_exists?html}</textarea>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">总经理审批</label>
                    </td>
                </tr>
				<!-- line.14 -->
                <tr>
					<td align="right" height="40" width="10%">
						<span class="filedzt">说明</span>
                    </td>
                    <td class="value" width="75%" colspan="5">
						<textarea name="description" id="description" rows="3" class="inputxt" datatype="*" style="width: 95%;">${data['${tableName}']['description']?if_exists?html}</textarea>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">说明</label>
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