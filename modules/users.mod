if (strtolower($cbase) == "users") {
	$cp = 0;
	$lsize = strlen("Account");
	$paz = explode(" ",$paramzz);
	if ($paz[1] == "") {
		$paz[1] = "1";
		$cp = 1;
	}
	if ($paz[2] == "") {
		$paz[2] = "500";
		$cp = 1;
	}
	$params = $paz[0];
	$sul = 6;
	global $chans; global $god;
	$ctarg = strtolower($target);
	$mc = 0;
	if ($params != "") {
		if ($paz[3] != "") {
			$matchstr = " matching $paz[3]";
			$pat = str_replace("[","\[",$paz[3]);
			$pat = str_replace("]","\]",$pat);
		}
		else {
			if ($cp == 1) {
				$matchstr = " matching $params";
			}
			$pat = str_replace("[","\[",$params);
			$pat = str_replace("]","\]",$pat);
		}
	}
	else {
		$pat = "*";
	}

	$fop = fopen("conf/users.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$fgr = explode(" ",$fra);
		if ($fgr[0] == "-") {
			$area = $fgr[1];
		}
		elseif ($fra == "") {
		}
		else {
			if ($area == $ctarg) {
				$uc++;
				$ualvl = str_replace("-","",$fgr[1]);
				if (str_replace("-","",$fgr[1]) != $fgr[1]) {
					$ustat[strtolower($fgr[0])] = "Suspended";
					$sul = 9;
				}
				$userz["$ualvl"][strtolower("$fgr[0]")] = array("1");
				if ($god["$fgr[0]"] == 1) {
					if (staffstat($fgr[0]) != "Bot") {
						$sul = 17;
					}
				}
				$xun[strtolower("$fgr[0]")] = $fgr[0];
				if (strlen($fgr[0]) > $lsize) {
					$lsize = strlen($fgr[0]);
				}
				$found = 1;
			}
		}
	}
	if (vaccess($paz[1],500) != "yes") {
		sendserv("NOTICE $nick :\002$paz[1]\002 is not a valid access level!");
		return(0);
	}
	if (vaccess($paz[2],500) != "yes") {
		sendserv("NOTICE $nick :\002$paz[2]\002 is not a valid access level!");
		return(0);
	}
	sendserv("NOTICE $nick :".@(isset($chans["$ctarg"]["name"]) ? $chans["$ctarg"]["name"] : $ctarg)." users from level $paz[1] to $paz[2]".$matchstr.":");
	sendserv("NOTICE $nick :Access".spaces("Access",6)." Account".spaces("Account",$lsize)." Status".spaces("Status",$sul)." Last Seen");
	krsort($userz);
	foreach ($userz as $uaxs => $unam) {
		ksort($unam);
		foreach ($unam as $unme => $unmear) {
			if (fnmatch(strtolower($pat),$unme)) {
				$stat = "Normal";
				if ($god[$xun["$unme"]] == 1) {
					$stat = "Security Override";
				}
				if ($ustat[$unme] != "") {
					$stat = $ustat[$unme];
				}
				if (staffstat($xun["$unme"]) == "Bot") {
					$stat = "Bot";
				}
				if ($uaxs >= $paz[1] && $uaxs <= $paz[2]) {
					sendserv("NOTICE $nick :$uaxs".spaces("$uaxs",6)." ".$xun[$unme].spaces($xun[$unme],$lsize)." ".$stat.spaces($stat,$sul)." ".lseen($unme,$ctarg)); 
					$mc++;
				}
			}
		}
	}
	sendserv("NOTICE $nick :There are \002$uc\002 users in ".$chans["$ctarg"]["name"].".\n");
	if ($params != "") {
		sendserv("NOTICE $nick :There are \002$mc\002 users in ".$chans["$ctarg"]["name"]." matching your request.\n");
	}
}