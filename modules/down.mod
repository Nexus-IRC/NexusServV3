if (strtolower($cbase) == "down") {
	$params = $paramzz;
	global $chans;
	$ctarg = strtolower($target);
	if ($chans["$ctarg"]["name"] == "") {
		sendserv("NOTICE $nick :I'm not in $target.");
		return(0);
	}
	$cname = $chans["$ctarg"]["name"];
	sendserv("MODE $target -ov $nick $nick");
	sendserv("NOTICE $nick :Removed op/voice from you in $cname.");
}