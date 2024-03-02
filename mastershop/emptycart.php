<?php
include "connect.php";
$userid =$_POST['userid'];
$sql ="DELETE FROM cart WHERE userid=?";
$stmt =$con->prepare($sql);
$stmt->execute(array($userid)) ;



?>
