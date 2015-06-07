CKEDITOR.editorConfig = function( config ) {

	config.language = 'zh-cn';
	config.fullPage= true;
	config.allowedContent= true;
	config.skin = 'moonocolor';
	config.font_names = '宋体/宋体;黑体/黑体;仿宋/仿宋_GB2312;楷体/楷体_GB2312;隶书/隶书;幼圆/幼圆;微软雅黑/微软雅黑;'
		+ config.font_names;
	
	config.toolbarGroups = [
        { name: 'document',    groups: [ 'mode', 'document', 'doctools' ] },
        { name: 'clipboard',   groups: [ 'clipboard', 'undo' ] },
        { name: 'insert' },{name:'font'},{ name: 'tools' },
        { name: 'others' },{ name: 'editing',     groups: [ 'find', 'selection' ] },
        { name: 'links' },{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup', 'font'] },
        { name: 'paragraph',   groups: [ 'list', 'indent', 'blocks', 'align' ] },
        { name: 'forms' },{ name: 'styles' },{ name: 'colors' }];
};
