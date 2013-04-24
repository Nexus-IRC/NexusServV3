if (strtolower($cbase) == "startvote") {
	global $userinfo; global $chans; global $botnick; global $god;
	$tchan = strtolower($target);
	$lnick = strtolower($nick);
	$acc = $userinfo["$lnick"]["auth"];
	$fop = fopen("conf/users.conf","r+");
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
	$fop = fopen("conf/settings.conf","r+");
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
	if ($axs < $tsets['changevote']) {
		sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
	}
	else {
		$ffop = fopen('conf/votes.conf','r+');
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
		if ($varray[$tchan]['start'] == 1) {
			sendserv("NOTICE $nick :The voting on \002$cname\002 was already started.");
			return(0);
		}
		$vo = 0;
		foreach ($varray[$tchan]['options'] as $vkint) {
			$vo++;
		}
		if ($vo < 2) {
			sendserv("NOTICE $nick :Please add at least 2 options to the voting of \002$cname\002.");
			return(0);
		}
		$varray[$tchan]['start'] = 1;
		$ffop = fopen('conf/votes.conf','w+');
		fwrite($ffop,serialize($varray));
		fclose($ffop);
		sendserv("NOTICE $nick :The voting was started.");
		sendserv("PRIVMSG $cname :\002$nick\002 started a voting");
		sendserv("PRIVMSG $cname :Question: ".$varray[$tchan]['question']);
		foreach ($varray[$tchan]['options'] as $vnr => $vtx) {
		sendserv("PRIVMSG $cname :   $vnr -> $vtx");
		}
		sendserv("PRIVMSG $cname :Use \002vote <ID>\002 to vote.");
	}
}