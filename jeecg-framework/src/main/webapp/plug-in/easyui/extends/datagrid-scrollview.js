/***
 * @author jueyue
 * @version1.0
 *虚拟布局，提供大数据量的布局方式，最好的方式是自己提供高度和宽度，默认高度25
 *特别是在有图片的情况下,请指定行高默认25px
 *如果修改高度 rowStyler 指定行高，不然不好对齐
 *一次加载数据多次渲染数据,所以ie下也不存在行数太多而不渲染失败的问题
 */
var scrollview = $.extend({}, $.fn.datagrid.defaults.view, {
	/***
	 * 渲染函数
	 * @param {} target
	 * @param {} container
	 * @param {} frozen
	 */
	render : function(target, container, frozen) {
		var state = $.data(target, 'datagrid');
		var opts = state.options;
		var rows = this.rows || [];
		if (!rows.length) {
			return;
		}
		var fields = $(target).datagrid('getColumnFields', frozen);

		if (frozen) {
			if (!(opts.rownumbers || (opts.frozenColumns && opts.frozenColumns.length))) {
				return;
			}
		}

		var index = this.index;
		var classValue = '';
		var styleValue = '';
		var style = '';
		var table = ['<table class="datagrid-btable" cellspacing="0" cellpadding="0" border="0"><tbody>'];
		for (var i = 0; i < rows.length; i++) {
			var css = opts.rowStyler ? opts.rowStyler.call(target, index,
					rows[i]) : '';
			if (typeof css == 'string') {
				styleValue = css;
			} else if (css) {
				classValue = css['class'] || '';
				styleValue = css['style'] || '';
			}
			var cls = 'class="datagrid-row '
					+ (index % 2 && opts.striped ? 'datagrid-row-alt ' : ' ')
					+ classValue + '"';
					
			if(frozen){
				style = 'style="height:'+opts.rowHeight+'px;"'
			}else{
				style = styleValue ? 'style="' + styleValue + '"' : 'style="height:25px;"';
			}
			var rowId = state.rowIdPrefix + '-' + (frozen ? 1 : 2) + '-'
					+ index;
			table.push('<tr id="' + rowId + '" datagrid-row-index="' + index
					+ '" ' + cls + ' ' + style + '>');
			table.push(this.renderRow.call(this, target, fields, frozen, index,
					rows[i]));
			table.push('</tr>');

			// render the detail row
			if (opts.detailFormatter) {
				table.push('<tr style="display:none;">');
				if (frozen) {
					table.push('<td colspan=' + (fields.length + 2)
							+ ' style="border-right:0">');
				} else {
					table.push('<td colspan=' + (fields.length) + '>');
				}
				table.push('<div class="datagrid-row-detail">');
				if (frozen) {
					table.push('&nbsp;');
				} else {
					table.push(opts.detailFormatter.call(target, i, rows[i]));
				}
				table.push('</div>');
				table.push('</td>');
				table.push('</tr>');
			}
			index++;
		}
		table.push('</tbody></table>');
		$(container).html(table.join(''));
		
	},
	/**
	 * 渲染行,这里个高度都是auto,可以在col里面来做style限制
	 * @param {} target
	 * @param {} fields
	 * @param {} frozen
	 * @param {} rowIndex
	 * @param {} rowData
	 * @return {}
	 */
	renderRow : function(target, fields, frozen, rowIndex, rowData) {
		var opts = $.data(target, 'datagrid').options;

		var cc = [];
		//添加行号
		if (frozen && opts.rownumbers) {
			var rownumber = rowIndex + 1;
			if (opts.pagination) {
				rownumber += (opts.pageNumber - 1) * opts.pageSize;
			}
			cc.push('<td class="datagrid-td-rownumber"><div class="datagrid-cell-rownumber" style="text-align:center">'
							+ rownumber + '</div></td>');
		}
		for (var i = 0; i < fields.length; i++) {
			var field = fields[i];
			var col = $(target).datagrid('getColumnOption', field);
			if (col) {
				var value = rowData[field]; // the field value
				var css = col.styler
						? (col.styler(value, rowData, rowIndex) || '')
						: '';
				var classValue = '';
				var styleValue = '';
				if (typeof css == 'string') {
					styleValue = css;
				} else if (cc) {
					classValue = css['class'] || '';
					styleValue = css['style'] || '';
				}
				var cls = classValue ? 'class="' + classValue + '"' : '';
				var style = col.hidden
						? 'style="display:none;' + styleValue + '"'
						: (styleValue ? 'style="' + styleValue + '"' : '');

				cc.push('<td field="' + field + '" ' + cls + ' ' + style + '>');

				if (col.checkbox) {
					style = 'height:15;';
				} else if (col.expander) {
					style = "text-align:center;height:15;";
				} else {
					style = styleValue;
					if (col.align) {
						style += ';text-align:' + col.align + ';'
					}
					if (!opts.nowrap) {
						style += ';white-space:normal;height:auto;';
					} else if (opts.autoRowHeight) {
						style += ';height:auto;';
					}
				}

				cc.push('<div style="' + style + '" ');
				if (col.checkbox) {
					cc.push('class="datagrid-cell-check');
				} else {
					cc.push('class="datagrid-cell ' + col.cellClass);
				}
				cc.push('">');

				if (col.checkbox) {
					cc.push('<input type="checkbox" name="' + field
							+ '" value="' + (value != undefined ? value : '')
							+ '">');
				} else if (col.expander) {
					cc.push('<span class="datagrid-row-expander datagrid-row-expand" style="display:inline-block;width:25px;height:auto;cursor:pointer;" />');
				} else if (col.formatter) {
					cc.push(col.formatter(value, rowData, rowIndex));
				} else {
					cc.push(value);
				}

				cc.push('</div>');
				cc.push('</td>');
			}
		}
		return cc.join('');
	},

	bindEvents : function(target) {
		var state = $.data(target, 'datagrid');
		var dc = state.dc;
		var opts = state.options;
		var body = dc.body1.add(dc.body2);
		var clickHandler = ($.data(body[0], 'events') || $._data(body[0],
				'events')).click[0].handler;
		body.unbind('click').bind('click', function(e) {
					var tt = $(e.target);
					var tr = tt.closest('tr.datagrid-row');
					if (!tr.length) {
						return
					}
					if (tt.hasClass('datagrid-row-expander')) {
						var rowIndex = parseInt(tr.attr('datagrid-row-index'));
						if (tt.hasClass('datagrid-row-expand')) {
							$(target).datagrid('expandRow', rowIndex);
						} else {
							$(target).datagrid('collapseRow', rowIndex);
						}
						$(target).datagrid('fixRowHeight');

					} else {
						clickHandler(e);
					}
					e.stopPropagation();
				});
	},

	onBeforeRender : function(target) {
		var state = $.data(target, 'datagrid');
		var opts = state.options;
		//这个是用来限制显示行数的
		var dc = state.dc;
		var view = this;
		/**
		 * 设置行高,这个地方需要注意,如果不同行高,比如有图片或者其他的东西,请在rowStyle设置行高
		 * 不然无法计算高度,并且调用rowStyler方法传入职为null这个需要注意下
		 * 解析方法就是下面的,所以请不要添加空格什么的
		 */
		opts.rowHeight = calculateDataGridTrStyleHeight(opts.rowStyler
				? opts.rowStyler.call(null, null, null)
				: '');
		/**
		 * 设置页行数,感觉每次滚动的条数在4行的样子，所以多渲染6行，chrome几乎没有感觉，ieie基本也没有啥感觉,
		 * 这个+10可以自己调整下
		 */
		opts.viewPageSize = Math.floor(dc.body2.height()/opts.rowHeight)+10;
		//这里用来缓存数据
		state.data.cacheRows  = state.data.rows;
		opts.finder.getRow = function(t, p) {
			var index = (typeof p == 'object')
					? p.attr('datagrid-row-index')
					: p;
			var row = $.data(t, 'datagrid').data.rows[index];
			if (!row) {
				var v = $(t).datagrid('options').view;
				row = v.rows[index - v.index];
			}
			return row;
		};

		dc.body1.add(dc.body2).empty();
		this.rows = undefined; // the rows to be rendered
		this.r1 = this.r2 = []; // the first part and last part of rows

		init();
		createHeaderExpander();

		function init() {
			state.onLoadSuccess = opts.onLoadSuccess;
			opts.onLoadSuccess = function() {
			};
			setTimeout(function() {
						dc.body2.unbind('.datagrid').bind('scroll.datagrid',
								function(e) {
									if (state.onLoadSuccess) {
										opts.onLoadSuccess = state.onLoadSuccess; // restore
										state.onLoadSuccess = undefined;
									}
									if (view.scrollTimer) {
										clearTimeout(view.scrollTimer);
									}
									view.scrollTimer = setTimeout(function() {
												scrolling.call(view);
											}, 50);
								});
						dc.body2.triggerHandler('scroll.datagrid');
					}, 0);
		}
		/**
		 * 这里才是重点,监听滚动条的移动
		 * 动态渲染行
		 */
		function scrolling() {
			if (dc.body2.is(':empty')) {
				reload.call(this);
			} else {
				var firstTr = opts.finder.getTr(target, this.index, 'body', 2);
				var lastTr = opts.finder.getTr(target, 0, 'last', 2);
				var headerHeight = dc.view2.children('div.datagrid-header')
						.outerHeight();
				var top = firstTr.position().top - headerHeight;
				var bottom = lastTr.position().top + lastTr.outerHeight()
						- headerHeight;

				if (top > dc.body2.height() || bottom < 0) {
					reload.call(this);
				} else if (top > 0) {
					var page = Math.floor(this.index / opts.viewPageSize);
					this.getRows.call(this, target, page, function(rows) {
								this.r2 = this.r1;
								this.r1 = rows;
								this.index = (page - 1) * opts.viewPageSize;
								this.rows = this.r1.concat(this.r2);
								this.populate.call(this, target);
							});
				} else if (bottom < dc.body2.height()) {
					var page = Math.floor(this.index / opts.viewPageSize) + 2;
					if (this.r2.length) {
						page++;
					}
					this.getRows.call(this, target, page, function(rows) {
								if (!this.r2.length) {
									this.r2 = rows;
								} else {
									this.r1 = this.r2;
									this.r2 = rows;
									this.index += opts.viewPageSize;
								}
								this.rows = this.r1.concat(this.r2);
								this.populate.call(this, target);
							});
				}
			}
			/**
			 * 这里进行数据重载
			 */
			function reload() {
				var top = $(dc.body2).scrollTop();
				var index = Math.floor(top / opts.rowHeight);
				var page = Math.floor(index / opts.viewPageSize) + 1;

				this.getRows.call(this, target, page, function(rows) {
							this.index = (page - 1) * opts.viewPageSize;
							this.rows = rows;
							this.r1 = rows;
							this.r2 = [];
							this.populate.call(this, target);
							dc.body2.triggerHandler('scroll.datagrid');
						});
			}
		}
		function createHeaderExpander() {
			if (!opts.detailFormatter) {
				return
			}

			var t = $(target);
			var hasExpander = false;
			var fields = t.datagrid('getColumnFields', true).concat(t
					.datagrid('getColumnFields'));
			for (var i = 0; i < fields.length; i++) {
				var col = t.datagrid('getColumnOption', fields[i]);
				if (col.expander) {
					hasExpander = true;
					break;
				}
			}
			if (!hasExpander) {
				if (opts.frozenColumns && opts.frozenColumns.length) {
					opts.frozenColumns[0].splice(0, 0, {
								field : '_expander',
								expander : true,
								width : 24,
								resizable : false,
								fixed : true
							});
				} else {
					opts.frozenColumns = [[{
								field : '_expander',
								expander : true,
								width : 24,
								resizable : false,
								fixed : true
							}]];
				}

				var t = dc.view1.children('div.datagrid-header').find('table');
				var td = $('<td rowspan="'
						+ opts.frozenColumns.length
						+ '"><div class="datagrid-header-expander" style="width:24px;"></div></td>');
				if ($('tr', t).length == 0) {
					td.wrap('<tr></tr>').parent().appendTo($('tbody', t));
				} else if (opts.rownumbers) {
					td.insertAfter(t
							.find('td:has(div.datagrid-header-rownumber)'));
				} else {
					td.prependTo(t.find('tr:first'));
				}
			}

			setTimeout(function() {
						view.bindEvents(target);
					}, 0);
		}
	},

	onAfterRender : function(target) {
		$.fn.datagrid.defaults.view.onAfterRender.call(this, target);
		var dc = $.data(target, 'datagrid').dc;
		var footer = dc.footer1.add(dc.footer2);
		footer.find('span.datagrid-row-expander').css('visibility', 'hidden');
	},
	/**
	 * getRows 获取数据的地方
	 * @param {} target
	 * @param {} page
	 * @param {} callback
	 */
	getRows : function(target, page, callback) {
		var state = $.data(target, 'datagrid');
		var opts = state.options;
		var index = (page - 1) * opts.viewPageSize;
		var rows = state.data.cacheRows.slice(index, index + opts.viewPageSize);
		if (rows.length) {
			callback.call(this, rows);
		}
	},

	populate : function(target) {
		var state = $.data(target, 'datagrid');
		var opts = state.options;
		var dc = state.dc;
		var rowHeight = opts.rowHeight;

		if (this.rows.length) {
			opts.view.render.call(opts.view, target, dc.body2, false);
			opts.view.render.call(opts.view, target, dc.body1, true);
			dc.body1.add(dc.body2).children('table.datagrid-btable').css({
				marginTop : this.index * rowHeight,
				marginBottom : state.data.cacheRows.length * rowHeight - this.rows.length
						* rowHeight - this.index * rowHeight
			});
		}
		if (this.rows.length) {

			var r = [];
			for (var i = 0; i < this.index; i++) {
				r.push({});
			}
			state.data.rows = r.concat(this.rows);
			/**
			 * 这里是设置rows的条数，这个因为分页的，所以设置和当前页页相同
			 */
			opts.onLoadSuccess.call(target, {
						total : this.rows.length,
						rows : this.rows
					});
		}
	}
});

