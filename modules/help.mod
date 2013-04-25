if (strtolower($cbase) == "help") {
	$helpfile = "./conf/help.txt";
	$params = $paramzz;
	$para = explode(" ",$params);
	if (substr($para[0],0,2) == "::") {
		$helpfile = "./conf/help".substr($para[0],2).".txt";
		$params = substr($params,strlen($para[0]." "));
	}
	global $botnick; global $version;
	$fop = fopen($helpfile,"r+");
	if ($params == "") {
		$paramz = "Main";
	}
	else {
		$paramz = $params;
	}
	$fcont = "";
	$area = "";
	while ($fg = fgets($fop)) {
		$fra = str_replace("\r","",$fg);
		$fra = str_replace("\n","",$fra);
		if ($fra{0} == "[") {
			$area = $fra;
		}
		else {
			if (strtolower($area) == strtolower("[".$paramz."]")) {
				$fcont .= $fra."\r\n";
			}
		}
	}
	if ($fcont == "") {
		sendserv("NOTICE $nick :No help on that topic!");
		return(101);
	}
	$bla = explode("\r\n",$fcont);
	foreach ($bla as $blu) {
		sendserv("NOTICE $nick :".str_replace('$V',$version,str_replace('$B',$botnick,str_replace("[b]","\002",str_replace("[u]","\037",str_replace("[i]","\035",substr($blu,1)))))));
	}
	fclose($fop);
}