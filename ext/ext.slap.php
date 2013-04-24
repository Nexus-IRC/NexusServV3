<?php
/* ext.slap.php - NexusServV3
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
		echo("NOTICE $nick :Toys must be activated publicly at \002$chan\002 to use slapping.\n");
	}
	elseif ($toys == "2") {
		$exp = explode(" ",$params);
		$xslap = file_get_contents("slapcount.z");
		$nfound = false;
		$nname = "";
		$nnick = $exp[0];
		if ($params == "") {
			$nnick = $nick;
			$nname = $nick;
			$xslap = $xslap + 1;
		}
		else {
			foreach ($nicklist as $nickname => $status) {
				$nfound[strtolower($nickname)] = $nickname;
			}

			$bla = explode(",",$params);

			if (count($bla) > 5) {
				echo("NOTICE $nick :Slapping more than \0025\002 users is not allowed.\n");
				return(0);
			}

			foreach ($bla as $xx) {
				if ($nfound[strtolower($xx)] == "") {
					echo("NOTICE $nick :\002$xx\002 is not on \002$chan\002.");
					return(0);
				}
				else {
					$xslap = $xslap + 1;
					if ($slapd[strtolower($xx)] == 1) {
						echo("NOTICE $nick :You already included \002".$nfound[strtolower($xx)]."\002 to your slap attack.\n");
						return(0);
					}
					$slapd[strtolower($xx)] = 1;
					if ($nname == "") {
						$nname = $nfound[strtolower($xx)];
					}
					else {
						$nname .= " and ".$nfound[strtolower($xx)];
					}
				}
			}
		}
		echo("PRIVMSG $chan :\001ACTION slaps $nname around a bit with everything he finds...\001\n");
		echo("PRIVMSG $chan :\001ACTION has already slapped ".$xslap." users!\001\n");
		$fp = fopen("slapcount.z","w+");
		fputs($fp,$xslap);
		fclose($fp);
	}
}
else {
	echo("NOTICE $nick :Slapping is just available to channels.\n");
}
?>