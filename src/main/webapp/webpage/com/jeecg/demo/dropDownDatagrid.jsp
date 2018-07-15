<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>uitags</title>
<t:base type="jquery,easyui,tools,autocomplete"></t:base>
</head>

<script>
(function ($) {
    
    //设置值
    function _setValues(jq, values, remainText) {
        var options = $.data(jq, "combogrid").options;
        var grid = $.data(jq, "combogrid").grid;
        var rows = grid.datagrid("getRows");
        var ss = [];
        for (var i = 0; i < values.length; i++) {
            var index = grid.datagrid("getRowIndex", values[i]);
            if (index >= 0) {
                grid.datagrid("selectRow", index);
                ss.push(rows[index][options.textField]);
            } else {
                ss.push(values[i]);
            }
        }
        if ($(jq).combo("getValues").join(",") == values.join(",")) {
            return;
        }
        $(jq).combo("setValues", values);
        if (!remainText) {
            $(jq).combo("setText", ss.join(options.separator));
        }
    };
    //查询
    function _query(jq, q) {
        var options = $.data(jq, "combogrid").options;
        var grid = $.data(jq, "combogrid").grid;
        $.data(jq, "combogrid").remainText = true;
        if (options.multiple && !q) {
            _setValues(jq, [], true);
        } else {
            _setValues(jq, [q], true);
        }
        if (options.mode == "remote") {
            grid.datagrid("clearSelections");
            grid.datagrid("load", $.extend({}, options.queryParams, { q: q }));
        } else {
            if (!q) {
                return;
            }
            var rows = grid.datagrid("getRows");
            for (var i = 0; i < rows.length; i++) {
                if (options.filter.call(jq, q, rows[i])) {
                    grid.datagrid("clearSelections");
                    grid.datagrid("selectRow", i);
                    return;
                }
            }
        }
    };
    //解析器
    $.fn.combogrid.parseOptions = function (target) {
        var t = $(target);
        return $.extend({}, $.fn.combo.parseOptions(target),
            $.fn.datagrid.parseOptions(target),
            $.parser.parseOptions(target, ["idField", "textField", "mode"]));
    };
    $.fn.combogrid.defaults = $.extend({}, $.fn.combo.defaults,
        $.fn.datagrid.defaults, {
            loadMsg: null,//在数据表格加载远程数据的时候显示消息
            idField: null,//ID字段名称
            textField: null,//ID字段名称
            //定义在文本改变的时候如何读取数据网格数据。设置为'remote'，
            //数据表格将从远程服务器加载数据。当设置为'remote'模式的时候，用户输入将会发送到名为'q'的http请求参数，向服务器检索新的数据。
            mode: "local",

            keyHandler: {
            up: function () {
                    selectRow(this, -1);
                },
                down: function () {
                    selectRow(this, 1);
                },
                enter: function () {
                    selectRow(this, 0);
                    $(this).combo("hidePanel");
                },
                query: function (q) {
                    _query(this, q);
                }
            },
            //定义在'mode'设置为'local'的时候如何选择本地数据，返回true时则选择该行
            filter: function (q, row) {
            var options = $(this).combogrid("options");
            return row[options.textField].indexOf(q) == 0;
        }
    });
})(jQuery);

</script>
<body>
<t:formvalid layout="div" formid="dd" dialog="" >
	 <fieldset>
		 <legend>下拉列表控件</legend>
			<div class="container">	
			<h2 class="page-header"></h2>
				<div class="docs-methods" style="height:400px">
					<input id="cc" class="easyui-combogrid" style="width:250px" data-options="
			            panelWidth: 500,
			            idField: 'name',
			            textField: 'name',
			            url: 'jeecgListDemoController.do?datagrid&field=id,name,age,birthday,depId,extField,sex,phone,salary,createDate,email,status,content,touxiang,createBy,createName,updateBy,updateDate,updateName,',
			            columns: [[
			                {field:'name',title:'姓名',width:80},
			                {field:'age',title:'年龄',width:120},
			                {field: 'sex',title: '性别',width: 120,
							formatter: function(value, rec, index) {
								if (value == '0') {
			                        return '男';
			                    }
			                    if (value == '1') {
			                        return '女';
			                    } else {
			                        return value;
			                    }
							}
			            },
						{field:'salary',title: '工资', sortable: true,width:120},
			            ]],
			             fitColumns: true
			        ">
			</div>
		</div>
	</fieldset>
</t:formvalid>
</body>
</html>
