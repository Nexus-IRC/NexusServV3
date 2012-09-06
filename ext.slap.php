<?php
 if ($chan[0] == "#") {
  if ($toys == "" || $toys == "0") {
   echo("NOTICE $nick :Toys are disabled in \002$chan\002.\n");
  }
  elseif ($toys == "1") {
   echo("NOTICE $nick :Toys must be activated publicly at \002$chan\002 to use slapping.\n");
  }
  elseif ($toys == "2") {
   $exp = explode(" ",$params);
   $xslap = file_get_contents("slapcount.z");
   $nfound = false;
   $nname = "";
   $nnick = $exp[0];
   if ($params == "") {
    $nnick = $nick;
	$nname = $nick;
    $xslap = $xslap + 1;
   }
   else {
    foreach ($nicklist as $nickname => $status) {
     $nfound[strtolower($nickname)] = $nickname;
    }
	
	$bla = explode(",",$params);
	
	if (count($bla) > 5) {
	 echo("NOTICE $nick :Slapping more than \0025\002 users is not allowed.\n");
	 return(0);
	}
	
	foreach ($bla as $xx) {
	 if ($nfound[strtolower($xx)] == "") {
	  echo("NOTICE $nick :\002$xx\002 is not on \002$chan\002.");
	  return(0);
	 }
	 else {
	  $xslap = $xslap + 1;
	  if ($slapd[strtolower($xx)] == 1) {
	   echo("NOTICE $nick :You already included \002".$nfound[strtolower($xx)]."\002 to your slap attack.\n");
	   return(0);
	  }
	  $slapd[strtolower($xx)] = 1;
	  if ($nname == "") {
	   $nname = $nfound[strtolower($xx)];
	  }
	  else {
	   $nname .= " and ".$nfound[strtolower($xx)];
	  }
	 }
	}
   }
   echo("PRIVMSG $chan :\001ACTION slaps $nname around a bit with everything he finds...\001\n");
   echo("PRIVMSG $chan :\001ACTION has already slapped ".$xslap." users!\001\n");
   $fp = fopen("slapcount.z","w+");
   fputs($fp,$xslap);
   fclose($fp);
  }
 }
 else {
  echo("NOTICE $nick :Slapping is just available to channels.\n");
 }
?>