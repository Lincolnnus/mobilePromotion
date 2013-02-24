<?php
switch ($_SERVER['REQUEST_METHOD']) 
{
    case 'GET':
        include_once("includes/connection.php");
        $hid = $_GET['hid'];
        if(isset($hid)){
	    $query = sprintf("SELECT * FROM `hotel` WHERE hid = '%s'",mysql_real_escape_string($hid));
	    $result = mysql_query($query);
	    if (!$result) {
		    $error_message = "system error"; 
	    }else if(mysql_num_rows($result) <= 0){
            $error_message = "no such hotel";
        }else{
            $success_message = mysql_fetch_assoc($result);
	    }
    }
        break;
}
header('Content-Type: application/json');
if (isset($error_message)){
    echo json_encode(Array('response_status'=>'fail','response_message'=>$error_message));
}
if (isset($success_message)){
    echo json_encode(Array('response_status'=>'succeed','response_message'=>$success_message));
}
?>
