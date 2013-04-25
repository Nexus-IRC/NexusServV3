if (strtolower($cbase) == "unregister") {
	$params = $paramzz;
	$tchan = strtolower($target);
	$area = "";
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
	fclose($fop);
	global $userinfo; global $botnick; global $god; global $chans;
	$lnick = strtolower($nick);
	$lchan = strtolower($target);
	$acc = $userinfo["$lnick"]["auth"];
	$saxs = 0;
	$fop = fopen("./conf/staff.conf","r+");
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
		if ($god["$acc"] != 1) {
			sendserv("NOTICE $nick :You must enable security override (helping mode) to use this command.");
		}
		else {
			if ($tsets["nodelete"] == "1") {
				sendserv("NOTICE $nick :You can't unregister this channel while NoDelete is activated.");
				return(0);
			}
			$cfound = 0;
			$area = "";
			$fcont = "";
			$fop = fopen("./conf/users.conf","r+");
			while ($fra = fgets($fop)) {
				$fra = str_replace("\r","",$fra);
				$fra = str_replace("\n","",$fra);
				$frg = explode(" ",$fra);
				if ($frg[0] == "-") {
					$area = $frg[1];
					if ($area != $lchan) {
						$fcont .= $fra."\r\n";
					}
				}
				else {
					if ($area != $lchan) {
						$fcont .= $fra."\r\n";
					}
					else {
						$cfound = 1;
					}
				}
			}
			fclose($fop);
			$fop = fopen("./conf/users.conf","w+");
			fwrite($fop,$fcont);
			fclose($fop);
			$fcont = "";
			$area = "";
			$fop = fopen("./conf/settings.conf","r+");
			while ($fra = fgets($fop)) {
				$fra = str_replace("\r","",$fra);
				$fra = str_replace("\n","",$fra);
				$frg = explode(" ",$fra);
				if ($frg[0] == "-") {
					$area = $frg[1];
					if ($area != $lchan) {
						$fcont .= $fra."\r\n";
					}
				}
				else {
					if ($area != $lchan) {
						$fcont .= $fra."\r\n";
					}
				}
			}
			fclose($fop);
			$fop = fopen("./conf/settings.conf","w+");
			fwrite($fop,$fcont);
			fclose($fop);
			$fcont = "";
			$area = "";
			$fop = fopen("./conf/bans.conf","r+");
			while ($fra = fgets($fop)) {
				$fra = str_replace("\r","",$fra);
				$fra = str_replace("\n","",$fra);
				$frg = explode(" ",$fra);
				if ($frg[0] == "-") {
					$area = $frg[1];
					if ($area != $lchan) {
						$fcont .= $fra."\r\n";
					}
				}
				else {
					if ($area != $lchan) {
						$fcont .= $fra."\r\n";
					}
				}
			}
			fclose($fop);
			$fop = fopen("./conf/bans.conf","w+");
			fwrite($fop,$fcont);
			fclose($fop);
			if ($cfound == 1) {
				sendserv("PART $target :Unregistered by $nick ($acc).");
				sendserv("NOTICE $nick :$target has been unregistered.");
				if($showdebug == true){
					sendserv("PRIVMSG $debugchannel :$nick ($acc) unregistered $target");
				}
			}
			else {
				sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
			}
		}
	}
	else {
		sendserv("NOTICE $nick :You lack sufficient staff access to use this command.");
	}
}