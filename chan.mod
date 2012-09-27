// cbase: mode
// cbase: deluser
// cbase: access
// cbase: adduser
// cbase: clvl
// cbase: info
// cbase: uset
// cbase: inviteme
// cbase: down
// cbase: downall
// cbase: myaccess
// cbase: up
// cbase: upall
// cbase: resync
// cbase: register
// cbase: unregister
// cbase: bans
// cbase: kick
// cbase: kickban
// cbase: ban
// cbase: unbanall
// cbase: addban
// cbase: timeban
// cbase: delban
// cbase: events
// cbase: invite
// cbase: banall
// cbase: deop
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
	if ($axs < 400) {
		sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
	}
	else {
		$fop = fopen("bans.conf","r+");
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
elseif (strtolower($cbase) == "invite") {
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
elseif (strtolower($cbase) == "events") {
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
	if ($cfound == 0) {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
		return(0);
	}
	if ($params == "") {
		$paramz = "10m";
	}
	else {
		$paramz = $params;
	}
	if ($paramz != "*") {
		$tdur = str2time($paramz);
		if ($tdur == "I") {
			sendserv("NOTICE $nick :\002$params\002 is an invalid time span.");
		}
		sendserv("NOTICE $nick :Events from ".$chans["$tchan"]["name"]." from the last ".time2str(str2time("$tdur")).":");
	}
	else {
		sendserv("NOTICE $nick :Events from ".$chans["$tchan"]["name"]." (\002all, since registration\002)");
	}
	$evcnt = 0;
	if ($axs >= 200) {
		$fop = fopen("events.log","r+");
		while ($fra = fgets($fop)) {
			$fra = str_replace("\r","",$fra);
			$fra = str_replace("\n","",$fra);
			$frg = explode(" ",$fra);
			$fm = explode("?",$frg[2]);
			if ($fm[1] != "") {
				$fres = $fm[0].":".$fm[1];
			}
			else {
				$fres = $fm[0];
			}
			if ($frg[0] == $tchan && $frg[1] >= (time() - str2time("$tdur")) or $frg[0] == $tchan && $params == "*") {
				$evcnt++;
				sendserv("NOTICE $nick :(".date("H:i:s d/m/y","$frg[1]").") [".$fres."] ".substr($fra,strlen("$frg[0] $frg[1] $frg[2] ")));
			}
		}
		fclose($fop);
		sendserv("NOTICE $nick :Found \002$evcnt\002 events in ".$chans["$tchan"]["name"].".");
	}
}
elseif (strtolower($cbase) == "delban") {
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
	if ($axs < 400 && $god["$acc"] != "1") {
		sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
		return(0);
	}
	$pp = explode(" ",$params);
	$reason = breason(substr($params,strlen($pp[0]." ")));
	$targ = $pp[0];
	if (str_replace("@","",$targ) != $targ) {
		if (str_replace("!","",$targ) != $targ) {
			// Nothing
		}
		else {
			sendserv("NOTICE $nick :\002$targ\002 is not a valid ban host.");
			return(0);
		}
	}
	elseif ($targ[0] == "*") {
		$targ = "*!*@".substr($targ,1).".*";
	}
	else {
		$targ = $targ."!*@*";
	}
	$bcfound = 0;
	$xx = 0;
	$fcont = "";
	$fop = fopen("bans.conf","r+");
	$ccnt = 0;
	$cmodes = "";
	$cparms = "";
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
		$area = $frg[1];
		$fcont .= "$fra\r\n";
		if ($area == $tchan) {
		$bcfound = 1;
		}
		}
		elseif ($fra == "") {
		}
		else {
			if ($area == $tchan) {
				if (fnmatch(bmask(strtolower($targ)),strtolower($frg[0]))) {
					$ccnt++;
					$cmodes .= "-b";
					$cparms .= " $frg[0]";
					if ($ccnt == 6) {
						sendserv("MODE $target $cmodes $cparms");
						$ccnt = 0;
						$cmodes = "";
						$cparms = "";
					}
				}
				else {
					$fcont .= "$fra\r\n";
				}
			}
			else {
				$fcont .= "$fra\r\n";
			}
		}
	}
	fclose($fop);
	if ($bcfound == 0) {
		$fcont .= "- $tchan\r\n";
		$fcont .= "$targ $acc p $reason\r\n";
	}
	$fop = fopen("bans.conf","w+");
	fwrite($fop,$fcont);
	fclose($fop);
	if ($cmodes != "") {
		sendserv("MODE $target $cmodes $cparms");
	}
	sendserv("NOTICE $nick :All bans matching \002$targ\002 have been removed.");
}
elseif (strtolower($cbase) == "timeban") {
	$params = $paramzz;
	$tchan = strtolower($target);
	$lnick = strtolower($nick);
	$area = "";
	$axs = 0;
	$cfound = 0;
	$uaxs = array();
	global $userinfo; global $chans; global $botnick; global $god; global $botnick;
	$lbotnick = strtolower($botnick);
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
	if ($axs < 400 && $god["$acc"] != "1") {
		sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
		return(0);
	}
	$pp = explode(" ",$params);
	$reason = breason(substr($params,strlen($pp[0]." ".$pp[1]." ")));
	$targ = $pp[0];
	if ($pp[1] == "p") {
		sendserv("NOTICE $nick :To ban someone permanently, please use \002addban\002.");
		return(0);
	}
	$btime = str2time($pp[1]);
	if ($btime != "I") {
		$btime = time() + $btime;
	}
	else {
		sendserv("NOTICE $nick :\002$pp[1]\002 is an invalid time span.");
		return(0);
	}
	if (str_replace("@","",$targ) != $targ) {
		if (str_replace("!","",$targ) != $targ) {
			foreach($chans["$tchan"]["users"] as $unick => $ustat) {
				$userhost = $userinfo["$unick"]["nick"]."!".$userinfo["$unick"]["ident"]."@".$userinfo["$unick"]["host"];
				$uauth = $userinfo["$unick"]["auth"];
				if (fnmatch(bmask(strtolower($targ)),strtolower($userhost))) {
					if ($uaxs["$uauth"] < $axs or $uaxs["$uauth"] == "") {
						if ($unick != strtolower($botnick)) {
							sendserv("MODE $target -o $unick");
							sendserv("KICK $target $unick :($nick) $reason");
						}
					}
					else {
						if ($axs >= 500 or $acc = $userinfo["$lbotnick"]["auth"]) {
							if ($unick != strtolower($botnick)) {
								sendserv("MODE $target -o $unick");
								sendserv("KICK $target $unick :($nick) $reason");
							}
						}
						else {
							sendserv("NOTICE $nick :Ban cannot be set: User ".$userinfo["$unick"]["nick"]." ($uauth) ranks you off.");
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
								sendserv("KICK $target $unick :($nick) $reason");
							}
						}
						else {
							if ($axs >= 500 or $acc = $userinfo["$lbotnick"]["auth"]) {
								if ($unick != strtolower($botnick)) {
									sendserv("MODE $target -o $unick");
									sendserv("KICK $target $unick :($nick) $reason");
								}
							}
							else {
								sendserv("NOTICE $nick :Ban cannot be set: User ".$userinfo["$unick"]["nick"]." ($uauth) ranks you off.");
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
								sendserv("KICK $target $unick :($nick) $reason");
							}
						}
						else {
							if ($axs >= 500 or $acc = $userinfo["$lbotnick"]["auth"]) {
								if ($unick != strtolower($botnick)) {
									sendserv("MODE $target -o $unick");
									sendserv("KICK $target $unick :($nick) $reason");
								}
							}
							else {
								sendserv("NOTICE $nick :Ban cannot be set: User ".$userinfo["$unick"]["nick"]." ($uauth) ranks you off.");
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
	$modifyban = 0;
	$bcfound = 0;
	$xx = 0;
	$fcont = "";
	$fop = fopen("bans.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
			$area = $frg[1];
			$fcont .= "$fra\r\n";
			if ($area == $tchan) {
				$bcfound = 1;
				$fcont .= "$targ $acc $btime $reason\r\n";
			}
		}
		elseif ($fra == "") {
		}
		else {
			if ($area == $tchan) {
				if (fnmatch(bmask(strtolower($targ)),strtolower($frg[0]))) {
					$modifyban++;
				}
				else {
					$fcont .= "$fra\r\n";
				}
			}
			else {
				$fcont .= "$fra\r\n";
			}
		}
	}
	fclose($fop);
	if ($bcfound == 0) {
		$fcont .= "- $tchan\r\n";
		$fcont .= "$targ $acc $btime $reason\r\n";
	}
	$fop = fopen("bans.conf","w+");
	fwrite($fop,$fcont);
	fclose($fop);
	sendserv("MODE $target +b $targ");
	if ($modifyban != 0) {
		sendserv("NOTICE $nick :\002$modifyban\002 bans have been changed.");
	}
	sendserv("NOTICE $nick :\002$targ\002 has been banned from $cname for ".time2str($btime - time()).".");
}
elseif (strtolower($cbase) == "addban") {
	$params = $paramzz;
	$tchan = strtolower($target);
	$lnick = strtolower($nick);
	$area = "";
	$axs = 0;
	$cfound = 0;
	$uaxs = array();
	global $userinfo; global $chans; global $botnick; global $god; global $botnick;
	$lbotnick = strtolower($botnick);
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
	if ($axs < 400 && $god["$acc"] != "1") {
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
							sendserv("KICK $target $unick :($nick) $reason");
						}
					}
					else {
						if ($axs >= 500 or $acc = $userinfo["$lbotnick"]["auth"]) {
							if ($unick != strtolower($botnick)) {
								sendserv("MODE $target -o $unick");
								sendserv("KICK $target $unick :($nick) $reason");
							}
						}
						else {
							sendserv("NOTICE $nick :Ban cannot be set: User ".$userinfo["$unick"]["nick"]." ($uauth) ranks you off.");
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
								sendserv("KICK $target $unick :($nick) $reason");
							}
						}
						else {
							if ($axs >= 500 or $acc = $userinfo["$lbotnick"]["auth"]) {
								if ($unick != strtolower($botnick)) {
									sendserv("MODE $target -o $unick");
									sendserv("KICK $target $unick :($nick) $reason");
								}
							}
							else {
								sendserv("NOTICE $nick :Ban cannot be set: User ".$userinfo["$unick"]["nick"]." ($uauth) ranks you off.");
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
								sendserv("KICK $target $unick :($nick) $reason");
							}
						}
						else {
							if ($axs >= 500 or $acc = $userinfo["$lbotnick"]["auth"]) {
								if ($unick != strtolower($botnick)) {
									sendserv("MODE $target -o $unick");
									sendserv("KICK $target $unick :($nick) $reason");
								}
							}
							else {
								sendserv("NOTICE $nick :Ban cannot be set: User ".$userinfo["$unick"]["nick"]." ($uauth) ranks you off.");
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
	$modifyban = 0;
	$bcfound = 0;
	$xx = 0;
	$fcont = "";
	$fop = fopen("bans.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
			$area = $frg[1];
			$fcont .= "$fra\r\n";
			if ($area == $tchan) {
				$bcfound = 1;
				$fcont .= "$targ $acc p $reason\r\n";
			}
		}
		elseif ($fra == "") {
		}
		else {
			if ($area == $tchan) {
				if (fnmatch(bmask(strtolower($targ)),strtolower($frg[0]))) {
					$modifyban++;
				}
				else {
					$fcont .= "$fra\r\n";
				}
			}
			else {
				$fcont .= "$fra\r\n";
			}
		}
	}
	fclose($fop);
	if ($bcfound == 0) {
		$fcont .= "- $tchan\r\n";
		$fcont .= "$targ $acc p $reason\r\n";
	}
	$fop = fopen("bans.conf","w+");
	fwrite($fop,$fcont);
	fclose($fop);
	sendserv("MODE $target +b $targ");
	if ($modifyban != 0) {
		sendserv("NOTICE $nick :\002$modifyban\002 bans have been changed.");
	}
	sendserv("NOTICE $nick :\002$targ\002 has been permanently banned from $cname.");
}
elseif (strtolower($cbase) == "unbanall") {
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
	if ($axs < 400) {
		sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
	}
	else {
	sendserv("MODE $cname -b *");
	sendserv("NOTICE $nick :Removed all channel bans from \002$cname\002.");
	}
}
elseif (strtolower($cbase) == "ban") {
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
	if ($axs < 400) {
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
						}
					}
					else {
							if ($axs >= 500) {
							if ($unick != strtolower($botnick)) {
								sendserv("MODE $target -o $unick");
							}
						}
						else {
							sendserv("NOTICE $nick :Ban cannot be set: User ".$userinfo["$unick"]["nick"]." ($uauth) ranks you off.");
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
							}
						}
						else {
							if ($axs >= 500) {
								if ($unick != strtolower($botnick)) {
									sendserv("MODE $target -o $unick");
								}
							}
							else {
								sendserv("NOTICE $nick :Ban cannot be set: User ".$userinfo["$unick"]["nick"]." ($uauth) ranks you off.");
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
							}
						}
						else {
							if ($axs >= 500) {
								if ($unick == strtolower($botnick)) {
									sendserv("NOTICE $nick :This ban matches the bots hostmask, and may not be set.");
									return(0);
								}
								sendserv("MODE $target -o $unick");
							}
							else {
								sendserv("NOTICE $nick :Ban cannot be set: User ".$userinfo["$unick"]["nick"]." ($uauth) ranks you off.");
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
	sendserv("MODE $target +b $targ");
	sendserv("NOTICE $nick :Users have been banned from $cname.");
}
elseif (strtolower($cbase) == "kickban") {
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
	if ($axs < 400) {
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
							sendserv("KICK $target $unick :($nick) $reason");
						}
					}
					else {
						if ($axs >= 500) {
							if ($unick != strtolower($botnick)) {
								sendserv("MODE $target -o $unick");
								sendserv("KICK $target $unick :($nick) $reason");
							}
						}
						else {
							sendserv("NOTICE $nick :Ban cannot be set: User ".$userinfo["$unick"]["nick"]." ($uauth) ranks you off.");
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
								sendserv("KICK $target $unick :($nick) $reason");
							}
						}
						else {
							if ($axs >= 500) {
								if ($unick != strtolower($botnick)) {
									sendserv("MODE $target -o $unick");
									sendserv("KICK $target $unick :($nick) $reason");
								}
							}
							else {
								sendserv("NOTICE $nick :Ban cannot be set: User ".$userinfo["$unick"]["nick"]." ($uauth) ranks you off.");
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
								sendserv("KICK $target $unick :($nick) $reason");
							}
						}
						else {
							if ($axs >= 500) {
								if ($unick != strtolower($botnick)) {
									sendserv("MODE $target -o $unick");
									sendserv("KICK $target $unick :($nick) $reason");
								}
							}
							else {
								sendserv("NOTICE $nick :Ban cannot be set: User ".$userinfo["$unick"]["nick"]." ($uauth) ranks you off.");
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
	sendserv("MODE $target +b $targ");
	sendserv("NOTICE $nick :Users have been kickbanned from $cname.");
}
elseif (strtolower($cbase) == "kick") {
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
	if ($axs < 400) {
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
							sendserv("KICK $target $unick :($nick) $reason");
						}
					}
					else {
						if ($axs >= 500) {
							if ($unick == strtolower($botnick)) {
								sendserv("NOTICE $nick :This kickmask matches the bots hostmask, and may not be set.");
								return(0);
							}
							sendserv("MODE $target -o $unick");
							sendserv("KICK $target $unick :($nick) $reason");
						}
						else {
							sendserv("NOTICE $nick :Kick cannot be done: User ".$userinfo["$unick"]["nick"]." ($uauth) ranks you off.");
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
								sendserv("KICK $target $unick :($nick) $reason");
							}
						}
						else {
							if ($axs >= 500) {
								if ($unick == strtolower($botnick)) {
									sendserv("NOTICE $nick :This kickmask matches the bots hostmask, and may not be set.");
									return(0);
								}
								sendserv("MODE $target -o $unick");
								sendserv("KICK $target $unick :($nick) $reason");
							}
							else {
								sendserv("NOTICE $nick :Kick cannot be done: User ".$userinfo["$unick"]["nick"]." ($uauth) ranks you off.");
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
								sendserv("KICK $target $unick :($nick) $reason");
							}
						}
						else {
							if ($axs >= 500) {
								if ($unick != strtolower($botnick)) {
									sendserv("MODE $target -o $unick");
									sendserv("KICK $target $unick :($nick) $reason");
								}
							}
							else {
								sendserv("NOTICE $nick :Kick cannot be done: User ".$userinfo["$unick"]["nick"]." ($uauth) ranks you off.");
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
	sendserv("NOTICE $nick :Users have been kicked from $cname.");
}
elseif (strtolower($cbase) == "bans") {
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
	if ($cfound == 0) {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
		return(0);
	}
	$cname = $chans["$tchan"]["name"];
	$lnick = strtolower($nick);
	if ($axs < 400 && $GLOBALS['god'][$acc] != 1) {
		sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
		return(0);
	}
	$xx = 0;
	$hl = strlen("Host");
	$nl = strlen("Set By");
	$ele = strlen("Expires");
	$fop = fopen("bans.conf","r+");
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
				if (strlen($frg[0]) > $hl) {
					$hl = strlen($frg[0]);
				}
				if (strlen($frg[1]) > $nl) {
					$nl = strlen($frg[1]);
				}
				if (strlen(b_expiry($frg[2])) >= $ele) {
					$ele = strlen(b_expiry($frg[2]));
				}
				$bans[$xx] = $frg[0]." ".$frg[1]." ".$frg[2]." ".substr($fra,strlen("$frg[0] $frg[1] $frg[2] "));
				$xx++;
			}
		}
	}
	fclose($fop);
	sendserv("NOTICE $nick :$cname ban list:");
	sendserv("NOTICE $nick :Host".spaces("Host",$hl)." Set By".spaces("Set By",$nl)." Expires".spaces("Expires",$ele)." Reason");
	if ($xx == 0) {
		sendserv("NOTICE $nick :        None");
	}
	foreach ($bans as $bannum => $bancont) {
		$xo = explode(" ",$bancont);
		$xre = substr($bancont,strlen("$xo[0] $xo[1] $xo[2] "));
		sendserv("NOTICE $nick :$xo[0]".spaces("$xo[0]",$hl)." $xo[1]".spaces("$xo[1]",$nl)." ".b_expiry($xo[2]).spaces(b_expiry($xo[2]),$ele)." $xre");
	}
	sendserv("NOTICE $nick :There are \002$xx\002 bans in \002$cname\002.");
}
elseif (strtolower($cbase) == "unregister") {
	$params = $paramzz;
	$tchan = strtolower($target);
	$area = "";
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
	global $userinfo; global $botnick; global $god; global $chans;
	$lnick = strtolower($nick);
	$lchan = strtolower($target);
	$acc = $userinfo["$lnick"]["auth"];
	$saxs = 0;
	$fop = fopen("staff.conf","r+");
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
			$fop = fopen("users.conf","r+");
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
			$fop = fopen("users.conf","w+");
			fwrite($fop,$fcont);
			fclose($fop);
			$fcont = "";
			$area = "";
			$fop = fopen("settings.conf","r+");
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
			$fop = fopen("settings.conf","w+");
			fwrite($fop,$fcont);
			fclose($fop);
			$fcont = "";
			$area = "";
			$fop = fopen("bans.conf","r+");
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
			$fop = fopen("bans.conf","w+");
			fwrite($fop,$fcont);
			fclose($fop);
			if ($cfound == 1) {
				sendserv("PART $target :Unregistered by $nick ($acc).");
				sendserv("NOTICE $nick :$target has been unregistered.");
				sendserv("PRIVMSG #ArcticServ :$nick ($acc) unregistered $target");
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
elseif (strtolower($cbase) == "register") {
	$params = $paramzz;
	global $userinfo; global $botnick; global $god; global $chans; global $waitfor;
	$lnick = strtolower($nick);
	$lchan = strtolower($target);
	$lpam = strtolower($params);
	$acc = $userinfo["$lnick"]["auth"];
	$saxs = 0;
	$fop = fopen("staff.conf","r+");
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
			$arfound = 0;
			$fop = fopen("users.conf","r+");
			while ($fra = fgets($fop)) {
				$fra = str_replace("\r","",$fra);
				$fra = str_replace("\n","",$fra);
				$frg = explode(" ",$fra);
				if ($frg[0] == "-" && $frg[1] == strtolower($target)) {
					$arfound = 1;
				}
			}
			fclose($fop);
			if ($arfound == 1) {
				sendserv("NOTICE $nick :".$chans["$lchan"]["name"]." is already registered to someone else.");
			}
			else {
				if ($params[0] == "*") {
					$accfound = "";
					$fop = fopen("accs.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if (strtolower($frg[0]) == strtolower(substr($params,1))) {
							$accfound = $frg[0]; 
						}
					}
					fclose($fop);
					if ($accfound != "") {
						$fop = fopen("users.conf","a+");
						fwrite($fop,"\r\n- ".$lchan." ".$acc." ".time()."\r\n");
						fwrite($fop,"$accfound 500");
						fclose($fop);
						sendserv("JOIN $target");
						sendserv("NOTICE $nick :$target has been registered to $accfound.");
						sendserv("PRIVMSG #ArcticServ :$nick ($acc) registered $target to $accfound.");
					}
					else {
						sendserv("NOTICE $nick :This account (\002".substr($params,1)."\002) is unknown to me.");
					}
				}
				elseif ($params == "") {
					$fop = fopen("users.conf","a+");
					fwrite($fop,"\r\n- ".$lchan." ".$acc." ".time()."\r\n");
					fwrite($fop,"$acc 500");
					sendserv("JOIN $target");
					sendserv("NOTICE $nick :$target has been registered to $acc");
					sendserv("PRIVMSG #ArcticServ :$nick ($acc) registered $target to $nick ($acc)");
				}
				else {
					if ($userinfo["$lpam"]["nick"] == "") {
						if ($userinfo["$lpam"]["unknown"] != "1") {
							$wfc = count($waitfor["$lpam"]) + 1;
							$waitfor["$lpam"][$wfc] = "CMD register $nick $user $host $cchan $target $params";
							sendserv("WHOIS $lpam");
							return(0);
						}
						else {
							sendserv("NOTICE $nick :User \002$params\002 doesn't exist.");
						}
					}
					else {
						$racc = $userinfo["$lpam"]["auth"];
						if ($racc == "") {
							sendserv("NOTICE $nick :".$userinfo["$lpam"]["nick"]." is not authed with \002AuthServ\002.");
							return(0);
						}
						$fop = fopen("users.conf","a+");
						fwrite($fop,"\r\n- ".$lchan." ".$acc." ".time()."\r\n");
						fwrite($fop,"$racc 500");
						fclose($fop);
						sendserv("JOIN $target");
						sendserv("NOTICE $nick :$target has been registered to ".$userinfo["$lpam"]["nick"]." ($racc).");
						sendserv("PRIVMSG #ArcticServ :$nick ($acc) registered $target to ".$userinfo["$lpam"]["nick"]." ($racc).");
					}
				}
			}
		}
	}
	else {
		sendserv("NOTICE $nick :You lack sufficient staff access to use this command.");
	}
}
elseif (strtolower($cbase) == "resync") {
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
	$cname = $chans["$ctarg"]["name"];
	$tsets = array();
	$axs = array();
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
	$fop = fopen("settings.conf","r+");
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
	if ($axs["$acc"] < 200 && $god["$acc"] != "1") {
		sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
		return(0);
	}
	if ($tsets["giveops"] == "") {
		$tsets["giveops"] = "200";
	}
	if ($tsets["givevoice"] == "") {
		$tsets["givevoice"] = "100";
	}
	$xuc = 0;
	$modes = "";
	$modeps = "";
	foreach ($chans["$ctarg"]["users"] as $unick => $ustat) {
		$authnick = $userinfo["$unick"]["auth"];
		$axss = $axs["$authnick"];
		if ($axss == "") {
			$axss = 0;
		}
		if ($axss >= $tsets["giveops"]) {
			if (str_replace("@","",$chans["$ctarg"]["users"]["$unick"]) == $chans["$ctarg"]["users"]["$unick"]) {
				$xuc++;
				$modes .= "+o";
				$modeps .= " $unick";
			}
		}
		elseif ($axss >= $tsets["givevoice"]) {
			if (str_replace("+","",$chans["$ctarg"]["users"]["$unick"]) == $chans["$ctarg"]["users"]["$unick"]) {
				$xuc++;
				$modes .= "+v";
				$modeps .= " $unick";
			}
		}
		if ($xuc == 6) {
			sendserv("MODE $target $modes $modeps");
			$modes = "";
			$modeps = "";
			$xuc = 0;
		}
		if ($axss < $tsets["giveops"]) {
			if (str_replace("@","",$chans["$ctarg"]["users"]["$unick"]) != $chans["$ctarg"]["users"]["$unick"]) {
				if ($unick != strtolower($botnick)) {
					$xuc++;
					$modes .= "-o";
					$modeps .= " $unick";
				}
			}
		}
		if ($xuc == 6) {
			sendserv("MODE $target $modes $modeps");
			$modes = "";
			$modeps = "";
			$xuc = 0;
		}
		if ($axss < $tsets["givevoice"]) {
			if (str_replace("+","",$chans["$ctarg"]["users"]["$unick"]) != $chans["$ctarg"]["users"]["$unick"]) {
				$xuc++;
				$modes .= "-v";
				$modeps .= " $unick";
			}
		}
		if ($xuc == 6) {
			sendserv("MODE $target $modes $modeps");
			$modes = "";
			$modeps = "";
			$xuc = 0;
		}
	}
	sendserv("MODE $target $modes $modeps");
	$modes = "";
	$modeps = "";
	$xuc = 0;
	sendserv ("NOTICE $nick :Users in $cname have been synchronised with the userlist.");
}
elseif (strtolower($cbase) == "upall") {
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
		$fop = fopen("settings.conf","r+");
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
elseif (strtolower($cbase) == "up") {
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
	$fop = fopen("settings.conf","r+");
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
elseif (strtolower($cbase) == "myaccess") {
	$params = $paramzz;
	$tchan = strtolower($target);
	$lnick = strtolower($nick);
	$area = "";
	$axs = 0;
	$cname = array();
	$cfound = 0;
	$cc = 0;
	global $userinfo; global $chans; global $botnick;
	if ($params == "") {
		if ($userinfo["$lnick"]["auth"] == "") {
			sendserv("NOTICE $nick :$nick is not authed with \002AuthServ\002.");
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
				$tsets["$area"]["$frg[0]"] = substr($fra,strlen($frg[0]." "));
			}
		}
		fclose($fop);
		$owncnt = 0;
		sendserv("NOTICE $nick :Showing all channel entries for \002".$userinfo["$lnick"]["auth"]."\002:");
		$fop = fopen("users.conf","r+");
		while ($fra = fgets($fop)) {
			$fra = str_replace("\r","",$fra);
			$fra = str_replace("\n","",$fra);
			$frg = explode(" ",$fra);
			if ($frg[0] == "-") {
			$area = $frg[1];
			if ($chans["$area"]["name"] != "") {
			$cname["$area"] = $chans["$area"]["name"];
			}
			else {
			$cname["$area"] = "\00304$area\003";
			}
			}
			else {
				if ($frg[0] == $userinfo["$lnick"]["auth"]) {
					$mlayer = "";
					$elayer = "";
					$axs = $frg[1];
					$autoinvite = $frg[2];
					$noamodes = $frg[3];
					$infos = unserialize(substr($fra,strlen("$frg[0] $frg[1] $frg[2] $frg[3] ")));
					if ($axs >= $tsets["$area"]["giveops"]) {
						$mlayer .= "o";
					}
					elseif ($axs >= $tsets["$area"]["givevoice"]) {
						$mlayer .= "v";
					}
					if (binsetting($autoinvite) == "On") {
						$mlayer .= "i";
					}
					if ($infos['info'] != "") {
						$elayer = ": ".$infos['info'];
					}
					if ($mlayer != "") {
						$mlayer = ",$mlayer";
					}
					sendserv("NOTICE $nick :[".$cname["$area"]." ($axs".$mlayer.")]".$elayer);
					if ($axs == "500") {
						$owncnt++;
					}
					$cc++;
				}
				$cfound = 1;
			}
		}
		if ($owncnt != 0) {
			$owntxt = " and has owner access on \002$owncnt\002 channel(s)";
		}
		fclose($fop);
		sendserv("NOTICE $nick :\002".$userinfo["$lnick"]["auth"]."\002 has access to \002$cc\002 channel(s)".$owntxt.".");
	}
	else {
		global $god;
		$uauth = $userinfo["$lnick"]["auth"];
		if ($god[$uauth] != 1) {
			sendserv("NOTICE $nick :You might just see access and infolines for yourself using this command without parameters.");
		}
		else {
			if ($paramzz[0] == "*") {
				$fop = fopen("accs.conf","r+");
				// TODO: Add accountcheck
				fclose($fop);
			}

			$owncnt = 0;
			sendserv("NOTICE $nick :Showing all channel entries for \002".$paramzz."\002:");
			$fop = fopen("users.conf","r+");
			while ($fra = fgets($fop)) {
				$fra = str_replace("\r","",$fra);
				$fra = str_replace("\n","",$fra);
				$frg = explode(" ",$fra);
				if ($frg[0] == "-") {
					$area = $frg[1];
					if ($chans["$area"]["name"] != "") {
						$cname["$area"] = $chans["$area"]["name"];
					}
					else {
						$cname["$area"] = "\00304$area\003";
					}
				}
				else {
					if ($frg[0] == $paramzz) {
						$mlayer = "";
						$elayer = "";
						$axs = $frg[1];
						$autoinvite = $frg[2];
						$noamodes = $frg[3];
						$setinfo = substr($fra,strlen("$frg[0] $frg[1] $frg[2] $frg[3] "));
						if ($axs >= $tsets["$area"]["giveops"]) {
							$mlayer .= "o";
						}
						elseif ($axs >= $tsets["$area"]["givevoice"]) {
							$mlayer .= "v";
						}
						if (binsetting($autoinvite) == "On") {
							$mlayer .= "i";
						}
						if ($setinfo != "") {
							$elayer = ": $setinfo";
						}
						if ($mlayer != "") {
						$mlayer = ",$mlayer";
							}
						sendserv("NOTICE $nick :[".$cname["$area"]." ($axs".$mlayer.")]".$elayer);
						if ($axs == "500") {
							$owncnt++;
						}
						$cc++;
					}
					$cfound = 1;
				}
			}
			if ($owncnt != 0) {
				$owntxt = " and has owner access on \002$owncnt\002 channel(s)";
			}
			fclose($fop);
			sendserv("NOTICE $nick :\002".$paramzz."\002 has access to \002$cc\002 channel(s)".$owntxt.".");
		}
	}
}
elseif (strtolower($cbase) == "deluser") {
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
	if ($axs["$acc"] < $tsets['deluser'] && $god["$acc"] != "1") {
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
			sendserv("NOTICE $nick :You cant delete yourself with \002deluser\002.");
			return(0);
		}
		if ($axs["$tacc"] >= $axs["$acc"] && $god["$acc"] != "1") {
			sendserv("NOTICE $nick :Command has no effect (User $tacc ranks you off.);");
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
					// Ignore him.
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
		sendserv("NOTICE $nick :$tacc has been removed from the $cname userlist (access ".$axs["$tacc"].")");
	}
	else {
		if ($userinfo["$pn"]["nick"] == "") {
			if ($userinfo["$pn"]["unknown"] != "1") {
				$wfc = count($waitfor["$pn"]) + 1;
				$waitfor["$pn"][$wfc] = "CMD deluser $nick $user $host $cchan $target $params";
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
			sendserv("NOTICE $nick :You cant delete yourself with \002deluser\002.");
			return(0);
		}
		if ($axs["$tacc"] >= $axs["$acc"] && $god["$acc"] != "1") {
			sendserv("NOTICE $nick :Command has no effect (User $pnnick ($tacc) ranks you off.);");
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
					// Ignore him.
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
		sendserv("NOTICE $nick :$pnnick ($tacc) has been removed from the $cname userlist (access ".$axs["$tacc"].")");
	}
}
elseif (strtolower($cbase) == "access") {
	$params = $paramzz;
	$area = "";
	$found = 0;
	$access = 0;
	$lchan = strtolower($target);
	$lnick = strtolower($nick);
	$xstr = "";
	global $chans; global $userinfo; global $botnick; global $god;
	if ($params[0] == "*") {
		$acc = substr($params,1);
		$fop = fopen("users.conf","r+");
		while ($fra = fgets($fop)) {
			$fra = str_replace("\r","",$fra);
			$fra = str_replace("\n","",$fra);
			$fgr = explode(" ",$fra);
			if ($fgr[0] == "-") {
				$area = $fgr[1];
			}
			else {
				if ($area == $lchan) {
					if (strtolower($fgr[0]) == strtolower("$acc")) {
						if ($god["$fgr[0]"] == "1") {
							$xstr = "\002 and has security override enabled\002";
						}
						$xsname = staffname($fgr[0]);
						if ($xsname != "") {
							sendserv("NOTICE $nick :$xsname");
						}
						$ualvl = str_replace("-","",$fgr[1]);
						sendserv("NOTICE $nick :$fgr[0] has access \002$ualvl\002 in ".$chans["$lchan"]["name"]."$xstr.");
						if ($ualvl != $fgr[1]) {
							sendserv("NOTICE $nick :\002$fgr[0]\002s Access to ".$chans["$lchan"]["name"]." is \002suspended\002.");
						}
						$autoinvite = $fgr[2];
						$noamodes = $fgr[3];
						$infos = unserialize(substr($fra,strlen("$fgr[0] $fgr[1] $fgr[2] $fgr[3] ")));
						if ($infos['info'] != "") {
							sendserv("NOTICE $nick :[".$fgr[0]."] ".$infos['info']);
						}
						if ($infos['pinfo'] != "") {
							sendserv("NOTICE $nick :[".$fgr[0]." Part] ".$infos['pinfo']);
						}
						if ($infos['qinfo'] != "") {
							sendserv("NOTICE $nick :[".$fgr[0]." Quit] ".$infos['qinfo']);
						}
						$access = 1;
					}
					$found = 1;
				}
			}
		}
		fclose($fop);
		if ($found == 0) {
			sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
		}
		elseif ($access == 0) {
			$afound = "";
			$fop = fopen("accs.conf","r+");
			while ($fra = fgets($fop)) {
				$fra = str_replace("\r","",$fra);
				$fra = str_replace("\n","",$fra);
				if (strtolower($fra) == strtolower($acc)) {
					$afound = "$fra";
				}
			}
			fclose($fop);
			if ($afound != "") {
				if ($god["$afound"] == "1") {
					$xstr = "\002 but has security override enabled\002";
				}
				$xsname = staffname($afound);
				if ($xsname != "") {
					sendserv("NOTICE $nick :$xsname");
				}
				sendserv("NOTICE $nick :$afound lacks access to ".$chans["$lchan"]["name"]."$xstr.");
			}
			else {
				sendserv("NOTICE $nick :This account (\002$acc\002) is unknown to me.");
			}
		}
	}


	elseif ($params == "") {
		if ($userinfo["$lnick"]["nick"] == "") {
			global $waitfor;
			$wfc = count($waitfor["$lnick"]) + 1;
			$waitfor["$lnick"][$wfc] == "CMD access $nick $user $host $cchan $target $params";
			sendserv("WHOIS $nick");
			return(0);
		}
		else {
			$acc = $userinfo["$lnick"]["auth"];
			if ($acc == "") {
				sendserv("NOTICE $nick :".$userinfo["$lnick"]["nick"]." is not authed with \002AuthServ\002.");
				return(0);
			}
		}
		$fop = fopen("users.conf","r+");
		while ($fra = fgets($fop)) {
			$fra = str_replace("\r","",$fra);
			$fra = str_replace("\n","",$fra);
			$fgr = explode(" ",$fra);
			if ($fgr[0] == "-") {
			$area = $fgr[1];
			}
			else {
				if ($area == $lchan) {
					if (strtolower($fgr[0]) == strtolower("$acc")) {
						if ($god["$fgr[0]"] == "1") {
							$xstr = "\002 and has security override enabled\002";
						}
						$xsname = staffname($fgr[0]);
						if ($xsname != "") {
							sendserv("NOTICE $nick :$xsname");
						}
						$ualvl = str_replace("-","",$fgr[1]);
						sendserv("NOTICE $nick :".$userinfo["$lnick"]["nick"]." ($fgr[0]) has access \002$ualvl\002 in ".$chans["$lchan"]["name"]."$xstr.");
						if ($ualvl != $fgr[1]) {
							sendserv("NOTICE $nick :\002$fgr[0]\002s Access to ".$chans["$lchan"]["name"]." is \002suspended\002.");
						}
						$autoinvite = $fgr[2];
						$noamodes = $fgr[3];
						$infos = unserialize(substr($fra,strlen("$fgr[0] $fgr[1] $fgr[2] $fgr[3] ")));
						if ($infos['info'] != "") {
							sendserv("NOTICE $nick :[".$userinfo["$lnick"]["nick"]."] ".$infos['info']);
						}
						if ($infos['pinfo'] != "") {
							sendserv("NOTICE $nick :[".$userinfo["$lnick"]["nick"]." Part] ".$infos['pinfo']);
						}
						if ($infos['qinfo'] != "") {
							sendserv("NOTICE $nick :[".$userinfo["$lnick"]["nick"]." Quit] ".$infos['qinfo']);
						}
						$access = 1;
					}
					$found = 1;
				}
			}
		}
		fclose($fop);
		if ($found == 0) {
			sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
		}
		elseif ($access == 0) {
			$afound = "";
			$fop = fopen("accs.conf","r+");
			while ($fra = fgets($fop)) {
				$fra = str_replace("\r","",$fra);
				$fra = str_replace("\n","",$fra);
				if (strtolower($fra) == strtolower($acc)) {
					$afound = "$fra";
				}
			}
			fclose($fop);
			if ($afound != "") {
				if ($god["$afound"] == "1") {
					$xstr = "\002 but has security override enabled\002";
				}
				$xsname = staffname($afound);
				if ($xsname != "") {
					sendserv("NOTICE $nick :$xsname");
				}
				sendserv("NOTICE $nick :".$userinfo["$lnick"]["nick"]." ($afound) lacks access to ".$chans["$lchan"]["name"]."$xstr.");
			}
			else {
				sendserv("NOTICE $nick :This account (\002$acc\002) is unknown to me.");
			}
		}
	}


	else {
		$lpam = strtolower($params);
		if ($userinfo["$lpam"]["nick"] == "") {
			if ($userinfo["$lpam"]["unknown"] != "1") {
				global $waitfor;
				$wfc = count($waitfor["$lpam"]) + 1;
				$waitfor["$lpam"][$wfc] = "CMD access $nick $user $host $cchan $target $params";
				sendserv("WHOIS $lpam");
				return(0);
			}
			else {
				sendserv("NOTICE $nick :User \002$params\002 doesn't exist.");
				unset($userinfo["$lpam"]);
				return(0);
			}
		}
		else {
			$acc = $userinfo["$lpam"]["auth"];
			if ($acc == "") {
				sendserv("NOTICE $nick :".$userinfo["$lpam"]["nick"]." is not authed with \002AuthServ\002.");
				return(0);
			}
		}
		$fop = fopen("users.conf","r+");
		while ($fra = fgets($fop)) {
			$fra = str_replace("\r","",$fra);
			$fra = str_replace("\n","",$fra);
			$fgr = explode(" ",$fra);
			if ($fgr[0] == "-") {
				$area = $fgr[1];
			}
			else {
				if ($area == $lchan) {
					if (strtolower($fgr[0]) == strtolower("$acc")) {
						if ($god["$fgr[0]"] == "1") {
							$xstr = "\002 and has security override enabled\002";
						}
						$xsname = staffname($fgr[0]);
						if ($xsname != "") {
							sendserv("NOTICE $nick :$xsname");
						}
						$ualvl = str_replace("-","",$fgr[1]);
						sendserv("NOTICE $nick :".$userinfo["$lpam"]["nick"]." ($fgr[0]) has access \002$ualvl\002 in ".$chans["$lchan"]["name"]."$xstr.");
						if ($ualvl != $fgr[1]) {
							sendserv("NOTICE $nick :\002$fgr[0]\002s Access to ".$chans["$lchan"]["name"]." is \002suspended\002.");
						}
						$access = 1;
						$autoinvite = $fgr[2];
						$noamodes = $fgr[3];
						$infos = unserialize(substr($fra,strlen("$fgr[0] $fgr[1] $fgr[2] $fgr[3] ")));
						if ($infos['info'] != "") {
							sendserv("NOTICE $nick :[".$userinfo["$lpam"]["nick"]."] ".$infos['info']);
						}
						if ($infos['pinfo'] != "") {
							sendserv("NOTICE $nick :[".$userinfo["$lpam"]["nick"]." Part] ".$infos['pinfo']);
						}
						if ($infos['qinfo'] != "") {
							sendserv("NOTICE $nick :[".$userinfo["$lpam"]["nick"]." Quit] ".$infos['qinfo']);
						}
					}
					$found = 1;
				}
			}
		}
		fclose($fop);
		if ($found == 0) {
			sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
		}
		elseif ($access == 0) {
			$afound = "";
			$fop = fopen("accs.conf","r+");
			while ($fra = fgets($fop)) {
				$fra = str_replace("\r","",$fra);
				$fra = str_replace("\n","",$fra);
				if (strtolower($fra) == strtolower($acc)) {
					$afound = "$fra";
				}
			}
			fclose($fop);
			if ($afound != "") {
				if ($god["$afound"] == "1") {
					$xstr = "\002 but has security override enabled\002";
				}
				$xsname = staffname($afound);
				if ($xsname != "") {
					sendserv("NOTICE $nick :$xsname");
				}
				sendserv("NOTICE $nick :".$userinfo["$lpam"]["nick"]." ($afound) lacks access to ".$chans["$lchan"]["name"]."$xstr.");
			}
			else {
				sendserv("NOTICE $nick :".$userinfo["$lpam"]["nick"]." ($acc) lacks access to ".$chans["$lchan"]["name"]);
				$fop = fopen("accs.conf","a+");
				fwrite($fop,"\r\n$acc");
				fclose($fop);
			}
		}
	}
}
elseif (strtolower($cbase) == "adduser") {
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
	$ctarg = strtolower($target);
	$tchan = $ctarg;
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
		$fop = fopen("accs.conf","r+");
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
		$fop = fopen("users.conf","r+");
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
		$fop = fopen("users.conf","w+");
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
		$fop = fopen("accs.conf","r+");
		while ($fra = fgets($fop)) {
			$fra = str_replace("\r","",$fra);
			$fra = str_replace("\n","",$fra);
			$frg = explode(" ",$fra);
			if (strtolower($frg[0]) == strtolower($pa)) {
				$accfound = $frg[0];
			}
		}
		if ($accfound == "") {
			$fop = fopen("accs.conf","a+");
			fwrite($fop,"\r\n$pa");
			fclose($fop);
			$accfound = $pa;
		}
		$fcont = "";
		$fop = fopen("users.conf","r+");
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
		$fop = fopen("users.conf","w+");
		fwrite($fop,$fcont);
		fclose($fop);
		sendserv("NOTICE $nick :$pnnick ($accfound) has been added to the $cname user list with access $ppe");
	}
}
elseif (strtolower($cbase) == "clvl") {
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
elseif (strtolower($cbase) == "info") {
	global $userinfo; global $chans; global $botnick; global $god;
	$lnick = strtolower($nick);
	$ctarg = strtolower($target);
	$tchan = $ctarg;
	$axs = 0;
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
	$registrar = "not registered";
	$acc = $userinfo["lnick"]["auth"];
	$registered = 0;
	$fop = fopen("users.conf","r+");
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
		sendserv("NOTICE $nick :\002".$chans["$ctarg"]["name"]."\002 channel information:");
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
				sendserv("NOTICE $nick :Use \002nicklist\002 (command) instead.");
			}
			sendserv("NOTICE $nick :User Count:   $unc");
			sendserv("NOTICE $nick :Modes:        ".$chans["$ctarg"]["modes"]);
			sendserv("NOTICE $nick :Limit:        ".$chans["$ctarg"]["limit"]);
			sendserv("NOTICE $nick :Key:          ".$chans["$ctarg"]["key"]);
		}
		else {
			sendserv("NOTICE $nick :You must be on the channel or its userlist to see the channel information");
		}
		sendserv("NOTICE $nick :---");
	}
	else {
	sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002ArcticServ\002.");
	}
}
elseif (strtolower($cbase) == "uset") {
	$params = $paramzz;
	$tchan = strtolower($target);
	$lnick = strtolower($nick);
	$area = "";
	$axs = 0;
	$cfound = 0;
	$autoinvite = "0";
	$nomodes = "0";
	$info = "";
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
					$autoinvite = $frg[2];
					$nomodes = $frg[3];
					$infos = unserialize(substr($fra,strlen("$frg[0] $frg[1] $frg[2] $frg[3] ")));
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
	if ($cfound == 0) {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
		return(0);
	}
	$cname = $chans["$tchan"]["name"];
	if ($tsets['uset'] == '') {
		$tsets['uset'] = '0';
	}
	if ($tsets['giveops'] == '') {
		$tsets['giveops'] = '200';
	}
	if ($tsets['givevoice'] == '') {
		$tsets['givevoice'] = '100';
	}
	if ($axs == 0 || $axs < $tsets['uset']) {
		sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
		return(0);  
	}
	$pp = explode(" ",$params);
	$pa = strtolower($pp[0]);
	$pb = strtolower($pp[1]);
	$pc = substr($params,strlen("$pa "));
	if ($pa == "") {
		sendserv("NOTICE $nick :$cname user settings for \002$acc\002:");
		if ($axs > $tsets['giveops']) {
			sendserv("NOTICE $nick :\002NoAutoOp             \002 ".binsetting($nomodes));
		}
		elseif ($axs > $tsets['givevoice']) {
			sendserv("NOTICE $nick :\002NoAutoVoice          \002 ".binsetting($nomodes));
		}
		sendserv("NOTICE $nick :\002AutoInvite           \002 ".binsetting($autoinvite));
		sendserv("NOTICE $nick :\002Info                 \002 ".strsetting($infos['info']));
		sendserv("NOTICE $nick :\002PartInfo             \002 ".strsetting($infos['pinfo']));
		sendserv("NOTICE $nick :\002QuitInfo             \002 ".strsetting($infos['qinfo']));
		sendserv("NOTICE $nick :\002NoInvite             \002 ".binsetting($infos['noinvite']));
	sendserv("NOTICE $nick :---");
	}
	elseif ($pa == "noautovoice" && $pb == "" && $axs > $tsets['givevoice'] && $axs < $tsets['giveops']) {
		sendserv("NOTICE $nick :\002NoAutoVoice          \002 ".binsetting($nomodes));
	}
	elseif ($pa == "noautoop" && $pb == "" && $axs > $tsets['giveops']) {
		sendserv("NOTICE $nick :\002NoAutoOp             \002 ".binsetting($nomodes));
	}
	elseif ($pa == "autoinvite" && $pb == "") {
		sendserv("NOTICE $nick :\002AutoInvite           \002 ".binsetting($autoinvite));
	}
	elseif ($pa == "noinvite" && $pb == "") {
		sendserv("NOTICE $nick :\002NoInvite             \002 ".binsetting($infos['noinvite']));
	}
	elseif ($pa == "info" && $pc == "") {
		sendserv("NOTICE $nick :\002Info                 \002 ".strsetting($infos['info']));
	}
	elseif ($pa == "partinfo" && $pc == "") {
		sendserv("NOTICE $nick :\002PartInfo             \002 ".strsetting($infos['pinfo']));
	}
	elseif ($pa == "quitinfo" && $pc == "") {
		sendserv("NOTICE $nick :\002QuitInfo             \002 ".strsetting($infos['qinfo']));
	}
	elseif ($pa == "noautoop" && $pb != "" && $axs > $tsets['giveops']) {
		if ($pb == "on" or $pb == "1") {
			$setchange = "1";
		}
		elseif ($pb = "off" or $pb == "0") {
			$setchange = "0";
		}
		else {
			sendserv("NOTICE $nick :\002$pb\002 is not a valid binary value.");
		}
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
			else {
				if ($area == $tchan) {
					if ($frg[0] == $userinfo["$lnick"]["auth"]) {
						$axs = $frg[1];
						$autoinvite = $frg[2];
						$nomodes = $frg[3];
						$info = substr($fra,strlen("$frg[0] $frg[1] $frg[2] $frg[3] "));
						$nomodes = $setchange;
						$fcont .= "$acc $axs $autoinvite $nomodes $info\r\n";
					}
					else {
						$fcont .= $fra."\r\n";
					}
				$cfound = 1;
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
		sendserv("NOTICE $nick :\002NoAutoOp             \002 ".binsetting($nomodes));
	}
	elseif ($pa == "noautovoice" && $pb != "" && $axs > $tsets['givevoice'] && $axs < $tsets['giveops']) {
		if ($pb == "on" or $pb == "1") {
		$setchange = "1";
		}
		elseif ($pb = "off" or $pb == "0") {
		$setchange = "0";
		}
		else {
		sendserv("NOTICE $nick :\002$pb\002 is not a valid binary value.");
		}
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
			else {
				if ($area == $tchan) {
					if ($frg[0] == $userinfo["$lnick"]["auth"]) {
						$axs = $frg[1];
						$autoinvite = $frg[2];
						$nomodes = $frg[3];
						$info = substr($fra,strlen("$frg[0] $frg[1] $frg[2] $frg[3] "));
						$nomodes = $setchange;
						$fcont .= "$acc $axs $autoinvite $nomodes $info\r\n";
					}
					else {
						$fcont .= $fra."\r\n";
					}
					$cfound = 1;
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
		sendserv("NOTICE $nick :\002NoAutoVoice          \002 ".binsetting($nomodes));
	}
	elseif ($pa == "autoinvite" && $pb != "") {
		if ($pb == "on" or $pb == "1") {
			$setchange = "1";
		}
		elseif ($pb = "off" or $pb == "0") {
			$setchange = "0";
		}
		else {
			sendserv("NOTICE $nick :\002$pb\002 is not a valid binary value.");
		}
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
			else {
				if ($area == $tchan) {
					if ($frg[0] == $userinfo["$lnick"]["auth"]) {
						$axs = $frg[1];
						$autoinvite = $frg[2];
						$nomodes = $frg[3];
						$info = substr($fra,strlen("$frg[0] $frg[1] $frg[2] $frg[3] "));
						$autoinvite = $setchange;
						$fcont .= "$acc $axs $autoinvite $nomodes $info\r\n";
					}
					else {
						$fcont .= $fra."\r\n";
					}
					$cfound = 1;
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
		sendserv("NOTICE $nick :\002AutoInvite           \002 ".binsetting($autoinvite));
	}
	elseif ($pa == "info" && $pc != "") {
		if ($pc == "*") {
		$pc = "";
		}
		$setchange = $pc;
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
			else {
				if ($area == $tchan) {
					if ($frg[0] == $userinfo["$lnick"]["auth"]) {
						$axs = $frg[1];
						$autoinvite = $frg[2];
						$nomodes = $frg[3];
						$infos = unserialize(substr($fra,strlen("$frg[0] $frg[1] $frg[2] $frg[3] ")));
						$infos['info'] = $setchange;
						$fcont .= "$acc $axs $autoinvite $nomodes ".serialize($infos)."\r\n";
					}
					else {
						$fcont .= $fra."\r\n";
					}
					$cfound = 1;
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
		sendserv("NOTICE $nick :\002Info                 \002 ".strsetting($infos['info']));
	}
	elseif ($pa == "partinfo" && $pc != "") {
		if ($pc == "*") {
			$pc = "";
		}
		$setchange = $pc;
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
			else {
				if ($area == $tchan) {
					if ($frg[0] == $userinfo["$lnick"]["auth"]) {
						$axs = $frg[1];
						$autoinvite = $frg[2];
						$nomodes = $frg[3];
						$infos = unserialize(substr($fra,strlen("$frg[0] $frg[1] $frg[2] $frg[3] ")));
						$infos['pinfo'] = $setchange;
						$fcont .= "$acc $axs $autoinvite $nomodes ".serialize($infos)."\r\n";
					}
					else {
						$fcont .= $fra."\r\n";
					}
					$cfound = 1;
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
		sendserv("NOTICE $nick :\002PartInfo             \002 ".strsetting($infos['pinfo']));
	}
	elseif ($pa == "quitinfo" && $pc != "") {
		if ($pc == "*") {
			$pc = "";
		}
		$setchange = $pc;
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
			else {
				if ($area == $tchan) {
					if ($frg[0] == $userinfo["$lnick"]["auth"]) {
						$axs = $frg[1];
						$autoinvite = $frg[2];
						$nomodes = $frg[3];
						$infos = unserialize(substr($fra,strlen("$frg[0] $frg[1] $frg[2] $frg[3] ")));
						$infos['qinfo'] = $setchange;
						$fcont .= "$acc $axs $autoinvite $nomodes ".serialize($infos)."\r\n";
					}
					else {
						$fcont .= $fra."\r\n";
					}
					$cfound = 1;
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
		sendserv("NOTICE $nick :\002QuitInfo             \002 ".strsetting($infos['qinfo']));
	}
	else {
	sendserv("NOTICE $nick :\002$pa\002 is an invalid user setting");
	}
}
elseif (strtolower($cbase) == "mode") {
	$params = $paramzz;
	global $chans; global $userinfo; global $god; global $botnick;
	$ctarg = strtolower($target);
	$axs = array();
	$tsets = array();
	$lnick = strtolower($nick);
	$auth = $userinfo["$lnick"]["auth"];
	$lbotnick = strtolower($botnick);
	if ($auth == "") {
		sendserv("NOTICE $nick :$nick is not authed with \002AuthServ\002.");
		return(0);
	}
	if ($chans["$ctarg"]["name"] == "") {
		sendserv("NOTICE $nick :I'm not at $target.");
		return(0);
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
	$fop = fopen("settings.conf","r+");
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
	$modex = explode(" ",$params);
	$modes = $modex[0];
	$modep = explode(" ",substr($params,strlen($modex[0]." ")));
	if (str_replace("o","",$modes) != $modes) {
		sendserv("NOTICE $nick :$modes is an invalid set of channel modes.");
		return(0);
	}
	if (str_replace("v","",$modes) != $modes) {
		sendserv("NOTICE $nick :$modes is an invalid set of channel modes.");
		return(0);
	}
	if (str_replace("b","",$modes) != $modes) {
		sendserv("NOTICE $nick :$modes is an invalid set of channel modes.");
		return(0);
	}
	if ($axs["$auth"] < 200 && $god["$auth"] != "1" && $auth != $userinfo["$lbotnick"]["auth"]) {
		sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
		return(0);
	}
	$umc = 0;
	$x = 0;
	$mset = array();
	$category = "incl";
	while ($mode = $modes[$x]) {
		if ($mode == "-") {
		$category = "excl";
		}
		elseif ($mode == "+") {
		$category = "incl";
		}
		else {
			if ($category == "incl") {
				if ($mode == "k") {
					$mset["modes"] .= "+k";
					$mset["params"] .= " ".$modep[$umc];
					$umc++;
				}
				elseif ($mode == "l") {
					$mset["modes"] .= "+"."l";
					$mset["params"] .= " ".$modep[$umc];
					$umc++;
				}
				else {
					$mset["modes"] .= "+".$mode;
				}
			}
			elseif ($category == "excl") {
				if ($mode == "k") {
					$mset["modes"] .= "-k";
					$mset["params"] .= " ".$chans["$ctarg"]["key"];
					$umc++;
				}
				else {
					$mset["modes"] .= "-".$mode;
				}
			}
		}
		$x++;
	}
	sendserv("MODE $target ".$mset["modes"]." ".$mset["params"]);
	sendserv("NOTICE $nick :Set the modes for $cname.");
}
elseif (strtolower($cbase) == "inviteme") {
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
	if ($tsets["inviteme"] == "") {
		$tsets["inviteme"] = "1";
	}
	if ($cfound != 0) {
		if ($axs >= $tsets["inviteme"]) {
			sendserv("INVITE $nick $target");
			sendserv("NOTICE $nick :You have been invited.");
		}
		else {
			sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
		}
	}
	else {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
	}
}
elseif (strtolower($cbase) == "down") {
	$params = $paramzz;
	global $chans;
	$ctarg = strtolower($target);
	if ($chans["$ctarg"]["name"] == "") {
		sendserv("NOTICE $nick :I'm not at $target.");
		return(0);
	}
	$cname = $chans["$ctarg"]["name"];
	sendserv("MODE $target -ov $nick $nick");
	sendserv("NOTICE $nick :Removed op/voice from you in $cname.");
}
elseif (strtolower($cbase) == "downall") {
	$params = $paramzz;
	global $chans;
	$ctarg = strtolower($target);
	if ($chans["$ctarg"]["name"] == "") {
		sendserv("NOTICE $nick :I'm not at $target.");
		return(0);
	}
	foreach ($chans as $clname => $clarray) {
		sendserv("MODE ".$chans["$clname"]["name"]." -ov $nick $nick");
	}
	sendserv("NOTICE $nick :Removed op/voice from you in all channels.");
}
elseif (strtolower($cbase) == "deop") {
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
	if ($axs < 300 || $god[$acc] == 1) {
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
							sendserv("NOTICE $nick :Deop cannot be done: User ".$userinfo["$unick"]["nick"]." ($uauth) ranks you off.");
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
								sendserv("NOTICE $nick :Deop cannot be done: User ".$userinfo["$unick"]["nick"]." ($uauth) ranks you off.");
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
								sendserv("NOTICE $nick :Deop cannot be done: User ".$userinfo["$unick"]["nick"]." ($uauth) ranks you off.");
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
	sendserv("NOTICE $nick :Users have been kicked from $cname.");
}
