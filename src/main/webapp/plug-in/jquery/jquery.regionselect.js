/**
 *省市区下拉框
 */
// url:'',actionurl:"jeecgAdvanceCmptController.do?regionSelect",
(function($) {
    $.fn.regionselect = function(argoptions) {
    	var argdefault={
 			   pid:"1",
 			   proname:'province',
 			   cityname:'city',
 			   areaname:'area',
 			   proid:'province',
 			   cityid:'city',
 			   areaid:'area',
 			   proval:'',
 			   cityval:'',
 			   areaval:'',
 			   level:3
    	};
    	var ajaxmethod=function(url,pid,selectionclass){
    		param={pid:pid};
			$.get(url,param,function(data){
				var jsonData=JSON.parse(data);
				$.each(jsonData,function(i,value){
					if($('#'+selectionclass).val()==value['name']){
						$("."+selectionclass).append("<option selected='selected' idq='"+value['id']+"' value='"+value['name']+"'>"+value['name']+"</option>");
						$("."+selectionclass).trigger('change');
					}else{
						$("."+selectionclass).append("<option idq='"+value['id']+"' value='"+value['name']+"'>"+value['name']+"</option>");	
					}
				});
			});
    	};
        var options = $.fn.extend({},argdefault,argoptions);
        //options.url=options.basepath+options.actionurl;
        return this.each(function() {
			var oo = $(this);
			//var a=oo.offset();
			var oowidth=oo.css("width");
			//console.info(oowidth);

			oo.after("<select class='form-control "+options.proid+"' name='"+options.proname+"' style='display:inline-block;font-size:12px;line-height:1em;height:26px;width:"+oowidth+"'><option value='' idq=''>--全国--</option></select>");
			oo.css("display","none");
			
			var cityobj=$("#"+options.cityid);
			var citywidth=cityobj.css("width");
			cityobj.after("<select class='form-control "+options.cityid+"' name='"+options.cityname+"' style='display:inline-block;font-size:12px;line-height:1em;height:26px;width:"+citywidth+"'></select>");
			cityobj.css("display","none");
			
			var areaobj=$("#"+options.areaid);
			var areawidth=areaobj.css("width");
			areaobj.after("<select class='form-control "+options.areaid+"' name='"+options.areaname+"' style='display:inline-block;font-size:12px;line-height:1em;height:26px;width:"+areawidth+"'></select>");
			areaobj.css("display","none");

			ajaxmethod(options['url'],options['pid'],options['proid']);
			
			$("."+options.proid).bind("change",function(){
				var provselected=$("."+options.proid+" option:selected").attr("idq");
				if($("."+options.cityid).length>0){
					$("."+options.cityid).empty();
					$("."+options.cityid).append("<option value=''>-- --</option>");
					ajaxmethod(options['url'],provselected,options['cityid']);
				}
				if($("."+options.areaid).length>0){
					$("."+options.areaid).empty();
				}
			});
			
			$("."+options.cityid).bind("change",function(){
				var cityselected=$("."+options.cityid+" option:selected").attr("idq");
				if($("."+options.areaid).length>0){
					$("."+options.areaid).empty();
					$("."+options.areaid).append("<option value=''>-- --</option>");
					ajaxmethod(options['url'],cityselected,options['areaid']);
				}
				
			});
			
        });
	};
})(jQuery);