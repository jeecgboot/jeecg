$(function(){
$("body").append("<link href=\"plug-in/lhgDialog/skins/default.css\" rel=\"stylesheet\" id=\"lhgdialoglink\">");
var $btn = $("<div class=\"ui_buttons\"  style=\"display:inline-block;\"><input style=\"position: relative;top: -8px;\" class=\"ui_state_highlight\" type=\"button\" value=\"sql解析\"  id=\"sqlAnalyze\" /></div>");
$("#cgrSql").after($btn);
$btn.click(function(){
 $.ajax({
    url:"cgReportController.do?getFields",
    data:{sql:$("#cgrSql").val()},
	type:"Post",
    dataType:"json",
    success:function(data){
    if(data.status=="success"){
	      $("#add_cgreportConfigItem_table").empty();
	      $.each(data.datas,function(index,e){
	        var $tr = $("#add_cgreportConfigItem_table_template tr").clone();
		    $tr.find("td:eq(1) :text").val(e);
		    $tr.find("td:eq(2) :text").val(index);
		    $tr.find("td:eq(3) :text").val(e);
		    $("#add_cgreportConfigItem_table").append($tr);
	      }); 
	      resetTrNum("add_cgreportConfigItem_table");
    }else{
		$.messager.alert('错误',data.datas);
	}
  }
  });
 });
});