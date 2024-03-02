
<?php

include "connect.php";
$id =$_POST['id'];
$sql ="SELECT * FROM headphone JOIN product ON headphone.productid = product.productid  WHERE product.productid= $id";
$stmt =$con->prepare($sql);
$stmt->execute() ;
$headphones =$stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode( $headphones);




?> 