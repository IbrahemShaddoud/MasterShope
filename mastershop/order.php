<?php
include "connect.php";

    $clintid =$_POST['clintid'];
    $orderid =$_POST['orderid'];
    $productid =$_POST['productid'];
    $productcount =$_POST['productcount'];
    $legalname =$_POST['legalname'];
    $number =$_POST['number'];
    $price =$_POST['price'];
    $address =$_POST['address'];
    
    
    
   

    $stmtcheck =$con->prepare("SELECT * FROM order_pay WHERE order_id =?");
    $stmtcheck->execute(array($orderid)) ;
    $row1 = $stmtcheck->rowcount();


    if ($row1 <1){
      $stmt1 =$con->prepare("INSERT INTO order_pay (order_id,userid,legal_name,number,price,address)
      VALUES (?,?,?,?,?,?)");
      $stmt1->execute(array($orderid,$clintid,$legalname,$number,$price,$address)) ;
        $row = $stmt1->rowcount();  

        $stmt =$con->prepare("INSERT INTO item_pay (orderid,productid,count)
        VALUES (?,?,?)");
        $stmt->execute(array($orderid,$productid,$productcount)) ;
          $row = $stmt->rowcount();
          
  
       
    }else{
      $stmt =$con->prepare("INSERT INTO item_pay (orderid,productid)
      VALUES (?,?)");
      $stmt->execute(array($orderid,$productid)) ;
        $row = $stmt->rowcount();
        

    }

    
    
?>
