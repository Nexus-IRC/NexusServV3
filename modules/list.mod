if (strtolower($cbase) == "list") {
	$params = $paramzz;
	$paz = explode(" ",$params);
	global $userinfo; global $botnick; global $god;
	$lnick = strtolower($nick);
	$acc = $userinfo["$lnick"]["auth"];
	$saxs = 0;
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
		$cnt = 0;
		$fope = fopen("accs.conf","r+");
		sendserv("NOTICE $nick :\002Auth List\002");
		while ($frae = fgets($fope)) {
			$frae = str_replace("\r","",$frae);
			$frae = str_replace("\n","",$frae);
			sendserv("NOTICE $nick :$frae");
			$cnt++;
		}
		sendserv("NOTICE $nick :---");
		sendserv("NOTICE $nick :Found \002$cnt\002 auths");
		sendserv("NOTICE $nick :---");
		fclose($fope);
	}
}