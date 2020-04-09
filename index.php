<?php 
	session_start(); 
	$_SESSION['count']++; 
	printf ( $_SERVER["SERVER_ADDR"]." session counter: ".$_SESSION['count']."\n" ); 
?>
