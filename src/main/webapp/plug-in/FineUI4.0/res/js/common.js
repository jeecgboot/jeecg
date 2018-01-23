
$(function () {

    // 从Cookie中读取设置参数
    var theme = F.cookie('Theme_JS') || 'pure_green';
    var language = F.cookie('Language_JS') || 'zh_CN';
    var displayMode = F.cookie('MenuMode_JS') || 'normal';
    var loadingImageIndex = parseInt(F.cookie('Loading_JS'), 10) || 0;


    var largeMode = false;
    // 移动端示例启用大字体和动画
    var href = location.href;
    if (location.hash) {
        href = href.substr(0, href.length - location.hash.length);
    }
    if (href.indexOf('/mobile/') > 0) {
        displayMode = 'large';
    }


    // 初始化（添加主题及语言等相关引用）
    F.init({
        language: language,
        theme: theme,
        displayMode: displayMode,
        enableAnimation: true,
        loadingImageIndex: loadingImageIndex,
        addThemeTag: true,      // 是否添加主题的引用标签（实际项目中，请直接在页面中添加主题样式链接）
        addLanguageTag: true    // 是否添加语言的引用标签（实际项目中，请直接在页面中添加语言脚本链接）
    });


});



// 公共方法 - 在顶层窗口弹出通知框
function showNotify(message, messageIcon) {
    F.notify({
        message: message,
        messageIcon: messageIcon,
        target: '_top',
        header: false,
        displayMilliseconds: 3000,
        positionX: 'center',
        positionY: 'top'
    });
}



// 显示居中通知对话框
function showCenterNotify(message, messageIcon) {
    F.notify({
        message: message,
        messageIcon: messageIcon || '',
        modal: true,
        hideOnMaskClick: true,
        header: false,
        displayMilliseconds: 3000,
        positionX: 'center',
        positionY: 'center',
        messageAlign: 'center',
        minWidth: 200
    });
}



// 公共方法 - 通过消息框展示表格选中的行
function notifySelectedRows(gridId, columns) {
    var grid = F(gridId);
    var genderColumn = grid.getColumn('gender');
    var majorColumn = grid.getColumn('major');

    var result = ['<table class="result">'];
    result.push('<tr>');
    if (grid.idField) {
        result.push('<th>ID</th>');
    }
    if (grid.textField) {
        result.push('<th>Text</th>');
    }
    if (genderColumn) {
        result.push('<th>性别</th>');
    }
    if (majorColumn) {
        result.push('<th>专业</th>');
    }

    if (columns && columns.length) {
        $.each(columns, function (index, item) {
            result.push('<th>' + item.text + '</th>');
        });
    }

    result.push('</tr>');

    $.each(grid.getSelectedRows(true), function (index, row) {
        result.push('<tr>');
        if (grid.idField) {
            result.push('<td>' + row.id + '</td>');
        }
        if (grid.textField) {
            result.push('<td>' + row.text + '</td>');
        }
        if (genderColumn) {
            result.push('<td>' + row.values['gender'] + '</td>');
        }
        if (majorColumn) {
            result.push('<td>' + row.values['major'] + '</td>');
        }

        if (columns && columns.length) {
            $.each(columns, function (index, item) {
                var column = grid.getColumn(item.columnId);

                if (column.columnType === 'checkboxfield' && column.editcheckbox) {
                    // 如果是复选框列
                    var cbxIconEl = grid.getCellEl(row, column).find('.f-grid-checkbox');
                    if (cbxIconEl.hasClass('f-checked')) {
                        result.push('<td>true</td>');
                    } else {
                        result.push('<td>false</td>');
                    }
                } else {
                    result.push('<td>' + row.values[item.columnId] + '</td>');
                }

            });
        }

        result.push('</tr>');
    });
    result.push('</table>');

    var content = result.join('');

    // 消息正文可能会比较长，所以不显示前面的图标（messageIcon: ''）
    F.notify({
        message: content,
        target: '_top',
        header: false,
        messageIcon: '',
        displayMilliseconds: 3000,
        positionX: 'center',
        positionY: 'top'
    });
}