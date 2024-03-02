<?php

include "connect.php";
$id =$_POST['id'];
$sql ="SELECT * FROM tv JOIN product ON tv.productid = product.productid  WHERE product.productid= $id";
$stmt =$con->prepare($sql);
$stmt->execute() ;
$tvs =$stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode( $tvs);




?> 
