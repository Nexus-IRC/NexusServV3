<?php
/* ext/time.php - NexusServV3
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
$apikey = "";   //you can get your key here: http://www.worldweatheronline.com/register.aspx after account activation you can create your apikey
                //when you have add your key bind this script with this command =bind time extscript time.php

$param = explode(" ",$params);
if ($param[0] == "") {
	echo("NOTICE $nick :\002".$command."\002 requires more parameters.");
	die();
}
$url = "http://api.worldweatheronline.com/free/v2/tz.ashx?q=".urlencode($params)."&format=json&key=".$apikey;
$data = get_contents($url);
$data = json_decode($data);
$return = "The time in \002".$data->data->request[0]->query."\002 is ".$data->data->time_zone[0]->localtime;
if ($chan[0] == "#") {
	if ($toys == "" || $toys == "0") {
		echo("NOTICE $nick :Toys are disabled in \002$chan\002.\n");
	}
	elseif ($toys == "1") {
		if(isset($data->data->error[0]->msg)) {
			echo("NOTICE $nick :Unable to find a match.");
		} else {
			echo("NOTICE $nick :".$return."\n");
		}
	}
	elseif ($toys == "2") {
		if(isset($data->data->error[0]->msg)) {
			echo("PRIVMSG $chan :Unable to find a match.");
		} else {
			echo("PRIVMSG $chan :".$return."\n");
		}
	}
}
else {
	if(isset($data->data->error[0]->msg)) {
		echo("NOTICE $nick :Unable to find a match.");
	} else {
		echo("NOTICE $nick :".$return."\n");
	}
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