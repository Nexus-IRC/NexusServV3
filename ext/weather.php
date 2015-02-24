<?php
/* ext/weather.php - NexusServV3
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
                //when you have add your key bind this script with this command =bind weather extscript weather.php

$param = explode(" ",$params);
if ($param[0] == "") {
	echo("NOTICE $nick :\002weather\002 requires more parameters.");
	die();
}
$url = "http://api.worldweatheronline.com/free/v2/weather.ashx?q=".urlencode($params)."&format=xml&num_of_days=5&key=".$apikey;
$data = str_replace("]]>", "", str_replace("<![CDATA[", "", get_contents($url)));
function object_to_array($object) {
	$new = null;
	if (is_object($object)) {
		$object = (array)$object;
	}
	if (is_array($object)) {
		$new = array();
		foreach($object as $key => $val) {
			$key = preg_replace("/^\\0(.*)\\0/","",$key);
			$new[$key] = object_to_array($val);
		}
	}
	else {
		$new = $object;
	}
	return $new;
}
$data = simplexml_load_string($data);
$data = object_to_array($data);
if ($chan[0] == "#") {
	if ($toys == "" || $toys == "0") {
		echo("NOTICE $nick :Toys are disabled in \002$chan\002.\n");
	}
	elseif ($toys == "1") {
		if(isset($data['error']['msg'])) {
			echo("NOTICE $nick :Unable to find a match.");
		} else {
			echo "NOTICE $nick :As of ".$data["current_condition"]["observation_time"]." it is ".strtolower($data["current_condition"]["weatherDesc"])." in \002".$data["request"]['query']."\002 with a temperature of ".$data["current_condition"]["temp_C"]."°C/".$data["current_condition"]["temp_F"]."°F\n";
		}
	}
	elseif ($toys == "2") {
		if(isset($data['error']['msg'])) {
			echo("PRIVMSG $chan :Unable to find a match.");
		} else {
			echo "PRIVMSG $chan :As of ".$data["current_condition"]["observation_time"]." it is ".strtolower($data["current_condition"]["weatherDesc"])." in \002".$data["request"]['query']."\002 with a temperature of ".$data["current_condition"]["temp_C"]."°C/".$data["current_condition"]["temp_F"]."°F\n";
		}
	}
}
else {
	if(isset($data['error']['msg'])) {
		echo("NOTICE $nick :Unable to find a match.");
	} else {
		echo "NOTICE $nick :As of ".$data["current_condition"]["observation_time"]." it is ".strtolower($data["current_condition"]["weatherDesc"])." in \002".$data["request"]['query']."\002 with a temperature of ".$data["current_condition"]["temp_C"]."°C/".$data["current_condition"]["temp_F"]."°F\n";
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