if (strtolower($cbase) == "upall") {
	global $chans; global $userinfo;
	$tsets = array();
	$lnick = strtolower($nick);
	$auth = $userinfo["$lnick"]["auth"];
	if ($auth == "") {
		sendserv("NOTICE $nick :$nick is not authed with \002AuthServ\002.");
		return(0);
	}
	$cname = $chans["$ctarg"]["name"];
	foreach ($chans as $ctarg => $ctarray) {
		$axs = array();
		$targ = $chans["$ctarg"]["name"];
		$fop = fopen("./conf/users.conf","r+");
		while ($fra = fgets($fop)) {
			$fra = str_replace("\r","",$fra);
			$fra = str_replace("\n","",$fra);
			$frg = explode(" ",$fra);
			if ($frg[0] == "-") {
				$area = $frg[1];
			}
			else {
				if ($area == $ctarg) {
					$axs["$frg[0]"] = $frg[1];
					$cfound = 1;
				}
			}
		}
		fclose($fop);
		$fop = fopen("./conf/settings.conf","r+");
		while ($fra = fgets($fop)) {
			$fra = str_replace("\r","",$fra);
			$fra = str_replace("\n","",$fra);
			$frg = explode(" ",$fra);
			if ($frg[0] == "-") {
				$area = $frg[1];
			}
			else {
				if ($area == $ctarg) {
					$tsets["$frg[0]"] = substr($fra,strlen($frg[0]." "));
				}
			}
		}
		fclose($fop);
		if ($tsets["giveops"] == "") {
			$tsets["giveops"] = "200";
		}
		if ($tsets["givevoice"] == "") {
			$tsets["givevoice"] = "100";
		}
		if ($axs["$auth"] >= $tsets["giveops"]) {
			sendserv("MODE $targ +o $nick");
		}
		elseif ($axs["$auth"] >= $tsets["givevoice"]) {
			sendserv("MODE $targ +v $nick");
		}
	}
	sendserv("NOTICE $nick :You have been opped/voiced in all channels where you have access.");
}