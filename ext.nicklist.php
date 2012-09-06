<?php
 if ($chan[0] == "#") {
  $uc = 0;
  echo("NOTICE $nick :On \002$chan\002 there are the following users:\n");
  foreach ($nicklist as $nickname => $status) {
   $uc++;
   echo("NOTICE $nick : $nickname\n");
  }
  echo("NOTICE $nick :\002$uc\002 users found.\n");
 }
 else {
 }
?>