var detailview = $.extend({}, $.fn.datagrid.defaults.view, { 
    addExpandColumn: function(target, index){ 
        var opts = $.data(target, 'datagrid').options; 
        if (index >= 0){ 
            _add(index); 
            this.resetExpander(target); 
        } else { 
            var length = $(target).datagrid('getRows').length; 
            for(var i=0; i<length; i++){ 
                _add(i); 
            } 
        } 
          
        function _add(rowIndex){ 
            var tr = opts.finder.getTr(target, rowIndex, 'body', 1); 
            var cc = []; 
            cc.push('<td id="td'+rowIndex+'">'); 
            cc.push('<div style="text-align:center;width:16px">'); 
            cc.push('<div class="datagrid-row-expander datagrid-row-expand" row-index=' + rowIndex + ' style="cursor:pointer;height:14px;" />'); 
            cc.push('</div>'); 
            cc.push('</td>'); 
            if (tr.is(':empty')){ 
                tr.html(cc.join('')); 
            } else if (tr.children('td.datagrid-td-rownumber').length){ 
                $(cc.join('')).insertAfter(tr.children('td.datagrid-td-rownumber')); 
            } else { 
                $(cc.join('')).insertBefore(tr.children('td:first')); 
            } 
            $(target).datagrid('fixRowHeight', rowIndex); 
      if(!detailview.bindExpander(target,rowIndex)){ 
        tr.find('div.datagrid-row-expander').unbind('.datagrid').bind('click.datagrid', function(e){ 
          var rowIndex = $(this).attr('row-index'); 
          if ($(this).hasClass('datagrid-row-expand')){ 
            $(target).datagrid('expandRow', rowIndex); 
          } else { 
            $(target).datagrid('collapseRow', rowIndex); 
          } 
          $(target).datagrid('fixRowHeight'); 
          return false; 
        }); 
      } 
      //tr.children('td.datagrid-td-rownumber').attr('rowspan', 2); 
        } 
    }, 
  
  bindExpander: function(target,rowIndex){ 
    var opts = $.data(target, 'datagrid').options; 
    if(opts.bindExpander!=undefined){ 
      var controlid='#'+opts.bindExpander+rowIndex; 
      var tr = opts.finder.getTr(target, rowIndex, 'body', 1); 
      $(controlid).unbind('click').bind('click', function(){ 
        var trid=tr.find('div.datagrid-row-expander'); 
        if ($(trid).hasClass('datagrid-row-expand')){ 
          $(target).datagrid('expandRow', rowIndex); 
          $(this).linkbutton({ 
              text:'退出', 
              iconCls: 'icon-cancel' 
          }); 
        } else { 
          $(target).datagrid('collapseRow', rowIndex); 
          $(this).linkbutton({ 
              text:'查看', 
              iconCls: 'icon-search' 
          }); 
        } 
      }); 
      return true; 
    } 
    else return false; 
  }, 
  
  showExpander: function(target){ 
    var opts = $.data(target, 'datagrid').options; 
    if(!opts.showExpander){ 
      opts.finder.getTr(target, '', 'allbody', 1).each(function(){ 
        var tr = $(this); 
        var rowIndex = tr.attr('datagrid-row-index'); 
        $('#td'+rowIndex).css('display','none');  
        //$('#td'+rowIndex).css('visibility', 'hidden'); 
      }); 
    } 
  }, 
      
    resetExpander: function(target){ 
        var opts = $.data(target, 'datagrid').options; 
        opts.finder.getTr(target, '', 'allbody', 1).each(function(){ 
            var tr = $(this); 
            var rowIndex = tr.attr('datagrid-row-index'); 
            tr.find('div.datagrid-row-expander').attr('row-index', rowIndex); 
        }); 
    }, 
      
    render: function(target, container, frozen){ 
        var opts = $.data(target, 'datagrid').options; 
        var rows = $.data(target, 'datagrid').data.rows; 
        var fields = $(target).datagrid('getColumnFields', frozen); 
        var table = []; 
        for(var i=0; i<rows.length; i++) { 
            table.push('<table cellspacing="0" cellpadding="0" border="0"><tbody>'); 
              
            // get the class and style attributes for this row 
            var cls = (i % 2 && opts.striped) ? 'class="datagrid-row datagrid-row-alt"' : 'class="datagrid-row"'; 
            var styleValue = opts.rowStyler ? opts.rowStyler.call(target, i, rows[i]) : ''; 
            var style = styleValue ? 'style="' + styleValue + '"' : ''; 
              
            table.push('<tr datagrid-row-index="' + i + '" ' + cls + ' ' + style + '>'); 
            table.push(this.renderRow.call(this, target, fields, frozen, i, rows[i])); 
            table.push('</tr>'); 
              
            table.push('<tr style="display:none;">'); 
            if (frozen){ 
                table.push('<td colspan=' + (fields.length+2) + ' style="border-right:0">'); 
            } else { 
                table.push('<td colspan=' + (fields.length) + '>'); 
            } 
            table.push('<div class="datagrid-row-detail">'); 
            if (frozen){ 
                table.push('&nbsp;'); 
            } else { 
                table.push(opts.detailFormatter.call(target, i, rows[i])); 
            } 
            table.push('</div>'); 
            table.push('</td>'); 
            table.push('</tr>'); 
              
            table.push('</tbody></table>'); 
        } 
          
        $(container).html(table.join('')); 
    }, 
      
    insertRow: function(target, index, row){ 
        var opts = $.data(target, 'datagrid').options; 
        var dc = $.data(target, 'datagrid').dc; 
        var panel = $(target).datagrid('getPanel'); 
        var view1 = dc.view1; 
        var view2 = dc.view2; 
          
        var isAppend = false; 
        var rowLength = $(target).datagrid('getRows').length; 
        if (rowLength == 0){ 
            $(target).datagrid('loadData',{total:1,rows:[row]}); 
            return; 
        } 
          
        if (index == undefined || index == null || index > rowLength) { 
            index = rowLength; 
            isAppend = true; 
            this.canUpdateDetail = false; 
        } 
          
        $.fn.datagrid.defaults.view.insertRow.call(this, target, index, row); 
          
        _insert(true); 
        _insert(false); 
          
        this.addExpandColumn(target, index); 
        this.canUpdateDetail = true; 
          
        function _insert(frozen){ 
            var v = frozen ? view1 : view2; 
            var tr = v.find('tr[datagrid-row-index='+index+']'); 
            var table = tr.parents('table:first'); 
              
            var newTable = $('<table cellspacing="0" cellpadding="0" border="0"><tbody></tbody></table>'); 
            if (isAppend){ 
                newTable.insertAfter(table); 
                var newDetail = tr.next().clone(); 
            } else { 
                newTable.insertBefore(table); 
                var newDetail = tr.next().next().clone(); 
            } 
            tr.appendTo(newTable.children('tbody')); 
            newDetail.insertAfter(tr); 
            newDetail.hide(); 
            if (!frozen){ 
                newDetail.find('div.datagrid-row-detail').html(opts.detailFormatter.call(target, index, row)); 
            } 
        } 
    }, 
      
    deleteRow: function(target, index){ 
        var opts = $.data(target, 'datagrid').options; 
        var dc = $.data(target, 'datagrid').dc; 
        var tr = opts.finder.getTr(target, index); 
        tr.parent().parent().remove(); 
        $.fn.datagrid.defaults.view.deleteRow.call(this, target, index); 
        this.resetExpander(target); 
        dc.body2.triggerHandler('scroll'); 
    }, 
      
    updateRow: function(target, rowIndex, row){ 
        var opts = $.data(target, 'datagrid').options; 
        $.fn.datagrid.defaults.view.updateRow.call(this, target, rowIndex, row); 
          
        // update the detail content 
        if (this.canUpdateDetail){ 
            var row = $(target).datagrid('getRows')[rowIndex]; 
            var detail = $(target).datagrid('getRowDetail', rowIndex); 
            detail.html(opts.detailFormatter.call(target, rowIndex, row)); 
        } 
  
    this.bindExpander(target,rowIndex); 
    }, 
      
      onBeforeRender: function(target){ 
           var opts = $.data(target, 'datagrid').options; 
           opts.showExpander=opts.showExpander==undefined?true:opts.showExpander; 
           if(opts.showExpander){ 
              var dc = $.data(target, 'datagrid').dc; 
              var panel = $(target).datagrid('getPanel'); 
              var t = dc.view1.children('div.datagrid-header').find('table'); 
              if (t.find('div.datagrid-header-expander').length){ 
                 return; 
              } 
              var td = $('<td rowspan="'+opts.frozenColumns.length+'"><div class="datagrid-header-expander" style="width:16px;"></div></td>'); 
              if ($('tr',t).length == 0){ 
                 td.wrap('<tr></tr>').parent().appendTo($('tbody',t)); 
              } else if (opts.rownumbers){ 
                 td.insertAfter(t.find('td:has(div.datagrid-header-rownumber)')); 
              } else { 
                 td.prependTo(t.find('tr:first')); 
              } 
            } 
    }, 
      
    onAfterRender: function(target){ 
        var state = $.data(target, 'datagrid'); 
        var dc = state.dc; 
        var opts = state.options; 
        var panel = $(target).datagrid('getPanel'); 
          
        $.fn.datagrid.defaults.view.onAfterRender.call(this, target); 
          
        if (!state.onResizeColumn){ 
            state.onResizeColumn = opts.onResizeColumn; 
        } 
        if (!state.onResize){ 
            state.onResize = opts.onResize; 
        } 
        function setBodyTableWidth(){ 
            var columnWidths = dc.view2.children('div.datagrid-header').find('table').width(); 
            dc.body2.children('table').width(columnWidths); 
        } 
          
        opts.onResizeColumn = function(field, width){ 
            setBodyTableWidth(); 
            var rowCount = $(target).datagrid('getRows').length; 
            for(var i=0; i<rowCount; i++){ 
                $(target).datagrid('fixDetailRowHeight', i); 
            } 
              
            // call the old event code 
            state.onResizeColumn.call(target, field, width); 
        }; 
        opts.onResize = function(width, height){ 
            setBodyTableWidth(); 
            state.onResize.call(panel, width, height); 
        }; 
          
        this.addExpandColumn(target); 
        this.canUpdateDetail = true;    // define if to update the detail content when 'updateRow' method is called; 
    this.showExpander(target); 
          
        dc.footer1.find('div.datagrid-row-expander').css('visibility', 'hidden'); 
        $(target).datagrid('resize'); 
    } 
}); 
  
