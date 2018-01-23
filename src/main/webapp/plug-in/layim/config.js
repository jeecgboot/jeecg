//layim聊天组件start
//请将这个ip地址修改为本机ip地址
//websocket 配置
//动态配置Ip为当前服务器
var chatIp = document.location.host;
var id = "";
jQuery.post("chat/imController.do?getUserid", {

}, function (text) {

    id = text;//text.substring(1,text.length-1);

});
if(!/^http(s*):\/\//.test(location.href)){
    alert('请部署到localhost上查看该演示');
}

if (typeof WebSocket != 'undefined') {
layui.use('layim', function(layim){
//      //建立WebSocket通讯
    var socket = new WebSocket("ws://"+chatIp+"/jeecg/WebSocket/"+id);

    //基础配置
    layim.config({
        msgbox: layui.cache.dir + 'css/modules/layim/html/msgbox.html',
        //初始化接口
        init: {
            //url: '$!{basePath}/content/chat/demo/json/getList.json'
            url: 'chat/imController.do?getUsers'
            ,data: {}
        }

        //简约模式（不显示主面板）
        //,brief: true

        //查看群员接口
        ,members: {
            url: 'chat/imController.do?getMembers'
            ,data: {}
        }

        ,uploadImage: {
            url: 'chat/imController.do?uploadImage' //（返回的数据格式见下文）
            ,type: 'post' //默认post
        }

        ,uploadFile: {
            url: 'chat/imController.do?uploadFile' //（返回的数据格式见下文）
            ,type: '' //默认post
        }

        //,skin: ['http://cdn.firstlinkapp.com/upload/2016_4/1461747766565_14690.jpg'] //皮肤
        ,brief:true
        ,title:"在线聊天"
        ,maxLength:3000
        ,right:'0px'
        ,brief:false
        ,isAudio:true
        ,isVideo:true
        ,isgroup: true //是否开启群组
        ,chatLog: 'chat/chatMessageHistory.do?from='+id //聊天记录地址

        
        ,find: './demo/find.html'
        ,copyright: true //是否授权
    });

    //监听发送消息
    layim.on('sendMessage', function(data){
        console.log(data);
        //更多情况下，一般是传递一个对象
        socket.send(JSON.stringify(data));
    });

    //连接成功时触发
    socket.onopen = function(){
        //socket.send('XXX连接成功');
    };

    //监听收到的消息
    socket.onmessage = function(res){
        var message = JSON.parse(res.data);
        var timestamp = new Date().getTime();
        console.log(message);
        if(message.to.type=="group"){
            layim.getMessage({
                username: message.mine.username //消息来源用户名
                ,avatar: message.mine.avatar//消息来源用户头像
                ,id: message.to.id //聊天窗口来源ID（如果是私聊，则是用户id，如果是群聊，则是群组id）
                ,type: message.to.type //聊天窗口来源类型，从发送消息传递的to里面获取
                ,content: message.mine.content //消息内容
                ,timestamp: timestamp //服务端动态时间戳
            });
        }else {
            layim.getMessage({
                username: message.mine.username //消息来源用户名
                ,avatar: message.mine.avatar//消息来源用户头像
                ,id: message.mine.id //聊天窗口来源ID（如果是私聊，则是用户id，如果是群聊，则是群组id）
                ,type: message.to.type //聊天窗口来源类型，从发送消息传递的to里面获取
                ,content: message.mine.content //消息内容
                ,timestamp: timestamp //服务端动态时间戳
            });
        }

    };
    //监听在线状态的切换事件
    layim.on('online', function(data){
        console.log(data);
    });


    //监听查看群员
    layim.on('members', function(data){
        console.log(data);
    });

    //监听聊天窗口的切换
    layim.on('chatChange', function(data){
        console.log(data);
    });
    layim.on('sign', function(value){
        $.get("chat/imController.do?changeSign&sign="+value);
        console.log(value); //获得新的签名

    });
    //初始最小化聊天界面
    //layim.setChatMin();

});
}

//layim聊天组件end