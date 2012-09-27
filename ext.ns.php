<?php
if ($chan[0] == "#") {
	if ($toys == "" || $toys == "0") {
		echo("NOTICE $nick :Toys are disabled in \002$chan\002.\n");
	}
	elseif ($toys == "1") {
		echo("NOTICE $nick :    _   __                    \n");
		echo("NOTICE $nick :   / | / /__  _  ____  _______\n");
		echo("NOTICE $nick :  /  |/ / _ | |/_/  / / / ___/\n");
		echo("NOTICE $nick : / /|  /  __/>  </ /_/ (__  ) \n");
		echo("NOTICE $nick :/_/ |_/\___/_/|_|\____/____/  \n");
	}
	elseif ($toys == "2") {
		echo("PRIVMSG $chan :    _   __                    \n");
		echo("PRIVMSG $chan :   / | / /__  _  ____  _______\n");
		echo("PRIVMSG $chan :  /  |/ / _ | |/_/  / / / ___/\n");
		echo("PRIVMSG $chan : / /|  /  __/>  </ /_/ (__  ) \n");
		echo("PRIVMSG $chan :/_/ |_/\___/_/|_|\____/____/  \n");
		echo("PRIVMSG $chan :                        | / / /|                       \n");
		echo("PRIVMSG $chan :                        |      |                       \n");
		echo("PRIVMSG $chan :                        |      |                       \n");
		echo("PRIVMSG $chan :                        | (o)(o)                       \n");
		echo("PRIVMSG $chan :                        C      _)                      \n");
		echo("PRIVMSG $chan :                         | ,___|                       \n");
		echo("PRIVMSG $chan :                         |   /                         \n");
		echo("PRIVMSG $chan :_________________oOOo____/___\____oOOo_________________\n");
	}
}
else {
	echo("NOTICE $nick :    _   __                    \n");
	echo("NOTICE $nick :   / | / /__  _  ____  _______\n");
	echo("NOTICE $nick :  /  |/ / _ | |/_/  / / / ___/\n");
	echo("NOTICE $nick : / /|  /  __/>  </ /_/ (__  ) \n");
	echo("NOTICE $nick :/_/ |_/\___/_/|_|\____/____/  \n");
}
?>
