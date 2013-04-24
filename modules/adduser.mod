if (strtolower($cbase) == "adduser") {
	$params = $paramzz;
	global $userinfo; global $chans; global $god; global $waitfor; global $botnick;
	$lnick = strtolower($nick);
	$acc = $userinfo["$lnick"]["auth"];
	$pp = explode(" ",$params);
	$pa = $pp[0];
	$pn = strtolower($pa);
	$axs = 0;
	$pe = $pp[1];
	$ppe = $pp[1];
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
	$ctarg = strtolower($target);
	$tchan = $ctarg;
	fclose($fop);
	$area = "";
	$fop = fopen("conf/settings.conf","r+");
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
	if ($cname == "") {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
		return(0);
	}
	if ($acc == "") {
		sendserv("NOTICE $nick :$nick is not authed with \002AuthServ\002.");
		return(0);
	}
	if ($params == "") {
		sendserv("NOTICE $nick :More parameters required: <*account|nick> <access>");
		return(0);
	}
	if ($pp[1] == "") {
		sendserv("NOTICE $nick :You need to specify an access level!");
		return(0);
	}
	elseif ($params[0] == "*") {
		$pa = substr($pa,1);
		$pe = $pp[1];
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
					if ($frg[0] == $userinfo["$lnick"]["auth"]) {
						$axs = $frg[1];
					}
					if (strtolower($frg[0]) == strtolower($pa)) {
						sendserv("NOTICE $nick :$frg[0] is already on the userlist for $cname (with access $frg[1]).");
						return(0);
					}
					$cfound = 1;
				}
			}
		}
		fclose($fop);
		if ($axs < asetting($tsets['adduser']) && $god["$acc"] != "1") {
			sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command");
			return(0);
		}
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
		if ($pe >= $axs && $god["$acc"] != 1) {
			sendserv("NOTICE $nick :You may not add a user with access equal to or higher as your own.");
			return(0);
		}
		$accfound = "";
		$fop = fopen("conf/accs.conf","r+");
		while ($fra = fgets($fop)) {
			$fra = str_replace("\r","",$fra);
			$fra = str_replace("\n","",$fra);
			$frg = explode(" ",$fra);
			if (strtolower($frg[0]) == strtolower($pa)) {
				$accfound = $frg[0];
			}
		}
		if ($accfound == "") {
			sendserv("NOTICE $nick :This account (\002$pa\002) is unknown to me.");
			return(0);
		}
		$fcont = "";
		$fop = fopen("conf/users.conf","r+");
		while ($fra = fgets($fop)) {
			$fra = str_replace("\r","",$fra);
			$fra = str_replace("\n","",$fra);
			$frg = explode(" ",$fra);
			if ($frg[0] == "-") {
				$area = $frg[1];
				$fcont .= $fra."\r\n";
				if ($area == $ctarg) {
					$fcont .= "$accfound $ppe\r\n";
				}
			}
			else {
				$fcont .= $fra."\r\n";
			}
		}
		fclose($fp);
		$fop = fopen("conf/users.conf","w+");
		fwrite($fop,$fcont);
		fclose($fop);
		sendserv("NOTICE $nick :$accfound has been added to the $cname user list with access $ppe");
	}
	else {
		if ($userinfo["$pn"]["nick"] == "") {
			if ($userinfo["$pn"]["unknown"] != "1") {
				$wfc = count($waitfor["$pn"]) + 1;
				$waitfor["$pn"][$wfc] = "CMD adduser $nick $user $host $cchan $target $params";
				sendserv("WHOIS $pn");
				return(0);
			}
			else {
				sendserv("NOTICE $nick :User \002$pn\002 doesn't exist.");
				return(0);
			}
		}
		if ($userinfo["$pn"]["auth"] == "") {
			sendserv("NOTICE $nick :".$userinfo["$pn"]["nick"]." is not authed with \002AuthServ\002.");
			return(0);
		}
		$pnnick = $userinfo["$pn"]["nick"];
		$pa = $userinfo["$pn"]["auth"];
		$pe = $pp[1];
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
					if ($frg[0] == $userinfo["$lnick"]["auth"]) {
						$axs = $frg[1];
					}
					if (strtolower($frg[0]) == strtolower($pa)) {
						sendserv("NOTICE $nick :$pnnick ($frg[0]) is already on the userlist for $cname (with access $frg[1]).");
						return(0);
					}
					$cfound = 1;
				}
			}
		}
		fclose($fop);
		if ($axs < asetting($tsets['adduser']) && $god["$acc"] != "1") {
			sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command");
			return(0);
		}
		$xyz = 500;
		$valid = 0;
		while ($xyz > -1) {
			if ($pe == $xyz) {
				$valid = 1;
			}
			$xyz = $xyz - 1;
		}
		if ($valid == 0) {
			sendserv("NOTICE $nick :\002$pe\002 is an invalid access level.");
			return(0);
		}
		if ($pe >= $axs && $god["$acc"] != 1) {
			sendserv("NOTICE $nick :You may not add a user with access equal to or higher as your own.");
			return(0);
		}
		$accfound = "";
		$fop = fopen("conf/accs.conf","r+");
		while ($fra = fgets($fop)) {
			$fra = str_replace("\r","",$fra);
			$fra = str_replace("\n","",$fra);
			$frg = explode(" ",$fra);
			if (strtolower($frg[0]) == strtolower($pa)) {
				$accfound = $frg[0];
			}
		}
		if ($accfound == "") {
			$fop = fopen("conf/accs.conf","a+");
			fwrite($fop,"\r\n$pa");
			fclose($fop);
			$accfound = $pa;
		}
		$fcont = "";
		$fop = fopen("conf/users.conf","r+");
		while ($fra = fgets($fop)) {
			$fra = str_replace("\r","",$fra);
			$fra = str_replace("\n","",$fra);
			$frg = explode(" ",$fra);
			if ($frg[0] == "-") {
				$area = $frg[1];
				$fcont .= $fra."\r\n";
				if ($area == $ctarg) {
					$fcont .= "$accfound $ppe\r\n";
				}
			}
			else {
				$fcont .= $fra."\r\n";
			}
		}
		fclose($fp);
		$fop = fopen("conf/users.conf","w+");
		fwrite($fop,$fcont);
		fclose($fop);
		sendserv("NOTICE $nick :$pnnick ($accfound) has been added to the $cname user list with access $ppe");
	}
}