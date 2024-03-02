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
        echo json_encode( array('status'=>"email already found"));
       
    }else{
        $stmt =$con->prepare("INSERT INTO user(firstname,lastname,email,mobile,password)
        VALUES (?,?,?,?,?)");
        $stmt->execute(array($firstname,$lastname,$email, $mobile,$password)) ;
        $row = $stmt->rowcount();
        if($row > 0){
        echo json_encode( array('firstname' => $firstname, 'lastname' => $lastname,
             'email'=> $email,'mobile'=>$mobile,'password' =>  $password,'status'=>"success"));
                    
        }

    }



?>
