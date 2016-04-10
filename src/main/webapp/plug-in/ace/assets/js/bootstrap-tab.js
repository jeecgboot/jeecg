var addTabs = function (options) {
    //var rand = Math.random().toString();
    //var id = rand.substring(rand.indexOf('.') + 1);
    //var url = window.location.protocol + '//' + window.location.host;
    //options.url = url + options.url;
	
    id = "tab_" + options.id;
    $(".active").removeClass("active");
    //如果TAB不存在，创建一个新的TAB
    if (!$("#" + id)[0]) {
        //固定TAB中IFRAME高度
        //mainHeight = $(document.body).height();
        mainHeight = 683;//Ace 右侧高度默认
        //创建新TAB的title
        title = '<li role="presentation" id="tab_' + id + '"><a href="#' + id + '" aria-controls="' + id + '" role="tab" data-toggle="tab">' + options.title;
        //是否允许关闭
        if (options.close) {
            title += ' <i class="icon-remove" tabclose="' + id + '"></i>';
        }
        title += '</a></li>';
        //是否指定TAB内容
        if (options.content) {
            content = '<div role="tabpanel" class="tab-pane" id="' + id + '">' + options.content + '</div>';
        } else {//没有内容，使用IFRAME打开链接
            content = '<div role="tabpanel" class="tab-pane" id="' + id + '"><iframe src="' + options.url + '" width="100%" height="' + mainHeight +
                    '" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe></div>';
        }
        //加入TABS
        $(".nav-tabs").append(title);
        $(".tab-content").append(content);
    }
    //激活TAB
    $("#tab_" + id).addClass('active');
    $("#" + id).addClass("active");

    var last = $("#tabs>ul>li:last");
    /*$(".contextMenuPlugin").mouseout(function(){
     $(".contextMenuPlugin").remove();
     })
     $(".contextMenuPlugin").mouseup(function(){
     alert("aaa");
     })*/
    last.contextPopup({
        title: '菜单',
        items: [
            {
                label:'刷新缓存',icon:'plug-in/diy/icons/shopping-basket.png',action:function(){
                //last就是当前选中的元素
                var tab = last.children("a").attr("aria-controls").toString();
                //$("#tabs").find("li[aria-controls='"+tab+"']").remove();
                var div = $("#tabs").find("div[id='"+tab+"']");
                div.find("iframe").attr("src",options.url);
                //tabs.tabs("refresh");
            }
            },
            {
                label:'关闭',icon:'plug-in/diy/icons/shopping-basket.png',action:function(){
                //last就是当前选中的元素
                var closeText = last.children("a").text().trim();
                var nowText = $("#tabs").find("li[class='active']").children("a").text().trim();
                if(closeText==nowText){
                    //关闭的是当前页的时候，显示前一页，如果没有前一页了，就提示
                    var prevCount = last.prevAll().size();
                    if(prevCount==0){
                        var tab = last.children("a").attr("aria-controls").toString();
                        last.remove();
                        $("#tabs").find("div[id='"+tab+"']").remove();
                    }else{
                        //显示前一个tab
                        var tab = last.children("a").attr("aria-controls").toString();
                        var prev = last.prevAll().first();
                        last.remove();
                        $("#tabs").find("div[id='"+tab+"']").remove();
                        prev.addClass("active");
                        var id = prev.children("a").attr("aria-controls").toString();
                        $("#tabs").find("div[id='"+id+"']").addClass("active");
                    }
                }else{
                    //关闭的不是当前页，关闭就好了╮(╯_╰)╭
                    var tab = last.children("a").attr("aria-controls").toString();
                    last.remove();
                    $("#tabs").find("div[id='"+tab+"']").remove();
                }
            }
            },
            {
                label:'全部关闭',icon:'plug-in/diy/icons/shopping-basket.png',action:function(){
                $("#tabs>ul>li").remove();
                $("#tabs>div>div").remove();
                //tabs.tabs("refresh");
            }
            },
            {
                label:'除此之外全部关闭',icon:'plug-in/diy/icons/shopping-basket.png',action:function(){
                var closeText = last.children("a").text().trim();
                var nowText = $("#tabs").find("li[class='active']").children("a").text().trim();
                //此是当前页则关闭，如果不是当前页面，要激活选择页面
                if(closeText==nowText){
                    //此是当前页面
                    var tab = last.children("a").attr("aria-controls").toString();
                    $("#tabs>ul>li").not(last).remove();
                    $("#tabs>div>div").not($("#tabs").find("div[id='"+tab+"']")).remove();
                }else{
                    var tab = last.children("a").attr("aria-controls").toString();
                    $("#tabs>ul>li").not(last).remove();
                    $("#tabs>div>div").not($("#tabs").find("div[id='"+tab+"']")).remove();
                    last.addClass("active");
                    var id = last.children("a").attr("aria-controls").toString();
                    $("#tabs").find("div[id='"+id+"']").addClass("active");
                }
                //tabs.tabs("refresh");
            }
            },
            null,
            {
                label:'当前页右侧全部关闭',icon:'plug-in/diy/icons/shopping-basket.png',action:function(){
                var closeText = last.children("a").text().trim();
                var nowText = $("#tabs").find("li[class='active']").children("a").text().trim();
                if(closeText==nowText){
                    //当前页面
                    var nextAll = last.nextAll();
                    if(nextAll.length!=0){
                        nextAll.remove();
                        var tab = last.children("a").attr("aria-controls").toString();
                        //$("#tabs>ul>li").not(shouye).remove();
                        $("#tabs>div").find("div[id='"+tab+"']").nextAll().remove();
                        //tabs.tabs("refresh");
                    }else{
                        layer.msg('<b>右侧没有啦</b>');
                    }
                }else{
                    //不是当前页，当前页的active去掉
                    var now = $("#tabs").find("li[class='active']");
                    var nowid = now.children("a").attr("aria-controls").toString();
                    now.removeClass("active");
                    $("#tabs").find("div[id='"+nowid+"']").removeClass("active");
                    var nextAll = last.nextAll();
                    if(nextAll.length!=0){
                        nextAll.remove();
                        var tab = last.children("a").attr("aria-controls").toString();
                        //$("#tabs>ul>li").not(shouye).remove();
                        $("#tabs>div").find("div[id='"+tab+"']").nextAll().remove();
                        last.addClass("active");
                        var id = last.children("a").attr("aria-controls").toString();
                        $("#tabs").find("div[id='"+id+"']").addClass("active");
                        //tabs.tabs("refresh");
                    }else{
                        layer.msg('<b>右侧没有啦</b>');
                    }
                }
            }
            },
            {
                label:'当前页左侧全部关闭',icon:'plug-in/diy/icons/shopping-basket.png',action:function(){
                var closeText = last.children("a").text().trim();
                var nowText = $("#tabs").find("li[class='active']").children("a").text().trim();
                if(closeText==nowText){
                    //当前页面
                    var prevAll = last.prevAll();
                    if(prevAll.length!=0){
                        prevAll.remove();
                        var tab = last.children("a").attr("aria-controls").toString();
                        //$("#tabs>ul>li").not(shouye).remove();
                        $("#tabs>div").find("div[id='"+tab+"']").prevAll().remove();
                        //tabs.tabs("refresh");
                    }else{
                        layer.msg('<b>左侧没有啦</b>');
                    }
                }else{
                    //不是当前页，当前页的active去掉
                    var now = $("#tabs").find("li[class='active']");
                    var nowid = now.children("a").attr("aria-controls").toString();
                    now.removeClass("active");
                    $("#tabs").find("div[id='"+nowid+"']").removeClass("active");
                    var prevAll = last.prevAll();
                    if(prevAll.length!=0){
                        prevAll.remove();
                        var tab = last.children("a").attr("aria-controls").toString();
                        //$("#tabs>ul>li").not(shouye).remove();
                        $("#tabs>div").find("div[id='"+tab+"']").prevAll().remove();
                        last.addClass("active");
                        var id = last.children("a").attr("aria-controls").toString();
                        $("#tabs").find("div[id='"+id+"']").addClass("active");
                        //tabs.tabs("refresh");
                    }else{
                        layer.msg('<b>左侧没有啦</b>');
                    }
                }
                /*var prevAll = last.prevAll();
                 if(prevAll.length!=0){
                 prevAll.remove();
                 }else{
                 layer.msg('<b>左侧没有啦</b>');
                 }
                 var tab = last.attr("aria-controls").toString();
                 //$("#tabs>ul>li").not(shouye).remove();
                 $("#tabs>div").find("div[id='"+tab+"']").prevAll().remove();*/
                //tabs.tabs("refresh");
            }
            }
        ]
    });
};
var closeTab = function (id) {
    //如果关闭的是当前激活的TAB，激活他的前一个TAB
    if ($("li.active").attr('id') == "tab_" + id) {
        $("#tab_" + id).prev().addClass('active');
        $("#" + id).prev().addClass('active');
    }
    //关闭TAB
    $("#tab_" + id).remove();
    $("#" + id).remove();
};
$(function () {
    mainHeight = $(document.body).height();
    $('.main-left,.main-right').height(mainHeight);
    $("[addtabs]").click(function () {
        addTabs({ id: $(this).attr("id"), title: $(this).attr('title'), close: true });
    });

    $(".nav-tabs").on("click", "[tabclose]", function (e) {
        id = $(this).attr("tabclose");
        closeTab(id);
    });
});
