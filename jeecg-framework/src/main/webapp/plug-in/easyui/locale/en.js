if ($.fn.pagination){
	$.fn.pagination.defaults.beforePageText = 'Page';
	$.fn.pagination.defaults.afterPageText = 'Total{pages}Page';
	$.fn.pagination.defaults.displayMsg = 'Show{from}To{to},Total{total}Record';
}
if ($.fn.datagrid){
	$.fn.datagrid.defaults.loadMsg = 'Process, Please Wait...';
}
if ($.fn.treegrid && $.fn.datagrid){
	$.fn.treegrid.defaults.loadMsg = $.fn.datagrid.defaults.loadMsg;
}
if ($.messager){
	$.messager.defaults.ok = 'Confirm';
	$.messager.defaults.cancel = 'Cancel';
}
if ($.fn.validatebox){
	$.fn.validatebox.defaults.missingMessage = 'This item must enter';
	$.fn.validatebox.defaults.rules.email.message = 'Please enter valid email address';
	$.fn.validatebox.defaults.rules.url.message = 'Please enter valid URL address';
	$.fn.validatebox.defaults.rules.length.message = 'Enter context length must betweeen{0}with{1}';
	$.fn.validatebox.defaults.rules.remote.message = 'Please fix this filed';
}
if ($.fn.numberbox){
	$.fn.numberbox.defaults.missingMessage = 'This item must enter';
}
if ($.fn.combobox){
	$.fn.combobox.defaults.missingMessage = 'This item must enter';
}
if ($.fn.combotree){
	$.fn.combotree.defaults.missingMessage = 'This item must enter';
}
if ($.fn.combogrid){
	$.fn.combogrid.defaults.missingMessage = 'This item must enter';
}
if ($.fn.calendar){
	$.fn.calendar.defaults.weeks = ['Sun','Mon','Tus','Wen','Ths','Fir','Sat'];
	$.fn.calendar.defaults.months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Set','Oct','Nov','Dec'];
}
if ($.fn.datebox){
	$.fn.datebox.defaults.currentText = 'Today';
	$.fn.datebox.defaults.closeText = 'Close';
	$.fn.datebox.defaults.okText = 'Confirm';
	$.fn.datebox.defaults.missingMessage = 'This item must enter';
	$.fn.datebox.defaults.formatter = function(date){
		var y = date.getFullYear();
		var m = date.getMonth()+1;
		var d = date.getDate();
		return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
	};
	$.fn.datebox.defaults.parser = function(s){
		if (!s) return new Date();
		var ss = s.split('-');
		var y = parseInt(ss[0],10);
		var m = parseInt(ss[1],10);
		var d = parseInt(ss[2],10);
		if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
			return new Date(y,m-1,d);
		} else {
			return new Date();
		}
	};
}
if ($.fn.datetimebox && $.fn.datebox){
	$.extend($.fn.datetimebox.defaults,{
		currentText: $.fn.datebox.defaults.currentText,
		closeText: $.fn.datebox.defaults.closeText,
		okText: $.fn.datebox.defaults.okText,
		missingMessage: $.fn.datebox.defaults.missingMessage
	});
}
