<?php
include "connect.php";
$sql ="SELECT * FROM product WHERE (DATEDIFF(NOW(),datofpublication)) < 30 ";
$stmt =$con->prepare($sql);
$stmt->execute() ;
$products =$stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode( $products);


?>
