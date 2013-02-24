<?php
define('SERVER_URL', 'http://54.251.118.233/hotels');
    switch ($_SERVER['REQUEST_METHOD'])
    {
        case 'GET':
            $hid = $_GET['hid'];
            if(isset($hid))
                getPromotion($hid);
            break;
        case 'POST':
            if(isset($_POST["functionType"]))
            {
                switch ($_POST["functionType"]) {
                    case 'insert':
                        $promotion = $_POST["promotion"];
                        if(isset($promotion))
                            insertNewPromotion($promotion);
                        break;
                    case 'delete':
                        $pid = $_POST["pid"];
                        $hid = $_POST["hid"];
                        if((isset($pid))&&(isset($hid)))
                            deletePromotion($pid,$hid);
                        break;
                    case 'update':
                        $promotion = $_POST["promotion"];
                        if(isset($promotion))
                            updatePromotion($promotion);
                        break;
                    case 'uploadImg':
                        $hid = $_POST["hid"];
                        $pid = $_POST["pid"];
                        $uploaddir = './uploads/';
                        $file = basename($_FILES['userfile']['name']);
                        $uploadfile = $uploaddir . $file;
                        if (move_uploaded_file($_FILES['userfile']['tmp_name'], $uploadfile)) {
                            $imgFile= SERVER_URL."/uploads/{$file}";
                            updateImage ($hid,$uid,$imgFile);
                        }
                        break;
                    default:
                        break;
                }
            }
            break;
    }
    
    function getPromotion($hid){
        include_once("includes/connection.php");
        $query = sprintf("SELECT * FROM `promotion` WHERE hid = '%s'",
                         mysql_real_escape_string($hid));
        $result = mysql_query($query);
        if (!$result) {
            showError('system error');
        }else if(mysql_num_rows($result) <= 0){
            showError('no such promotion');
        }else{
            while ($row=mysql_fetch_assoc($result))
                $success_message[] = $row;
            showSuccess($success_message);
        }
    }
    function insertNewPromotion($promotion){
        include_once("includes/connection.php");
        $hid = $promotion["hid"];
        $title = $promotion["title"];
        $content = $promotion["content"];
        $startTime = $promotion["startTime"];
        $endTime = $promotion["endTime"];
        $categoryName = $promotion["categoryName"];
        $maxBook = $promotion["maxBook"];
        $query = sprintf("INSERT INTO `promotion`(
                         hid,
                         title,
                         content,
                         endTime,
                         startTime,
                         categoryName,
                         maxBook)
        VALUES (
                '%s',
                '%s',
                '%s',
                '%s',
                '%s',
                '%s',
                '%s')",
        mysql_real_escape_string($hid),
        mysql_real_escape_string($title),
        mysql_real_escape_string($content),
        mysql_real_escape_string($startTime),
        mysql_real_escape_string($endTime),
        mysql_real_escape_string($categoryName),
        mysql_real_escape_string($maxBook));
        $result = mysql_query($query);
        if (!$result) {
            showError('system error');
        }else {
            showSuccess(mysql_insert_id());
        }
    }
    function updatePromotion($promotion){
        include_once("includes/connection.php");
        $hid = $promotion["hid"];
        $pid = $promotion["pid"];
        $title = $promotion["title"];
        $content = $promotion["content"];
        $startTime = $promotion["startTime"];
        $endTime = $promotion["endTime"];
        $categoryName = $promotion["categoryName"];
        $maxBook = $promotion["maxBook"];
        $query = sprintf("UPDATE promotion SET
                         title = '%s',
                         content = '%s',
                         startTime = '%s',
                         endTime = '%s',
                         categoryName = '%s',
                         maxBook = '%s'
                         WHERE hid = '%s' AND pid = '%s'",
                         mysql_real_escape_string($title),
                         mysql_real_escape_string($content),
                         mysql_real_escape_string($startTime),
                         mysql_real_escape_string($endTime),
                         mysql_real_escape_string($categoryName),
                         mysql_real_escape_string($maxBook),
                         mysql_real_escape_string($hid),
                         mysql_real_escape_string($pid));
        $result = mysql_query($query);
        if (!$result) {
            showError('system error');
        }else {
            showSuccess('success');
        }
    }
     function updateImg($pid,$hid,$thumbnail){
        include_once("includes/connection.php");
        $query = sprintf("UPDATE promotion SET
                         thumbnail = '%s'
                         WHERE hid = '%s' AND pid = '%s'",
                         mysql_real_escape_string($thumbnail),
                         mysql_real_escape_string($hid),
                         mysql_real_escape_string($pid));
        $result = mysql_query($query);
        if (!$result) {
            showError('system error');
        }else {
            showSuccess('success');
        }
    }
    function deletePromotion($pid,$hid){
        include_once("includes/connection.php");
        $query = sprintf("DELETE * FROM `promotion` WHERE pid = '%s' AND hid='%s'",
                         mysql_real_escape_string($pid),
                         mysql_real_escape_string($hid));
        $result = mysql_query($query);
        if (!$result) {
            showError('system error');
        }else {
            showSuccess('success');
        }
    }
    function showError($error_message){
        header('Content-Type: application/json');
        echo json_encode(Array('response_status'=>'fail','response_message'=>$error_message));
    }
    
    function showSuccess($success_message){
        header('Content-Type: application/json');
        echo json_encode(Array('response_status'=>'succeed','response_message'=>$success_message));
    }
    ?>
