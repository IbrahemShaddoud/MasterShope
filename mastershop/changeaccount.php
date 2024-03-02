<?php
include "connect.php";


    $firstname =filter_var($_POST['firstname'],FILTER_SANITIZE_STRING);
    $lastname =filter_var($_POST['lastname'],FILTER_SANITIZE_STRING);
    $email =filter_var($_POST['email'],FILTER_SANITIZE_STRING);
    $mobile =filter_var($_POST['mobile'],FILTER_SANITIZE_STRING);
    $password  =$_POST['password'];


    $stmtcheck =$con->prepare("SELECT * FROM user WHERE email =?");
    $stmtcheck->execute(array($email)) ;
    $row = $stmtcheck->rowcount();


    if ($row >0){
        $stmt =$con->prepare("UPDATE user SET firstname=?,lastname=?,mobile=?,password=?
        WHERE email=?");
        $stmt->execute(array($firstname,$lastname,$mobile,$password,$email)) ;
        $row = $stmt->rowcount();
        if($row > 0){
        echo json_encode( array('firstname' => $firstname, 'lastname' => $lastname,
             'email'=> $email,'mobile'=>$mobile,'password' =>  $password,'status'=>"success"));
                    
        }
       
       
    }else{
         echo json_encode( array('status'=>"email already found"));

    }



?>