$.extend($.fn.datagrid.methods, { 
    fixDetailRowHeight: function(jq, index){ 
        return jq.each(function(){ 
            var opts = $.data(this, 'datagrid').options; 
            var dc = $.data(this, 'datagrid').dc; 
            var tr1 = opts.finder.getTr(this, index, 'body', 1).next(); 
            var tr2 = opts.finder.getTr(this, index, 'body', 2).next(); 
            // fix the detail row height 
            if (tr2.is(':visible')){ 
                tr1.css('height', ''); 
                tr2.css('height', ''); 
                var height = Math.max(tr1.height(), tr2.height()); 
                tr1.css('height', height); 
                tr2.css('height', height); 
            } 
            dc.body2.triggerHandler('scroll'); 
        }); 
    }, 
    // get row detail container 
    getRowDetail: function(jq, index){ 
        var opts = $.data(jq[0], 'datagrid').options; 
        var tr = opts.finder.getTr(jq[0], index, 'body', 2); 
        return tr.next().find('div.datagrid-row-detail'); 
    }, 
    expandRow: function(jq, index){ 
        return jq.each(function(){ 
            var opts = $(this).datagrid('options'); 
            var dc = $.data(this, 'datagrid').dc; 
            var expander = dc.body1.find('div.datagrid-row-expander[row-index='+index+']'); 
            if (expander.hasClass('datagrid-row-expand')){ 
                expander.removeClass('datagrid-row-expand').addClass('datagrid-row-collapse'); 
                var tr1 = opts.finder.getTr(this, index, 'body', 1).next(); 
                var tr2 = opts.finder.getTr(this, index, 'body', 2).next(); 
                tr1.show(); 
                tr2.show(); 
                $(this).datagrid('fixDetailRowHeight', index); 
                if (opts.onExpandRow){ 
                    var row = $(this).datagrid('getRows')[index]; 
                    opts.onExpandRow.call(this, index, row); 
                } 
            } 
        }); 
    }, 
    collapseRow: function(jq, index){ 
        return jq.each(function(){ 
            var opts = $(this).datagrid('options'); 
            var dc = $.data(this, 'datagrid').dc; 
            var expander = dc.body1.find('div.datagrid-row-expander[row-index='+index+']'); 
            if (expander.hasClass('datagrid-row-collapse')){ 
                expander.removeClass('datagrid-row-collapse').addClass('datagrid-row-expand'); 
                var tr1 = opts.finder.getTr(this, index, 'body', 1).next(); 
                var tr2 = opts.finder.getTr(this, index, 'body', 2).next(); 
                tr1.hide(); 
                tr2.hide(); 
                dc.body2.triggerHandler('scroll'); 
                if (opts.onCollapseRow){ 
                    var row = $(this).datagrid('getRows')[index]; 
                    opts.onCollapseRow.call(this, index, row); 
                } 
            } 
        }); 
    } 
});