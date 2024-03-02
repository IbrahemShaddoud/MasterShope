<?php
include "connect.php";

    $userid =$_POST['userid'];
    $complaint =filter_var($_POST['complaint'],FILTER_SANITIZE_STRING);

    $stmt =$con->prepare("INSERT INTO complaint(userid,complaint)
        VALUES (?,?)");
        $stmt->execute(array($userid,$complaint)) ;
        $row = $stmt->rowcount();
        

    



?>
