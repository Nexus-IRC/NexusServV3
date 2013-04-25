if (strtolower($cbase) == "god") {
	global $userinfo; global $botnick; global $god;
	$lnick = strtolower($nick);
	$acc = $userinfo["$lnick"]["auth"];
	$saxs = 0;
	$fop = fopen("./conf/staff.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if (strtolower($frg[0]) == strtolower($acc)) {
			$saxs = $frg[1];
		}
	}
	fclose($fop);
	$ccchan = $cchan;
	if ($cchan[0] != "#") {
		$ccchan = "";
	}
	$command = $GLOBALS['msg'];
	sendserv("NOTICE $debugchannel :($ccchan) [$nick:$acc] $command");
	if ($saxs >= 200) {
		if ($god["$acc"] != 1) {
			$god["$acc"] = 1;
			sendserv("NOTICE $nick :Security override has been enabled.");
		}
		else {
			$god["$acc"] = 0;
			sendserv("NOTICE $nick :Security override has been disabled.");
		}
	}
	else {
		sendserv("NOTICE $nick :You lack sufficient staff access to use this command.");
	}
}