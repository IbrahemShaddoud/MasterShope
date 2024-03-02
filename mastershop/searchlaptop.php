<?php
include "connect.php";
$prod =$_POST['pro'];
$sql ="SELECT * FROM product WHERE (productname LIKE '%$prod%' OR company LIKE '%$prod%') AND catid= 1 ";
$stmt =$con->prepare($sql);
$stmt->execute() ;
$products =$stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode( $products);


?>
