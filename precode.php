<?php
#################################
# PLEASE DO NOT MODIFY THIS     #
#################################

@(include("time_handler.php")) OR die("ERROR #01: Included php-script missing: \002time_handler.php\002.\n");

define("PHPGOD_VERSION","1.2.0"); $php = new phpgod;

class phpgod {
 public function evaluate ($code) {
  echo(eval($code));
 }
 public function version () {
  echo("ArcticServ PHPGod ".PHPGOD_VERSION."\n");
  echo("- core code 1.0 calisto-phpgod-public\n");
 }
 public function bot_version () {
  include("config.php");
  echo("ArcticServ ".$bversion." (".$bcodename.") Release ".$brelease."\n");
  echo("Core ".$core);
 }
 public function help () {
  echo("\002PHPGod\002\n");
  echo("PHPGod is a script, that makes it possible to run PHP code\n");
  echo("from another script, and it doesnt care, if it crashes.\n");
  echo("The code you run is totally separated from your main code.\n");
  echo("This makes PHPGods very safe.\n");
  echo(" \n");
  echo("If you want to know how to create a PHPGod-Script, ask \002Calisto.\002\n");
  echo(" \n");
  echo("This code is using PHPGod version:\n");
  self::version();
 }
}

function prex ($program) {
 echo(shell_exec($program));
}

function getArrayFromFile ($file) {
 $fp = fopen($file,"r+");
 while ($fg = fgets($fp)) {
  $fr .= $fg;
 }
 fclose($fp);
 if (is_array(unserialize($fr))) {
  return(unserialize($fr));
 }
 else {
  echo("\0034ERROR:\003 The content of $file is not a valid array.\n");
 }
}

function sendArrayToFile ($file, $array) {
 $fp = fopen($file,"w+");
 fwrite($fp, serialize($array));
 fclose($fp);
}

function print_array ($file) {
 $ar = getArrayFromFile($file);
 foreach ($ar as $ak => $av) {
  if (is_array($av)) {
   $bla .= "\"".addslashes($ak)."\" ".print_r($av,1);
  }
  else {
   $bla .= "$av\n";
  }
 }
 echo($bla);
}

function removeMultiSpace ($string) {
 $newstring = "";
 $st = explode(" ",$string);
 foreach ($st as $val) {
  if ($val != "") {
   if ($newstring != "") {
    $newstring .= " ".$val;
   }
   else {
    $newstring = $val;
   }
  }
 }
 return($newstring);
}

function removeMultiSpace160 ($string) {
 $newstring = "";
 $st = explode(chr(160),$string);
 foreach ($st as $val) {
  if ($val != "") {
   if ($newstring != "") {
    $newstring .= " ".$val;
   }
   else {
    $newstring = $val;
   }
  }
 }
 return($newstring);
}

function unspacer ($string) {
 $newstring = "";
 $newstring = utf8_decode($string);
 $newstring = removeMultiSpace160($newstring);
 $newstring = removeMultiSpace($newstring);
 return($newstring);
}
?>