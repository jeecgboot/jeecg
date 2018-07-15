<#setting number_format="0.#####################">
<!DOCTYPE html>
<html class="not-ie" lang="en">
<head> 
    <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>列表</title>
    <link href="online/template/${this_olstylecode}/css/bootstrap.min.css" rel="stylesheet">
    <link href="online/template/${this_olstylecode}/css/scojs.css" rel="stylesheet">
    <link href="online/template/${this_olstylecode}/css/sco.message.css" rel="stylesheet">
    <link href="online/template/${this_olstylecode}/css/style.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="plug-in/Formdesign/js/html5shiv.min.js"></script>
        <script src="plug-in/Formdesign/js/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript" src="online/template/${this_olstylecode}/js/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="plug-in/jquery-plugs/i18n/jquery.i18n.properties.js"></script>
    <script type="text/javascript" src="online/template/${this_olstylecode}/js/respond.min.js"></script>
   <script type="text/javascript" src="online/template/${this_olstylecode}/js/bootstrap.js"></script>
    <script type="text/javascript" src="online/template/${this_olstylecode}/js/sco.message.js"></script>
    <script type="text/javascript" src="online/template/${this_olstylecode}/js/sco.confirm.js"></script>
    <script type="text/javascript" src="plug-in/tools/curdtools.js"></script>
    <script type="text/javascript" src="plug-in/tools/dataformat.js"></script>
    <script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript">
		var totalPage=-1;
		//需要显示的列
		var fields=new Array();
		<#list config_fieldList  as x>
			<#if x['field_isShow'] != "N" >
            fields.push("${x['field_id']}");
			</#if>
		</#list>
        $(function(){
			//判断表单是否生成
            $.get("cgFormHeadController.do?checkIsExit&checkIsTableCreate&name=${config_id}",
                    function(data){
                        data = $.parseJSON(data);
                        if(data.success){
                            loadData(1);
                        }else{
                            alertTip('表:<span style="color:red;">${config_id}</span>还没有生成,请到表单配置生成表');
                        }
                    });
        });
		//加载表单数据
		function loadData(page){
			if(page&&page!=''){
				page=parseInt(page);
				if(page&&(totalPage==-1||page<totalPage))
                $("#page").val(page);
			}

            var initUrl = 'cgAutoListController.do?datagrid&configId=${config_id}&field=${fileds}${initquery}';
            initUrl = encodeURI(initUrl);
			$("formPage").val($("#page").val());
			$("formRows").val($("#rows").val());
            $.ajax({
                url:initUrl,
                type:"get",
				data:$("#dataForm").serialize(),
                dataType:"json",
                success:function(data){
					$("#dataBody").empty();
                    pagination(data.total);
					$.each(data.rows,function(i,f){
                        $("#dataBody").append(getDataTr(f));
					})
                }
            })
		}
		//生成数据tr条目
		function getDataTr(data){
			var item="<tr>";
		<#if config_ischeckbox=="Y">
            item+="<td><input type='checkbox'class='item' name='ck' value='"+data['id']+"'/></td>";
		</#if>
			$.each(fields,function(i,f){
				item+="<td>"+ ((data[f]&&data[f]!='null')?data[f]:'')+"</td>";
			});
            item+="<td><button class='btn btn-danger' onclick='del(\'"+data['id']+"\')'>删除</button></td>";
			item+="</tr>";
			return item;
		}
		//设置页码信息
		function pagination(totalCount){
			if(totalCount){
                var rows=parseInt($("#rows").val());
				totalPage=Math.ceil(totalCount*1.0/rows);
                $("#pageInfo").text("共"+totalPage+"页,"+totalCount+"条,当前为第"+$("#page").val()+"页");
			}
		}
		//选中 反选
		function checkAll(obj){
            $(".item").each(function(){
				this.checked=obj.checked;
			});
		}
		//重置
		function searchReset(){
			$("#dataForm").find("[type!='hidden']").val("");

		}
		//删除单条
		function del(id){
            $.ajax({
                url: "cgAutoListController.do?delBatch",
                data: {'ids': id, 'configId': '${config_id}'},
                type: "Post",
                dataType: "json",
                success: function (data) {
                    $.scojs_message(data.msg, $.scojs_message.TYPE_OK);
                    loadData();
                },
                error: function (data) {
                    $.scojs_message(data.msg, $.scojs_message.TYPE_ERROR);
                }
            });
		}
        //批量删除
        function delBatch() {
            //获取选中的ID串
            var idChecked = $(".item:checked");
            var ids="";
            if (idChecked.length <= 0) {
                $.scojs_message('请选择至少一条信息', $.scojs_message.TYPE_ERROR);
                return false;
            }

			$.each(idChecked,function(i,f){
					ids+= f.value+",";
			});
                        $.ajax({
                            url: "cgAutoListController.do?delBatch",
                            data: {'ids': ids, 'configId': '${config_id}'},
                            type: "Post",
                            dataType: "json",
                            success: function (data) {
                                $.scojs_message(data.msg, $.scojs_message.TYPE_OK);
                                loadData();
                            },
                            error: function (data) {
                                $.scojs_message(data.msg, $.scojs_message.TYPE_ERROR);
                            }
                        });

        }
		//excel导出
        function ExportExcel(){
            var queryParams=getQueryParam();
            var params = '&';
            $.each(queryParams, function(key, val){
                params+='&'+key+'='+val;
            });
            var fields = '&field=';
<#list config_fieldList  as x>
		<#if x['field_isShow'] != "N" >
            fields+="${x['field_id']},";
		</#if>
</#list>

            window.location.href = "excelTempletController.do?exportXls&tableName=${config_id}"+encodeURI(params+fields)
        }
		function getQueryParam(){
			var formArray=$("#dataForm").serializeArray();
			var params={};
			$.each(formArray,function(i,f){
				params[f["name"]]=f["value"];
			})
			return params;
		}
        //JS增强
		${config_jsenhance}


	</script>
