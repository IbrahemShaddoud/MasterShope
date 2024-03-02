<?php
include "connect.php";
$productid =$_POST['productid'];
$sql ="SELECT * FROM product WHERE productid = ?";
$stmt =$con->prepare($sql);
$stmt->execute(array($productid)) ;
$products =$stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode( $products);


?>
