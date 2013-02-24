<?php
define('SERVER_URL', 'http://54.251.118.233/hotels');
    switch ($_SERVER['REQUEST_METHOD'])
    {
        case 'GET':
            $hid = $_GET['hid'];
            $uid = $_GET['uid'];
            $bid = $_GET['bid'];
            if((isset($hid))&(isset($uid)))
                getMyBooking($hid,$uid);
            else if(isset($bid))
                getBooking($bid);
            break;
        case 'POST':
            if(isset($_POST["functionType"]))
            {
                switch ($_POST["functionType"]) {
                    case 'insert':
                        $booking = $_POST["booking"];
                        if(isset($booking))
                            insertNewBooking($booking);
                        break;
                    case 'delete':
                        $bid = $_POST["bid"];
                        if(isset($bid))
                            deleteBooking($bid);
                        break;
                    case 'update':
                        $booking = $_POST["booking"];
                        if(isset($booking))
                            updateBooking($booking);
                        break;
                    default:
                        break;
                }
            }
            break;
    }
    
    function getMyBooking($hid,$uid){
        include_once("includes/connection.php");
        $query = sprintf("SELECT * FROM `booking` WHERE hid = '%s' AND uid = '%s'",
                         mysql_real_escape_string($hid),
                         mysql_real_escape_string($uid));
        $result = mysql_query($query);
        if (!$result) {
            showError('system error');
        }else if(mysql_num_rows($result) <= 0){
            showError('no such booking');
        }else{
            while ($row=mysql_fetch_assoc($result))
                $success_message[] = $row;
            showSuccess($success_message);
        }
    }
     function getBooking($bid){
        include_once("includes/connection.php");
        $query = sprintf("SELECT * FROM `booking` WHERE bid = '%s'",
                         mysql_real_escape_string($bid));
        $result = mysql_query($query);
        if (!$result) {
            showError('system error');
        }else if(mysql_num_rows($result) <= 0){
            showError('no such booking');
        }else{
            while ($row=mysql_fetch_assoc($result))
                $success_message[] = $row;
            showSuccess($success_message);
        }
    }
    function insertBooking($booking){
        include_once("includes/connection.php");
        $hid = $booking["hid"];
        $pid = $booking["pid"];
        $uid= $booking["uid"];
        $status = $booking["status"];
        $startDate = $booking["startDate"];
        $endDate= $booking["endDate"];
        $confirmationNum= md5(time());
        $query = sprintf("INSERT INTO `booking`(
                         hid,
                         pid,
                         uid,
                         status,
                         startDate,
                         endDate,
                         confirmationNum
                         )
        VALUES (
                '%s',
                '%s',
                '%s',
                '%s',
                '%s',
                '%s',
                '%s')",
        mysql_real_escape_string($hid),
        mysql_real_escape_string($pid),
        mysql_real_escape_string($uid),
        mysql_real_escape_string($status),
        mysql_real_escape_string($startDate),
        mysql_real_escape_string($endDate),
        mysql_real_escape_string($confirmationNum));
        $result = mysql_query($query);
        if (!$result) {
            showError('system error');
        }else {
            showSuccess(mysql_insert_id());
        }
    }
    function updateBooking($booking){
        include_once("includes/connection.php");
        $bid = $booking["bid"];
        $status = $promotion["status"];
        $query = sprintf("UPDATE booking SET
                         status = '%s'
                         WHERE bid = '%s'",
                         mysql_real_escape_string($status),
                         mysql_real_escape_string($bid));
        $result = mysql_query($query);
        if (!$result) {
            showError('system error');
        }else {
            showSuccess('success');
        }
    }
    function deleteBooking($bid){
        include_once("includes/connection.php");
        $query = sprintf("DELETE * FROM `booking` WHERE bid = '%s'",
                         mysql_real_escape_string($bid));
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
