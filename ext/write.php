<?php
/* ext/write.php - NexusServV3
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
include("./inc/phpTextWrite.class.php"); // Text writer include...
$phpText = new phpText(chr(22)." ".chr(22));

 if ($chan[0] == "#") {
  if ($toys == "" || $toys == "0") {
   echo("NOTICE $nick :Toys are disabled in \002$chan\002.\n");
  }
  elseif ($toys == "1") {
   		$xy = explode("\n",$phpText->convert($params));
		foreach ($xy as $line) {
			if ($line != "") {
				echo("NOTICE $nick :".utf8_encode($line)."\n");
			}
		}
  }
  elseif ($toys == "2") {
   		$xy = explode("\n",$phpText->convert($params));
		foreach ($xy as $line) {
			if ($line != "") {
				echo("PRIVMSG $chan : ".utf8_encode($line)."\n");
			}
		}
  }
 }
 else {
   		$xy = explode("\n",$phpText->convert($params));
		foreach ($xy as $line) {
			if ($line != "") {
				echo("NOTICE $nick :".utf8_encode($line)."\n");
			}
		}
 }
?>