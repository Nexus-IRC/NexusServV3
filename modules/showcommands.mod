if (strtolower($cbase) == "showcommands") {
	global $botnick;
	$cc = 0;
	$lsize = 0;
	sendserv("NOTICE $nick :\002$botnick\002 commands:");
	$fop = fopen("./conf/bind.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$fgr = explode(" ",$fra);
		if (strlen($fgr[0]) > $lsize) {
			$lsize = strlen($fgr[0]);
		}
		$cc++;
	}
	fclose($fop);
	$fad = 0;
	$fstr = "";
	$fop = fopen("./conf/bind.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$fgr = explode(" ",$fra);
		if ($fad < 4) {
			if ($fgr[1] != "mod_mod") {
				$fgr[0] == "\0034".$fgr[0]."\003";
			}
			$fstr .= "$fgr[0]".spaces("$fgr[0]",$lsize)." ";
		}
		else {
			sendserv("NOTICE $nick :$fstr");
			$fstr = "";
			$fad = 0;
			if ($fgr[1] != "mod_mod") {
				$fgr[0] == "\0034".$fgr[0]."\003";
			}
			$fstr .= "$fgr[0]".spaces("$fgr[0]",$lsize)." ";
		}
		$fad++;
	}
	fclose($fop);
	if ($fstr != "") {
		sendserv("NOTICE $nick :$fstr");
	}
	sendserv("NOTICE $nick :-- $cc commands found. --");
}