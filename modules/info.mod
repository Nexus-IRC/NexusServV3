if (strtolower($cbase) == "info") {
	global $userinfo; global $chans; global $botnick; global $god;
	$lnick = strtolower($nick);
	$ctarg = strtolower($target);
	$tchan = $ctarg;
	$axs = 0;
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
	$registrar = "not registered";
	$acc = $userinfo["lnick"]["auth"];
	$registered = 0;
	$fop = fopen("./conf/users.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$fgr = explode(" ",$fra);
		if ($fgr[0] == "-" && $fgr[1] == $ctarg) {
			$registrar = $fgr[2];
			$registered = time() - $fgr[3];
		}
	}
	if ($chans["$ctarg"]["name"] != "" && $god["$acc"] != "1") {
		sendserv("NOTICE $nick :\002".$chans["$ctarg"]["name"]."\002 Channel Information:");
		sendserv("NOTICE $nick :Registrar:    $registrar");
		sendserv("NOTICE $nick :Registered:   ".time2str($registered));
		if ($chans["$ctarg"]["users"]["$lnick"] != "" or $god["$acc"] == "1" or $axs > 0) {
			sendserv("NOTICE $nick :Topic:        ".$chans["$ctarg"]["topic"]);
			sendserv("NOTICE $nick : Set by: ".$chans["$ctarg"]["topic_by"]);
			if ($paramzz == "nicklist") {
				sendserv("NOTICE $nick :Users:");
			}
			$unc = 0;
			foreach ($chans["$ctarg"]["users"] as $unick => $ustat) {
				$estat = "";
				if (str_replace("@","",$ustat) != $ustat) {
					$estat .= "@";
				}
				if (str_replace("+","",$ustat) != $ustat) {
					$estat .= "+";
				}
				$xt = "$estat".$userinfo["$unick"]["nick"];
				$nlist[$xt] = 1;
				$unc++;
			}
			ksort($nlist);
			if ($paramzz == "nicklist") {
				sendserv("NOTICE $nick :This parameter has been removed in Release 801");
				sendserv("NOTICE $nick :Use the \002nicklist\002 command instead.");
			}
			sendserv("NOTICE $nick :User Count:   $unc");
			sendserv("NOTICE $nick :Modes:        ".$chans["$ctarg"]["modes"]);
			sendserv("NOTICE $nick :Limit:        ".$chans["$ctarg"]["limit"]);
			sendserv("NOTICE $nick :Key:          ".$chans["$ctarg"]["key"]);
		}
		else {
			sendserv("NOTICE $nick :You must be on the channel or its userlist to see the channel information");
		}
	}
	else {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002".$botnick."\002.");
	}
}