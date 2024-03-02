<?php
include "connect.php";
$useremail =$_POST['useremail'];
$sql ="SELECT userid FROM user WHERE email=?";
$stmt =$con->prepare($sql);
$stmt->execute(array($useremail)) ;
$id =$stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode( $id);


?>
