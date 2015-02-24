<?php
/* ext/google.php - NexusServV3
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
$param = explode(" ",$params);
if ($param[0] == "") {
	echo("NOTICE $nick :\002google\002 requires more parameters.");
	die();
}
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
function from_google($query) {
	$query = urlencode($query);
	$array = array();
	$url = "http://ajax.googleapis.com/ajax/services/search/web?v=1.0&q=".$query."&rsz=large";
	$data = get_contents($url);
	$json = json_decode($data);
	$array = object_to_array($json);
	return $array;
}
function decode_entities($text) {
	$text = html_entity_decode($text,ENT_QUOTES,"UTF-8");
	$text = preg_replace_callback(
		"/&#(\d+);/m",
		function ($matches) {
			return chr(1);
		},
		$text
	);
	$text = preg_replace_callback(
		"/&#x([a-f0-9]+);/mi",
		function ($matches) {
			return chr(0x1);
		},
		$text
	);
	return $text;
}
$google = from_google($params);
if (isset($google['responseData']['results'][0]['titleNoFormatting'])) {
	for ($i=0; $i<5; $i++) {
		privmsg($chan,"\002[Google]\002 ".decode_entities($google['responseData']['results'][$i]['titleNoFormatting'])." => ".urldecode($google['responseData']['results'][$i]['url']));
	}
}
else {
	privmsg($chan,"\002[Google]\002 Your search ".$params." did not match any documents.");
}

function privmsg ($chan, $line) {
	echo("PRIVMSG ".$chan." :".$line."\n");
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