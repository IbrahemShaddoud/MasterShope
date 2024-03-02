<?php
include "connect.php";
$email =$_POST['email'];
$sql ="SELECT * FROM user WHERE email=?";
$stmt =$con->prepare($sql);
$stmt->execute(array($email)) ;
$mobils =$stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode( $mobils);


?>
