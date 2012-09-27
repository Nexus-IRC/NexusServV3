// cbase: clist
if (strtolower($cbase) == "clist") {
	global $userinfo; global $botnick; global $god; global $chans;
	$lbotnick = strtolower($botnick);
	$lnick = strtolower($nick);
	$acc = $userinfo["$lnick"]["auth"];
	$saxs = 0;
	$ccnt = 0;
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
	if ($saxs >= 200) {
		sendserv("NOTICE $nick :Channel list");
		$fp = fopen("users.conf","r+");
		while ($fg = fgets($fp)) {
			$fg = str_replace("\r","",$fg);
			$fg = str_replace("\n","",$fg);
			$fe = explode(" ",$fg);
			if ($fe[0] == "-") {
				if ($chans[$fe[1]]['name']) {
					sendserv("NOTICE $nick :  ".$chans[$fe[1]]['name']);
				}
				else {
					sendserv("NOTICE $nick :  ".$fe[1]);
				}
				$ccnt++;
			}
		}
		sendserv("NOTICE $nick :\002$ccnt\002 channels found");
	}
	else {
		sendserv("NOTICE $nick :You lack sufficient staff access to use this command.");
	}
}