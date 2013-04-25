if (strtolower($cbase) == "readchan") {
	$params = $paramzz;
	$tchan = strtolower($target);
	$lnick = strtolower($nick);
	$area = "";
	$axs = 0;
	$cfound = 0;
	global $userinfo; global $chans; global $botnick; global $god;
	$acc = $userinfo["$lnick"]["auth"];
	$fop = fopen("./conf/users.conf","r+");
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
	$fop = fopen("./conf/settings.conf","r+");
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

	$uc = 0;
	$ufound = "";
	global $botnick;
	global $chans;
	foreach ($chans[strtolower($target)]['users'] as $uname => $uaccs) {
		if ($userinfo[$uname]['auth'] != "") {
			if (str_replace("@","",$uaccs) != $uaccs) {
				if (addChanUser(strtolower($target),$userinfo[$uname]['auth'],200) == "Ok") {
					$ua = $userinfo[$uname]['auth'];
					$uc++;
					sendserv("NOTICE $nick :Added \002$uname\002 ($ua) with access \002200\002");
				}
			}
			if (str_replace("+","",$uaccs) != $uaccs) {
				if (addChanUser(strtolower($target),$userinfo[$uname]['auth'],100) == "Ok") {
					$ua = $userinfo[$uname]['auth'];
					$uc++;
					sendserv("NOTICE $nick :Added \002$uname\002 ($ua) with access \002100\002");
				}
			}
		}
	}
	sendserv("NOTICE $nick :\002$uc\002 users were added.");
}