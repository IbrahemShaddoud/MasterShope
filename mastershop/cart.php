<?php
include "connect.php";
$userid =$_POST['userid'];
$sql ="SELECT * FROM cart WHERE userid = ?";
$stmt =$con->prepare($sql);
$stmt->execute(array($userid)) ;
$products =$stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode( $products);


?>
