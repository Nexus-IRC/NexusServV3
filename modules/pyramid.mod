if (strtolower($cbase) == "pyramid") {
	if ($cchan[0] != "#") {
		sendserv("NOTICE $nick :     .");
		sendserv("NOTICE $nick :    ...");
		sendserv("NOTICE $nick :   .....");
		sendserv("NOTICE $nick :  .......");
		sendserv("NOTICE $nick : .........");
		sendserv("NOTICE $nick :...........");
		sendserv("NOTICE $nick :Thats Cleopatras pyramid!");
		return(0);
	}
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
	if ($tsets['toys'] == '' || $tsets['toys'] == '0') {
		sendserv("NOTICE $nick :Toys are disabled in \002".$chans[$tchan]['name']."\002.");
	}
	else {
		if ($tsets['toys'] == '1') {
			sendserv("NOTICE $nick :     .");
			sendserv("NOTICE $nick :    ...");
			sendserv("NOTICE $nick :   .....");
			sendserv("NOTICE $nick :  .......");
			sendserv("NOTICE $nick : .........");
			sendserv("NOTICE $nick :...........");
			sendserv("NOTICE $nick :Thats Cleopatras pyramid!");
		}
		else {
			sendserv("PRIVMSG $target :\002$nick\002:      .");
			sendserv("PRIVMSG $target :\002$nick\002:     ...");
			sendserv("PRIVMSG $target :\002$nick\002:    .....");
			sendserv("PRIVMSG $target :\002$nick\002:   .......");
			sendserv("PRIVMSG $target :\002$nick\002:  .........");
			sendserv("PRIVMSG $target :\002$nick\002: ...........");
			sendserv("PRIVMSG $target :\002$nick\002: Thats Cleopatras pyramid!");
	}
	}
}