if (strtolower($cbase) == "8ball") {
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

	$responses[0] = "Never.";
	$responses[1] = "Absolutely!";
	$responses[2] = "Not a chance.";
	$responses[3] = "Maybe, maybe...";
	$responses[4] = "No!";
	$responses[5] = "Impossible!";
	$responses[6] = "Who knows?";
	$responses[7] = "Sure.";
	$responses[8] = "This is just possible if i'm human.";
	if ($cchan[0] != "#") {
		$tsets['toys'] = 1;
	}
	if ($tsets['toys'] == '' || $tsets['toys'] == '0') {
		sendserv("NOTICE $nick :Toys are disabled in \002".$chans[$tchan]['name']."\002.");
	}
	else {
		if ($tsets['toys'] == '1') {
			sendserv("NOTICE $nick :".$responses[modulo_str($paramzz,9)]);
		}
		else {
			sendserv("PRIVMSG $target :\002$nick\002: ".$responses[modulo_str($paramzz,9)]);
		}
	}
}