$(function() {
	$("#btn_sub").click(function() {
		CKupdate();
	});
});
function CKupdate() {
	for (instance in CKEDITOR.instances) {
		var ins = CKEDITOR.instances[instance];
		ins.setData(ins.getData().replace(new RegExp("\r\n", "g"), ""));
		ins.updateElement();
	}
}