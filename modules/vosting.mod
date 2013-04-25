if (strtolower($cbase) == "voting") {
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
	if ($axs < -1000) {
		sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
	}
	else {
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
		sendserv("NOTICE $nick :\002Voting info for $cname:\002");
		sendserv("NOTICE $nick :Question: ".$varray[$tchan]['question']);
		sendserv("NOTICE $nick :Options:");
		foreach ($varray[$tchan]['options'] as $optnr => $optarg) {
			$vtimes = $varray[$tchan]['votes'][$optnr];
			if ($vtimes == "") {
				$vtimes = "0";
			}
			sendserv("NOTICE $nick :    $optnr -> $optarg (Voted ".$vtimes." times)");
		}
		if ($varray[$tchan]['start'] == 1) {
			sendserv("NOTICE $nick :- The voting on \002$cname\002 is started.");
		}
		$ffop = fopen('./conf/votes.conf','w+');
		fwrite($ffop,serialize($varray));
		fclose($ffop);
	}
}