<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>bootstrap-suggest-plugin</title>

	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="这是一个基于 bootstrap 按钮式下拉菜单组件的搜索建议插件">
    <meta name="Keywords" content="Bootstrap Search Suggest,bootstrap,搜索建议插件"/>
    <t:base type="bootstrap"></t:base>
</head>
<body>
<div class="container">
        <h2>bootstrap combox 搜索建议插件示例</h2>
        <form action="index_submit" method="get" accept-charset="utf-8" role="form">
            <h3>测试(URL 获取)</h3>
            <p>配置了 data-id，非下拉菜单选择输入则背景色警告。</p>
            <div class="row">
                <div class="col-lg-2">
                    <div class="input-group">
                        <input type="text" class="form-control" id="test">
                        <div class="input-group-btn">
                            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-right" role="menu">
                            </ul>
                        </div>
                        <!-- /btn-group -->
                    </div>
                </div>
            </div>
 
            <h3>测试(URL 获取)</h3>
            <p>不展示下拉菜单按钮。</p>
            <div class="row">
                <div class="col-lg-6">
                    <div class="input-group">
                        <input type="text" class="form-control" id="testNoBtn">
                        <div class="input-group-btn">
                            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-right" role="menu">
                            </ul>
                        </div>
                        <!-- /btn-group -->
                    </div>
                </div>
            </div>
            
            <h3>测试(URL 获取)</h3>
            <p>数据库用户表数据</p>
            <div class="row">
                <div class="col-lg-6">
                    <div class="input-group">
                        <input type="text" class="form-control" id="testDbUser">
                        <div class="input-group-btn">
                            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-right" role="menu">
                            </ul>
                        </div>
                        <!-- /btn-group -->
                    </div>
                </div>
            </div>
 
            <h3>测试(json 数据中获取)</h3>
            <p>默认启用空关键字检索。</p>
            <div class="row">
                <div class="col-lg-6">
                    <div class="input-group">
                        <input type="text" class="form-control" id="test_data">
                        <div class="input-group-btn">
                            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-right" role="menu">
                            </ul>
                        </div>
                        <!-- /btn-group -->
                    </div>
                </div>
            </div>
 
            <h3>百度搜索</h3>
            <p>支持逗号分隔多关键字</p>
            <div class="row">
                <div class="col-lg-6">
                    <div class="input-group" style="width: 300px;">
                        <input type="text" class="form-control" id="baidu">
                        <div class="input-group-btn">
                            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-right" role="menu">
                            </ul>
                        </div>
                        <!-- /btn-group -->
                    </div>
                </div>
            </div>
 
            <h3>淘宝搜索</h3>
            <p>支持逗号分隔多关键字</p>
            <div class="row">
                <div class="col-lg-6">
                    <div class="input-group" style="width: 400px;">
                        <input type="text" class="form-control" id="taobao">
                        <div class="input-group-btn">
                            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-right" role="menu">
                            </ul>
                        </div>
                        <!-- /btn-group -->
                    </div>
                </div>
            </div>
 
        </form>
    </div>
    <script src="plug-in/hplus/plugins/suggest/bootstrap-suggest.min.js"></script>
    <script type="text/javascript">
    var testBsSuggest = $("#test").bsSuggest({
        //url: "/rest/sys/getuserlist?keyword=",
        url: "plug-in/hplus/plugins/suggest/data.json",
        /*effectiveFields: ["userName", "shortAccount"],
        searchFields: [ "shortAccount"],
        effectiveFieldsAlias:{userName: "姓名"},*/
        idField: "userId",
        keyField: "userName"
    }).on('onDataRequestSuccess', function (e, result) {
        console.log('onDataRequestSuccess: ', result);
    }).on('onSetSelectValue', function (e, keyword) {
        console.log('onSetSelectValue: ', keyword);
    }).on('onUnsetSelectValue', function (e) {
        console.log("onUnsetSelectValue");
    });
    
    
    var testBsSuggest = $("#testDbUser").bsSuggest({
        url: "jeecgListDemoController/loadSuggestData.do?keyword=",
        /*effectiveFields: ["userName", "shortAccount"],
        searchFields: [ "shortAccount"],
        effectiveFieldsAlias:{userName: "姓名"},*/
        idField: "username",
        keyField: "realname"
    }).on('onDataRequestSuccess', function (e, result) {
        console.log('onDataRequestSuccess: ', result);
    }).on('onSetSelectValue', function (e, keyword) {
        console.log('onSetSelectValue: ', keyword);
    }).on('onUnsetSelectValue', function (e) {
        console.log("onUnsetSelectValue");
    });
 
    /**
     * 不显示下拉按钮
     */
    var testBsSuggest = $("#testNoBtn").bsSuggest({
        //url: "/rest/sys/getuserlist?keyword=",
        url: "plug-in/hplus/plugins/suggest/data.json",
        /*effectiveFields: ["userName", "shortAccount"],
        searchFields: [ "shortAccount"],
        effectiveFieldsAlias:{userName: "姓名"},*/
        showBtn: false,
        idField: "userId",
        keyField: "userName"
    }).on('onDataRequestSuccess', function (e, result) {
        console.log('onDataRequestSuccess: ', result);
    }).on('onSetSelectValue', function (e, keyword) {
        console.log('onSetSelectValue: ', keyword);
    }).on('onUnsetSelectValue', function (e) {
        console.log("onUnsetSelectValue");
    });
 
    /**
     * 从 data参数中过滤数据
     */
    var testdataBsSuggest = $("#test_data").bsSuggest({
        indexId: 2,  //data.value 的第几个数据，作为input输入框的内容
        indexKey: 1, //data.value 的第几个数据，作为input输入框的内容
        data: {
            'value':[
                {'id':'0','word':'张起灵','description':'http://lzw.me'},
                {'id':'1','word':'张湾小学','description':'http://w.lzw.me'},
                {'id':'2','word':'张三李四','description':'http://www.meizu.com'},
                {'id':'3','word':'李大钊','description':'http://flyme.meizu.com'}
            ],
            'defaults':'http://lzw.me'
        }
    });
    /**
     * 百度搜索 API 测试
     */
    var baiduBsSuggest = $("#baidu").bsSuggest({
        allowNoKeyword: false,   //是否允许无关键字时请求数据。为 false 则无输入时不执行过滤请求
        multiWord: true,         //以分隔符号分割的多关键字支持
        separator: ",",          //多关键字支持时的分隔符，默认为空格
        getDataMethod: "url",    //获取数据的方式，总是从 URL 获取
        url: 'http://unionsug.baidu.com/su?p=3&t='+ (new Date()).getTime() +'&wd=', /*优先从url ajax 请求 json 帮助数据，注意最后一个参数为关键字请求参数*/
        jsonp: 'cb',                      //如果从 url 获取数据，并且需要跨域，则该参数必须设置
        processData: function (json) {    // url 获取数据时，对数据的处理，作为 getData 的回调函数
            var i, len, data = {value: []};
            if (!json || !json.s || json.s.length === 0) {
                return false;
            }
 
            console.log(json);
            len = json.s.length;
 
            jsonStr = "{'value':[";
            for (i = 0; i < len; i++) {
                data.value.push({
                    word: json.s[i]
                });
            }
            data.defaults = 'baidu';
 
            //字符串转化为 js 对象
            return data;
        }
    });
    /**
     * 淘宝搜索 API 测试
     */
    var taobaoBsSuggest = $("#taobao").bsSuggest({
        indexId: 2,             //data.value 的第几个数据，作为input输入框的内容
        indexKey: 1,            //data.value 的第几个数据，作为input输入框的内容
        allowNoKeyword: false,  //是否允许无关键字时请求数据。为 false 则无输入时不执行过滤请求
        multiWord: true,        //以分隔符号分割的多关键字支持
        separator: ",",         //多关键字支持时的分隔符，默认为空格
        getDataMethod: "url",   //获取数据的方式，总是从 URL 获取
        showHeader: true,       //显示多个字段的表头
        effectiveFieldsAlias:{Id: "序号", Keyword: "关键字", Count: "数量"},
        url: 'http://suggest.taobao.com/sug?code=utf-8&extras=1&q=', /*优先从url ajax 请求 json 帮助数据，注意最后一个参数为关键字请求参数*/
        jsonp: 'callback',               //如果从 url 获取数据，并且需要跨域，则该参数必须设置
        processData: function(json){     // url 获取数据时，对数据的处理，作为 getData 的回调函数
            var i, len, data = {value: []};
 
            if(!json || !json.result || json.result.length == 0) {
                return false;
            }
 
            console.log(json);
            len = json.result.length;
 
            for (i = 0; i < len; i++) {
                data.value.push({
                    "Id": (i + 1),
                    "Keyword": json.result[i][0],
                    "Count": json.result[i][1]
                });
            }
            console.log(data);
            return data;
        }
    });
 
    $("form").submit(function(e) {
        return false;
    });
    </script>
 <div class="container" style="margin-top:20px">
 <div><h2>------------------------------------------备注-------------------------------------------------</h2></div>
 <p>Bootstrap Search Suggest 是一个基于 bootstrap 按钮式下拉菜单组件的搜索建议插件，必须使用于按钮式下拉菜单组件上。</p>
 <h3>浏览器支持</h3>
 <ul><li>支持 ie8+,chrome,firefox,safari</li></ul>
 <h3>功能说明</h3>
 <ul>
	<li>搜索方式：从 data.value 的有效字段数据中查询 keyword 的出现，或字段数据包含于 keyword 中</li>
	<li>支持单关键字、多关键字的输入搜索建议，多关键字可自定义分隔符</li>
	<li>支持按 data 数组数据搜索、按  URL 请求搜索和按首次请求URL数据并缓存搜索三种方式</li>
	<li>单关键字会设置 data-id 和输入框内容两个值，以 indexId/idField 和 indexKey/idFiled 取值 data 的数据为准；多关键字只设置输入框值</li>
 </ul>
 <h3>配置参数</h3>
 <pre>
 var defaultOptions = {
    url: null,                      //请求数据的 URL 地址
    jsonp: null,                    //设置此参数名，将开启jsonp功能，否则使用json数据结构
    data: {             
        value: []               
    },                              //提示所用的数据，注意格式
    indexId: 0,                     //每组数据的第几个数据，作为input输入框的 data-id，设为 -1 且 idField 为空则不设置此值
    indexKey: 0,                    //每组数据的第几个数据，作为input输入框的内容
    idField: '',                    //每组数据的哪个字段作为 data-id，优先级高于 indexId 设置（推荐）
    keyField: '',                   //每组数据的哪个字段作为输入框内容，优先级高于 indexKey 设置（推荐）
 
    /* 搜索相关 */
    autoSelect: true,               //键盘向上/下方向键时，是否自动选择值
    allowNoKeyword: true,           //是否允许无关键字时请求数据
    getDataMethod: 'firstByUrl',    //获取数据的方式，url：一直从url请求；data：从 options.data 获取；firstByUrl：第一次从Url获取全部数据，之后从options.data获取
    delayUntilKeyup: false,         //获取数据的方式 为 firstByUrl 时，是否延迟到有输入时才请求数据
    ignorecase: false,              //前端搜索匹配时，是否忽略大小写
    effectiveFields: [],            //有效显示于列表中的字段，非有效字段都会过滤，默认全部。
    effectiveFieldsAlias: {},       //有效字段的别名对象，用于 header 的显示
    searchFields: [],               //有效搜索字段，从前端搜索过滤数据时使用，但不一定显示在列表中。effectiveFields 配置字段也会用于搜索过滤
    twoWayMatch: true,              // 是否双向匹配搜索。为 true 即输入关键字包含或包含于匹配字段均认为匹配成功，为 false 则输入关键字包含于匹配字段认为匹配成功
 
    multiWord: false,               //以分隔符号分割的多关键字支持
    separator: ',',                 //多关键字支持时的分隔符，默认为半角逗号
    delay: 300,                     //搜索触发的延时时间间隔，单位毫秒
 
    /* UI */
    autoDropup: false,              //选择菜单是否自动判断向上展开。设为 true，则当下拉菜单高度超过窗体，且向上方向不会被窗体覆盖，则选择菜单向上弹出
    autoMinWidth: false,            //是否自动最小宽度，设为 false 则最小宽度不小于输入框宽度
    showHeader: false,              //是否显示选择列表的 header。为 true 时，有效字段大于一列则显示表头
    showBtn: true,                  //是否显示下拉按钮
    inputBgColor: '',               //输入框背景色，当与容器背景色不同时，可能需要该项的配置
    inputWarnColor: 'rgba(255,0,0,.1)', //输入框内容不是下拉列表选择时的警告色
    listStyle: {
        'padding-top': 0,
        'max-height': '375px',
        'max-width': '800px',
        'overflow': 'auto',
        'width': 'auto',
        'transition': '0.3s',
        '-webkit-transition': '0.3s',
        '-moz-transition': '0.3s',
        '-o-transition': '0.3s'
    },                              //列表的样式控制
    listAlign: 'left',              //提示列表对齐位置，left/right/auto
    listHoverStyle: 'background: #07d; color:#fff', //提示框列表鼠标悬浮的样式
    listHoverCSS: 'jhover',         //提示框列表鼠标悬浮的样式名称
    clearable: false,               // 是否可清除已输入的内容
 
    /* key */
    keyLeft: 37,                    //向左方向键，不同的操作系统可能会有差别，则自行定义
    keyUp: 38,                      //向上方向键
    keyRight: 39,                   //向右方向键
    keyDown: 40,                    //向下方向键
    keyEnter: 13,                   //回车键
 
    /* methods */   
    fnProcessData: processData,     //格式化数据的方法，返回数据格式参考 data 参数
    fnGetData: getData,             //获取数据的方法，无特殊需求一般不作设置
    fnAdjustAjaxParam: null,        //调整 ajax 请求参数方法，用于更多的请求配置需求。如对请求关键字作进一步处理、修改超时时间等
    fnPreprocessKeyword: null       //搜索过滤数据前，对输入关键字作进一步处理方法。注意，应返回字符串
};
 </pre>
 </div>   
</body>
</html>
<t:authFilter />