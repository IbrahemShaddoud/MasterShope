<?php
include "connect.php";

    $userid =$_POST['userid'];
    $value =$_POST['ratevalue'];
    $review =filter_var($_POST['review'],FILTER_SANITIZE_STRING);

    $stmtcheck =$con->prepare("SELECT * FROM rate WHERE userid =?");
    $stmtcheck->execute(array($userid)) ;
    $row = $stmtcheck->rowcount();


    if ($row >0){
        $stmt =$con->prepare("UPDATE rate SET  ratevalue=?,review=?,userid=?
        WHERE userid=?");
        $stmt->execute(array($value,$review,$userid,$userid)) ;
        $row = $stmt->rowcount();
        
       
    }else{
        $stmt =$con->prepare("INSERT INTO rate(ratevalue,review,userid)
        VALUES (?,?,?)");
        $stmt->execute(array($value,$review,$userid)) ;
        $row = $stmt->rowcount();
        

    }



?>
