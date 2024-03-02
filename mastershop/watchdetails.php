<?php
include "connect.php";
$id =$_POST['id'];
$sql ="SELECT * FROM watch WHERE productid=$id";
$sql ="SELECT * FROM watch JOIN product ON watch.productid = product.productid  WHERE product.productid= $id ";
$stmt =$con->prepare($sql);
$stmt->execute() ;
$watchs =$stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode( $watchs);


?>