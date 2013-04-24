if (strtolower($cbase) == "history") {
	sendserv("NOTICE $nick :".chr(31)."NexusServ ".$GLOBALS['bofficial']."".chr(31)." can be found at http://git.nexus-irc.de/?p=NexusServV3.git");
	sendserv("NOTICE $nick :".chr(31)."ArcticServ 2.0".chr(31)." was incomplete and has been removed");
	sendserv("NOTICE $nick :Try \002v1-history\002 for the ".chr(31)."ArcticServ 1.0".chr(31)." history");
}