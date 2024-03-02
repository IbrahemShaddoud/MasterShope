<?php
include "connect.php";
$id =$_POST['id'];
$sql ="SELECT * FROM phone_tablet JOIN product ON phone_tablet.productid = product.productid  WHERE product.productid= $id AND phone_tablet.mob_or_tab =2";
$stmt =$con->prepare($sql);
$stmt->execute() ;
$mobils =$stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode( $mobils);


?>
