<?php
include "connect.php";

    $userid =$_POST['userid'];
    $productid =$_POST['productid'];
    $newcount = $_POST['newcount'];
    
   
    $stmt =$con->prepare("UPDATE cart SET  count=?
        WHERE userid=? And productid=?");
        $stmt->execute(array($newcount,$userid,$productid)) ;
        $row = $stmt->rowcount();
  
?>


