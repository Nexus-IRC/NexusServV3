if (strtolower($cbase) == "version") {
	global $version; global $devline; global $secdevline;
	sendserv("NOTICE $nick :\002NexusServ ".$GLOBALS['bofficial']."\002");
	sendserv("NOTICE $nick :NexusServ ".$GLOBALS['bversion']." (".$GLOBALS['bcodename'].") Release ".$GLOBALS['brelease']." Core ".$GLOBALS['core']."");
	sendserv("NOTICE $nick :NexusServ can be found on #Nexus or at http://nexus-irc.de/nexusserv.html");
	sendserv("NOTICE $nick :If you have found a bug or if you have a good idea report it on http://bugtracker.nexus-irc.de");
}