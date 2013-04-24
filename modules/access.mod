if (strtolower($cbase) == "access") {
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
		$fop = fopen("conf/users.conf","r+");
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
			$fop = fopen("conf/accs.conf","r+");
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
		$fop = fopen("conf/users.conf","r+");
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
			$fop = fopen("conf/accs.conf","r+");
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
		$fop = fopen("conf/users.conf","r+");
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
			$fop = fopen("conf/accs.conf","r+");
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
				$fop = fopen("conf/accs.conf","a+");
				fwrite($fop,"\r\n$acc");
				fclose($fop);
			}
		}
	}
}