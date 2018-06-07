/**
 * 船舶拖动bug 自定义拖动JS
 * @author 86729
 */
$(function() {
	$(document).mousemove(function(e) {
		if (!!this.move) {
			var callback = document.call_down;
			callback.call(this, e);
		}
	}).mouseup(function(e) {
		if (!!this.move) {
			$("div.resize-iframe-shade").each(function() {
				this.parentNode.removeChild(this);
			});
			var callback = document.call_up || function(){};
			callback.call(this, e);
			$.extend(this, {
				'move': false,
				'move_target': null,
				'call_down': false,
				'call_up': false
			});
		}
	});
	var resizeYiframeBorder = $('.resize-y-iframe > .resize-y-border');
	if(!resizeYiframeBorder || resizeYiframeBorder.length<=0){
		$('.resize-y-iframe').append("<div class='resize-y-border'></div>");
	}
	var $box = $('.resize-y-iframe').mousedown(function(e) {
	    var offset = $(this).offset();
	    this.posix = {'y': e.pageY - offset.top};
		console.log("box mousedown:"+e.pageY +"--"+ offset.top);
	    $.extend(document, {'move': true, 'move_target': this});
	}).on('mousedown', '.resize-y-border', function(e) {
		$box.append("<div class='resize-iframe-shade'></div>");
		//$box.find("iframe").css({position:"relative","z-index":-2});
	    var posix = {
	            'w': $box.width(), 
	            'h': $box.height(), 
	            'x': e.pageX, 
	            'y': e.pageY
	        };
	    $.extend(document, {'move': true, 'call_down': function(e) {
	        $box.css({
	            'height': Math.max(30, e.pageY - posix.y + posix.h)
	        });
	    }});
	    return false;
	});
});