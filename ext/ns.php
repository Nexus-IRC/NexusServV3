<?php
/* ext/ns.php - NexusServV3
 * Copyright (C) 2012-2013  #Nexus project
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License 
 * along with this program. If not, see <http://www.gnu.org/licenses/>. 
 */
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
