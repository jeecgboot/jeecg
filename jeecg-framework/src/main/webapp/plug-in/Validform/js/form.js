/**
 * FORM表单选项卡
 */
$(function() {
	var current 	= 1;
	var stepsWidth	= 0;
    var widths 		= new Array();
	$('#steps .step').each(function(i){
        var jqstep 		= $(this);
		widths[i]  		= stepsWidth;
        stepsWidth	 	+= jqstep.width();
		var jqlink = $('#navigation li:nth-child(' + parseInt(i+1) + ') a');
		var valclass = 'checked';
		$('<span class="'+valclass+'"></span>').insertAfter(jqlink);
    });
	$('#steps').width(stepsWidth);
	$('#navigation').show();
    $('#navigation a').bind('click',function(e){
		var jqthis	= $(this);
		var prev	= current;
		jqthis.closest('ul').find('li').removeClass('selected');
        jqthis.parent().addClass('selected');
		current = jqthis.parent().index() + 1;
        $('#steps').stop().animate({
            marginLeft: '-' + widths[current-1] + 'px'
        },500,function(){
		
		});
        e.preventDefault();
    });
});
