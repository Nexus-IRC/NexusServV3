if (strtolower($cbase) == "banall")  {
	$params = $paramzz;
	$tchan = strtolower($target);
	$lnick = strtolower($nick);
	$area = "";
	$axs = 0;
	$cfound = 0;
	$uaxs = array();
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
	if ($axs < 400) {
		sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
	}
	else {
		$fop = fopen("./conf/bans.conf","r+");
		$ccnt = 0;
		$cmodes = "";
		$cparms = "";
		$buffer = "";
		while ($fra = fgets($fop)) {
			$fra = str_replace("\r","",$fra);
			$fra = str_replace("\n","",$fra);
			$frg = explode(" ",$fra);
			if ($frg[0] == "-") {
				$area = $frg[1];
			}
			elseif ($fra == "") {
			}
			else {
				if ($area == $tchan) {
					$ccnt++;
					$cmodes .= "+b";
					$cparms .= " $frg[0]";
					if ($ccnt == 6) {
						$buffer .= "MODE $target $cmodes $cparms\n";
						$cmodes = "";
						$cparms = "";
						$ccnt = 0;
					}
				}
			}
		}
		if ($cmodes != "") {
			$buffer .= "MODE $target $cmodes $cparms\n";
		}
		sendserv($buffer);
		sendserv("NOTICE $nick :Reset banlist from $cname.");
	}
}