/**
 * datatype扩展
 */
$.Datatype.need1 = function(gets, obj, curform, regxp) {
	var need = 1, numselected = curform.find("input[name='" + obj.attr("name") + "']:checked").length;
	return numselected >= need ? true : "请至少选择" + need + "项！";
};
$.Datatype.need2 = function(gets, obj, curform, regxp) {
	var need = 2, numselected = curform.find("input[name='" + obj.attr("name") + "']:checked").length;
	return numselected >= need ? true : "请至少选择" + need + "项！";
};
$.Datatype.d=/^(\d*\.)?\d+$/;
