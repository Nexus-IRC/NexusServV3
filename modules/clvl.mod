if (strtolower($cbase) == "clvl") {
	$params = $paramzz;
	global $userinfo; global $chans; global $god; global $waitfor; global $botnick;
	$lnick = strtolower($nick);
	$acc = $userinfo["$lnick"]["auth"];
	$pp = explode(" ",$params);
	$pa = $pp[0];
	$pn = strtolower($pa);
	$pe = $pp[1];
	$cfound = 0;
	$ppe = $pp[1];
	$accs = array();
	$ctarg = strtolower($target);
	$tchan = $ctarg;
	$area = "";
	$xyz = 500;
	$valid = 0;
	while ($xyz > 0) {
		if ("$pe" == "$xyz") {
			$valid = 1;
		}
		$xyz = $xyz - 1;
	}
	if ($valid == 0) {
		sendserv("NOTICE $nick :\002$pe\002 is an invalid access level.");
		return(0);
	}
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
	if ($tsets['changeusers'] == "") {
		$tsets['changeusers'] = "300";
	}
	if ($tsets['adduser'] == "") {
		$tsets['adduser'] = $tsets['changeusers'];
	}
	if ($tsets['deluser'] == "") {
		$tsets['deluser'] = $tsets['changeusers'];
	}
	if ($tsets['clvl'] == "") {
		$tsets['clvl'] = $tsets['changeusers']; 
	}
	$cname = $chans["$ctarg"]["name"];
	$fop = fopen("users.conf","r+");
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
	$fop = fopen("accs.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		$frgl = strtolower($frg[0]);
		$accs["$frgl"] = $frg[0];
	}
	fclose($fop);
	if ($cfound == 0) {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
	}
	if ($acc == "") {
		sendserv("NOTICE $nick :$nick is not authed with \002AuthServ\002.");
		return(0);
	}
	if ($axs["$acc"] < $tsets['clvl'] && $god["$acc"] != "1") {
		sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
		return(0);
	}
	if ($params == "") {
		sendserv("NOTICE $nick :More parameters required: <*account|nick> <access>");
		return(0);
	}
	elseif ($params[0] == "*") {
		$pa = substr($pa,1);
		$pal = strtolower($pa);
		if ($accs["$pal"] == "") {
			sendserv("NOTICE $nick :This account (\002$pa\002) is unknown to me.");
			return(0);
		}
		else {
			$tacc = $accs["$pal"];
		}
		if ($axs["$tacc"] == "") {
			sendserv("NOTICE $nick :$tacc is not on the userlist for $cname.");
			return(0);
		}
		if ($acc == $tacc && $god["$acc"] != "1") {
			sendserv("NOTICE $nick :You cant change your own access.");
			return(0);
		}
		if ($axs["$tacc"] >= $axs["$acc"] && $god["$acc"] != "1") {
			sendserv("NOTICE $nick :Command has no effect (User $tacc ranks you off.);");
			return(0);
		}
		if ($pe >= $axs["$acc"] && $god["$acc"] != "1") {
			sendserv("NOTICE $nick :You may not change the level of a user higher than or equal to yours.");
			return(0);
		}
		if ($pe < 1 && $god["$acc"] != "1") {
			sendserv("NOTICE $nick :Negative (suspended) access levels are to be set with \002suspend\002.");
			return(0);
		}
		$area = "";
		$fcont = "";
		$fop = fopen("users.conf","r+");
		while ($fra = fgets($fop)) {
			$fra = str_replace("\r","",$fra);
			$fra = str_replace("\n","",$fra);
			$frg = explode(" ",$fra);
			if ($frg[0] == "-") {
				$area = $frg[1];
				$fcont .= $fra."\r\n";
			}
			elseif ($frg[0] == "") {
			}
				else {
				if ($area == $ctarg && $frg[0] == $tacc) {
					$fcont .= $frg[0]." $pe\r\n";
				}
				else {
					$fcont .= $fra."\r\n";
				}
			}
		}
		fclose($fop);
		$fop = fopen("users.conf","w+");
		fwrite($fop,$fcont);
		fclose($fop);
		sendserv("NOTICE $nick :$tacc now has access $pe (before the user had ".$axs["$tacc"].")");
	}
	else {
		if ($userinfo["$pn"]["nick"] == "") {
			if ($userinfo["$pn"]["unknown"] != "1") {
				$wfc = count($waitfor["$pn"]) + 1;
				$waitfor["$pn"][$wfc] = "CMD clvl $nick $user $host $cchan $target $params";
				sendserv("WHOIS $pn");
				return(0);
			}
			else {
				sendserv("NOTICE $nick :User \002$pn\002 doesn't exist.");
				return(0);
			}
		}
		$pnnick = $userinfo["$pn"]["nick"];
		if ($userinfo["$pn"]["auth"] == "") {
			sendserv("NOTICE $nick :$pnnick is not authed with \002AuthServ\002.");
			return(0);
		}
		$pa = $userinfo["$pn"]["auth"];
		$pal = strtolower($pa);
		if ($accs["$pal"] == "") {
			$fop = fopen("accs.conf","a+");
			fwrite($fop,"\r\n$pa");
			fclose($fop);
			$tacc = $pa;
		}
		else {
			$tacc = $accs["$pal"];
		}
		if ($axs["$tacc"] == "") {
			sendserv("NOTICE $nick :$pnnick ($tacc) is not on the userlist for $cname.");
			return(0);
		}
		if ($acc == $tacc && $god["$acc"] != "1") {
			sendserv("NOTICE $nick :You cant change your own access.");
			return(0);
		}
		if ($axs["$tacc"] >= $axs["$acc"] && $god["$acc"] != "1") {
			sendserv("NOTICE $nick :Command has no effect (User $pnnick ($tacc) ranks you off.);");
			return(0);
		}
		if ($pe >= $axs["$acc"] && $god["$acc"] != "1") {
			sendserv("NOTICE $nick :You may not change the level of a user higher than or equal to yours.");
			return(0);
		}
		$area = "";
		$fcont = "";
		$fop = fopen("users.conf","r+");
		while ($fra = fgets($fop)) {
			$fra = str_replace("\r","",$fra);
			$fra = str_replace("\n","",$fra);
			$frg = explode(" ",$fra);
			if ($frg[0] == "-") {
				$area = $frg[1];
				$fcont .= $fra."\r\n";
			}
			elseif ($frg[0] == "") {
			}
			else {
				if ($area == $ctarg && $frg[0] == $tacc) {
					$fcont .= $frg[0]." $pe\r\n";
				}
				else {
					$fcont .= $fra."\r\n";
				}
			}
		}
		fclose($fop);
		$fop = fopen("users.conf","w+");
		fwrite($fop,$fcont);
		fclose($fop);
		sendserv("NOTICE $nick :$pnnick ($tacc) now has access $pe (before the user had ".$axs["$tacc"].")");
	}
}