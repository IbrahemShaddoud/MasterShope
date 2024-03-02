<?php
include "connect.php";
    

    $userid =$_POST['userid'];
    $productid =$_POST['productid'];
    $price =$_POST['price'];
    
    $stmtcheck =$con->prepare("SELECT * FROM cart WHERE (productid =? AND userid=?)");
    $stmtcheck->execute(array($productid,$userid)) ;
    $row1 = $stmtcheck->rowcount();

    if ($row1 >0){
        $stmt1 =$con->prepare("UPDATE cart SET  count=count+1
        WHERE (productid=? AND userid=?)");
        $stmt1->execute(array($productid,$userid)) ;
        $row = $stmt1->rowcount();

        }else{
            $stmt =$con->prepare("INSERT INTO cart(userid,productid,price)
        VALUES (?,?,?)");
        $stmt->execute(array($userid,$productid,$price)) ;
        $row = $stmt->rowcount();
        
        }
    

    



?>


    