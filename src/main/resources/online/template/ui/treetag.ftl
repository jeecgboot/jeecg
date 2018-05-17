<#-- 树控件的通用处理 -->
<#macro treetag po formStyle="">
 <input id="${po.field_name}" type="text"<#rt/>
 <#if formStyle == 'ace'>
 class="form-control"<#rt/>
 <#else>
 class="inputxt"  <#rt/>
 </#if>
 <#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if><#rt/>
 <#if po.field_valid_type?if_exists?html != ''>
  datatype="${po.field_valid_type?if_exists?html}"<#rt/>
 <#else>
 <#if po.type == 'int'>
 datatype="n"<#rt/>
 <#elseif po.type=='double'>
 datatype="/^(-?\d+)(\.\d+)?$/"<#rt/>
 <#else>
 <#if po.is_null != 'Y'>datatype="*"</#if><#rt/>
 </#if>
 </#if>
 onclick="show${po.field_name?cap_first }Tree();" readonly="readonly">
   <input type="hidden" id="${po.field_name}Id" name="${po.field_name}" value="${data['${tableName}']['${po.field_name}']?if_exists?html}" class="show${po.field_name?cap_first}">  
	<div id="show${po.field_name?cap_first }TreeContent" class="menuContent" style="display: none; position: absolute; border: 1px #CCC solid; background-color: #F0F6E4;z-index:9999;">  
	    <ul id="show${po.field_name?cap_first }Tree" class="ztree" style="margin-top:0;"></ul>  
	</div>
