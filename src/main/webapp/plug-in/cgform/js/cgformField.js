var filedTypes = ['check', 'database', 'key', 'page','index'];
var headerTr = "template_header_";
var bodytr = "add_column_table_template_";
var iframeId = "iframe_";
var fieldData = [];// 字段的数据
var iframeLoadNumber = 0; // 当前加载的Iframe的数量
var rownumber = 0 ;//标识当前序号
var toDelete = [];  //保存表单待删除属性字段id
$(document).ready(iframeLoaded());
//$("#iframe_check").load(iframeLoaded());
//$("#iframe_database").load(iframeLoaded());
//$("#iframe_key").load(iframeLoaded());
//$("#iframe_page").load(iframeLoaded());
//add-start author： wangkun  date:20160611 for: TASK #1090 【online】online表单缺少索引配置 代码修改痕迹
//$("#iframe_index").load(iframeLoaded());
//add-end author： wangkun  date:20160611 for: TASK #1090 【online】online表单缺少索引配置 代码修改痕迹

function iframeLoaded() {
	iframeLoadNumber++;
	if (iframeLoadNumber == 6) {
		$(".datagrid-toolbar").parent().css("width", "auto");
//		setTimeout(initData, 500);
		initData();
	}
}
var fixHelper = function(e, ui) {
    ui.children().each(function() {
        $(this).width($(this).width());
    });
    return ui;
};
setTimeout(function(){
	$("#tab_div_database tbody").sortable({
	    helper: fixHelper,
	    items: '> tr',
	    forcePlaceholderSize: true,
	    stop: function (event, ui) {
	    	var textContent = ui.item.context.innerText?
	    			ui.item.context.innerText.toString():
	    				ui.item.context.textContent.toString();
	    	var endString = textContent.indexOf("S")!=-1?textContent.indexOf("S"):textContent.length;
	    	var startRownum = textContent.substring(0,endString).replace(/(^\s*)|(\s*$)/g,'');
	    	var targetIndex = ui.item.context.rowIndex;
	    	for (var i = 0; i < filedTypes.length; i++) {
	    		if(filedTypes[i] == "database" && startRownum != (targetIndex + 1)) continue;
	    		if(startRownum == (targetIndex + 1)){  //处理当前行和下一行交换位置
	    			$("#tab_div_" + filedTypes[i]).find("tr").eq(startRownum).insertBefore($("#tab_div_" + filedTypes[i]).find("tr").eq(targetIndex));
	    		}else if(startRownum > targetIndex){
	    			$("#tab_div_" + filedTypes[i]).find("tr").eq(startRownum-1).insertBefore($("#tab_div_" + filedTypes[i]).find("tr").eq(targetIndex));
	    		} else {
	    			$("#tab_div_" + filedTypes[i]).find("tr").eq(startRownum-1).insertAfter($("#tab_div_" + filedTypes[i]).find("tr").eq(targetIndex));
	    		}
	    	}
	    	for (var i = 0; i < filedTypes.length; i++) {
	    		resetTrNum("#tab_div_" + filedTypes[i]);
	    	}
	    }
	});
	// .disableSelection()研究下这个的意义好像这里没啥作用,影响了火狐
}, 2000);
function initData() {
	addTableHead();
	$.get("cgFormHeadController.do?getColumnList&id=" + $("#id").val(),getDataHanlder);
	$.get("cgFormIndexController.do?getIndexList&id=" + $("#id").val(),getDataHanlderIndex);

	$('.t_table').height($(window).height()-300);
	$(window).resize(function(){
		$('.t_table').height($(window).height()-300);
	});

	
}

/**
 * 添加表头
 */
function addTableHead() {
	for (var i = 0; i < filedTypes.length; i++) {
		var tr = $(getIframeDocument(filedTypes[i])).find("#"
				+ headerTr + filedTypes[i] + " tr").clone();
		$("#tab_div_" + filedTypes[i]+"_title").append(tr);
	}
}
// 兼容不同浏览器获取iframe 内容

//主要情况是ie11下的版本是火狐的标识倒是出差错
function getIframeDocument(id){

	try {
		if (window.frames["iframe_" + id].contentDocument) {
			return window.frames["iframe_" + id].contentDocument;
		}
		return window.frames["iframe_" + id].document;
	} catch (e) {
	}
	return document.getElementById("iframe_" + id).contentDocument;

}


/**
 * 获取数据的回调
 * 
 * @param {}
 * data
 */
