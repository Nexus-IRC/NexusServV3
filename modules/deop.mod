if (strtolower($cbase) == "deop") {
	$params = $paramzz;
	$tchan = strtolower($target);
	$lnick = strtolower($nick);
	$area = "";
	$axs = 0;
	$cfound = 0;
	$uaxs = array();
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
				$uaxs["$frg[0]"] = $frg[1];
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
	if ($cfound == 0) {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
		return(0);
	}
	$cname = $chans["$tchan"]["name"];
	if ($axs < 300 || $god[$acc] == 0) {
		sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
		return(0);
	}
	$pp = explode(" ",$params);
	$reason = breason(substr($params,strlen($pp[0]." ")));
	$targ = $pp[0];
	if (str_replace("@","",$targ) != $targ) {
		if (str_replace("!","",$targ) != $targ) {
			foreach($chans["$tchan"]["users"] as $unick => $ustat) {
				$userhost = $userinfo["$unick"]["nick"]."!".$userinfo["$unick"]["ident"]."@".$userinfo["$unick"]["host"];
				$uauth = $userinfo["$unick"]["auth"];
				if (fnmatch(bmask(strtolower($targ)),strtolower($userhost))) {
					if ($uaxs["$uauth"] < $axs or $uaxs["$uauth"] == "") {
						if ($unick != strtolower($botnick)) {
							sendserv("MODE $target -o $unick");
							//sendserv("KICK $target $unick :($nick) $reason");
						}
					}
					else {
						if ($axs >= 500) {
							if ($unick == strtolower($botnick)) {
								sendserv("NOTICE $nick :This kickmask matches the bots hostmask, and may not be set.");
								return(0);
							}
							sendserv("MODE $target -o $unick");
							//sendserv("KICK $target $unick :($nick) $reason");
						}
						else {
							sendserv("NOTICE $nick :Deop cannot be done: User ".$userinfo["$unick"]["nick"]." ($uauth) outranks you.");
							return(0);
						}
					}
				}
			}
		}
		else {
			sendserv("NOTICE $nick :\002$targ\002 is not a valid ban host.");
			return(0);
		}
	}
	elseif ($targ[0] == "*") {
		$targ = "*!*@".substr($targ,1).".*";
		if (str_replace("@","",$targ) != $targ) {
			if (str_replace("!","",$targ) != $targ) {
				foreach($chans["$tchan"]["users"] as $unick => $ustat) {
					$userhost = $userinfo["$unick"]["nick"]."!".$userinfo["$unick"]["ident"]."@".$userinfo["$unick"]["host"];
					$uauth = $userinfo["$unick"]["auth"];
					if (fnmatch(bmask(strtolower($targ)),strtolower($userhost))) {
						if ($uaxs["$uauth"] < $axs or $uaxs["$uauth"] == "") {
							if ($unick != strtolower($botnick)) {
								sendserv("MODE $target -o $unick");
								//sendserv("KICK $target $unick :($nick) $reason");
							}
						}
						else {
							if ($axs >= 500) {
								if ($unick == strtolower($botnick)) {
									sendserv("NOTICE $nick :This kickmask matches the bots hostmask, and may not be set.");
									return(0);
								}
								sendserv("MODE $target -o $unick");
								//sendserv("KICK $target $unick :($nick) $reason");
							}
							else {
								sendserv("NOTICE $nick :Deop cannot be done: User ".$userinfo["$unick"]["nick"]." ($uauth) outranks you.");
								return(0);
							}
						}
					}
				}
			}
			else {
				sendserv("NOTICE $nick :\002$targ\002 is not a valid kick host.");
				return(0);
			}
		}
	}
	else {
		$targ = $targ."!*@*";
		if (str_replace("@","",$targ) != $targ) {
			if (str_replace("!","",$targ) != $targ) {
				foreach($chans["$tchan"]["users"] as $unick => $ustat) {
					$userhost = $userinfo["$unick"]["nick"]."!".$userinfo["$unick"]["ident"]."@".$userinfo["$unick"]["host"];
					$uauth = $userinfo["$unick"]["auth"];
					if (fnmatch(bmask(strtolower($targ)),strtolower($userhost))) {
						if ($uaxs["$uauth"] < $axs or $uaxs["$uauth"] == "") {
							if ($unick != strtolower($botnick)) {
								sendserv("MODE $target -o $unick");
								//sendserv("KICK $target $unick :($nick) $reason");
							}
						}
						else {
							if ($axs >= 500) {
								if ($unick != strtolower($botnick)) {
									sendserv("MODE $target -o $unick");
									//sendserv("KICK $target $unick :($nick) $reason");
								}
							}
							else {
								sendserv("NOTICE $nick :Deop cannot be done: User ".$userinfo["$unick"]["nick"]." ($uauth) outranks you.");
								return(0);
							}
						}
					}
				}
			}
			else {
				sendserv("NOTICE $nick :\002$targ\002 is not a valid ban host.");
				return(0);
			}
		}
	}
	sendserv("NOTICE $nick :User(s) have been deopped in $cname.");
}