<script>
	$(function(){
		if(!$.fn.zTree){
			$("head").append('<link rel="stylesheet" href="${basePath}/plug-in/ztree/css/zTreeStyle.css"/>');
			$("head").append('<script type=\"text/javascript\" src=\"${basePath}/plug-in/ztree/js/jquery.ztree.core-3.5.min.js\"><\/script>');
			$("head").append('<script type=\"text/javascript\" src=\"${basePath}/plug-in/ztree/js/jquery.ztree.excheck-3.5.min.js\"><\/script>');
		}
		var defaultVal = $("#${po.field_name}Id").val();
		if(defaultVal != null && defaultVal != ''){
			if(defaultVal.indexOf(",") > -1){
				var defaultValArray = defaultVal.split(",");
				var resultValue = "";
				for(var i = 0; i < defaultValArray.length; i++){
					var result = $.ajax({
						url:'${basePath}/categoryController.do?tree',
						type:'POST',
						dataType:'JSON',
						data:{
							selfCode:defaultValArray[i]
						},
						async:false
					});
					var responseText = result.responseText;
					if(typeof responseText == 'string'){
						responseText = JSON.parse(responseText);
					}
					if(resultValue != ''){
						  resultValue = resultValue + "," + responseText[0].text;
					}else{
						resultValue = responseText[0].text;
					}
				}
				$("#${po.field_name}").val(resultValue);
			}else{
				$.ajax({
					url:'${basePath}/categoryController.do?tree',
					type:'POST',
					dataType:'JSON',
					data:{
						selfCode:defaultVal
					},
					success:function(res){
						if(typeof res == 'object'){
							var value = res[0].text;
							$("#${po.field_name}").val(value);
						}
					}
				});
			}
			
		}
		$("body").bind("mousedown", onBodyDownBy${po.field_name?cap_first });
	});
	
	var ${po.field_name}Setting = {  
	<#-- update-begin-author:taoYan date:20180323 for:勾选 checkbox 对于父子节点的关联关系，需要根据特定的业务配置 -->
			check: {  
                enable: true,
                chkStyle: "checkbox",
				chkboxType: { "Y": "", "N": "" }
	        }, 
    <#-- update-end-author:taoYan date:20180323 for:勾选 checkbox 对于父子节点的关联关系，需要根据特定的业务配置 -->
		    view: {  
		        dblClickExpand: false  
		    },  
		    data: {  
		        simpleData: {  
		            enable: true  
		        },
		        key:{
		        	name:'text'
		        }
		    },  
		    callback: {  
		        onClick: ${po.field_name}OnClick,
		        onCheck: ${po.field_name}OnCheck
		    }  
		}; 
		function ${po.field_name}OnCheck(e, treeId, treeNode) { 
		<#-- update-begin-author:taoyan date:20180323 for:树选中/取消事件-取值，之前的代码逻辑判断太多，通用性不够好，此法虽非最优解但通用性强  -->
		    var myTree = $.fn.zTree.getZTreeObj("show${po.field_name?cap_first }Tree");  
		    var nodes = myTree.getCheckedNodes(true);
		    var tempId='',tempText='';
		    if(nodes && nodes.length>0){
		    	 for(var a in nodes){
			    	tempId+=nodes[a].id+",";
			    	tempText+=nodes[a].text+",";
			     }
		    }
		    if(tempId!=''){
		    	$("#${po.field_name}Id").val(tempId.substring(0,tempId.length - 1));
		    }else{
		    	$("#${po.field_name}Id").val('');
		    }
			if(tempText!=''){
				$("#${po.field_name}").val(tempText.substring(0,tempText.length - 1));
		    }else{
		    	$("#${po.field_name}").val('');
		    }
		 <#-- update-end-author:taoyan date:20180323 for:树选中/取消事件-取值，之前的代码逻辑判断太多，通用性不够好，此法虽非最优解但通用性强  -->
		    e.stopPropagation();
		}  
	function ${po.field_name}OnClick(e, treeId, treeNode) {  
		    var zTree = $.fn.zTree.getZTreeObj("show${po.field_name?cap_first }Tree");  
		  	zTree.checkNode(treeNode, !treeNode.checked, true,true);
		  	e.stopPropagation();
		}  
	function show${po.field_name?cap_first }Tree(){
		 if($("#show${po.field_name?cap_first }TreeContent").is(":hidden")){
		 	 $.ajax({  
		        url:'${basePath}/categoryController.do?tree',  
		        type:'POST',  
		        dataType:'JSON',
		        async:false,  
	        	data:{
	        		selfCode:'${po.dict_field}'
	        	},
		        success:function(res){
		            var obj = res; 
		            $.fn.zTree.init($("#show${po.field_name?cap_first }Tree"), ${po.field_name}Setting, obj);  
		            var deptObj = $("#${po.field_name}");  
		            var deptOffset = $("#${po.field_name}").offset();  
		            <#if formStyle == 'ace'>
		            	$("#show${po.field_name?cap_first }TreeContent").css({top:(deptObj[0].offsetTop + deptObj.outerHeight()) + "px"}).slideDown("fast");  
		            	$('#show${po.field_name?cap_first }Tree').css({display:'inline-block',width:deptObj.outerWidth()-2 + "px"});
					<#else>
						$("#show${po.field_name?cap_first }TreeContent").css({left:deptOffset.left + "px", top:deptOffset.top + deptObj.outerHeight() + "px"}).slideDown("fast");  
		          	    $('#show${po.field_name?cap_first }Tree').css({width:deptObj.outerWidth() - 12 + "px"}); 
					</#if>
		            var zTree = $.fn.zTree.getZTreeObj("show${po.field_name?cap_first }Tree"); 
		            var idVal =  $("#${po.field_name}Id").val();
		            if(idVal != null && idVal != ''){
			             if(idVal.indexOf(",") > -1){
			            	var idArray = idVal.split(",");
			            	for(var i = 0; i < idArray.length; i++){
			            		var node = zTree.getNodeByParam("id", idArray[i], null);
			            		zTree.checkNode(node, true, true);
			            	}
			            }else{
			            	var node = zTree.getNodeByParam("id", idVal, null);
			            		zTree.checkNode(node, true, true);
			            } 
		            }
		            //$("#show${po.field_name?cap_first }TreeContent").bind("mousedown",${po.field_name?cap_first }TreeContentClick);  
		        } 
		      }); 
		 }
		 }
	   
	    function onBodyDownBy${po.field_name?cap_first }(event){
	    	if(event.target.id == '' || (event.target.id.indexOf('switch') == -1 
		    	&& event.target.id.indexOf('check') == -1 
		    	&& event.target.id.indexOf('span') == -1
		    	&& event.target.id.indexOf('ico') == -1)){  
		    	$("#show${po.field_name?cap_first }TreeContent").fadeOut("fast");  
				//$("body").unbind("mousedown", onBodyDownBy${po.field_name?cap_first });
			 }
	    }
</script>
</#macro>