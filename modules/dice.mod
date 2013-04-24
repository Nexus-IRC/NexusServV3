if (strtolower($cbase) == "dice") {
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
	$dicesize = 6;
	if ($params != "") {
		if (str_replace("d","",$params) != $params) {
			$ddd = explode("+",$params);
			if ($ddd[1] == "") {
				$ddd[1] = 0;
			}
			$params = $ddd[0];
		}
		$dicesize = $params;
		if (str_replace("d","",$params) != $params) {
			$dd = explode("d",$params);
			if ($dd[1] == "") {
				$dd[1] = 6;
			}
		}
	}
	if ($cchan[0] != "#") {
		$tsets['toys'] = 1;
	}
	if ($tsets['toys'] == '' || $tsets['toys'] == '0') {
		sendserv("NOTICE $nick :Toys are disabled in \002".$chans[$tchan]['name']."\002.");
	}
	else {
		if ($tsets['toys'] == '1') {
			if ($dd == "") {
				sendserv("NOTICE $nick :A \002".rand(1,$dicesize)."\002 shows on the $dicesize sided die.");
			}
			else {
				if ($dd[0] > 20) {
					sendserv("NOTICE $nick :$dd[0] is too many dice. Please use at most 20.");
					return(0);
				}
				$diced = 0;
				for ($x=1;$x<($dd[1]+1);$x++) { 
					$diced = $diced + rand(1,$dicesize)+$ddd[1];
				}
				sendserv("NOTICE $nick :The total is \002".($diced)."\002 from rolling $dd[0]d$dd[1]+".$ddd[1].".");
			}
		}
		else {
			if ($dd == "") {
				sendserv("PRIVMSG $target :\002$nick\002: A \002".rand(1,$dicesize)."\002 shows on the $dicesize sided die.");
			}
			else {
				if ($dd[0] > 20) {
					sendserv("NOTICE $nick :$dd[0] is too many dice. Please use at most 20.");
					return(0);
				}
				$diced = 0;
				for ($x=1;$x<($dd[1]+1);$x++) { 
					$diced = $diced + rand(1,$dicesize);
				}
				$diced = $diced + +$ddd[1];
				sendserv("PRIVMSG $target :\002$nick\002: The total is \002".($diced)."\002 from rolling $dd[0]d$dd[1]+".$ddd[1]."."); 
			}
		}
	}
}