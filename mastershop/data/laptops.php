<?php
include "connect.php";
$sql ="SELECT * FROM product ";
$stmt =$con->prepare($sql);
$stmt->execute() ;
$laptops =$stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode( $laptops);


