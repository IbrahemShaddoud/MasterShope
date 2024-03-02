<?php
include "connect.php";
$cat =$_POST['cat'];
$sql ="SELECT * FROM product WHERE catid = ?";
$stmt =$con->prepare($sql);
$stmt->execute(array($cat)) ;
$products =$stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode( $products);


?>