</head>
<body>

				<div class="panel panel-default">
				  <div class="panel-heading">
                      <h3 class="panel-title">${config_name}列表</h3>
				  </div>
				  <div class="panel-body">

				  			<form id="dataForm" role="form" class="form-inline">
                                <input type="hidden" id="formPage" name="page" value="1" />
                                <input type="hidden" id="formRows" name="rows" value="10" />
							<#if config_querymode == "group">
								<#list config_queryList  as x>
									<#if x['field_isQuery']=="Y">
                                        <div class="form-group col-sm-6 col-md-4">
                                            <label for="exampleInputEmail1" class="control-label col-sm-4 col-md-4 line34">${x['field_title']}：</label>
									<#if x['field_queryMode']=="group">
									        <div class="col-sm-8 col-md-8">
										<#if x['field_isQuery']=="Y">
                                            <input type="text" name="${x['field_id']}_begin" style="min-width: 94px;"  class="col-sm-5 col-md-5"  <#if x['field_type']=="Date">class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"</#if> value="${x['field_value_begin']}" />
                                            <span class="col-sm-2 col-md-2" style="display:-moz-inline-box;display:inline-block;width: 8px;text-align:right;">~</span>
                                            <input type="text" name="${x['field_id']}_end" style="min-width: 94px;"  class="col-sm-5 col-md-5" <#if x['field_type']=="Date">class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"</#if> value="${x['field_value_end']}"/>
										<#else>
                                            <input type="hidden" name="${x['field_id']}_begin"   value="${x['field_value_begin']}"/>
                                            <input type="hidden" name="${x['field_id']}_end"    value="${x['field_value_end']}"/>
										</#if>
                                            </div>
									</#if>
									<#if x['field_queryMode']=="single">
										<#if x['field_isQuery']=="Y">
											<#if  (x['field_dictlist']?size >0)>
                                                <select name = "${x['field_id']}" class="col-sm-8 col-md-8">
                                                    <option value = ""></option>
													<#list x['field_dictlist']  as xd>
                                                        <option value = "${xd['typecode']}">${xd['typename']}</option>
													</#list>
                                                </select>
											</#if>
											<#if  (x['field_dictlist']?size <= 0)>
												<#if x['field_showType']!='popup'>
                                                    <input type="text" name="${x['field_id']}"   <#if x['field_type']=="Date">class="col-sm-8 col-md-8 Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"<#else> class="col-sm-8 col-md-8"</#if>  value="${x['field_value']?if_exists?default('')}" />
												<#else>
                                                    <input type="text" name="${x['field_id']}"  class="col-sm-8 col-md-8"
                                                           class="searchbox-inputtext" value="${x['field_value']?if_exists?default('')}"
                                                           onClick="inputClick(this,'${x['field_dictField']?if_exists?html}','${x['field_dictTable']?if_exists?html}');" />
												</#if>
											</#if>
										<#else>
                                            <input type="hidden" name="${x['field_id']}"    value="${x['field_value']?if_exists?default('')}" />
										</#if>
									</#if>
                                    </div>
									</#if>
								</#list>
                                <div class="clearfix"></div>
                                <button type="button" class="btn btn-primary" onclick="loadData()">搜  索</button>
                                <button type="button" class="btn btn-info" onclick="searchReset()">重置</button>
							</#if>
							<#if config_querymode == "single">
								<div class="col-md-5 col-md-offset-2">
                                    <input id="${config_id}Listsearchbox" class="form-control" placeholder="请输入关键字" </input>
                                    <div id="${config_id}Listmm" style="width:120px">
										<#list config_queryList  as x>
											<#if x['field_isQuery']=="Y">
                                                <div data-options="name:'${x['field_id']}',iconCls:'icon-ok'  ">${x['field_title']}</div>
											<#else>
											</#if>
										</#list>
                                    </div>

								</div>
							    <div class="col-md-3"><button type="submit" class="btn btn-primary" onclick="loadData()">搜  索</button>
                                    <button type="button" class="btn btn-info" onclick="searchReset()">重置</button>
								</div>
							</#if>

							</form>

				  		<div id="legend">
				          <legend  class="le">数据列表</legend>
				        </div>
                      <div class="btn-group">
                          <button type="button" class="btn btn-default">录入</button>
                          <button type="button" class="btn btn-default">编辑</button>
                          <button type="button" class="btn btn-default" onclick="delBatch()">批量删除</button>
                          <button type="button" class="btn btn-default">查看</button>
                          <button type="button" class="btn btn-default" onclick="ExportExcel()">Excel导出</button>
					  </div>
				        <table  id="${config_id}List" class="table table-striped">
					        <thead>
					          <tr>
							  <#if config_ischeckbox=="Y"><th><input type="checkbox"  class="checkAll" onclick="checkAll(this)" /></th></#if>
							  <#list config_fieldList  as x>
								  <#if x['field_isShow'] != "N" >
							  		<th>${x['field_title']}</th>
								  </#if>
							  </#list>
                                  <th>操作</th>
					          </tr>
					        </thead>
					        <tbody id="dataBody">

					         </tbody>
					    </table>
						<div class="text-right">
							<ul class="pagination">
							  <li><span style="height: 40px" id="pageInfo">共0页,0条</span>
								  <input type="hidden" id="page" name="page" value="1" />
							  </li>
							  <li><a href="#" style="height: 40px" onclick="loadData(parseInt($('#page').val())-1)">上一页</a></li>
							  <li><span style="height: 40px">跳转到 <input type="text" id="goTo" value="">&nbsp;<button class="btn btn-default btn-sm" onclick="loadData(parseInt($('#goTo').val()))">GO</button></span></li>
							  <li><a href="#" style="height: 40px" onclick="loadData(parseInt($('#page').val())+1)">下一页</a></li>
                                <li><span style="height: 40px">每页显示
							  		<select id="rows" onchange="loadData()">
                                        <option value="10">10</option>
                                        <option  value="20">20</option>
                                        <option  value="30">30</option>
                                        <option  value="40">40</option>
                                    </select>
								</span>
                                </li>
							</ul>
						</div>
				  </div>	
				</div>


</body>
</html>
