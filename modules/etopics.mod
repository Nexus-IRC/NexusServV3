if (strtolower($cbase) == "etopics") {
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
	}
	else {
	if ($tsets["changetopic"] == "") {
		$tsets["changetopic"] = "200";
	}
	if ($tsets["enftopic"] == "") {
		$tsets["enftopic"] = "400";
	}
	if ($axs < $tsets["changetopic"]) {
		sendserv("NOTICE $nick :You lack sufficient access to ".$chans["$tchan"]["name"]." to use this command.");
	}
	if (binsetting($tsets['enhancedtopic']) == 'Off') {
		sendserv("NOTICE $nick :\002EnhancedTopic\002 is disabled in \002".$chans["$tchan"]["name"]."\002.");
		return(0);
	}
	sendserv("NOTICE $nick :\002EnhancedTopic values for ".chr(31).$chans["$tchan"]["name"].chr(31).":");
	$etopics = getArrayFromFile("./conf/etopics.conf");
	sendserv("NOTICE $nick :1         = ".$etopics[$tchan][1]);
	sendserv("NOTICE $nick :2         = ".$etopics[$tchan][2]);
	sendserv("NOTICE $nick :3         = ".$etopics[$tchan][3]);
	sendserv("NOTICE $nick :4         = ".$etopics[$tchan][4]);
	sendserv("NOTICE $nick :5         = ".$etopics[$tchan][5]);
	sendserv("NOTICE $nick :6         = ".$etopics[$tchan][6]);
	sendserv("NOTICE $nick :7         = ".$etopics[$tchan][7]);
	sendserv("NOTICE $nick :8         = ".$etopics[$tchan][8]);
	sendserv("NOTICE $nick :9         = ".$etopics[$tchan][9]);
	sendserv("NOTICE $nick :10        = ".$etopics[$tchan][10]);
	sendserv("NOTICE $nick :11        = ".$etopics[$tchan][11]);
	sendserv("NOTICE $nick :12        = ".$etopics[$tchan][12]);
	sendserv("NOTICE $nick :13        = ".$etopics[$tchan][13]);
	sendserv("NOTICE $nick :14        = ".$etopics[$tchan][14]);
	sendserv("NOTICE $nick :15        = ".$etopics[$tchan][15]);
	sendserv("NOTICE $nick ---");
	sendArrayToFile("./conf/etopics.conf",$etopics);
	}
}