function getDataHanlder(data) {
	data = eval("(" + data + ")");
	// 兼容之前order最小为0的问题
	var orderMin = data[0].orderNum == 0;
	$.each(data, function(idx, item) {
		rownumber = idx;//存储当前序号
		for (var i = 0; i < filedTypes.length; i++) {
			//add-start author： wangkun  date:20160611 for: TASK #1090 【online】online表单缺少索引配置 代码修改痕迹
			if(i!=4){
				initTrData(item, filedTypes[i], orderMin);
			}
			//add-end author： wangkun  date:20160611 for: TASK #1090 【online】online表单缺少索引配置 代码修改痕迹
		}
	});
	jformTypeChange();
	fixTab();
	
}

//获取表单的索引配置
function getDataHanlderIndex(data) {
	data = eval("(" + data + ")");

	$.each(data, function(idx, item) {
		rownumber = idx;//存储当前序号
		initTrDataIndex(item, 'index', false);
	});

	jformTypeChange();
	fixTab();
	
}
/**
 * 添加行数据
 * 
 * @param {}
 *            item 这个数据
 * @param {}
 *            filedType 这一行的类型
 */
function initTrData(item, filedType, orderMin) {
	var tr = $(getIframeDocument(filedType)).find("#" + bodytr
			+ filedType + " tr").clone();
 	var isId = item.fieldName == "id";
	$(':input, select,a', $(tr)).each(function() {
		var $this = $(this), name = $this.attr('name'), val = $this.val();
		if(isId){setAttrForThis($this);}
		//自定义一个序号<a> 按名字进行获取对象，并进行序号指定
		if(name.indexOf("#rindex#") > 0){
			$this.attr("name", name.replace('#rindex#',rownumber));
			$this.html(rownumber+1);
		}
		if (name.indexOf("#index#") > 0) {
			var fieldName = name.replace("columns[#index#].", "");
			$this.attr("name", name.replace('#index#',rownumber));
			
			if (item[fieldName] != "Y" && item[fieldName] != "N") {
				//--author: zhoujf -----start----date:20160331 -------for:online开发创建表单时 表属性设置增加一列checkbox设置传不了值的问题
				$this.attr('type')=='checkbox'? $this.attr("checked", false):$this.val(item[fieldName]);
				//--author: zhoujf -----end----date:20160331 -------for:online开发创建表单时 表属性设置增加一列checkbox设置传不了值的问题
			} else {
				item[fieldName] == "Y" ? $this.attr("checked", true) : $this
						.attr("checked", false);
			}
		} else if (name != "ck") {
			$this.attr("name", name.replace('_index',rownumber));
			$this.val(name.indexOf("columnsfieldName") != -1
					? item.fieldName
					: item.content);
		}
		else{
			$this.val(item.id);
		}
	});
	$("#tab_div_" + filedType).append(tr);
}
//add-start author： wangkun  date:20160611 for: TASK #1090 【online】online表单缺少索引配置 代码修改痕迹
function initTrDataIndex(item, filedType, orderMin) {
	var tr = $(getIframeDocument(filedType)).find("#" + bodytr
			+ filedType + " tr").clone();
 	var isId = item.fieldName == "id";
	$(':input, select,a', $(tr)).each(function() {
		var $this = $(this), name = $this.attr('name'), val = $this.val();
		if(isId){setAttrForThis($this);}
		//自定义一个序号<a> 按名字进行获取对象，并进行序号指定
		if(name.indexOf("#rindex#") > 0){
			$this.attr("name", name.replace('#rindex#',rownumber));
			$this.html(rownumber+1);
		}
		if (name.indexOf("#index#") > 0) {
			var fieldName = name.replace("indexes[#index#].", "");
			$this.attr("name", name.replace('#index#',rownumber));
			
			if (item[fieldName] != "Y" && item[fieldName] != "N") {
				//--author: zhoujf -----start----date:20160331 -------for:online开发创建表单时 表属性设置增加一列checkbox设置传不了值的问题
				$this.attr('type')=='checkbox'? $this.attr("checked", false):$this.val(item[fieldName]);
				//--author: zhoujf -----end----date:20160331 -------for:online开发创建表单时 表属性设置增加一列checkbox设置传不了值的问题
			} else {
				item[fieldName] == "Y" ? $this.attr("checked", true) : $this
						.attr("checked", false);
			}
		} else if (name != "ck") {
			$this.attr("name", name.replace('_index',rownumber));
			$this.val(name.indexOf("columnsfieldName") != -1
					? item.fieldName
					: item.content);
		}
		else{
			$this.val(item.id);
		}
	});
	$("#tab_div_" + filedType).append(tr);
}
//add-end author： wangkun  date:20160611 for: TASK #1090 【online】online表单缺少索引配置 代码修改痕迹

