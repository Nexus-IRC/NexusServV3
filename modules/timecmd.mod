if (strtolower($cbase) == "timecmd") {
	$xx = time();
	$pp = explode(" ",$paramzz);
	if ($pp[0] == "") {
		$xy = 0;
		sendserv("NOTICE $nick :Missing parameters: <command> [parameters]");
		$fop = fopen("./conf/bind.conf","r+");
		while ($fra = fgets($fop)) {
			$fra = str_replace("\r","",$fra);
			$fra = str_replace("\n","",$fra);
			$fgr = explode(" ",$fra);
			if ($xy == 6) {
				sendserv("NOTICE $nick :Subcommands of ".$GLOBALS['command'].": $xi");
				$xi = '';
				$xy = 0;
			}
			$xi .= " ".$fgr[0];
			$xy++;
		}
		if ($xi != "") {
			sendserv("NOTICE $nick :Subcommands of ".$GLOBALS['command'].": $xi");
		}
		fclose($fop);
		return(0);
	}
	if ($pp[1][0] != "#") {
		cmd_parser($nick,$ident,$host,"$pp[0]",$cchan,$target,substr($paramzz,strlen("$pp[0] ")));
	}
	else {
		cmd_parser($nick,$ident,$host,"$pp[0]",$cchan,$pp[1],substr($paramzz,strlen("$pp[0] $pp[1] ")));
	}
	$yy = time() - $xx;
	sendserv("NOTICE $nick :Command executed in ".time2str($yy));
}