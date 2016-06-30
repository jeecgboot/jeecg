/**
 * datatype扩展
 */
$.Datatype.need1 = function(gets, obj, curform, regxp) {
	var need = 1, numselected = curform.find("input[name='" + obj.attr("name") + "']:checked").length;
	return numselected >= need ? true : "Please only select" + need + "item!";
};
$.Datatype.need2 = function(gets, obj, curform, regxp) {
	var need = 2, numselected = curform.find("input[name='" + obj.attr("name") + "']:checked").length;
	return numselected >= need ? true : "Please only select" + need + "item!";
};
$.Datatype.d=/^(\d*\.)?\d+$/;

$.Datatype.select1 = function(gets, obj, curform, regxp) {
    var name = obj.attr("name") != undefined ? "name" : "comboname"; // select 或 combotree
    var need = 1, numselected = 0;

    if(name=="comboname"){
    	var value=$("#"+obj.attr(name)).combotree("getValues");
    	if(value!=""){
    		numselected = 1;
    	}
    }else{
    	numselected = curform.find("select[" + name + "='" + obj.attr(name) + "'] option[selected='selected']").length
    }

    return numselected >= need ? true : "Please only select" + need + "item!";
};

