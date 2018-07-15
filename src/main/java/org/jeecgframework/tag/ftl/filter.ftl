			<div id='mm' class='easyui-menu' style='width:120px;'>
				<div data-options="iconCls:'icon-filter'">
					<span>过滤</span>
					<div class='menu-content filter-content'>
						<div id='curField'></div>
						<div style='width:218px;'>
							 <select name='ruler' id='ruler'>
							 	<option value='0'>等于</option>
							 	<option value='1'>不含</option>
							 	<option value='2'>包含</option>
							 </select>
							 <input name='keyword' id='keyword'> 
							 <div class='btnDiv'> 
							 	<a href='javascript:void(0)' onclick='doFilter()' class='easyui-linkbutton'>&nbsp;&nbsp;确认&nbsp;&nbsp;</a> 
							 	<a href='javascript:void(0)' onclick='cancleFilter()' class='easyui-linkbutton'>&nbsp;&nbsp;取消&nbsp;&nbsp;</a> 
							 </div> 
						</div>
					</div>
				</div>		
				<div class='menu-sep'></div>
			</div>


		 <script type='text/javascript'>
			var cmenu;
			var curFiled;
		 	function doFilter(){
		 		$('#${gridId}').datagrid({
		 			rowStyler: function(index,row){
						var ruler = $('#ruler').val();
						var keyword = $('#keyword').val();
						var field = row[curFiled];
						if(ruler == 0){
							<#--update-begin--Author:xuelin  Date:20171128 for：[#2421]【bug】字段过滤功能 -->
							var objRegExp = /^\d{4}(\-|\/|\.)\d{1,2}\1\d{1,2}$/;
							if(objRegExp.test(keyword)){
								field = field.substring(0,10);	
							}
							<#--update-end--Author:xuelin  Date:20171128 for：[#2421]【bug】字段过滤功能 -->
							if (field != keyword){
			 					return 'display:none;';
			 				}
							return 'display:block;';
						}else if(ruler == 1){
							if(field.indexOf(keyword) > -1){
			 					return 'display:none;';						
							}
							return 'display:block;';
						}else if(ruler == 2){
							if(field.indexOf(keyword) == -1){
			 					return 'display:none;';		
							}
							return 'display:block;';
						}
		 			}
		 		});
		 		$('#mm').menu('hide');
		 	} 	
		 	function cancleFilter(){
		 		<#--update-begin--Author:xuelin  Date:20171128 for：[#2421]【bug】字段过滤功能 -->
		 		$('#keyword').val('');
		 		$('#${gridId}').datagrid({
		 			rowStyler: function(index,row){
						return 'display:block;';
		 			}
		 		});
		 		<#--update-end--Author:xuelin  Date:20171128 for：[#2421]【bug】字段过滤功能 -->
		 		$('#mm').menu('hide');
		 	}
			function createMenu(){
				cmenu = $('#mm').menu({
					onClick: function(item){
						if (item.iconCls == 'icon-ok'){
							$('#${gridId}').datagrid('hideColumn', item.name);
							cmenu.menu('setIcon', {
								target: item.target,
								iconCls: 'icon-empty'
							});
						} else if(item.iconCls == 'icon-empty'){
							$('#${gridId}').datagrid('showColumn', item.name);
							cmenu.menu('setIcon', {
								target: item.target,
								iconCls: 'icon-ok'
							});
						}
					}
				});
				var fields = $('#${gridId}').datagrid('getColumnFields');
				for(var i=0; i<fields.length; i++){
					var field = fields[i];
					var col = $('#${gridId}').datagrid('getColumnOption', field);
					if(col.title != '主键'){
						cmenu.menu('appendItem', {
							text: col.title,
							name: field,
							iconCls: 'icon-ok'
						});
					}
				}
			}
			<#--update-begin--Author:xuelin  Date:20171128 for：[#2421]【bug】字段过滤功能 --加载多次问题 -->
			function headerMenu(e, field){				
				e.preventDefault();
				if (!cmenu){
					createMenu();
				}
				curFiled = field;
				var col = $('#${gridId}').datagrid('getColumnOption', field);
				$('#curField').html('当前字段：'+col.title);
				$('#mm').menu('show', {
					left: e.pageX,
					top: e.pageY
				});
			}
			<#--update-end--Author:xuelin  Date:20171128 for：[#2421]【bug】字段过滤功能 --加载多次问题  -->	
		</script>
