if (strtolower($cbase) == "trace") {
	$params = $paramzz;
	$paz = explode(" ",$params);
	if (strtoupper($paz[0]) == "PRINT") {
		// nothing, continue.
	}
	elseif (strtoupper($paz[0]) == "COUNT") {
		// nothing, continue.
	}
	else {
		sendserv("NOTICE $nick :\002$paz[0]\002 is an invalid AuthTrace action.");
		return("ERROR: Invalid ATRACE");
	}
	global $userinfo; global $botnick; global $god;
	$lnick = strtolower($nick);
	$acc = $userinfo["$lnick"]["auth"];
	$saxs = 0;
	$fop = fopen("conf/staff.conf","r+");
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
		$cnt = 0;
		$fope = fopen("conf/accs.conf","r+");
		while ($frae = fgets($fope)) {
			$frae = str_replace("\r","",$frae);
			$frae = str_replace("\n","",$frae);
			if (strtoupper($paz[0]) == "PRINT" && fnmatch(strtolower($paz[1]),strtolower($frae))) {
				sendserv("NOTICE $nick :$frae");
			}
			if (fnmatch(strtolower($paz[1]),strtolower($frae))) {
				$cnt++;
			}
		}
		sendserv("NOTICE $nick :\002$cnt\002");
		fclose($fope);
	}
}