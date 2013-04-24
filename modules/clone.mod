if (strtolower($cbase) == "clone") {
	sendserv("NOTICE $nick :Under construction.");
	$paz = explode(" ",$paramzz);
	if (strtolower($paz[0]) == "add") {
		sendserv("NOTICE $nick :SYNTAX clone add <nick> <realname>");
		sendserv("NOTICE $nick : Adds a clone to the bot and connects to the default clones server");
	}
}