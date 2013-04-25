if (strtolower($cbase) == "bans") {
	$params = $paramzz;
	$tchan = strtolower($target);
	$lnick = strtolower($nick);
	$area = "";
	$axs = 0;
	$cfound = 0;
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
	$lnick = strtolower($nick);
	if ($axs < 400 && $GLOBALS['god'][$acc] != 1) {
		sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
		return(0);
	}
	$xx = 0;
	$hl = strlen("Host");
	$nl = strlen("Set By");
	$ele = strlen("Expires");
	$fop = fopen("./conf/bans.conf","r+");
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