// cbase: set
if (strtolower($cbase) == 'set') {
  $params = $paramzz;
 $tchan = strtolower($target);
 $lnick = strtolower($nick);
 $area = "";
 $axs = 0;
 $cfound = 0;
 global $userinfo; global $chans; global $botnick; global $god;
 $acc = $userinfo["$lnick"]["auth"];
 $fop = fopen("users.conf","r+");
 while ($fra = fgets($fop)) {
  $fra = str_replace("\r","",$fra);
  $fra = str_replace("\n","",$fra);
  $frg = explode(" ",$fra);
  if ($frg[0] == "-") {
   $area = $frg[1];
  }
  else {
   if ($area == $tchan) {
    if ($frg[0] == $userinfo["$lnick"]["auth"]) {
     $axs = $frg[1];
    }
    $cfound = 1;
   }
  }
 }
 fclose($fop);
 $area = "";
 $fop = fopen("settings.conf","r+");
 while ($fra = fgets($fop)) {
  $fra = str_replace("\r","",$fra);
  $fra = str_replace("\n","",$fra);
  $frg = explode(" ",$fra);
  if ($frg[0] == "-") {
   $area = $frg[1];
  }
  else {
   if ($area == $tchan) {
    $tsets["$frg[0]"] = substr($fra,strlen($frg[0]." "));
   }
  }
 }
 fclose($fop);
 if ($cfound == 0) {
  sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
 }
 elseif (binsetting($tsets['spamserv']) == "Off") {
  sendserv("NOTICE $nick :AntiSpam protection is not enabled on \002".$chans["$tchan"]["name"]."\002.");
 }
 else {
  if ($tsets["setters"] == "") {
   $tsets["setters"] = "400";
  }
  if ($tsets["spam.spamreaction"] == "") {
   $tsets["spam.spamreaction"] = "KICK";
  }
  if ($tsets["spam.floodreaction"] == "") {
   $tsets["spam.floodreaction"] = "KICK";
  }
  if ($tsets["spam.badwordreaction"] == "") {
   $tsets["spam.badwordreaction"] = "KICK";
  }
  if ($tsets["spam.botnetreaction"] == "") {
   $tsets["spam.botnetreaction"] = "KICK";
  }
  if ($tsets["spam.advreaction"] == "") {
   $tsets["spam.advreaction"] = "KICK";
  }
  if ($tsets["spam.capsreaction"] == "") {
   $tsets["spam.capsreaction"] = "KICK";
  }
  if ($tsets["spam.exceptlevel"] == "") {
   $tsets["spam.exceptlevel"] = "200";
  }
  if ($tsets["spam.floodsensibility"] == "") {
   $tsets["spam.floodsensibility"] = "1:2";
  }
  if ($axs >= $tsets["setters"] or $god["$acc"] == 1) {
	// asetting = access, binsetting = boolean, strsetting = text, rsetting = reacion setting (just ArcticSpam)
    if ($params == "") {
	sendserv("NOTICE $nick :\002".$chans["$tchan"]["name"]."\002 antispam setting overview:");
	 sendserv("NOTICE $nick :\002SpamScan           \002 ".binsetting($tsets["spam.spamscan"]));
	 if ($tsets['spam.spamscan'] == "1") {
	  sendserv("NOTICE $nick :\002    SpamReaction   \002 ".asetting($tsets["spam.spamreaction"]));
	 }
	 sendserv("NOTICE $nick :\002FloodScan          \002 ".binsetting($tsets["spam.floodscan"]));
	 sendserv("NOTICE $nick :\002JoinFloodScan      \002 ".binsetting($tsets["spam.joinfloodscan"]));
	 sendserv("NOTICE $nick :\002BadwordScan        \002 ".binsetting($tsets["spam.badwordscan"]));
	 sendserv("NOTICE $nick :\002BotNetScan         \002 ".binsetting($tsets["spam.botnetscan"]));
	 sendserv("NOTICE $nick :\002AdvScan            \002 ".binsetting($tsets["spam.advscan"]));
	 sendserv("NOTICE $nick :\002CapsScan           \002 ".binsetting($tsets["spam.capsscan"]));
	 if ($tsets['spam.capsscan'] == "1") {
	  sendserv("NOTICE $nick :\002    CapsPercent    \002 ".asetting($tsets["spam.capspercent"]));
	 }
	 sendserv("NOTICE $nick :\002FloodSensibility   \002 ".strsetting($tsets["spam.floodsensibility"]));
	 sendserv("NOTICE $nick :\002ScanChanOps        \002 ".binsetting($tsets["spam.scanchanops"]));
	 sendserv("NOTICE $nick :\002ScanVoiced         \002 ".binsetting($tsets["spam.scanvoiced"]));
	 sendserv("NOTICE $nick :\002ScanRegular        \002 ".binsetting($tsets["spam.scanregular"]));
	 sendserv("NOTICE $nick :\002ExceptLevel        \002 ".asetting($tsets["spam.exceptlevel"]));
     sendserv("NOTICE $nick :--- End of the overview ---");
	}
	else {
	 $pp = explode(" ",$params);
     $pe = substr($params,strlen($pp[0]." "));
     if (strtolower($pp[0]) == "spamscan" && $pe == "") {
	  sendserv("NOTICE $nick :\002SpamScan           \002 ".binsetting($tsets["spam.spamscan"]));
	 }
     elseif (strtolower($pp[0]) == "floodscan" && $pe == "") {
	  sendserv("NOTICE $nick :\002FloodScan          \002 ".binsetting($tsets["spam.floodscan"]));
	 }
     elseif (strtolower($pp[0]) == "joinfloodscan" && $pe == "") {
	  sendserv("NOTICE $nick :\002JoinFloodScan      \002 ".binsetting($tsets["spam.joinfloodscan"]));
	 }
     elseif (strtolower($pp[0]) == "badwordscan" && $pe == "") {
	  sendserv("NOTICE $nick :\002BadwordScan        \002 ".binsetting($tsets["spam.badwordscan"]));
	 }
     elseif (strtolower($pp[0]) == "botnetscan" && $pe == "") {
	  sendserv("NOTICE $nick :\002BotNetScan         \002 ".binsetting($tsets["spam.botnetscan"]));
	 }
	 elseif (strtolower($pp[0]) == "advscan" && $pe == "") {
	  sendserv("NOTICE $nick :\002AdvScan            \002 ".binsetting($tsets["spam.advscan"]));
	 }
	 elseif (strtolower($pp[0]) == "capsscan" && $pe == "") {
	  sendserv("NOTICE $nick :\002CapsScan           \002 ".binsetting($tsets["spam.capsscan"]));
	 }
	 elseif (strtolower($pp[0]) == "scanchanops" && $pe == "") {
	  sendserv("NOTICE $nick :\002ScanChanOps        \002 ".binsetting($tsets["spam.scanchanops"]));
	 }
	 elseif (strtolower($pp[0]) == "scanvoiced" && $pe == "") {
	  sendserv("NOTICE $nick :\002ScanVoiced         \002 ".binsetting($tsets["spam.scanvoiced"]));
	 }
	 elseif (strtolower($pp[0]) == "scanregular" && $pe == "") {
	  sendserv("NOTICE $nick :\002ScanRegular        \002 ".binsetting($tsets["spam.scanregular"]));
	 }
	 elseif (strtolower($pp[0]) == "exceptlevel" && $pe == "") {
	  sendserv("NOTICE $nick :\002ExceptLevel        \002 ".asetting($tsets["spam.exceptlevel"]));
	 }
   elseif (strtolower($pp[0]) == "spamscan" && $pe != "") {
    if ($pe != "0" && $pe != "1") {
     sendserv("NOTICE $nick :\002$pe\002 is not a valid binary value.");
     return(0);
    }
     $fcont = "";
     $area = "";
     $sfound = 0;
     $arfound = 0;
     $fop = fopen("settings.conf","r+");
     while ($fra = fgets($fop)) {
      $fra = str_replace("\r","",$fra);
      $fra = str_replace("\n","",$fra);
      $frg = explode(" ",$fra);
      if ($frg[0] == "-") {
       $area = $frg[1];
       $fcont .= "- $frg[1]\r\n";
       if ($area == $tchan) {
        $arfound = 1;
        $fcont .= "spam.spamscan $pe\r\n";
       }
      }
      else {
        if ($area == $tchan && $frg[0] == "spam.spamscan") {
         $sfound = 1;
         $fcont .= ""; // Ignore old data.
        }
        else {
         $fcont .= "$fra\r\n";
        }
      }
     }
     fclose($fop);
     if ($sfound == 0) {
      if ($arfound == 0) {
       $fcont .= "- ".$tchan."\r\n";
       $fcont .= "spam.spamscan $pe\r\n";
      }
     }
     unlink("settings.conf");
     $fop = fopen("settings.conf","w+");
     fwrite($fop,$fcont);
     fclose($fop);
     sendserv("NOTICE $nick :\002SpamScan           \002 ".binsetting($pe));
    }
   elseif (strtolower($pp[0]) == "exceptlevel" && $pe != "") {
     $xyz = 501;
     $valid = 0;
     while ($xyz > -1) {
      if ($pe == $xyz) {
       $valid = 1;
      }
      $xyz = $xyz - 1;
     }
     if ($valid == 0) {
      sendserv("NOTICE $nick :\002$pe\002 is an invalid access level.");
      return(0);
     }
     if ($axs != 500 && $god["$acc"] != "1") {
      if ($pe > $axs) {
       sendserv("NOTICE $nick :You may not change this setting above your own access level.");
       return(0);
      }
     }
     $fcont = "";
     $area = "";
     $sfound = 0;
     $arfound = 0;
     $fop = fopen("settings.conf","r+");
     while ($fra = fgets($fop)) {
      $fra = str_replace("\r","",$fra);
      $fra = str_replace("\n","",$fra);
      $frg = explode(" ",$fra);
      if ($frg[0] == "-") {
       $area = $frg[1];
       $fcont .= "- $frg[1]\r\n";
       if ($area == $tchan) {
        $arfound = 1;
        $fcont .= "spam.exceptlevel $pe\r\n";
       }
      }
      else {
        if ($area == $tchan && $frg[0] == "spam.exceptlevel") {
         $sfound = 1;
         $fcont .= ""; // Ignore old data.
        }
        else {
         $fcont .= "$fra\r\n";
        }
      }
     }
     fclose($fop);
     if ($sfound == 0) {
      if ($arfound == 0) {
       $fcont .= "- ".$tchan."\r\n";
       $fcont .= "spam.exceptlevel $pe\r\n";
      }
     }
     unlink("settings.conf");
     $fop = fopen("settings.conf","w+");
     fwrite($fop,$fcont);
     fclose($fop);
    sendserv("NOTICE $nick :\002ExceptLevel            \002 ".asetting($pe));
    }
	 else {
	  sendserv("NOTICE $nick :\002$pp[0]\002 is an invalid antispam channel setting");
	  sendserv("NOTICE $nick :This is a development version. Maybe the changing of this setting is not an included function at this moment");
	 }
	}
  }
  else {
   sendserv("NOTICE $nick :You lack sufficient access to ".$chans[$tchan]['name']." to use this command.");
  }
 }
}