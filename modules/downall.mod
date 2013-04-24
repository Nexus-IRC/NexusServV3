if (strtolower($cbase) == "downall") {
	$params = $paramzz;
	global $chans;
	$ctarg = strtolower($target);
	if ($chans["$ctarg"]["name"] == "") {
		sendserv("NOTICE $nick :I'm not in $target.");
		return(0);
	}
	foreach ($chans as $clname => $clarray) {
		sendserv("MODE ".$chans["$clname"]["name"]." -ov $nick $nick");
	}
	sendserv("NOTICE $nick :Removed op/voice from you in all channels.");
}