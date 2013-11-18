<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<script src="plug-in/jquery/jquery-autocomplete/jquery.autocomplete.js" type="text/javascript"></script>
<link href="plug-in/jquery/jquery-autocomplete/jquery.autocomplete.css" rel="stylesheet" type="text/css" /> 
<style>
<!--
	.ac_over{
		background: #E0ECFF;
		cursor: pointer;
		color:#416AA3;
	}
	
	.ac_results{
		border:1px solid rgb(172, 216, 236);
	}
-->
</style>
<SCRIPT type="text/javascript">
        
/* $(function () {
        	//触发事件
          	 $("#keyword").keyup(function () {
	        	var keyWords = $("#keyword").val();
	        	if (keyWords.length == 2 && keyWords != $("#keywordTex").val()) {
	        		$("#keywordTex").val(keyWords);
	        		$("#keyword").unautocomplete();
	        		$.getJSON("commonController.do?getAutoList",{
						featureClass : "P",
						style : "full",
						maxRows : 10,
						labelField : "userName,realName",
						valueField : "id",
						searchField : "userName",
						entityName : "TSUser",
						trem: keyWords
						
					},function (data) {
			            $('#keyword').autocomplete(data.rows, {
			                max: 5, //列表里的条目数 
			                minChars: 2, //自动完成激活之前填入的最小字符 
			                width: 400, //提示的宽度，溢出隐藏 
			                scrollHeight: 300, //提示的高度，溢出显示滚动条 
			                matchContains: true, //包含匹配，就是data参数里的数据，是否只要包含文本框里的数据就显示 
			                autoFill: false, //自动填充 
			                //每个数据对象
			                formatItem: function (row, i, max) {//row表示每一行的数据对象，i表示每一行的编号，max表示总的数据行数
			                    return row.userName + "-->" + " " + row.realName;
			                }
			                
			            }).result(function (event, row, formatted) {
			                callBack(row);
			            });
			            //${"#keyword"}.focus();
	        		});
	        	}
        		
        	});   */
        	
        
       
       
      /*   $('#keyword').autocomplete("commonController.do?getAutoList",{
        	max: 5, //列表里的条目数 
            minChars: 2, //自动完成激活之前填入的最小字符 
            width: 200, //提示的宽度，溢出隐藏 
            scrollHeight: 100, //提示的高度，溢出显示滚动条 
            matchContains: true, //包含匹配，就是data参数里的数据，是否只要包含文本框里的数据就显示 
            autoFill: false,
            extraParams:{
            	featureClass : "P",
							style : "full",
							maxRows : 10,
							labelField : "userName,realName",
							valueField : "id",
							searchField : "userName",
							entityName : "TSUser",
							trem: getValue
            },
            parse: function (data) {//row表示每一行的数据对象，i表示每一行的编号，max表示总的数据行数
            	var parsed = [];
		        	$.each(data.rows,function(index,row){
		        		parsed.push({data:row,result:row,value:row.id});
		        	});
        				return parsed;
               },
            formatItem: function (row, i, max) {//row表示每一行的数据对象，i表示每一行的编号，max表示总的数据行数
                return row.userName + "-->" + " " + row.realName;
            }
        }).result(function (event, row, formatted) {
            callBack(row);
        });; 

        
                           
        }); */
        
        function parse(data){
            	var parsed = [];
		        	$.each(data.rows,function(index,row){
		        		parsed.push({data:row,result:row,value:row.id});
		        	});
        				return parsed;
        }
        /**
         * 选择后回调 
         * 
         * @param {Object} data
         */
        function callBack(data) {
        	$("#user").val(data.userName);
        }
        
         /**
          * 每一个选择项显示的信息
          * 
          * @param {Object} data
          */
        function formatItem(data) {
        	return data.userName + "-->" + " " + data.realName;
        }

  </SCRIPT>
<t:formvalid formid="formobj" dialog="false" layout="div" action="demoController.do?saveDemo">
 <fieldset class="step">
  <div class="form">
   <label class="form">
    自动补全：
   </label>
   <!-- update-begin--Author:tanghong  Date:20130528 for：[ 114 ]自动补全标签优化-->
     <t:autocomplete minLength="1" dataSource="commonController.do?getAutoList" closefun="close" valueField="id"
      searchField="userName,realName" labelField="userName,realName" parse="parse" formatItem="formatItem" result="callBack"
      name="user" entityName="TSUser" datatype="*" maxRows="10" nullmsg="请输入关键字" errormsg="数据不存在,请重新输入"></t:autocomplete>  
   <!--  <input type="text" id="keyword" />
   <input type="hidden" id="account" />
   <input type="hidden" id="keywordTex" />
   <span id="msg" style="display: none">真实姓名:<span id="real"></span>
   </span>
   <span class="Validform_checktip">自动提示数据说明:用户名,真实姓名</span>   -->
   <!-- update-end--Author:tanghong  Date:20130528 for：[ 114 ]自动补全标签优化-->
  </div>
 </fieldset>
</t:formvalid>
