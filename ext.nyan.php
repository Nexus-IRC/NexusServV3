<?php
/* ext.nyan.php - NexusServV3
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
		echo("NOTICE $nick :\0034-_-_-_-_-_-_-_\003,------,\n");
		echo("NOTICE $nick :\0038_-_-_-_-_-_-_-\003|   /\_/\\n");
		echo("NOTICE $nick :\0039-_-_-_-_-_-_-\003~|__( ^\u203f\u203f^)\n");
		echo("NOTICE $nick :\00312_-_-_-_-_-_-_-\003\034\034 \034\034\n");
	}
	elseif ($toys == "2") {
		echo("PRIVMSG $chan :\0034-_-_-_-_-_-_-_\003,------,\n");
	    echo("PRIVMSG $chan :\0038_-_-_-_-_-_-_-\003|   /\_/\\n");
		echo("PRIVMSG $chan :\0039-_-_-_-_-_-_-\003~|__( ^\u203f\u203f^)\n");
		echo("PRIVMSG $chan :\00312_-_-_-_-_-_-_-\003\034\034 \034\034\n");
	}
}
else {
	echo("NOTICE $nick :\0034-_-_-_-_-_-_-_\003,------,\n");
	echo("NOTICE $nick :\0038_-_-_-_-_-_-_-\003|   /\_/\\n");
	echo("NOTICE $nick :\0039-_-_-_-_-_-_-\003~|__( ^\u203f\u203f^)\n");
	echo("NOTICE $nick :\00312_-_-_-_-_-_-_-\003\034\034 \034\034\n");
}
/*
4-_-_-_-_-_-_-_,------,
8_-_-_-_-_-_-_-|   /\_/\
9-_-_-_-_-_-_-~|__( ^__^)
12_-_-_-_-_-_-_-"" ""
*/
?>