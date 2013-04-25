if (strtolower($cbase) == "unbind") {
	$params = $paramzz;
	$paz = explode(" ",$params);
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
	if ($saxs >= 800) {
		$fope = fopen("./conf/bind.conf","r+");
		$found = 0;
		$fcont = "";
		while ($frae = fgets($fope)) {
			$frae = str_replace("\r","",$frae);
			$frae = str_replace("\n","",$frae);
			$frge = explode(" ",$frae);
			if (strtolower($frge[0]) == strtolower($paz[0])) {
				// ignore this command?
				$found = 1;
			}
			else {
				$fcont .= $frae."\n";
			}
		}
		fclose($fope);
		if ($found == 1) {
			$fope = fopen("./conf/bind.conf","w+");
			fwrite($fope,$fcont);
			fclose($fope);
			sendserv("NOTICE $nick :Command \002$paz[0]\002 unbound from the bot.");
		}
		else {
			sendserv("NOTICE $nick :Command \002$paz[0]\002 is unknown to me.");
		}
	}
	else {
		sendserv("NOTICE $nick :You lack sufficient staff access to use this command.");
	}
}