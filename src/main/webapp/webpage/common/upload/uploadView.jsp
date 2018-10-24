<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html >
<html>
 <head>
<t:base type="jquery,easyui,tools"></t:base>
<script type="text/javascript">

        function uploadSuccess(d,file,response){
                $("#fileUrl").val(d.attributes.url);
                $("#fileName").val(d.attributes.name);
                $("#swfpath").val(d.attributes.swfpath);
                var url = $("#fileUrl").val();
                var html="";
                if(url.indexOf(".gif")!=-1 || 
                                url.indexOf(".jpg")!=-1        ||
                                url.indexOf(".png")!=-1 ||
                                url.indexOf(".bmp")!=-1){
                        html += "<img src='"+url+"' width =400 height=300 />";
                }else{
                        html += "<a href='"+url+"' target=_blank >下载:"+d.attributes.name+"</a>";
                }
                $("#fileShow").html(html);
            	changebutton(false);
        }
        function uploadCallback(callback,inputId){
                var url = $("#fileUrl").val();
                var name= $("#fileName").val();
                var swfpath = $("#swfpath").val();
                callback(url,name,inputId,swfpath);
        }
        //修改确认按钮禁用状态 
        function changebutton(flag){
	       	var api = frameElement.api;
         	api.button({
         		id: 'ok',
        		name: flag?"上传中":"确定",
                disabled: flag
            });
        }
        //默认未上传文件，确认按钮为禁用状态 
        function myUploadStart(){
        	var documentTitle = $('#documentTitle').val();
    	    $('#instruction').uploadify("settings", "formData", {
    	        'documentTitle': documentTitle
    	    });
    	    changebutton(true);
        }
        //只返回文件的相对路径,可以直接存储在数据库中
        function backOnlyUrl(){
      	  return $("#fileUrl").val();
        }

</script>
</head>
 <body style="overflow-x: hidden">
  <table cellpadding="0" cellspacing="1" class="formtable">
  <input id="documentTitle" type="hidden" name="documentTitle" value="blank"/>
  <input id="fileUrl" type="hidden"/>
  <input id="fileName" type="hidden"/>
  <input id="swfpath" type="hidden">
   <tbody>
    <tr>
     <td align="right">
       <label class="Validform_label"></label>
     </td>
     <td class="value">
      <t:upload onUploadStart="myUploadStart" name="instruction" dialog="false" multi="false" extend="" queueID="instructionfile" view="false" auto="true" uploader="cgUploadController.do?ajaxSaveFile" onUploadSuccess="uploadSuccess"  id="instruction" formData="documentTitle"></t:upload>
     </td>
    </tr>
    <tr>
     <td colspan="2" id="instructionfile" class="value">
     </td>
    </tr>
   </tbody>
  </table>
   <div id="fileShow" >
  </div>
 </body>
 </html>
