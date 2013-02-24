<?php
define('SERVER_URL', 'http://54.251.118.233/hotels');
    switch ($_SERVER['REQUEST_METHOD'])
    {
        case 'GET':
            $email = $_GET["email"];
            $password = $_GET["password"];
            $uid = $_GET["uid"];
            if((isset($email))&&(isset($password)))
                getUser($email,$password);
            else if (isset($uid)){
                getUserbyUid($uid);
            }
            break;
        case 'POST':
            if(isset($_POST["functionType"]))
            {
                switch ($_POST["functionType"]) {
                    case 'insert':
                        $user = $_POST["user"];
                        if(isset($user))
                            insertNewUser($user);
                        break;
                    case 'update':
                        $user = $_POST["user"];
                        if(isset($user))
                            updateUser($user);
                        break;
                    default:
                        break;
                }
            }
            break;
    }
    
    function getUser($email,$password){
        include_once("includes/connection.php");
        $query = sprintf("SELECT * FROM `u8ser` WHERE email = '%s' AND password = '%s'",
                         mysql_real_escape_string($email),
                         mysql_real_escape_string(md5($password))
                         );
        $result = mysql_query($query);
        if (!$result) {
            showError('system error');
        }else if(mysql_num_rows($result) <= 0){
            showError('no such user');
        }else{
            $row=mysql_fetch_assoc($result);
            showSuccess($row);
        }
    }
    function insertUser($user){
        include_once("includes/connection.php");
        $email = $user["email"];
        $password = md5($user ["password"]);
        $fname = $user["fname"];
        $lname = $user["lname"];
        $gender = $user["gender"];
        $title = $user["title"];
        $hid = $user["hid"];
        $query = sprintf("INSERT INTO `user`(
                         email,
                         password,
                         fname,
                         lname,
                         gender,
                         title,
                         hid)
        VALUES (
                '%s',
                '%s',
                '%s',
                '%s',
                '%s',
                '%s',
                '%s')",
        mysql_real_escape_string($email),
        mysql_real_escape_string($password),
        mysql_real_escape_string($fname),
        mysql_real_escape_string($lname),
        mysql_real_escape_string($gender),
        mysql_real_escape_string($title),
        mysql_real_escape_string($hid));
        $result = mysql_query($query);
        if (!$result) {
            showError('system error');
        }else {
            showSuccess(mysql_insert_id());
        }
    }
    function updateUser($user){
       /* include_once("includes/connection.php");
        $hid = $promotion["hid"];
        $pid = $promotion["pid"];
        $title = $promotion["title"];
        $content = $promotion["content"];
        $startTime = $promotion["startTime"];
        $endTime = $promotion["endTime"];
        $thumbnail = $promotion["thumbnail"];
        $categoryName = $promotion["categoryName"];
        $maxBook = $promotion["maxBook"];
        $query = sprintf("UPDATE promotion SET
                         title = '%s',
                         content = '%s',
                         startTime = '%s',
                         endTime = '%s',
                         thumbnail = '%s',
                         categoryName = '%s',
                         maxBook = '%s'
                         WHERE hid = '%s' AND pid = '%s'",
                         mysql_real_escape_string($title),
                         mysql_real_escape_string($content),
                         mysql_real_escape_string($startTime),
                         mysql_real_escape_string($endTime),
                         mysql_real_escape_string($thumbnail),
                         mysql_real_escape_string($categoryName),
                         mysql_real_escape_string($maxBook),
                         mysql_real_escape_string($hid),
                         mysql_real_escape_string($pid));
        $result = mysql_query($query);
        if (!$result) {
            showError('system error');
        }else {
            showSuccess('success');
        }*/
    }
    function getUserbyUid($uid){
     include_once("includes/connection.php");
        $query = sprintf("SELECT * FROM `user` WHERE uid = '%s'",
                         mysql_real_escape_string($uid)
                         );
        $result = mysql_query($query);
        if (!$result) {
            showError('system error');
        }else if(mysql_num_rows($result) <= 0){
            showError('no such user');
        }else{
            $row=mysql_fetch_assoc($result);
            showSuccess($row);
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
