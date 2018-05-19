<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link>
<title>ueditor</title>
<link rel="stylesheet" href="plug-in/tab/css/tab.css">
<!-- vue -->
<script src="https://unpkg.com/vue/dist/vue.js"></script>
<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.config.js"></script>
<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.all.min.js"></script>
</head>
<body>
<div id="app">

	<div v-for="(todo,index) in todos" v-show="index==currentEdit">
		<textarea v-bind="{id:'ueditorContent_'+index}" name="ueditorContent" type="text/plain" >{{todo.text}}</textarea>
	</div>

	<div class="pagetab">
		<ul id="pageList">
			<li v-bind:class="{current:index==currentEdit}" v-for="(todo,index) in todos" @click="changeEdit(index)" >
				<b>
					<span >{{todo.text }}</span>
				</b>
			</li>
		</ul>
		<span class="add">
			  <img id="addPage" @click="addTab()" src="plug-in/tab/picture/icon_plus.gif" class="imgPlus" title="在当前页后插入">
			  <img id="delPage" @click="delTab()" src="plug-in/tab/picture/icon_minus.gif" class="imgDelete" title="删除当前页">
		</span>
	</div>
</div>
<script>
    var app = new Vue({
        el: '#app',
        data: {
            todos: [
                { id:0, text: '主页' },
            ],
            currentEdit:0
        },
        methods: {
            addTab: function () {
                this.todos.push({ id:this.todos.length,text: '新页面'+this.todos.length });
                var id="ueditorContent_"+(this.todos.length-1);
                setTimeout(function () {
                    UE.getEditor(id);
                },300)
                console.log("addTab")
            },
            delTab: function () {
                if(this.todos.length==1){
                    alert("主页无法删除")
                    return;
				}
                this.todos.splice(this.todos.length-1,1);
                this.currentEdit=this.todos.length-1;
            },
            changeEdit:function (index) {
                this.currentEdit=index;
            }
        }
    });
    var id="ueditorContent_"+0;
    var ue = UE.getEditor(id);
</script>

</body>
</html>

