<#setting number_format="0.#####################">
<!DOCTYPE html>
<html>
 <head>
  <title></title>
  ${config_iframe}
 </head>
 <body style="overflow-y: hidden; overflow-x: hidden;" scroll="no">
  <form id="formobj" action="cgFormBuildController.do?saveOrUpdate" name="formobj" method="post">
			<input type="hidden" id="btn_sub" class="btn_sub"/>
			<input type="hidden" name="tableName" value="${tableName?if_exists?html}" >
			<input type="hidden" name="id" value="${id?if_exists?html}" >
			<#list columnhidden as po>
			  <input type="hidden" id="${po.field_name}" name="${po.field_name}" value="${data['${tableName}']['${po.field_name}']?if_exists?html}" >
			</#list>
			<table cellpadding="0" cellspacing="1" class="formtable">
			   <tr>
			     <td colspan='11' align="center" ><strong>客户资料管理卡</strong></td>
			   </tr>
			   <tr>
				   <td colspan="2"  align="right" ><label class="Validform_label">* 客户名称</label></td>
                   <td colspan="3" class="value"><input id="cust_name" datatype="*" name="cust_name" type="text"  style="width: 150px"  class="inputxt" value="${data['${tableName}']['cust_name']?if_exists?html}"  />
                       <span class="Validform_checktip"></span>
                       <label class="Validform_label" style="display: none;">客户名称</label>
                   </td>
                   <td align="right"><label class="Validform_label">地址</label></td>
                   <td  class="value"><input id="cust_addr"  name="cust_addr" type="text"  style="width: 70px"  class="inputxt"   value="${data['${tableName}']['cust_addr']?if_exists?html}"  /></td>
                   <td align="right"><label class="Validform_label">*客户编号</label></td>
                   <td   class="value"><input id="cust_code" datatype="*"  name="cust_code" type="text"  style="width: 60px"  class="inputxt"  value="${data['${tableName}']['cust_code']?if_exists?html}"  />
                       <span class="Validform_checktip"></span>
                       <label class="Validform_label" style="display: none;">客户编号</label></td>
                   <td align="right"><label class="Validform_label">邮箱</label></td>
                   <td  class="value"><input id="email"  name="email" type="text"  datatype="e"  style="width: 150px"  class="inputxt"  value="${data['${tableName}']['email']?if_exists?html}"  />
                       <span class="Validform_checktip"></span>
                       <label class="Validform_label" style="display: none;">邮箱</label>
                   </td>
			   </tr>
                <tr>
                    <td colspan="2" align="right"><label class="Validform_label">负责人</label></td>
                    <td  class="value"><input id="cust_charge"  name="cust_charge" type="text"  style="width: 50px"  class="inputxt"  value="${data['${tableName}']['cust_charge']?if_exists?html}"  /></td>
                    <td align="right"><label class="Validform_label">性别</label></td>
                    <td  class="value"><input   name="sex" type="radio" value="男" <#if (data['${tableName}']['sex']?if_exists == '男')>checked</#if>  />男&nbsp;<input  <#if (data['${tableName}']['sex']?if_exists == '女')>checked</#if>    name="sex" type="radio" value="女"  />女</td>
                    <td align="right"><label class="Validform_label">年龄</label></td>
                    <td  class="value"><input id="age"  name="age"  datatype="n"  type="text"  style="width: 70px"  class="inputxt"  value="${data['${tableName}']['age']?if_exists?html}"  />
                        <span class="Validform_checktip"></span>
                        <label class="Validform_label" style="display: none;">年龄</label>
                    </td>
                    <td align="right"><label class="Validform_label">职务</label></td>
                    <td  class="value"><input id="position"  name="position" type="text"  style="width: 50px"  class="inputxt"  value="${data['${tableName}']['position']?if_exists?html}"  /></td>
                    <td align="right"><label class="Validform_label">电话</label></td>
                    <td  class="value"><input id="phone"  name="phone" type="text"  style="width: 150px"  class="inputxt"  value="${data['${tableName}']['phone']?if_exists?html}"  /></td>

				</tr>
                <tr>
                    <td rowspan="3" align="right"><label class="Validform_label">金融情况</label></td>
                    <td align="right"><label class="Validform_label">往来银行</label></td>
                    <td   class="value"><input id="bank"  name="bank" type="text"  style="width: 50px"  class="inputxt"  value="${data['${tableName}']['bank']?if_exists?html}"  /></td>
                    <td colspan="2" align="right"><label class="Validform_label">现金情况</label></td>
                    <td colspan="2"  class="value"><input id="money"  name="money" type="text"  style="width: 150px"  class="inputxt"  value="${data['${tableName}']['money']?if_exists?html}"  /></td>
                    <td align="right"><label class="Validform_label">承办人</label></td>
                    <td colspan="3"  class="value"><input id="promoter"  name="promoter" type="text"  style="width: 250px"  class="inputxt"  value="${data['${tableName}']['promoter']?if_exists?html}"  /></td>
				</tr>
                <tr>
                    <td align="right"><label class="Validform_label">账号</label></td>
                    <td   class="value"><input id="account"  name="account" type="text"  style="width: 50px"  class="inputxt"  value="${data['${tableName}']['account']?if_exists?html}"  /></td>
                    <td  colspan="2" align="right"><label class="Validform_label">资金周转</label></td>
                    <td colspan="2"  class="value"><input id="turnover"  name="turnover" type="text"  style="width: 150px"  class="inputxt"  value="${data['${tableName}']['turnover']?if_exists?html}"  /></td>
                    <td align="right"><label class="Validform_label">付款态度</label></td>
                    <td colspan="3"  class="value"><input id="payment_attr"  name="payment_attr" type="text"  style="width: 250px"  class="inputxt"  value="${data['${tableName}']['payment_attr']?if_exists?html}"  /></td>
                </tr>
                <tr>
                    <td  align="right"><label class="Validform_label">税号</label></td>
                    <td colspan="5"  class="value"><input id="sax_num"  name="sax_num" type="text"  style="width: 250px"  class="inputxt"  value="${data['${tableName}']['sax_num']?if_exists?html}"  /></td>
                    <td align="right"><label class="Validform_label">付款日期</label></td>
                    <td colspan="3"  class="value"><input id="pay_date"  name="pay_date" type="text"  style="width: 250px"   class="Wdate" onClick="WdatePicker()"  value="${data['${tableName}']['pay_date']?if_exists?html}"   /></td>
                </tr>
                <tr>
                    <td colspan="2" align="right"><label class="Validform_label">开始交易日期</label></td>
                    <td colspan="4"  class="value"><input id="begin_pay_date"  name="begin_pay_date" type="text"  style="width: 150px"    class="Wdate" onClick="WdatePicker()"  value="${data['${tableName}']['begin_pay_date']?if_exists?html}"  /></td>
                    <td align="right"><label class="Validform_label">主营产品</label></td>
                    <td colspan="4"  class="value">
                        <input type="hidden" id="main_bus" name="main_bus"  value="${data['${tableName}']['main_bus']?if_exists?html}"  />
						<input type="checkbox" name="main_bus_c" value="a" <#if (data['${tableName}']['main_bus']?if_exists?index_of('a') gt 0)>checked</#if>  onclick="getChecked(this.name,'main_bus')" >虚拟</input>
                        <input type="checkbox" name="main_bus_c" value="b"   <#if (data['${tableName}']['main_bus']?if_exists?index_of('b') gt 0)>checked</#if>      onclick="getChecked(this.name,'main_bus')" >数码</input>
                        <input type="checkbox" name="main_bus_c" value="c"   <#if (data['${tableName}']['main_bus']?if_exists?index_of('c') gt 0)>checked</#if>      onclick="getChecked(this.name,'main_bus')" >美容</input>
                        <input type="checkbox" name="main_bus_c" value="d"   <#if (data['${tableName}']['main_bus']?if_exists?index_of('d') gt 0)>checked</#if>      onclick="getChecked(this.name,'main_bus')" >服装</input>
                        <input type="checkbox" name="main_bus_c" value="e"   <#if (data['${tableName}']['main_bus']?if_exists?index_of('e') gt 0)>checked</#if>     onclick="getChecked(this.name,'main_bus')" >配饰</input>
                        <input type="checkbox" name="main_bus_c" value="f"   <#if (data['${tableName}']['main_bus']?if_exists?index_of('f') gt 0)>checked</#if>     onclick="getChecked(this.name,'main_bus')" >母婴</input>
                        <input type="checkbox" name="main_bus_c" value="g"   <#if (data['${tableName}']['main_bus']?if_exists?index_of('g') gt 0)>checked</#if>     onclick="getChecked(this.name,'main_bus')" >家居</input>
                        <input type="checkbox" name="main_bus_c" value="h"    <#if (data['${tableName}']['main_bus']?if_exists?index_of('h') gt 0)>checked</#if>     onclick="getChecked(this.name,'main_bus')" >食品</input>
					</td>
				</tr>
                <tr>
                    <td rowspan="7" align="right"><label class="Validform_label">营业概况</label></td>
                    <td align="right"><label class="Validform_label">营业项目</label></td>
                    <td   class="value"><input id="bus_pro"  name="bus_pro" type="text"  style="width: 50px"  class="inputxt"  value="${data['${tableName}']['bus_pro']?if_exists?html}"  /></td>
                    <td colspan="2" align="right"><label class="Validform_label">仓库情况</label></td>
                    <td   class="value"><input id="warehouse"  name="warehouse" type="text"  style="width: 50px"  class="inputxt"  value="${data['${tableName}']['warehouse']?if_exists?html}"  /></td>
                    <td align="right"><label class="Validform_label">员工人数及素质</label></td>
                    <td   class="value"><input id="people"  name="people" type="text"  style="width: 50px"  class="inputxt"  value="${data['${tableName}']['people']?if_exists?html}"  /></td>
                    <td align="right"><label class="Validform_label">运输方式</label></td>
                    <td colspan="2"  class="value">
                        <input type="hidden" id="transportation" name="transportation"  value="${data['${tableName}']['transportation']?if_exists?html}"   />
						<input type="checkbox" name="transportation_c" value="a"  <#if (data['${tableName}']['transportation']?if_exists?index_of('a') gt 0)>checked</#if>   onclick="getChecked(this.name,'transportation')" >铁路</input>
                        <input type="checkbox" name="transportation_c" value="b"  <#if (data['${tableName}']['transportation']?if_exists?index_of('b') gt 0)>checked</#if>   onclick="getChecked(this.name,'transportation')" >水运</input>
                        <input type="checkbox" name="transportation_c" value="c"  <#if (data['${tableName}']['transportation']?if_exists?index_of('c') gt 0)>checked</#if>   onclick="getChecked(this.name,'transportation')" >汽运</input>
                        <input type="checkbox" name="transportation_c" value="d"  <#if (data['${tableName}']['transportation']?if_exists?index_of('d') gt 0)>checked</#if>   onclick="getChecked(this.name,'transportation')" >自提</input>
					</td>
				</tr>
                <tr>
                    <td align="right"><label class="Validform_label">经营体制</label></td>
                    <td  class="value"><input id="operation"  name="operation" type="text"  style="width: 50px"  class="inputxt"  value="${data['${tableName}']['operation']?if_exists?html}"  /></td>
                    <td colspan="2" align="right"><label class="Validform_label">服务车数目</label></td>
                    <td  class="value"><input id="car"  name="car" type="text"  style="width: 50px"  class="inputxt"  value="${data['${tableName}']['car']?if_exists?html}"  /></td>
                    <td align="right"><label class="Validform_label">零售商数及覆盖情况</label></td>
                    <td colspan="4"  class="value"><input id="shopkeeper"  name="shopkeeper" type="text"  style="width: 250px"  class="inputxt"  value="${data['${tableName}']['shopkeeper']?if_exists?html}"  /></td>
                </tr>
                <tr>
                    <td  align="right"><label class="Validform_label">批发商数</label></td>
                    <td   class="value"><input id="wholesale"  name="wholesale" type="text"  style="width: 50px"  class="inputxt"  value="${data['${tableName}']['wholesale']?if_exists?html}"  /></td>
                    <td colspan="2" align="right"><label class="Validform_label">营业范围</label></td>
                    <td   class="value"><input id="bus_scope"  name="bus_scope" type="text"  style="width: 50px"  class="inputxt"  value="${data['${tableName}']['bus_scope']?if_exists?html}"  /></td>
                    <td align="right"><label class="Validform_label">门市面积</label></td>
                    <td colspan="4"  class="value"><input id="area"  name="area" type="text"  style="width: 250px"  class="inputxt"  value="${data['${tableName}']['area']?if_exists?html}"  /></td>
                </tr>
                <tr>
                    <td align="right"><label class="Validform_label">经营方针</label></td>
                    <td colspan="9"  class="value">
                        <input  id="management" name="management" type="hidden"  value="${data['${tableName}']['management']?if_exists?html}"  />
						<input   name="management_c" type="checkbox" value="a"    <#if (data['${tableName}']['management']?if_exists?index_of('a') gt 0)>checked</#if>    onclick="getChecked(this.name,'management')" >销售上量</input>
                        <input   name="management_c" type="checkbox" value="b"   <#if (data['${tableName}']['management']?if_exists?index_of('b') gt 0)>checked</#if>     onclick="getChecked(this.name,'management')" >利润为准</input>
                        <input   name="management_c" type="checkbox" value="c"    <#if (data['${tableName}']['management']?if_exists?index_of('c') gt 0)>checked</#if>    onclick="getChecked(this.name,'management')" >量利兼顾</input>
                        <input   name="management_c" type="checkbox" value="d"   <#if (data['${tableName}']['management']?if_exists?index_of('d') gt 0)>checked</#if>     onclick="getChecked(this.name,'management')" >积极</input>
                        <input   name="management_c" type="checkbox" value="e"   <#if (data['${tableName}']['management']?if_exists?index_of('e') gt 0)>checked</#if>     onclick="getChecked(this.name,'management')" >保守</input>
                        <input   name="management_c" type="checkbox" value="f"   <#if (data['${tableName}']['management']?if_exists?index_of('f') gt 0)>checked</#if>     onclick="getChecked(this.name,'management')" >平常</input>
                        <input   name="management_c" type="checkbox" value="g"   <#if (data['${tableName}']['management']?if_exists?index_of('g') gt 0)>checked</#if>     onclick="getChecked(this.name,'management')" >投机</input>
                        <input   name="management_c" type="checkbox" value="h"    <#if (data['${tableName}']['management']?if_exists?index_of('h') gt 0)>checked</#if>    onclick="getChecked(this.name,'management')" >凌乱</input>
					</td>
				</tr>
				<tr>
                    <td rowspan="3" align="right"><label class="Validform_label">年度销售潜力</label></td>
                    <td  align="right"><label class="Validform_label">进货</label></td>
                    <td colspan="3"  class="value"><input id="stock1"  name="stock1" type="text"  style="width: 130px"  class="inputxt"  value="${data['${tableName}']['stock1']?if_exists?html}"  /></td>
                    <td rowspan="3" align="right"><label class="Validform_label">第一品牌</label></td>
                    <td  align="right"><label class="Validform_label">进货</label></td>
                    <td colspan="4"   class="value"><input id="stock2"  name="stock2" type="text"  style="width: 250px"  class="inputxt"  value="${data['${tableName}']['stock2']?if_exists?html}"  /></td>
				</tr>
                <tr>
                    <td align="right"><label class="Validform_label">销售</label></td>
                    <td colspan="3"  class="value"><input id="sale1"  name="sale1" type="text"  style="width: 130px"  class="inputxt"  value="${data['${tableName}']['sale1']?if_exists?html}"  /></td>
                    <td align="right"><label class="Validform_label">销售</label></td>
                    <td colspan="4"   class="value"><input id="sale2"  name="sale2" type="text"  style="width: 250px"  class="inputxt"  value="${data['${tableName}']['sale2']?if_exists?html}"  /></td>
                </tr>
                <tr>
                    <td align="right"><label class="Validform_label">存货</label></td>
                    <td colspan="3"  class="value"><input id="inventory1"  name="inventory1" type="text"  style="width: 130px"  class="inputxt"  value="${data['${tableName}']['inventory1']?if_exists?html}"  /></td>
                    <td align="right"><label class="Validform_label">存货</label></td>
                    <td colspan="4"  class="value"><input id="inventory2"  name="inventory2" type="text"  style="width: 250px"  class="inputxt"  value="${data['${tableName}']['inventory2']?if_exists?html}"  /></td>
                </tr>
                <tr>
                    <td colspan="2" align="right"><label class="Validform_label">最高信用额度</label></td>
                    <td colspan="4"  class="value"><input id="max_money"  name="max_money" type="text"  style="width: 200px"  class="inputxt"  value="${data['${tableName}']['max_money']?if_exists?html}"  /></td>
                    <td  align="right"><label class="Validform_label">客户等级</label></td>
                    <td colspan="4"  class="value"><input id="cust_level"  name="cust_level" type="text"  style="width: 250px"  class="inputxt"  value="${data['${tableName}']['cust_level']?if_exists?html}"  /></td>
                </tr>
                <tr>
                    <td  colspan="2" align="right"><label class="Validform_label">总体月均库存数</label></td>
                    <td colspan="4"  class="value"><input id="all_avg_inventory"  name="all_avg_inventory" type="text"  style="width: 200px"  class="inputxt"  value="${data['${tableName}']['all_avg_inventory']?if_exists?html}"  /></td>
                    <td  align="right"><label class="Validform_label">月均库存数</label></td>
                    <td colspan="4"   class="value"><input id="avg_inventory"  name="avg_inventory" type="text"  style="width: 250px"  class="inputxt"    value="${data['${tableName}']['avg_inventory']?if_exists?html}"  /></td>
                </tr>
                <tr>
                    <td  colspan="2" align="right"><label class="Validform_label">价格/折扣</label></td>
                    <td colspan="4"  class="value"><input id="price"  name="price" type="text"  style="width: 200px"  class="inputxt"  value="${data['${tableName}']['price']?if_exists?html}"  /></td>
                    <td  align="right"><label class="Validform_label">支持和服务的承诺</label></td>
                    <td colspan="4"  class="value"><input id="promise"  name="promise" type="text"  style="width: 250px"  class="inputxt"  value="${data['${tableName}']['promise']?if_exists?html}"  /></td>
                </tr>
                <tr>
                    <td  colspan="2" align="right"><label class="Validform_label">竞品经营情况</label></td>
                    <td colspan="9"  class="value"><input id="competing_goods"  name="competing_goods" type="text"  style="width: 620px"  class="inputxt"  value="${data['${tableName}']['competing_goods']?if_exists?html}"  /></td>
                    </tr>
			  <tr id = "sub_tr" style="display: none;">
				  <td colspan="11" align="center">
				  <input type="button" value="提交" onclick="neibuClick();" class="ui_state_highlight">
				  </td>
			  </tr>
			</table>
			<script type="text/javascript">$(function(){$("#formobj").Validform({tiptype:1,btnSubmit:"#btn_sub",btnReset:"#btn_reset",ajaxPost:true,usePlugin:{passwordstrength:{minLen:6,maxLen:18,trigger:function(obj,error){if(error){obj.parent().next().find(".Validform_checktip").show();obj.find(".passwordStrength").hide();}else{$(".passwordStrength").show();obj.parent().next().find(".Validform_checktip").hide();}}}},callback:function(data){if(data.success==true){uploadFile(data);}else{if(data.responseText==''||data.responseText==undefined){$.messager.alert('错误', data.msg);$.Hidemsg();}else{try{var emsg = data.responseText.substring(data.responseText.indexOf('错误描述'),data.responseText.indexOf('错误信息')); $.messager.alert('错误',emsg);$.Hidemsg();}catch(ex){$.messager.alert('错误',data.responseText+'');}} return false;}if(!neibuClickFlag){var win = frameElement.api.opener; win.reloadTable();}}});});</script>

  </form>
	<#--update-end--Author:luobaoli  Date:20150614 for：表单单表属性中增加了扩展参数 ${po.extend_json?if_exists}-->
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
<#--add-end--Author:钟世云  Date:20150614 for：online支持树配置-->
</script>
	<script type="text/javascript">${js_plug_in?if_exists}</script>		
 </body>
</html>