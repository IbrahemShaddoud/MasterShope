<?php
include "connect.php";
$id =$_POST['id'];
$sql ="SELECT * FROM laptops JOIN product ON laptops.productid = product.productid  WHERE product.productid= $id";
$stmt =$con->prepare($sql);
$stmt->execute() ;
$laptop =$stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode( $laptop);


?>