function setAttrForThis($this){
	if($this.is('select')){
		$this.attr("onfocus","this.defOpt=this.selectedIndex");
		$this.attr("onchange","this.selectedIndex=this.defOpt;");
	}else if($this.is('input')&&$this.attr('type')=='text'){
		$this.attr("readonly","readonly");
	}else if($this.is('input')&&$this.attr('type')=='checkbox'){
		$this.attr("onclick","return false;");
	}
}

/**
 * 添加行
 */
function addColumnBtnClick() {
	for (var i = 0; i < filedTypes.length-1; i++) {
		addTrToTable(filedTypes[i]);
	}
}
function addIndexBtnClick(){
	addTrToTable('index');
}
function addTrToTable(filedType) {
	var tr = $(getIframeDocument(filedType)).find("#" + bodytr
			+ filedType + " tr").clone();
	$("#tab_div_" + filedType).append(tr);
	resetTrNum('#tab_div_' + filedType);
}
function deleteUnUsedFiled(){
	if(toDelete && toDelete.length>0){
		for(index in toDelete){
			if(toDelete[index] == "on") continue;
			$.post("cgFormHeadController.do?delField&id="+ toDelete[index]);
		}
	}
	return true;
}
/**
 * 删除行
 */
function delColumnBtnClick() {
	// 获取当前的check的行并进行遍历
	$("#tab_div_database").find("input[name='ck']:checked").parent().parent("tr").each(function(index, ele){
		//$.post("cgFormHeadController.do?delField&id="+ $("#tab_div_database").find("input[name='ck']:checked").val());
		toDelete.push($(this).find("input[name='ck']:checked").val());
		var selectIndex = ele.rowIndex;
		for (var i = 0; i < filedTypes.length; i++) {
			$("#tab_div_" + filedTypes[i]).find("tr").eq(selectIndex).remove();
		}
	})
	for (var i = 0; i < filedTypes.length; i++) {
		resetTrNum("#tab_div_" + filedTypes[i]);
	}
}
function delIndexBtnClick() {
	$("#tab_div_index").find("input[name='ck']:checked").parent().parent("tr").each(function(index, ele){
		//toDelete.push($(this).find("input[name='ck']:checked").val());
		var selectIndex = ele.rowIndex;
		$("#tab_div_index").find("tr").eq(selectIndex).remove();
	})
}
/**
 * 重设table的order
 * 
 * @param {}
 *            tableId
 */
function resetTrNum(tableId) {
	$(tableId + " tbody tr").each(function(i) {
		$(':input, select,a', this).each(function() {
					var $this = $(this), name = $this.attr('name'), val = $this
							.val();
					if (name != null && name.indexOf("#index#") >= 0) {
						$this.attr("name", name.replace('#index#', i));
						/*if (name.indexOf('orderNum') >= 0) {  Date20131212 liuht取消重置orderNumber
							$this.val(getMaxNum());
						}*/
					} else if (name != null && name.indexOf("_index") >= 0) {
						$this.attr("name", name.replace('_index', i));
					} else if (name != null && name != "ck") {
						$this.attr("name", name.replace(getNowIndex(name), i));
					}
					//代码移动位置，优化调整     Date20131212
					if (name != null && name.indexOf("rownumber") >= 0) {
						$this.html(i+1);   // 移动tr|新加行|删除行 ---重置 rownumber值
					}
					if (name != null && name.indexOf("orderNum") >= 0) {
						$this.val(i+1);   // 移动tr|新加行|删除行 ---重置 orderNumber值
					}
					
				});
	});
	jformTypeChange();
}
/**
 * 获取最大的 orderNum
 */
function getMaxNum() {
	var maxNum = 0;
	$("input[name*='orderNum']").each(function() {
				maxNum = parseInt($(this).val()) > maxNum
						? $(this).val()
						: maxNum;
			});
	return parseInt(maxNum) + 1;
}

/**
 * 同步fieldName
 */
$(document).on('change', '.fieldNameInput','columnsfieldName',valueChange);

/**
 * 同步content
 */
$(document).on('change', '.contentInput','columnscontent',valueChange);


function valueChange(e){
	var val = $(this).val();
	var index = getNowIndex($(this).attr('name'));
	for (var i = 0; i < filedTypes.length; i++) {
		$("#tab_div_" + filedTypes[i]).find("input[name='"+e.data+ index + "']").val(val);
	}
}

