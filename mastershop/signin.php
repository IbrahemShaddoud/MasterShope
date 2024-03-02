<?php
include "connect.php";

    $email =filter_var($_POST['email'],FILTER_SANITIZE_STRING);
    $password  =$_POST['password'];

    $sql ="SELECT * FROM user WHERE email =? AND password = ?";
    $stmt =$con->prepare($sql);
    $stmt->execute(array($email ,$password)) ;

    $user =$stmt->fetch();
    $row = $stmt->rowcount();

    if ($row >0){
        $userid =$user['userid'];
        $firstname =$user['firstname'];
        $lastname =$user['lastname'];
        $email =$user['email'];
        $mobile =$user['mobile'];
        $password =$user['password'];
        
        echo json_encode( array('userid' => $userid , 'firstname' => $firstname, 'lastname' => $lastname,
         'email'=> $email,'mobile'=>$mobile,'password' =>  $password,'status'=>"success"));
    }else{
        echo json_encode( array('status'=>"fail",'password' =>  "dsdf",));
    }
?>
