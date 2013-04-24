<?php
/* ext.cow.php - NexusServV3
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
		echo("NOTICE $nick :\002The cow is coming!!!\002\n");
		echo("NOTICE $nick : \n");
		$xx = shell_exec("apt-get moo");
		$xy = explode("\n",str_replace("\r","",$xx));
		foreach ($xy as $xl) {
			echo("NOTICE $nick :$xl\n");
		}
		echo("NOTICE $nick : \n");
		echo("NOTICE $nick :Yeehaw!!!\n");
	}
	elseif ($toys == "2") {
		echo("PRIVMSG $chan :\002The cow is coming!!!\002\n");
		echo("PRIVMSG $chan : \n");
		$xx = shell_exec("apt-get moo");
		$xy = explode("\n",str_replace("\r","",$xx));
		foreach ($xy as $xl) {
			echo("PRIVMSG $chan :$xl\n");
		}
		echo("PRIVMSG $chan : \n");
		echo("PRIVMSG $chan :Yeehaw!!!\n");
	}
}
else {
	echo("NOTICE $nick :\002The cow is coming!!!\002\n");
	echo("NOTICE $nick : \n");
	$xx = shell_exec("apt-get moo");
	$xy = explode("\n",str_replace("\r","",$xx));
	foreach ($xy as $xl) {
		echo("NOTICE $nick :$xl\n");
	}
	echo("NOTICE $nick : \n");
	echo("NOTICE $nick :Yeehaw!!!\n");
}
?>
