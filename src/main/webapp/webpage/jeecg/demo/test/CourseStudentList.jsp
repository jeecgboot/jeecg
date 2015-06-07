<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<script type="text/javascript">
	$('#addCustomBtn').linkbutton({   
	    iconCls: 'icon-add'  
	});  
	$('#delCustomBtn').linkbutton({   
	    iconCls: 'icon-remove'  
	}); 
	$('#addCustomBtn').bind('click', function(){   
 		 var tr =  $("#add_jeecgStudent_table_template tr").clone();
	 	 $("#add_jeecgStudent_table").append(tr);
	 	 resetTrNum('add_jeecgStudent_table');
    });  
	$('#delCustomBtn').bind('click', function(){   
      	$("#add_jeecgStudent_table").find("input:checked").parent().parent().remove();   
        resetTrNum('add_jeecgStudent_table'); 
    }); 
    $(document).ready(function(){
    	$(".datagrid-toolbar").parent().css("width","auto");
    });
    function resetTrNum(tableId) {
		$tbody = $("#"+tableId+"");
		$tbody.find('>tr').each(function(i){
			$(':input, select', this).each(function(){
				var $this = $(this), name = $this.attr('name'), val = $this.val();
				if(name!=null){
					if (name.indexOf("#index#") >= 0){
						$this.attr("name",name.replace('#index#',i));
					}else{
						var s = name.indexOf("[");
						var e = name.indexOf("]");
						var new_name = name.substring(s+1,e);
						$this.attr("name",name.replace(new_name,i));
					}
				}
			});
		});
	}
</script>
<div style="padding: 3px; height: 25px; width: auto;" class="datagrid-toolbar"><a id="addCustomBtn" href="#">添加</a> <a id="delCustomBtn" href="#">删除</a></div>
<div style="width: auto; height: 300px; overflow-y: auto; overflow-x: scroll;">
<table border="0" cellpadding="2" cellspacing="0" id="jeecgOrderCustom_table">
	<tr bgcolor="#E6E6E6">
		<td align="center" bgcolor="#EEEEEE">序号</td>
		<td align="left" bgcolor="#EEEEEE">姓名</td>
		<td align="left" bgcolor="#EEEEEE">性别</td>
		<td  style="display: none;"></td>
	</tr>
	<tbody id="add_jeecgStudent_table">
		<c:if test="${fn:length(studentsList)  <= 0 }">
			<tr>
				<td align="center"><input style="width: 20px;" type="checkbox" name="ck" /></td>
				<td align="left"><input name="students[0].name" maxlength="50" type="text" style="width: 220px;"></td>
				<td align="left"><t:dictSelect field="students[0].sex" typeGroupCode="sex" hasLabel="false" defaultVal="${jgDemo.sex}"></t:dictSelect></td>
            </tr>
		</c:if>
		<c:if test="${fn:length(studentsList)  > 0 }">
			<c:forEach items="${studentsList}" var="poVal" varStatus="stuts">
				<tr>
					<td align="center"><input style="width: 20px;" type="checkbox" name="ck" /></td>
					<td align="left"><input name="students[${stuts.index }].name" maxlength="50" type="text" value="${poVal.name }" style="width: 220px;"></td>
					<td align="left"><t:dictSelect field="students[${stuts.index }].sex" typeGroupCode="sex" hasLabel="false" defaultVal="${poVal.sex}"></t:dictSelect></td>
                    <td align="left" style="display: none;"><input name="students[${stuts.index }].id" type="text" value="${poVal.id }" style="width: 0px;"></td>
                </tr>
			</c:forEach>
		</c:if>
	</tbody>
</table>
</div>