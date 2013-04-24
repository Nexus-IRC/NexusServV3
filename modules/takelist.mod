if (strtolower($cbase) == "takelist") {
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
	if ($tsets['changeusers'] == "") {
		$tsets['changeusers'] = "300";
	}
	if ($tsets['adduser'] == "") {
		$tsets['adduser'] = $tsets['changeusers'];
	}
	if ($tsets['deluser'] == "") {
		$tsets['deluser'] = $tsets['changeusers'];
	}
	if ($tsets['clvl'] == "") {
		$tsets['clvl'] = $tsets['changeusers']; 
	}
	$cname = $chans["$ctarg"]["name"];
	if ($cfound == 0) {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
	}
	else {
		if ($axs < "500" && $god[$acc] != "1") {
			sendserv("NOTICE $nick :You lack sufficient access to ".$chans["$tchan"]["name"]." to use this command.");
			return(0);
		}
	}


	$ufound = "";
	global $botnick;
	if ($paramzz == "") {
		$paramzz = "chanserv";
	}
	$paz = explode(" ",$paramzz);
	foreach ($GLOBALS['chans'][strtolower($target)]['users'] as $unick => $u) {
		if ($unick == strtolower($paz[0])) {
			$ufound = $GLOBALS['userinfo'][$unick]['nick'];
		}
	}
	if ($ufound == "") {
		sendserv("NOTICE $nick :\002$paz[0]\002 was not found on \002$target\002.");
		return(0);
	}
	if ($paz[1] != "!".substr(md5($ufound),0,8)."!" && $god[$acc] != "1") {
		sendserv("NOTICE $nick :To really try synchronizing \002$botnick\002s userlist with \002$ufound\002, use \002".$GLOBALS['command']." $ufound !".substr(md5($ufound),0,8)."!\002");
		return(0);
	}
	if ($ufound == $botnick) {
		sendserv("NOTICE $nick :You can't synchronize \002$botnick\002 with itself.");
		return(0);
	}
	if ($GLOBALS['takelistchan'] != "") {
		sendserv("NOTICE $nick :Interupting erroneous synchronisation of \002".$GLOBALS['tln']."\002...");  
	}

	sendserv("NOTICE $nick :Synchronizing the userlist of ".$chans["$tchan"]["name"]." with \002$ufound\002...");
	$GLOBALS["takelista"] = "false";
	$GLOBALS["takelist"] = $ufound;
	$GLOBALS["takelistnick"] = $nick;
	$GLOBALS["tln"] = $ufound;
	$GLOBALS["takelistchan"] = $chans["$tchan"]["name"];
	sendserv("PRIVMSG $ufound :users ".$chans["$tchan"]["name"]);
	sendserv("PRIVMSG $ufound :a ".$chans["$tchan"]["name"]);
}