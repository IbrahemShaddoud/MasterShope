<?php
include "connect.php";
$prod =$_POST['pro'];
$sql ="SELECT * FROM product WHERE price <($prod+(15*$prod)/100) ";
$stmt =$con->prepare($sql);
$stmt->execute() ;
$products =$stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode( $products);


?>
