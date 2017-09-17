//update-begin--Author:zhangjiaqiang  Date:20160906 for：【插件demo】一对多，明细行间距太大
$(function(){
	
	$demo = $("#dailogForm").Validform();
	$demo.config({
		tiptype:function(msg,o,cssctl){
			if(o.type == 3){//验证失败的时候弹出框当中显示相关的信息
				alert(msg);
			}
		}
	})
	
	<#list subEntityList as sub>
	
		$("#${sub.paramData.lowerName}_add").click(function(){
			var tr = $("#add_${sub.paramData.lowerName}_template tr").clone();
			$("#${sub.paramData.lowerName}_table tbody").append(tr);
			resetTrNum('${sub.paramData.lowerName}_table');
		});
		$("#${sub.paramData.lowerName}_del").click(function(){
			$("#${sub.paramData.lowerName}_table").find("input:checked").parent().parent().remove();   
	        resetTrNum('${sub.paramData.lowerName}_table'); 
	        return false;
		});
	</#list>
	
});




//初始化下标
function resetTrNum(tableId) {
	$tbody = $("#"+tableId+" tbody");
	$tbody.find('>tr').each(function(i){
		$(':input, select,button,a', this).each(function(){
			var $this = $(this), name = $this.attr('name'),id=$this.attr('id'),onclick_str=$this.attr('onclick'), val = $this.val();
			if(name!=null){
				if (name.indexOf("#index#") >= 0){
					$this.attr("name",name.replace('#index#',i));
				}else{
					var s = name.indexOf("[");
					var e = name.indexOf("]");
					var new_name = name.substring(s+1,e);
					$this.attr("name",name.replace(new_name,i));
				}
			}
			if(id!=null){
				if (id.indexOf("#index#") >= 0){
					$this.attr("id",id.replace('#index#',i));
				}else{
					var s = id.indexOf("[");
					var e = id.indexOf("]");
					var new_id = id.substring(s+1,e);
					$this.attr("id",id.replace(new_id,i));
				}
			}
			if(onclick_str!=null){
				if (onclick_str.indexOf("#index#") >= 0){
					$this.attr("onclick",onclick_str.replace(/#index#/g,i));
				}else{
				}
			}
		});
		$(this).find('div[name=\'xh\']').html(i+1);
	});
}

//update-end--Author:zhangjiaqiang  Date:20160906 for：【插件demo】一对多，明细行间距太大

$("#dailogForm").Validform({
	datatype:{
		idcard:function(gets,obj,curform,regxp){
			var code = gets; 	
			var city={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江 ",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北 ",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏 ",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外 "};
	            var tip = "";
	            var pass= true;
	            
	            if(!code || !/^\d{6}(18|19|20)?\d{2}(0[1-9]|1[12])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i.test(code)){
	                tip = "身份证号格式错误";
	                pass = false;
	            }
	            
	           else if(!city[code.substr(0,2)]){
	                tip = "地址编码错误";
	                pass = false;
	            }
	            else{
	                //18位身份证需要验证最后一位校验位
	                if(code.length == 18){
	                    code = code.split('');
	                    //∑(ai×Wi)(mod 11)
	                    //加权因子
	                    var factor = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ];
	                    //校验位
	                    var parity = [ 1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2 ];
	                    var sum = 0;
	                    var ai = 0;
	                    var wi = 0;
	                    for (var i = 0; i < 17; i++)
	                    {
	                        ai = code[i];
	                        wi = factor[i];
	                        sum += ai * wi;
	                    }
	                    var last = parity[sum % 11];
	                    if(parity[sum % 11] != code[17]){
	                        tip = "校验位错误";
	                        pass =false;
	                    }
	                }
	            }
	            return pass;
		}
	}
});