/**
 * 获取当前的索引值
 * 
 * @param {}
 *            name 这个元素的Name
 * @return {}
 */
function getNowIndex(name) {
	var s = name.indexOf("[");
	var e = name.indexOf("]");
	if(s>=0 && e>=0){
		return name.substring(s + 1, e);
	} else if(name.indexOf("columnsfieldName")>=0){
		return name.substring(16);
	}else if(name.indexOf("columnscontent")>=0){
		return name.substring(14);   //修改字段备注无法同步问题
	}
}

/**
 * 主键策略的改变,控制序列的输入
 */
function jformPkTypeChange(){
	var pkType = $("#jformPkType").val();
	var $idInput=null;
	$("[name$='fieldName']").each(function(){
		var fieldv = $(this).val();
		if(fieldv && fieldv=="id"){
			$idInput=$(this);
		}
	});
	var $idInput_type=$idInput.parent().parent().find("select[name$='type']");
	var $idInput_length=$idInput.parent().parent().find("input[name$='length']");
	$("#jformPkSequence").val("");
	if(pkType && pkType=="SEQUENCE"){
		$("#jformPkTypeTd").attr("colspan","1");
		$("#jformPkSequenceV").attr("style","");
		$("#jformPkSequenceN").attr("style","");
		$("#jformPkSequence").attr("datatype","*");
		$idInput_type.val("int");
		$idInput_length.val("20");
	}else{
		$("#jformPkSequenceV").attr("style","display: none;");
		$("#jformPkSequenceN").attr("style","display: none;");
		$("#jformPkTypeTd").attr("colspan","3");
		$("#jformPkSequence").removeAttr("datatype");
		if(pkType=="NATIVE"){
			$idInput_type.val("int");
			$idInput_length.val("20");
		}else if(pkType=="UUID"){
			$idInput_type.val("string");
			$idInput_length.val("36");
		}
	}
}
/**
 * 表类型的改变,附表才可以设置主表
 */
function jformTypeChange(){
	openOrCloseSetKeyOp($("#jformType").val() == 3);
	openOrCloseRelationTypeDisplay($("#jformType").val() == 3);
}
//控制：只有附表才可以选择附表关联类型
function openOrCloseRelationTypeDisplay(boo){
	if(boo){
		$("#relation_type_div").attr("style","display: block;");
	}else{
		$("#relation_type_div").attr("style","display: none;");
	}
}

function openOrCloseSetKeyOp(boo){
	$("#tab_div_key tbody tr").each(function(i) {
		$(':input', this).each(function() {
					var $this = $(this), name = $this.attr('name');
					if (name != null && (name.indexOf("mainTable") >= 0
					||name.indexOf("mainField") >= 0)&&
					name!="columns[0].mainTable"&&name!="columns[0].mainField") {
						boo?$this.removeAttr("readonly"):
							$this.attr("readonly","readonly");
					}
				});
	});
}


/**
 * fix修复
 */
function fixTab(){

	$('#tabs').tabs({
		width: 2000,
	    onSelect:function(title){
	        if(title=="数据库属性"){fix("database");}
	        else if(title=="页面属性"){fix("page");}
	        else if(title=="校验字典"){fix("check");}
	        else if(title=="外键"){fix("key");}
	        else if(title=="索引"){fix("index");}
	    }
	});

	
	$('#t_table_database').scroll(function(){
 		 $('#tab_div_database_title').css('margin-left',-($('#t_table_database').scrollLeft()));
	});
	$('#t_table_page').scroll(function(){
 		 $('#tab_div_page_title').css('margin-left',-($('#t_table_page').scrollLeft()));
	});
	$('#t_table_check').scroll(function(){
 		 $('#tab_div_check_title').css('margin-left',-($('#t_table_check').scrollLeft()));
	});
	$('#t_table_key').scroll(function(){
 		 $('#tab_div_key_title').css('margin-left',-($('#t_table_key').scrollLeft()));
	});
	$('#t_table_index').scroll(function(){
		 $('#tab_div_index_title').css('margin-left',-($('#t_table_index').scrollLeft()));
	});
}

//利用js让头部与内容对应列宽度一致。
function fix(type){
	for(var i=0;i<=$('#tab_div_'+type+' tr:last').find('td:last').index();i++){
  			$('#tab_div_'+type+'_title th').eq(i).css('width',
  				$('#tab_div_'+type+' tr:last').find('td').eq(i).width());
 	}
 	$('#tab_div_'+type+'_title').css('width',
 	 		$('#tab_div_'+type+' tr:last').width());
}



