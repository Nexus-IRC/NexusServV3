<?php
function modulo_str ($string, $modulo) {
 $i = 0;
 while (substr($string,$i,1)) {
  $myascii = $myascii + ord(substr($string,$i,1));
  $i++;
 }
 return($myascii % $modulo);
}

 if ($chan[0] == "#") {
  if ($toys == "" || $toys == "0") {
   echo("NOTICE $nick :Toys are disabled in \002$chan\002.\n");
  }
  elseif ($toys == "1") {
   echo("NOTICE $nick :You are gay ".modulo_str($nick,101)."%!\n");
  }
  elseif ($toys == "2") {
   echo("PRIVMSG $chan :\002$nick\002: You are gay ".modulo_str($nick,101)."%!\n");
  }
 }
 else {
  echo("NOTICE $nick :You are gay ".modulo_str($nick,101)."%!\n");
 }
?>