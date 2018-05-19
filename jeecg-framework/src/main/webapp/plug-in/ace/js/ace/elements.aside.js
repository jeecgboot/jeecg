/**
 <b>Content Slider</b>. with custom content and elements based on Bootstrap modals.
*/
(function($ , undefined) {
	var $window = $(window);
	
	function Aside(modal, settings) {
		var $modal = $(modal);
		var placement = 'right', vertical = false;
		var backdrop = '', invisible_backdrop = false;
		
		var options = {}
		options.fixed = settings.fixed || $modal.attr('data-fixed') == 'true';
		options.dark = settings.background || $modal.attr('data-background') == 'true';
		options.offset = settings.offset || $modal.attr('data-offset') == 'true';
		options.no_scroll = !settings.body_scroll || $modal.attr('data-body-scroll') == 'false';
		options.transition = settings.transition !== false && $modal.attr('data-transition') !== 'false';
		options.scroll_style = settings.scroll_style || ((options.dark ? 'scroll-white' : 'scroll-dark') + ' no-track');
		
		var dialog = $modal.find('.modal-dialog');
		var content = $modal.find('.modal-content');
		
		this.initiate = function() {
			modal.className = modal.className.replace(/(\s|^)aside\-(right|top|left|bottom)(\s|$)/ig , '$1$3');

			placement = settings.placement || $modal.attr('data-placement');
			if(placement) placement = $.trim(placement.toLowerCase());
			else placement = 'right';
			
			backdrop = settings.backdrop || $modal.attr('data-backdrop');
		
			if( !(/right|top|left|bottom/.test(placement)) ) placement = 'right';
			$modal.attr('data-placement', placement);
			$modal.addClass('aside-' + placement);
			
			if( /right|left/.test(placement) ) {
				vertical = true;
				$modal.addClass('aside-vc');//vertical
			}
			else $modal.addClass('aside-hz');//horizontal
			
			if( options.fixed ) $modal.addClass('aside-fixed');
			if( options.dark ) $modal.addClass('aside-dark');
			if( options.offset ) $modal.addClass('navbar-offset');
			
			if( !options.transition ) $modal.addClass('transition-off');
			
			$modal.addClass('aside-hidden');

			this.insideContainer();
			
			/////////////////////////////
			
			dialog = $modal.find('.modal-dialog');
			content = $modal.find('.modal-content');
			
			if(options.no_scroll) {
				//don't allow body scroll when modal is open
				$modal.on('mousewheel.aside DOMMouseScroll.aside touchmove.aside pointermove.aside', function(e) {
					if( !$.contains(content[0], e.target) ) {
						e.preventDefault();
						return false;
					}
				})
			}
			
			if( backdrop === false || backdrop === 'false' ) {
				$modal.addClass('no-backdrop');
			}
			else if(backdrop === 'invisible') invisible_backdrop = true;
		}
		
		
		this.show = function() {
			$modal
			.css('position', 'fixed')
			.removeClass('aside-hidden');
		}
		
		this.hide = function() {
			toggleButton();
			
			if(ace.vars['transition'] && !$modal.hasClass('fade')) {
				$modal.one('bsTransitionEnd', function() {
					$modal.addClass('aside-hidden');
					$modal.css('position', '');
				}).emulateTransitionEnd(350);
			}
		}
		
		this.shown = function() {
			toggleButton();
			$('body').removeClass('modal-open').css('padding-right', '');

			if( invisible_backdrop ) {
				try {
					$modal.data('bs.modal').$backdrop.css('opacity', 0);
				} catch(e){}
			}

			var size = !vertical ? dialog.height() : content.height();
			if(!ace.vars['touch']) {
				if(!content.hasClass('ace-scroll')) {
					content.ace_scroll({
							size: size,
							reset: true,
							mouseWheelLock: true,
							lockAnyway: options.no_scroll,
							styleClass: options.scroll_style,
							'observeContent': true,
							'hideOnIdle': !ace.vars['old_ie'],
							'hideDelay': 1500
					})
				}
			}
			else {
				content.addClass('overflow-scroll').css('max-height', size+'px');
			}

			$window
			.off('resize.modal.aside')
			.on('resize.modal.aside', function() {
				if(!ace.vars['touch']) {
				  content.ace_scroll('disable');//to get correct size when going from small window size to large size
					var size = !vertical ? dialog.height() : content.height();
					content
					.ace_scroll('update', {'size': size})
					.ace_scroll('enable')
					.ace_scroll('reset');
				}
				else content.css('max-height', (!vertical ? dialog.height() : content.height())+'px');
			}).triggerHandler('resize.modal.aside');
		}
		
		
		this.hidden = function() {
			$window.off('.aside')
			//$modal.off('.aside')
			//
			if( !ace.vars['transition'] || $modal.hasClass('fade') ) {
				$modal.addClass('aside-hidden');
				$modal.css('position', '');
			}
		}
		
		
		this.insideContainer = function() {
			var container = $('.main-container');

			var dialog = $modal.find('.modal-dialog');
			dialog.css({'right': '', 'left': ''});
			if( container.hasClass('container') ) {
				var flag = false;
				if(vertical == true) {
					dialog.css( placement, parseInt(($window.width() - container.width()) / 2) );
					flag = true;
				}

				//strange firefox issue, not redrawing properly on window resize (zoom in/out)!!!!
				//--- firefix is still having issue!
				if(flag && ace.vars['firefox']) {
					ace.helper.redraw(container[0]);
				}
			}
		}
		
		this.flip = function() {
			var flipSides = {right : 'left', left : 'right', top: 'bottom', bottom: 'top'};
			$modal.removeClass('aside-'+placement).addClass('aside-'+flipSides[placement]);
			placement = flipSides[placement];
		}

		var toggleButton = function() {
			var btn = $modal.find('.aside-trigger');
			if(btn.length == 0) return;
			btn.toggleClass('open');
			
			var icon = btn.find(ace.vars['.icon']);
			if(icon.length == 0) return;
			icon.toggleClass(icon.attr('data-icon1') + " " + icon.attr('data-icon2'));
		}
		

		this.initiate();
		$modal.appendTo('body'); 
	}


	$(document)
	.on('show.bs.modal', '.modal.aside', function(e) {
		$('.aside.in').modal('hide');//??? hide previous open ones?
		$(this).ace_aside('show');
	})
	.on('hide.bs.modal', '.modal.aside', function(e) {
		$(this).ace_aside('hide');
	})
	.on('shown.bs.modal', '.modal.aside', function(e) {
		$(this).ace_aside('shown');
	})
	.on('hidden.bs.modal', '.modal.aside', function(e) {
		$(this).ace_aside('hidden');
	})
	
	

	
	$(window).on('resize.aside_container', function() {
		$('.modal.aside').ace_aside('insideContainer');
	});
	$(document).on('settings.ace.aside', function(e, event_name) {
		if(event_name == 'main_container_fixed') $('.modal.aside').ace_aside('insideContainer');
	});

	$.fn.aceAside = $.fn.ace_aside = function (option, value) {
		var method_call;

		var $set = this.each(function () {
			var $this = $(this);
			var data = $this.data('ace_aside');
			var options = typeof option === 'object' && option;

			if (!data) $this.data('ace_aside', (data = new Aside(this, options)));
			if (typeof option === 'string' && typeof data[option] === 'function') {
				if(value instanceof Array) method_call = data[option].apply(data, value);
				else method_call = data[option](value);
			}
		});

		return (method_call === undefined) ? $set : method_call;
	};
	
	$('.modal.aside').ace_aside();
})(window.jQuery);