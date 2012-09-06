<?php
 if ($chan[0] == "#") {
  if ($toys == "" || $toys == "0") {
   echo("NOTICE $nick :Toys are disabled in \002$chan\002.\n");
  }
  elseif ($toys == "1") {
   echo("NOTICE $nick :I don't want to be a part of your sick fantasies!\n");
  }
  elseif ($toys == "2") {
   echo("PRIVMSG $chan :\002$nick\002: I don't want to be a part of your sick fantasies!\n");
  }
 }
 else {
  echo("NOTICE $nick :I don't want to be a part of your sick fantasies!\n");
 }
?>