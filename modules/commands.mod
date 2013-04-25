if (strtolower($cbase) == "commands") {
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
	$bcount = 0;
	sendserv("NOTICE $nick :Binding".spaces("Binding",20)." Command");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$fgr = explode(" ",$fra);
		$cmdp = substr($fra,strlen($fgr[0]." ".$fgr[1]." ".$fgr[2]." ".$fgr[3]." "));
		sendserv("NOTICE $nick :$fgr[0]".spaces($fgr[0],20)." ".substr($fgr[2],0,(strlen($fgr[2])-4)).".$fgr[3] ".$cmdp);
		$bcount++;
	}
	sendserv("NOTICE $nick :There are \002$bcount\002 bindings for \002$botnick\002");
}