$.extend($.fn.datagrid.methods, {	
			fixDetailRowHeight : function(jq, index) {
				return jq.each(function() {
							var opts = $.data(this, 'datagrid').options;
							var dc = $.data(this, 'datagrid').dc;
							var tr1 = opts.finder.getTr(this, index, 'body', 1)
									.next();
							var tr2 = opts.finder.getTr(this, index, 'body', 2)
									.next();
							if (tr2.is(':visible')) {
								tr1.css('height', '');
								tr2.css('height', '');
								var height = Math.max(tr1.height(), tr2
												.height());
								tr1.css('height', height);
								tr2.css('height', height);
							}
							dc.body2.triggerHandler('scroll');
						});
			},
			getExpander : function(jq, index) { // get row expander object
				var opts = $.data(jq[0], 'datagrid').options;
				return opts.finder.getTr(jq[0], index)
						.find('span.datagrid-row-expander');
			},
			// get row detail container
			getRowDetail : function(jq, index) {
				var opts = $.data(jq[0], 'datagrid').options;
				var tr = opts.finder.getTr(jq[0], index, 'body', 2);
				return tr.next().find('div.datagrid-row-detail');
			},
			expandRow : function(jq, index) {
				return jq.each(function() {
							var opts = $(this).datagrid('options');
							var dc = $.data(this, 'datagrid').dc;
							var expander = $(this).datagrid('getExpander',
									index);
							if (expander.hasClass('datagrid-row-expand')) {
								expander.removeClass('datagrid-row-expand')
										.addClass('datagrid-row-collapse');
								var tr1 = opts.finder.getTr(this, index,
										'body', 1).next();
								var tr2 = opts.finder.getTr(this, index,
										'body', 2).next();
								tr1.show();
								tr2.show();
								$(this).datagrid('fixDetailRowHeight', index);
								if (opts.onExpandRow) {
									var row = $(this).datagrid('getRows')[index];
									opts.onExpandRow.call(this, index, row);
								}
							}
						});
			},
			collapseRow : function(jq, index) {
				return jq.each(function() {
							var opts = $(this).datagrid('options');
							var dc = $.data(this, 'datagrid').dc;
							var expander = $(this).datagrid('getExpander',
									index);
							if (expander.hasClass('datagrid-row-collapse')) {
								expander.removeClass('datagrid-row-collapse')
										.addClass('datagrid-row-expand');
								var tr1 = opts.finder.getTr(this, index,
										'body', 1).next();
								var tr2 = opts.finder.getTr(this, index,
										'body', 2).next();
								tr1.hide();
								tr2.hide();
								dc.body2.triggerHandler('scroll');
								if (opts.onCollapseRow) {
									var row = $(this).datagrid('getRows')[index];
									opts.onCollapseRow.call(this, index, row);
								}
							}
						});
			}
		});
function calculateDataGridTrStyleHeight(css) {
	var styleValue;
	if (typeof css == 'string') {
		styleValue = css;
	} else if (css) {
		classValue = css['class'] || '';
		styleValue = css['style'] || '';
	}

	if (styleValue && styleValue.indexOf("height") > -1) {
		var index = styleValue.indexOf("height") + 7;
		styleValue = styleValue.substr(index);
		return styleValue.substring(0, styleValue.indexOf(";"))
				.replace("px", '');
	}
	return 25;

}