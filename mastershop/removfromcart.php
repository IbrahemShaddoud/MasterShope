<?php
include "connect.php";

   $userid =$_POST['userid'];
    $productid =$_POST['productid']; 
    
   

    $stmt =$con->prepare("DELETE FROM cart WHERE (userid=? AND productid=?)");
        $stmt->execute(array($userid,$productid)) ;
        $row = $stmt->rowcount();
  
?>
