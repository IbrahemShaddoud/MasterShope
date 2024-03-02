<?php
include "connect.php";
$sql ="SELECT max(order_id) FROM order_pay ";
$stmt =$con->prepare($sql);
$stmt->execute() ;
$order =$stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode( $order);


?>
