<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<t:base type="jquery,easyui,tools"></t:base>
<link rel="stylesheet" href="plug-in/Validform/css/style.css" type="text/css"/>
<link rel="stylesheet" href="plug-in/Validform/css/tablefrom.css" type="text/css"/>
    <link rel="stylesheet" href="plug-in/Formdesign/js/ueditor/formdesign/bootstrap/css/bootstrap.css">
    <!--[if lte IE 6]>
    <link rel="stylesheet" type="text/css" href="plug-in/Formdesign/js/ueditor/formdesign/bootstrap/css/bootstrap-ie6.css">
    <![endif]-->
    <!--[if lte IE 7]>
    <link rel="stylesheet" type="text/css" href="plug-in/Formdesign/js/ueditor/formdesign/bootstrap/css/ie.css">
    <![endif]-->
    <link rel="stylesheet" href="plug-in/Formdesign/js/ueditor/formdesign/leipi.style.css">
</head>
<body>
<textarea id="original" style="display:none">${contents}</textarea>
<div id='preview'/>
<script>
$(function(){
	var html = parse_form($('#original').val());
	 $.ajax({
         type: 'POST',
         url : 'cgformFtlController.do?parseUeditor',
         dataType : 'json',
         data : {'action' :'edit','parseForm':html},
         success : function(msg){
             if(msg.success){
            	//update-begin--Author:jg_renjie  Date:20150706 for：更改解析参数的方式
            	var d = msg.msg;
            	if(d != null && d != ''){
            		$('#preview').html(msg.msg.replace(new RegExp(/(&quot;)/g),"'"));
            	}
            	//update-end--Author:jg_renjie  Date:20150706 for：更改解析参数的方式
			}else{
				tip(msg.msg);
			}
         }
     });
});
//update-begin--Author:jg_renjie  Date:20150706 for：更新parse_form，与官网同步
function parse_form(template,fields)
    {
	//正则  radios|checkboxs|select 匹配的边界 |--|  因为当使用 {} 时js报错 (plugins|fieldname|fieldflow)
    var preg =  /(\|-<span(((?!<span).)*plugins=\"(radios|checkboxs|select)\".*?)>(.*?)<\/span>-\||<(img|input|textarea|select).*?(<\/select>|<\/textarea>|\/>))/gi,preg_attr =/(\w+)=\"(.?|.+?)\"/gi,preg_group =/<input.*?\/>/gi;
    if(!fields) fields = 0;

    var template_parse = template,template_data = new Array(),add_fields=new Object(),checkboxs=0;

    var pno = 0;
    template.replace(preg, function(plugin,p1,p2,p3,p4,p5,p6){
        var parse_attr = new Array(),attr_arr_all = new Object(),name = '', select_dot = '' , is_new=false;
        var p0 = plugin;
        var tag = p6 ? p6 : p4;
        //alert(tag + " \n- t1 - "+p1 +" \n-2- " +p2+" \n-3- " +p3+" \n-4- " +p4+" \n-5- " +p5+" \n-6- " +p6);

        if(tag == 'radios' || tag == 'checkboxs')
        {
            plugin = p2;
        }else if(tag == 'select')
        {
            plugin = plugin.replace('|-','');
            plugin = plugin.replace('-|','');
        }
        plugin.replace(preg_attr, function(str0,attr,val) {
            if(attr=='name')
            {
                if(val=='NEWFIELD')
                {
                    is_new=true;
                    fields++;
                    val = 'data_'+fields;
                }
                name = val;
            }

            if(tag=='select' && attr=='value')
            {
                if(!attr_arr_all[attr]) attr_arr_all[attr] = '';
                attr_arr_all[attr] += select_dot + val;
                select_dot = ',';
            }else
            {
                attr_arr_all[attr] = val;
            }
            var oField = new Object();
            oField[attr] = val;
            parse_attr.push(oField);
        })
        /*alert(JSON.stringify(parse_attr));return;*/
        if(tag =='checkboxs') /*复选组  多个字段 */
        {
            plugin = p0;
            plugin = plugin.replace('|-','');
            plugin = plugin.replace('-|','');
            var name = 'checkboxs_'+checkboxs;
            attr_arr_all['parse_name'] = name;
            attr_arr_all['name'] = '';
            attr_arr_all['value'] = '';

            attr_arr_all['content'] = '<span plugins="checkboxs"  title="'+attr_arr_all['title']+'">';
            var dot_name ='', dot_value = '';
            p5.replace(preg_group, function(parse_group) {
                var is_new=false,option = new Object();
                parse_group.replace(preg_attr, function(str0,k,val) {
                    if(k=='name')
                    {
                    	if(val=='NEWFIELD')
                        {
                            is_new=true;
                            fields++;
                            val = 'data_'+fields;
                        }

                        attr_arr_all['name'] += dot_name + val;
                        dot_name = ',';

                    }
                    else if(k=='value')
                    {
                        attr_arr_all['value'] += dot_value + val;
                        dot_value = ',';

                    }
                    option[k] = val;
                });

                if(!attr_arr_all['options']) attr_arr_all['options'] = new Array();
                attr_arr_all['options'].push(option);
                if(!option['checked']) option['checked'] = '';
                var checked = option['checked'] ? 'checked="checked"' : '';
                attr_arr_all['content'] +='<input type="checkbox" name="'+option['name']+'" value="'+option['value']+'" fieldname="' + attr_arr_all['fieldname'] + option['fieldname'] + '" fieldflow="' + attr_arr_all['fieldflow'] + '" '+checked+'/>'+option['value']+'&nbsp;';

                if(is_new)
                {
                    var arr = new Object();
                    arr['name'] = option['name'];
                    arr['plugins'] = attr_arr_all['plugins'];
                    arr['fieldname'] = attr_arr_all['fieldname'] + option['fieldname'];
                    arr['fieldflow'] = attr_arr_all['fieldflow'];
                    add_fields[option['name']] = arr;
                }

            });
            attr_arr_all['content'] += '</span>';

            //parse
            template = template.replace(plugin,attr_arr_all['content']);
            template_parse = template_parse.replace(plugin,'{'+name+'}');
            template_parse = template_parse.replace('{|-','');
            template_parse = template_parse.replace('-|}','');
            template_data[pno] = attr_arr_all;
            checkboxs++;

        }else if(name)
        {
            if(tag =='radios') /*单选组  一个字段*/
            {
                plugin = p0;
                plugin = plugin.replace('|-','');
                plugin = plugin.replace('-|','');
                attr_arr_all['value'] = '';
                attr_arr_all['content'] = '<span plugins="radios" name="'+attr_arr_all['name']+'" title="'+attr_arr_all['title']+'">';
                var dot='';
                p5.replace(preg_group, function(parse_group) {
                    var option = new Object();
                    parse_group.replace(preg_attr, function(str0,k,val) {
                        if(k=='value')
                        {
                            attr_arr_all['value'] += dot + val;
                            dot = ',';
                        }
                        option[k] = val;
                    });
                    option['name'] = attr_arr_all['name'];
                    if(!attr_arr_all['options']) attr_arr_all['options'] = new Array();
                    attr_arr_all['options'].push(option);
                    if(!option['checked']) option['checked'] = '';
                    var checked = option['checked'] ? 'checked="checked"' : '';
                    attr_arr_all['content'] +='<input type="radio" name="'+attr_arr_all['name']+'" value="'+option['value']+'"  '+checked+'/>'+option['value']+'&nbsp;';

                });
                attr_arr_all['content'] += '</span>';

            }else
            {
                attr_arr_all['content'] = is_new ? plugin.replace(/NEWFIELD/,name) : plugin;
            }
            //attr_arr_all['itemid'] = fields;
            //attr_arr_all['tag'] = tag;
            template = template.replace(plugin,attr_arr_all['content']);
            template_parse = template_parse.replace(plugin,'{'+name+'}');
            template_parse = template_parse.replace('{|-','');
            template_parse = template_parse.replace('-|}','');
            if(is_new)
            {
                var arr = new Object();
                arr['name'] = name;
                arr['plugins'] = attr_arr_all['plugins'];
                arr['title'] = attr_arr_all['title'];
                arr['orgtype'] = attr_arr_all['orgtype'];
                arr['fieldname'] = attr_arr_all['fieldname'];
                arr['fieldflow'] = attr_arr_all['fieldflow'];
                add_fields[arr['name']] = arr;
            }
            template_data[pno] = attr_arr_all;


        }
        pno++;
    })
    var view = template.replace(/{\|-/g,'');
    view = view.replace(/-\|}/g,'');
    var parse_form = new Object({
        'fields':fields,//总字段数
        'template':template,//完整html
        'parse':view,
        'data':template_data,//控件属性
        'add_fields':add_fields//新增控件
    });
    return JSON.stringify(parse_form);
  //update-end--Author:jg_renjie  Date:20150706 for：更新parse_form，与官网同步
    }</script></body>
		
</html>