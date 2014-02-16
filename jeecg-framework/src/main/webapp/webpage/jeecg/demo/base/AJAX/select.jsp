<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<script type="text/javascript">
	function getdemo(id) {
		if(id==''){
			$('#demo').html("");
			return;
		}

		window.top.$.messager.progress({
			text : '正在加载数据....',
			interval : 300
		});
		var url = "demoController.do?getDemo&id=" + encodeURIComponent(encodeURIComponent(id));
		$.ajax({
			type : 'POST',
			url : url,
			success : function(data) {
				var d = $.parseJSON(data);
				if (d.success) {
					window.top.$.messager.progress('close');
					$('#demo').html(d.msg);

				}
			}
		});
	}
</script>
<t:formvalid layout="table" dialog="false" formid="formobj">
	<table class="formtable" cellpadding="0" cellspacing="1">
		<tr>
			<td width="10%" height="50" align="right"><span class="filedzt">下拉框AJAX联动：</span></td>
			<td width="90%" class="value" colspan="3"><select style="width: 150px" name="proname" id="proname" onchange="getdemo(this.value);">
				<option value="">--- 请选择菜单 ---</option>
				<c:forEach var="fun" items="${funList}" varStatus="status">
					<option value="${fun.id }">${fun.functionName}</option>
				</c:forEach>
			</select></td>
		</tr>
		<tr>
			<td height="50" align="right"><span class="filedzt">菜单项目：</span></td>
			<td class="value" colspan="3" nowrap><SPAN id="demo"></SPAN></td>
		</tr>
	</table>
</t:formvalid>
