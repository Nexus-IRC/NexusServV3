<?php
/* ext/iplocate.php - NexusServV3
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
$param = explode(" ",$params);
if ($param[0] == "") {
	echo("NOTICE $nick :\002".$command."\002 requires more parameters.");
	die();
}
$url = "http://freegeoip.net/json/".$param[0];
$data = get_contents($url);
$data = json_decode($data);

if (empty($data->country_name) && empty($data->region_name) && empty($data->city)) {
	$return = "Location undetermined.";
}
elseif (empty($data->region_name) && empty($data->city)) {
	$return = "Location: ".$data->country_name;
}
elseif (empty($data->region_name) && isset($data->city)) {
	$return = "Location: ".$data->city.", ".$data->country_name;
}
else {
	$return = "Location: ".$data->city.", ".$data->region_name.", ".$data->country_name;
}

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

function get_contents ($url) {
	global $useragent;
	$ch = curl_init();
	curl_setopt_array($ch, array(
		CURLOPT_RETURNTRANSFER => 1,
		CURLOPT_URL => $url,
		CURLOPT_USERAGENT => $useragent
	));
	return curl_exec($ch);
	curl_close($ch);
}
?>