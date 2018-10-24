   function getSelected(gname,field) {
		var row=$("#"+gname).bootstrapTable('getSelections')
		if (row != null) {
			value = row[0][field];
		} else {
			value = '';
		}
		return value;
	}
	function getSelections(gname,field) {
		var ids = [];
		var rows=$.map($("#"+gname).bootstrapTable('getSelections'),function(row){
			return row ;
		});
		for ( var i = 0; i < rows.length; i++) {
			ids.push(rows[i][field]);
		}
		ids.join(',');
		return ids
	};
	
	function tip(msg,icon) {
		try{
			parent.layer.open({
				title:'提示信息',
				offset:'rb',
				content:msg,
				time:3000,
				btn:false,
				shade:false,
				icon:icon,
				shift:2
			});
		}catch(e){
		}
	}

	function add(title, addurl, gname, width, height) {
		var index = parent.layer.open({
			type : 2,
			title : title,
			area : [ '80%', '80%' ],
			shade : 0.3,
			maxmin : true,
			content : addurl,
			btn : [ '确定', '关闭' ],
			yes : function(index, layero) {
			    var body = parent.layer.getChildFrame('body', index);
			    body.find('#btn_sub').click();
			},
			btn2 : function(index, layero) {
				parent.layer.closeAll();
			},
			zIndex : parent.layer.zIndex,
			success : function(layero) {
				parent.layer.setTop(layero);
			},

			end: function () {
				reloadTable();
            }

		});
		parent.layer.full(index);
	}

	/**
	 * 修改
	 * @param title
	 * @param url
	 * @param gname
	 * @return
	 */
	function update(title, url, gname, width, height) {
	    var id = getSelected(gname,'id');
		var url = url+'&id='+id;
		var index = parent.layer.open({
			type : 2,
			title : title,
			area : [ '80%', '80%' ],
			shade : 0.3,
			maxmin : true,
			content : url,
			btn : [ '确定', '关闭' ],
			yes : function(index, layero) {
				var body = parent.layer.getChildFrame('body', index);
		        body.find('#btn_sub').click();
			},
			btn2 : function(index, layero) {
				parent.layer.closeAll();
			},
			zIndex : parent.layer.zIndex,
			success : function(layero) {
				parent.layer.setTop(layero);
			},

			end: function () {
				reloadTable();
            }

		});
		parent.layer.full(index);
	}
	
	/**
	 * 多记录刪除請求
	 * @param title
	 * @param url
	 * @param gname
	 * @return
	 */
	function deleteALLSelect(title,url,gname) {
	    var rows = $("#"+gname).bootstrapTable('getSelections');
	    if (rows.length > 0) {
	    	parent.layer.confirm('你确定永久删除该数据吗?', {
    		  btn: ['确定','取消'] //按钮
    		}, function(){
    			var ids = getSelections(gname,'id');
    			$.ajax({
					url : url,
					type : 'post',
					data : {
						ids : ids.join(',')
					},
					cache : false,
					success : function(data) {
						var d = $.parseJSON(data);
						if (d.success) {
							var msg = d.msg;

							tip(msg,1);//icon设置为1 表示一个绿色的对勾图标

							reloadTable();
							ids='';
						}
					}
				});
    			
    		}, function(){
    		});
	    	
		} else {
			tip("请选择需要删除的数据");
		}
	}
	
	
	
	//删除
	function delObj(url,name) {
		parent.layer.confirm('确认删除该条记录吗？', {
  		  btn: ['确定','取消'] //按钮
  		}, function(){
  			$.ajax({
	  				url : url,
		   			type : 'GET',
					dataType: 'json',
					cache : false,
					success : function(data) {
						if (data.success) {
							var msg = data.msg;

							tip(msg,1);//icon设置为1 表示一个绿色的对勾图标

							reloadTable();
						}
					}
				});
  			
  		}, function(){
  		});
	}
	
	
	/*
	 * 鼠标放在图片上方，显示大图
	 */
	var bigImgIndex = null;
	function tipImg(obj){
		try{
			var src = $(obj).attr("src");
			parent.layer.open({
				type: 1,
				title: false,
				fixed: false,
				shade:0,
				offset: '30px',
				skin: 'layui-layer-nobg', 
				shadeClose: true,
				content: '<img src="'+src+'" style="width:100%;"/>'
			})
		}catch(e){
		}
		
	}

	function moveTipImg(){
		try{
			if(bigImgIndex != null){
				parent.layer.close(bigImgIndex);
			}
		}catch(e){
			
		}
	}
