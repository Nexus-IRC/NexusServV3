<?php
/* ext/nyan.php - NexusServV3
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
    $unichar = "\u203f";
	if ($toys == "" || $toys == "0") {
		echo("NOTICE $nick :Toys are disabled in \002$chan\002.\n");
	}
	elseif ($toys == "1") {
		echo("NOTICE $nick :\0034-_-_-_-_-_-_-_\003,------,\n");
		echo("NOTICE $nick :\0038_-_-_-_-_-_-_-\003|   /\_/\\n");
		echo("NOTICE $nick :\0039-_-_-_-_-_-_-\003~|__( ^"json_decode('"'.$unichar1.'"')json_decode('"'.$unichar1.'"')"^)\n");
		echo("NOTICE $nick :\00312_-_-_-_-_-_-_-\003".chr(34)..chr(34)." ".chr(34)..chr(34)."\n");
	}
	elseif ($toys == "2") {
		echo("PRIVMSG $chan :\0034-_-_-_-_-_-_-_\003,------,\n");
	    echo("PRIVMSG $chan :\0038_-_-_-_-_-_-_-\003|   /\_/\\n");
		echo("PRIVMSG $chan :\0039-_-_-_-_-_-_-\003~|__( ^"json_decode('"'.$unichar1.'"')json_decode('"'.$unichar1.'"')"^)\n");
		echo("PRIVMSG $chan :\00312_-_-_-_-_-_-_-\003".chr(34)..chr(34)." ".chr(34)..chr(34)."\n");
	}
}
else {
	echo("NOTICE $nick :\0034-_-_-_-_-_-_-_\003,------,\n");
	echo("NOTICE $nick :\0038_-_-_-_-_-_-_-\003|   /\_/\\n");
	echo("NOTICE $nick :\0039-_-_-_-_-_-_-\003~|__( ^"json_decode('"'.$unichar1.'"')json_decode('"'.$unichar1.'"')"^)\n");
	echo("NOTICE $nick :\00312_-_-_-_-_-_-_-\003".chr(34)..chr(34)." ".chr(34)..chr(34)."\n");
}
/*
4-_-_-_-_-_-_-_,------,
8_-_-_-_-_-_-_-|   /\_/\
9-_-_-_-_-_-_-~|__( ^__^)
12_-_-_-_-_-_-_-"" ""
*/
?>