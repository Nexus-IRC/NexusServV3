if (strtolower($cbase) == "invite") {
	$params = $paramzz;
	$tchan = strtolower($target);
	$lnick = strtolower($nick);
	$area = "";
	$axs = 0;
	$cfound = 0;
	global $userinfo; global $chans; global $botnick; global $god;
	$acc = $userinfo["$lnick"]["auth"];
	$fop = fopen("users.conf","r+");
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
	$fop = fopen("settings.conf","r+");
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
	$cname = $chans["$tchan"]["name"];
	if ($cfound != 0) {
		if ($axs >= 200) {
			$ps = explode(" ",$params);
			$xyxx = 0;
			while ($ps[$xyxx] != "") {
				sendserv("NOTICE ".$ps[$xyxx]." :\002$nick\002 invites you to join \002$cname\002");
				sendserv("INVITE ".$ps[$xyxx]." $target");
				sendserv("NOTICE $nick :Sent invite for ".$ps[$xyxx]);
				$xyxx++;
			}
			sendserv("NOTICE $nick :Invited the users to join $cname.");
		}
		else {
			sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
		}
	}
	else {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
	}
}