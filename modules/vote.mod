if (strtolower($cbase) == "vote") {
	global $userinfo; global $chans; global $botnick; global $god;
	$tchan = strtolower($target);
	$lnick = strtolower($nick);
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
				$uaxs["$frg[0]"] = $frg[1];
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
	if ($cfound == 0) {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
		return(0);
	}
	$cname = $chans["$tchan"]["name"];
	if ($tsets['votings'] != '1') {
		sendserv("NOTICE $nick :Votings are disabled in \002$cname\002.");
		return(0);
	}
	if ($tsets['changevote'] == '') {
		$tsets['changevote'] = '400';
	}
	if ($axs < $tsets['vote']) {
		sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
	}
	else {
		if ($paramzz == "") {
			sendserv("NOTICE $nick :\002vote\002 requires more parameters:");
			sendserv("NOTICE $nick : <OPTION-ID>");
			return(0);
		}
		$ffop = fopen('./conf/votes.conf','r+');
		while ($ffg = fgets($ffop)) {
			$ffg = str_replace("\r","",$ffg);
			$ffg = str_replace("\n","",$ffg);
			$varray = unserialize($ffg);
		}
		fclose($ffop);
		if ($varray[$tchan] == "") {
			sendserv("NOTICE $nick :There is no voting on \002$cname\002.");
			return(0);
		}
		$uauth = strtolower($userinfo[$lnick]['auth']);
		if ($varray[$tchan]['voted'][$uauth] == 1) {
			sendserv("NOTICE $nick :You already voted.");
			return(0);
		}
		if ($varray[$tchan]['start'] != 1) {
			sendserv("NOTICE $nick :The voting on \002$cname\002 is not started.");
			return(0);
		}
		if ($varray[$tchan]['options'][$paramzz] == "") {
			sendserv("NOTICE $nick :This option ID is not existing on \002$cname\002.");
			return(0);
		}
		$varray[$tchan]['votes'][$paramzz]++;
		$varray[$tchan]['voted'][$uauth] = 1;
		$ffop = fopen('./conf/votes.conf','w+');
		fwrite($ffop,serialize($varray));
		fclose($ffop);
		sendserv("NOTICE $nick :You voted for ID#$paramzz (".$varray[$tchan]['options'][$paramzz].")");
	}
}