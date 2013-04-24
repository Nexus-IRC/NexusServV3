if (strtolower($cbase) == "opchan") {
	global $botnick;
	sendserv("NOTICE $nick :If I'm not opped on ".$target.", I'll attempt to reop myself now.");
	sendserv("PRIVMSG ChanServ :UP $target");
	sendserv("PRIVMSG Centravi :UP $target");
	sendserv("PRIVMSG NeonServ :UP $target");
}