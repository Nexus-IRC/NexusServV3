<?php
/* ext/lastfm.php - NexusServV3
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

//Get your key here: http://www.last.fm/api/account/create
$apikey = "";
//Bind command with =bind lastfm extscript lastfm.php

$param = explode(" ",$params);
if ($param[0] == "") {
	echo("NOTICE $nick :\002lastfm\002 requires more parameters.");
	die();
}
$url = "https://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=".urlencode($params)."&limit=1&format=json&api_key=".$apikey;
$data = file_get_contents($url);
$data = json_decode($data, true);

if (isset($data['error'])) {
	$return = "\002Error:\002 ".$data['message'];
}
elseif ($data['recenttracks']['track'][0]['@attr']['nowplaying'] == true) {
	$return = $data['recenttracks']['@attr']['user']." is now playing \002".$data['recenttracks']['track'][0]['name']."\002 by \002".$data['recenttracks']['track'][0]["artist"]['#text']."\002";
}
else {
	$return = $data['recenttracks']['@attr']['user']." last played \002".$data['recenttracks']['track']['name']."\002 by \002".$data['recenttracks']['track']['artist']['#text']."\002";
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
?>