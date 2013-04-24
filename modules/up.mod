if (strtolower($cbase) == "up") {
	global $chans; global $userinfo;
	$ctarg = strtolower($target);
	$axs = array();
	$tsets = array();
	$lnick = strtolower($nick);
	$auth = $userinfo["$lnick"]["auth"];
	if ($auth == "") {
		sendserv("NOTICE $nick :$nick is not authed with \002AuthServ\002.");
		return(0);
	}
	if ($chans["$ctarg"]["name"] == "") {
		sendserv("NOTICE $nick :I'm not at $target.");
		return(0);
	}
	$cname = $chans["$ctarg"]["name"];
	$fop = fopen("conf/users.conf","r+");
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
	$fop = fopen("conf/settings.conf","r+");
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
		sendserv("MODE $target +o $nick");
		sendserv("NOTICE $nick :You have been opped in $cname.");
	}
	elseif ($axs["$auth"] >= $tsets["givevoice"]) {
		sendserv("MODE $target +v $nick");
		sendserv("NOTICE $nick :You have been voiced in $cname.");
	}
	else {
		sendserv("NOTICE $nick :You don't have enough access to get any rank in $cname.");
	}
}