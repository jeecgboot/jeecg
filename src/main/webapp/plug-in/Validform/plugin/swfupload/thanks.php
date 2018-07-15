<?php
header("Content-Type:text/html; charset=utf-8");

// Check for a degraded file upload, this means SWFUpload did not load and the user used the standard HTML upload
$used_degraded = false;
$resume_id = "";
if (isset($_FILES["resume_degraded"]) && is_uploaded_file($_FILES["resume_degraded"]["tmp_name"]) && $_FILES["resume_degraded"]["error"] == 0) {
    $resume_id = $_FILES["resume_degraded"]["name"];
    $used_degraded = true;
}

// Check for the file id we should have gotten from SWFUpload
if (isset($_POST["hidFileID"]) && $_POST["hidFileID"] != "" ) {
	$resume_id = $_POST["hidFileID"];
}
?>

<?php
//sleep(3);
//表单数据是以POST方式提交过来;

//$name=$_POST["name"];

//注意json数据必须严格按如下格式输出：{"info":"demo info","status":"y"};
//info: 输出提示信息;
//status: 返回提交数据的状态,是否提交成功。"y"表示提交成功，"n"表示提交失败，在callback函数里可以根据该值执行相应的回调操作;

echo '{
		"info":"用户名：'.htmlspecialchars($_POST["name"]).' - 附件：'.htmlspecialchars($_POST["hidFileID"]).'",
		"status":"y"
	 }';

//echo '{"info":"'.$name.'","status":"y"}';
?>