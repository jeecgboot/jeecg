$(function(){
$("body").append("<link href=\"plug-in/lhgDialog/skins/default.css\" rel=\"stylesheet\" id=\"lhgdialoglink\">");
var $btn = $("<div class=\"ui_buttons\"  style=\"display:inline-block;padding:0px;\"><input style=\"position: relative;top: 0px;\" class=\"ui_state_highlight\" type=\"button\" value=\"sql解析\"  id=\"sqlAnalyze\" /></div>");
$("#cgrSql").after($btn);
$btn.click(function(){
 $.ajax({
    url:"cgReportController.do?getFields",
    data:{sql:$("#cgrSql").val()},
	type:"Post",
    dataType:"json",
    success:function(data){
    if(data.status=="success"){
	      $("#add_jformGraphreportItem_table").empty();
	      $.each(data.fields,function(index,e){
			$("#addJformGraphreportItemBtn").click();
			$("#add_jformGraphreportItem_table tr:last").find(":text")
				.eq(0).val(e)
				.end().eq(1).val(e)
				.end().eq(2).val(index);
	      }); 
    }else{
		$.messager.alert('??',data.datas);
	}
  }
  });
 });
});

//初始化下标
function resetTrNum(tableId) {
	$tbody = $("#"+tableId+"");
	$tbody.find('>tr').each(function(i){
		$(':input, select,button,a', this).each(function(){
			var $this = $(this), name = $this.attr('name'),id=$this.attr('id'),onclick_str=$this.attr('onclick'), val = $this.val();
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
			if(id!=null){
				if (id.indexOf("#index#") >= 0){
					$this.attr("id",id.replace('#index#',i));
				}else{
					var s = id.indexOf("[");
					var e = id.indexOf("]");
					var new_id = id.substring(s+1,e);
					$this.attr("id",id.replace(new_id,i));
				}
			}
			if(onclick_str!=null){
				if (onclick_str.indexOf("#index#") >= 0){
					$this.attr("onclick",onclick_str.replace(/#index#/g,i));
				}else{
				}
			}
		});
		$(this).find('div[name=\'xh\']').html(i+1);
	});
}

jQuery(function() {
	jQuery("#formobj").Validform({
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
						jQuery(".passwordStrength").show();
						obj.parent().next().find(".Validform_checktip").hide();
					}
				}
			}
		},
		callback: function(data) {
			var win = frameElement.api.opener;
			if (data.success == true) {
				frameElement.api.close();
				win.tip(data.msg);
			} else {
				if (data.responseText == '' || data.responseText == undefined) {
					jQuery.messager.alert('错误', data.msg);
					jQuery.Hidemsg();
				} else {
					try {
						var emsg = data.responseText.substring(data.responseText.indexOf('错误描述'), data.responseText.indexOf('错误信息'));
						jQuery.messager.alert('错误', emsg);
						jQuery.Hidemsg();
					} catch(ex) {
						jQuery.messager.alert('错误', data.responseText + "");
						jQuery.Hidemsg();
					}
				}
				return false;
			}
			win.reloadTable();
		}
	});
});
