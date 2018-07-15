<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!-- <h4>分类标题</h4> -->
	    <div class="row">
	      <div class="col-md-12 layout-header">
	        <button id="addBtn_JformOrderCustomer2" type="button" class="btn btn-default">添加</button>
	        <button id="delBtn_JformOrderCustomer2" type="button" class="btn btn-default">删除</button>
	        <script type="text/javascript"> 
			$('#addBtn_JformOrderCustomer2').bind('click', function(){   
		 		 var tr =  $("#add_jformOrderCustomer2_table_template>tr").clone();
			 	 $("#add_jformOrderCustomer2_table").append(tr);
			 	 resetTrNum('add_jformOrderCustomer2_table');
			 	 return false;
		    });  
			$('#delBtn_JformOrderCustomer2').bind('click', function(){   
		       $("#add_jformOrderCustomer2_table").find("input[name$='ck']:checked").parent().parent().remove();   
		        resetTrNum('add_jformOrderCustomer2_table');
		        return false;
		    });
		    $(document).ready(function(){
		    	if(location.href.indexOf("load=detail")!=-1){
					$(":input").attr("disabled","true");
					$(".datagrid-toolbar").hide();
				}
		    	resetTrNum('add_jformOrderCustomer2_table');
		    });
		</script>
	      </div>
	    </div>
<div style="margin: 0; background-color: white;overflow: auto;">    
	    <!-- Table -->
      <table id="jformOrderCustomer2_table" class="table table-bordered table-hover" style="margin-bottom: 0;">
		<thead>
	      <tr>
	        <th style="white-space:nowrap;width:50px;">操作</th>
	        <th style="width:40px;">序号</th>
						<th>
							客户名
					    </th>
						<th>
							单价
					    </th>
						<th>
							性别
					    </th>
						<th>
							电话
					    </th>
	      </tr>
	    </thead>
        
	<tbody id="add_jformOrderCustomer2_table">	
	<c:if test="${fn:length(jformOrderCustomer2List)  <= 0 }">
			<tr>
				<td>
					<input style="width:20px;" type="checkbox" name="ck"/>
					<input name="jformOrderCustomer2List[0].id" type="hidden"/>
					<input name="jformOrderCustomer2List[0].fkId" type="hidden"/>
				</td>
					
				<td scope="row">
					<div name="xh"></div>
				</td>
				  	<td>
							<input name="jformOrderCustomer2List[0].name" maxlength="32" type="text" class="form-control"  style="width:120px;"  ignore="ignore" />
					</td>
				  	<td>
							<input name="jformOrderCustomer2List[0].money" maxlength="10" type="text" class="form-control"  style="width:120px;"  datatype="/^(-?\d+)(\.\d+)?$/"  ignore="ignore" />
					</td>
				  	<td>
							<t:dictSelect field="jformOrderCustomer2List[0].sex" type="list" extendJson="{class:'form-control',style:'width:150px'}"    typeGroupCode="sex"  defaultVal="${jformOrderCustomer2Page.sex}" hasLabel="false"  title="性别"></t:dictSelect>     
					</td>
				  	<td>
							<input name="jformOrderCustomer2List[0].telphone" maxlength="32" type="text" class="form-control"  style="width:120px;"  ignore="ignore" />
					</td>
   			</tr>
	</c:if>
	<c:if test="${fn:length(jformOrderCustomer2List)  > 0 }">
		<c:forEach items="${jformOrderCustomer2List}" var="poVal" varStatus="stuts">
			<tr>
				<td>
					<input style="width:20px;" type="checkbox" name="ck"/>
					<input name="jformOrderCustomer2List[${stuts.index }].id" type="hidden" value="${poVal.id }"/>
					<input name="jformOrderCustomer2List[${stuts.index }].fkId" type="hidden" value="${poVal.fkId }"/>
				</td>
					
				<td scope="row">
					<div name="xh">${stuts.index+1 }</div>
				</td>
				
				   <td>
					  	<input name="jformOrderCustomer2List[${stuts.index }].name" maxlength="32" type="text" class="form-control"  style="width:120px;"  ignore="ignore"  value="${poVal.name }"/>
				   </td>
				   <td>
					  	<input name="jformOrderCustomer2List[${stuts.index }].money" maxlength="10" type="text" class="form-control"  style="width:120px;"  datatype="/^(-?\d+)(\.\d+)?$/"  ignore="ignore"  value="${poVal.money }"/>
				   </td>
				   <td>
							<t:dictSelect field="jformOrderCustomer2List[${stuts.index }].sex" type="list" extendJson="{class:'form-control',style:'width:150px'}"    typeGroupCode="sex"  defaultVal="${poVal.sex }" hasLabel="false"  title="性别"></t:dictSelect>     
				   </td>
				   <td>
					  	<input name="jformOrderCustomer2List[${stuts.index }].telphone" maxlength="32" type="text" class="form-control"  style="width:120px;"  ignore="ignore"  value="${poVal.telphone }"/>
				   </td>
   			</tr>
		</c:forEach>
	</c:if>	
	</tbody>
</table>
</div>