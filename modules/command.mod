if (strtolower($cbase) == "command") {
	$params = $paramzz;
	$found = 0;
	$bip = explode(" ",$params);
	$fop = fopen("conf/bind.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$fgr = explode(" ",$fra);
		if (strtolower($fgr[0]) == strtolower($bip[0])) {
			if (strtolower($fgr[1]) == "mod_mod") {
				$comothis = str_replace(".mod","",$fgr[2]).".".$fgr[3];
				$cmdthis = str_replace(".mod","",$fgr[2]).".".substr($fra,strlen($fgr[0]." ".$fgr[1]." ".$fgr[2]." "));
				sendserv("NOTICE $nick :\002$bip[0]\002 is a binding for: $cmdthis");
				if (is_file("./defs/def._".strtolower($comothis)."_.txt")) {
					sendserv("NOTICE $nick :\002".strtoupper($comothis)."\002");
					$xx = explode("\n",str_replace("\r","",file_get_contents("./defs/def._".strtolower($comothis)."_.txt")));
					foreach ($xx as $xy) {
						cmd_parser($nick,$ident,$host,"help",$target,$target,$xy);
					}
				}
				sendserv("NOTICE $nick :End of requirements for $bip[0].");
			}
			else {
				sendserv("NOTICE $nick :\002$bip[0]\002 is a binding for bot_internal.".substr($fra,strlen($fgr[0]." ")));
				sendserv("NOTICE $nick :End of requirements for $bip[0].");
			}
			$found = 1;
		}
	}
	fclose($fop);
	if ($found == 0) {
		sendserv("NOTICE $nick :\002$bip[0]\002 is an unknown command");
	}
}