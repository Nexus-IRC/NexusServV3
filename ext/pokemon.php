<?php
/* ext/pokemon.php - NexusServV3
 * Copyright (C) 2014  #Nexus project
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
$url = "http://pokeapi.co/api/v1/pokemon/".rand(1,718);
$data = file_get_contents($url);
$data = json_decode($data);

$return = "You caught a ".$data->name."!";

if ($chan[0] == "#") {
	if ($toys == "" || $toys == "0") {
		echo("NOTICE $nick :Toys are disabled in \002$chan\002.\n");
	}
	elseif ($toys == "1") {
		echo("NOTICE $nick :".$return."\n");
	}
	elseif ($toys == "2") {
		echo("PRIVMSG $chan :".$return."\n");
	}
}
else {
	echo("NOTICE $nick :".$return."\n");
}
?>