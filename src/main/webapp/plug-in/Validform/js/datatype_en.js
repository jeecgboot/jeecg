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

//update-start--Author:zhangguoming  Date:20140826 for：添加 下拉框、combotree 验证
$.Datatype.select1 = function(gets, obj, curform, regxp) {
    var name = obj.attr("name") != undefined ? "name" : "comboname"; // select 或 combotree
    var need = 1, numselected = 0;
  //update-start--Author:zhoujf  Date:20150525 for：combotree选中 校验不通过的问题
    if(name=="comboname"){
    	var value=$("#"+obj.attr(name)).combotree("getValues");
    	if(value!=""){
    		numselected = 1;
    	}
    }else{
    	numselected = curform.find("select[" + name + "='" + obj.attr(name) + "'] option[selected='selected']").length
    }
  //update-end--Author:zhoujf  Date:20150525 for：combotree选中 校验不通过的问题
    return numselected >= need ? true : "Please only select" + need + "item!";
};
//update-end--Author:zhangguoming  Date:20140826 for：添加 下拉框、combotree 验证
