<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<script type="text/javascript">
	function getdemo(id) {
		if(id==''){
			$('#demo').html("");
			return;
		}
		var pro=window.top.$.messager;
		if(pro){
			window.top.$.messager.progress({
				text : '正在加载数据....',
				interval : 300
			});
		}

		var url = "demoController.do?getDemo&id=" + encodeURIComponent(encodeURIComponent(id));

		$.ajax({
			type : 'POST',
			url : url,
			success : function(data) {
				var d = $.parseJSON(data);
				if (d.success) {
					if(pro)
						window.top.$.messager.progress('close');
					$('#demo').html(d.msg);
// 					<!--update-begin--Author:huangzq  Date:20151127 for：三级联调 -->
					if(id=="ThreeLevelLinkage"){
						init_select();
					}
// 					<!--update-end--Author:huangzq  Date:20151127 for：三级联调 -->
				}
			}
		});
	}
</script>
<t:formvalid layout="table" dialog="false" formid="formobj">
	<table class="formtable" cellpadding="0" cellspacing="1">
		<tr>
			<td width="10%" height="50" align="right"><span class="filedzt">下拉框AJAX联动：</span></td>
			<td width="90%" class="value" colspan="3"><select style="width: 150px" name="proname" id="proname" onchange="getdemo(this.value);">
				<option value="">--- 请选择菜单 ---</option>
				<option value="ThreeLevelLinkage"><t:mutiLang langKey="三级联动"/></option>
				<c:forEach var="fun" items="${funList}" varStatus="status">
					<option value="${fun.id }"><t:mutiLang langKey="${fun.functionName}"/></option>
				</c:forEach>
			</select></td>
		</tr>
		<tr>
			<td height="50" align="right"><span class="filedzt">菜单项目：</span></td>
			<td class="value" colspan="3" nowrap><SPAN id="demo"></SPAN></td>
		</tr>
	</table>
</t:formvalid>
<!--update-begin--Author:huangzq  Date:20151127 for：三级联调 -->
<script type="text/javascript">
	var province_city_county_data=[ 	
	{
	    province:"江西",
	    city:[
	        {
	            cityName:"上饶",
	            county:["市辖区","信州区","上饶县","广丰县","玉山县","铅山县","横峰县","弋阳县","余干县","鄱阳县","万年县","婺源县","德兴市"]
	        },
	        {
	            cityName:"南昌",
	            county:["市辖区","东湖区","西湖区","青云谱区","湾里区","青山湖区","南昌县","新建县","安义县","进贤县"]
	        }
	    ]
	},
	
	{
	    province:"四川",
	    city:[
	        {
	            cityName:"成都",
	            county:["成都市","崇州市","金堂县"]
	        },
	        {
	            cityName:"南充",
	            county:["仪陇县","南部县","营山县"]
	        }
	    ]
	},
	{
	    province:"北京",
	    city:[
	        {   cityName:"北京市",
	            county:["东城区","朝阳区"]
	        }
	    ]
	
	},
	{
	    province:"安徽",
	    city:[
	        {   cityName:"安庆",
	            county:["安庆市","怀宁县","潜山县"]
	        },
	        {   cityName:"蚌埠",
	            county:["蚌埠市","固镇县","怀远县"]
	        }
	    ]
	
	}
	]
	var opt0 = ["省份","地级市","市、县级市、县"];
	var selectID_arr2=["provinceid","cityid","countyid"];
	var province_index; 
	  //初始化下拉框
    function init_select(){
        init_title();
        init_province();
        bind_province();
//         init_select();
    }
	 //初始化提示标题
	function init_title()
	{
    	for(var k = 0;k<selectID_arr2.length;k++){
            var select_obj= document.getElementById(selectID_arr2[k]);
            select_obj.options[0]=new Option(opt0[k],opt0[k]);
        }
    }
	//初始化省份
    function init_province(){
        var province_select_obj = document.getElementById(selectID_arr2[0]);
        var province_len = province_city_county_data.length;
        for(var i = 0;i<province_len;i++){
            province_select_obj.options[i+1] = new Option(province_city_county_data[i].province,province_city_county_data[i].province);
        }
    }
	// //给省份绑定onchange事件
    function bind_province(){
        var province_select_obj = document.getElementById(selectID_arr2[0]);
        province_select_obj.onchange=function(){
            var opt_index =province_select_obj.selectedIndex;
            if(opt_index!=0){
                province_index = opt_index-1;   //每个省份的序号比 option 的下标要小1
                init_city(province_index);
                bind_city();
                init_county(province_index,0);
            }else{
                clear_city();
                clear_county();
            }
        }
    }
    //选择一个省份才能初始化地级市
    function init_city(index){
        clear_city();
        var city_len = province_city_county_data[index].city.length;
        for(var i = 0;i<city_len;i++){
            document.getElementById(selectID_arr2[1]).options[i+1] = new Option(province_city_county_data[index].city[i].cityName,province_city_county_data[index].city[i].cityName);
        }
        document.getElementById(selectID_arr2[1]).options[1].selected = true;
    }
    //清除地级市信息
    function clear_city(){
        var city_select_obj = document.getElementById(selectID_arr2[1]);
        city_select_obj.options.length=0;  //每次选中一个新的省份 都重新删除地级市的信息
        init_title();      //重新初始化标题
    }
    //给地级市绑定onchange事件
    function bind_city(){
        var city_select_obj = document.getElementById(selectID_arr2[1]);
        city_select_obj.onchange=function(){
            var opt_index =city_select_obj.selectedIndex;
            if(opt_index!=0){
                init_county(province_index,opt_index-1);
            }else{
                clear_county();
            }
        }
    }
    //选择一个地级市后才能初始化县
    function init_county(index,city_index){
        clear_county();
        var county_len = province_city_county_data[index].city[city_index].county.length;
        for(var i = 0;i<county_len;i++){
            document.getElementById(selectID_arr2[2]).options[i+1] = new Option(province_city_county_data[index].city[city_index].county[i],province_city_county_data[index].city[city_index].county[i]);
        }
        document.getElementById(selectID_arr2[2]).options[1].selected = true;
    }
    //清除县城信息
    function clear_county(){
        var county_select_obj = document.getElementById(selectID_arr2[2]);
        county_select_obj.options.length=0;  //每次选中一个新的地级市 都重新删除县的信息
        init_title();      //重新初始化标题
    }
</script>
<!--update-end--Author:huangzq  Date:20151127 for：三级联调 -->