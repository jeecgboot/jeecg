//layim聊天组件start
//请将这个ip地址修改为本机ip地址
//websocket 配置
var chatIp = "192.168.0.114";
var id = "";
jQuery.post("chat/imController.do?getUserid", {

}, function (text) {
    id = text.substring(1,text.length-1);
});
if(!/^http(s*):\/\//.test(location.href)){
    alert('请部署到localhost上查看该演示');
}

layui.use('layim', function(layim){
//      //建立WebSocket通讯
    var socket = new WebSocket("ws://"+chatIp+":8080/jeecg/WebSocket/"+id);

    //基础配置
    layim.config({
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
            url: 'content/chat/demo/json/getMembers.json'
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
        ,title:"在线聊天"
        ,maxLength:3000
        ,brief:false
        ,isgroup: false //是否开启群组
        ,chatLog: 'chat/chatMessageHistory.do?from='+id //聊天记录地址

        
        ,find: './demo/find.html'
        ,copyright: true //是否授权
    });

    //监听发送消息
    layim.on('sendMessage', function(data){
        console.log(data);
        var mine = data.mine;
        var to = data.to;
        console.log(data);

        //更多情况下，一般是传递一个对象
        socket.send(JSON.stringify({
            type: 'friend' //随便定义，用于在服务端区分消息类型
            ,data: {"msg":mine.content,"from":mine.id,"to":to.id,"fromName":mine.username,"toName":to.username}
        }));
    });

    //连接成功时触发
    socket.onopen = function(){
        //socket.send('XXX连接成功');
    };

    //监听收到的消息
    socket.onmessage = function(res){
        var json = JSON.parse(res.data);
        var timestamp = new Date().getTime();
        layim.getMessage({
            username: json.data.fromName //消息来源用户名
            ,avatar: "http://tp1.sinaimg.cn/1571889140/180/40030060651/1" //消息来源用户头像
            ,id: json.data.from //聊天窗口来源ID（如果是私聊，则是用户id，如果是群聊，则是群组id）
            ,type: "friend" //聊天窗口来源类型，从发送消息传递的to里面获取
            ,content: json.data.msg //消息内容
            ,timestamp: timestamp //服务端动态时间戳
        });
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

    //初始最小化聊天界面
    //layim.setChatMin();
});
//layim聊天组件end