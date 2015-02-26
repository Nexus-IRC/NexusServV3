<?php
/* ext/yoda.php - NexusServV3
 * Copyright (C) 2015  #Nexus project
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
$apikey = "";		//register for api key here: https://www.mashape.com/ismaelc/yoda-speak

$param = explode(" ",$params);
if ($param[0] == "") {
	echo("NOTICE $nick :\002yoda\002 requires more parameters.");
	die();
}
$url = "https://yoda.p.mashape.com/yoda?sentence=".urlencode($params);
$data = get_contents($url, $apikey);
$data = str_replace("  ", " ", $data);

if ($chan[0] == "#") {
	if ($toys == "" || $toys == "0") {
		echo("NOTICE $nick :Toys are disabled in \002$chan\002.\n");
	}
	elseif ($toys == "1") {
		echo("NOTICE $nick :".$data."\n");
	}
	elseif ($toys == "2") {
		echo("PRIVMSG $chan :".$data."\n");
	}
}
else {
	echo("NOTICE $nick :".$data."\n");
}

function get_contents ($url, $apikey) {
	global $useragent;
	$ch = curl_init();
	curl_setopt_array($ch, array(
		CURLOPT_RETURNTRANSFER => 1,
		CURLOPT_URL => $url,
		CURLOPT_USERAGENT => $useragent,
		CURLOPT_HTTPHEADER => array(
			"X-Mashape-Key: ".$apikey,
    		"Accept: text/plain"
		),
		CURLOPT_SSL_VERIFYPEER => 0
	));
	return curl_exec($ch);
	curl_close($ch);
}
?>