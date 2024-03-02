<?php
include "connect.php";
$sql ="SELECT * FROM product WHERE (offerpersent IS NOT NULL) AND offerpersent !=0";
$stmt =$con->prepare($sql);
$stmt->execute() ;
$products =$stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode( $products);


?>
