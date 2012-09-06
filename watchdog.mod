// cbase: watchdog
// cbase: info
if (strtolower($cbase) == "watchdog") {
  global $userinfo; global $botnick; global $god; global $chans;
 $lbotnick = strtolower($botnick);
 $lnick = strtolower($nick);
 $acc = $userinfo["$lnick"]["auth"];
 $saxs = 0;
 $chansnoop = array();
 $chansnoton = array();
 $cpcount = 0;
 $fop = fopen("staff.conf","r+");
 while ($fra = fgets($fop)) {
  $fra = str_replace("\r","",$fra);
  $fra = str_replace("\n","",$fra);
  $frg = explode(" ",$fra);
  if (strtolower($frg[0]) == strtolower($acc)) {
   $saxs = $frg[1];
  }
 }
 fclose($fop);
 if ($saxs >= 800) {
  $pp = explode(' ',$paramzz);
  if ($paramzz == "") {
   sendserv("NOTICE $nick :Subcommands of \002watchdog\002: add del list info set");
  }
  elseif ($pp[0] == 'set') {
   if ($pp[1] == "") {
    sendserv("NOTICE $nick :\002Watchdog script settings\002");
	sendserv("NOTICE $nick :\002DYNAMIC\002");
    sendserv("NOTICE $nick :REACTION            KICKBAN");
    sendserv("NOTICE $nick :RREASON             Watchdog: Illegal word/url found.");
	sendserv("NOTICE $nick :\002STATIC\002");
    sendserv("NOTICE $nick :SACCESS             800 (or higher)");
	sendserv("NOTICE $nick :LINKER              add del list info set");
	sendserv("NOTICE $nick :LISTFILE            watchdog.txt");
   }
   else {
    sendserv("NOTICE $nick :ERROR: Setting request/change for \002$pp[1]\002 failed.");
   }
  }
  elseif ($pp[0] == 'info') {
   sendserv("NOTICE $nick :ArcticServ Watchdog Script v1.0-rv5 (added on ArcticServ v2.1.(wgn)-r2)");
  }
  elseif ($pp[0] == 'list') {
    sendserv("NOTICE $nick :\002Watchdog list\002");
    $fop = fopen('watchdog.txt','r+');
	while ($fr = fgets($fop)) {
	 $fr = str_replace("\r","",$fr);
	 $fr = str_replace("\n","",$fr);
	 sendserv("NOTICE $nick :$fr");
	}
	fclose($fop);
	sendserv("NOTICE $nick :--- End of list ---");
  }
  elseif ($pp[0] == 'add') {
   $fop = fopen('watchdog.txt','r+');
	while ($fr = fgets($fop)) {
	 $fr = str_replace("\r","",$fr);
	 $fr = str_replace("\n","",$fr);
	 $fg = explode(' ',$fr);
	 if (fnmatch($pp[1],$fg[0])) {
	  // ignore old match
	 }
	 else {
	  $wac .= $fr."\n";
	 }
	 if (fnmatch($fg[0],$pp[1])) {
	  sendserv("NOTICE $nick :There already is a match found for \002$pp[1]\002. (\002$fg[0]\002)");
	  return(0);
	 }
	}
	fclose($fop);

	$fop = fopen("watchdog.txt","w+");
	fwrite($fop,$wac.$pp[1]);
	fclose($fop);
	sendserv("NOTICE $nick :\002$pp[1]\002 was added to the Watchdog-list.");
  }
  elseif ($pp[0] == "del") {
  
     $fop = fopen('watchdog.txt','r+');
	while ($fr = fgets($fop)) {
	 $fr = str_replace("\r","",$fr);
	 $fr = str_replace("\n","",$fr);
	 $fg = explode(' ',$fr);
	 if (fnmatch($pp[1],$fg[0])) {
	  // ignore old match
	 }
	 else {
	  $wac .= $fr."\n";
	 }
	}
	fclose($fop);

	$fop = fopen("watchdog.txt","w+");
	fwrite($fop,$wac);
	fclose($fop);
	sendserv("NOTICE $nick :All matches for \002$pp[1]\002 were removed.");
  
  }
 }
 else {
  sendserv("NOTICE $nick :You lack sufficient staff access to use this command.");
 }
}