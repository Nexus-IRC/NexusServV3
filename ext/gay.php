<?php
/* ext/gay.php - NexusServV3
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
function modulo_str ($string, $modulo) {
	$i = 0;
	while (substr($string,$i,1)) {
		$myascii = $myascii + ord(substr($string,$i,1));
		$i++;
	}
	return($myascii % $modulo);
}

if ($chan[0] == "#") {
	if ($toys == "" || $toys == "0") {
		echo("NOTICE $nick :Toys are disabled in \002$chan\002.\n");
	}
	elseif ($toys == "1") {
		echo("NOTICE $nick :You are ".modulo_str($nick,101)."% gay!\n");
	}
	elseif ($toys == "2") {
		echo("PRIVMSG $chan :\002$nick\002: You are ".modulo_str($nick,101)."% gay!\n");
	}
}
else {
	echo("NOTICE $nick :You are ".modulo_str($nick,101)."% gay!\n");
}
?>