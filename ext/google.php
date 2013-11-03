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
echo "actually not work"; die();
if($param[0] == "") { echo("NOTICE $nick :\002google\002 requires more parameters."); die(); }
function object_to_array($object){
	$new=NULL;
	if(is_object($object)){
		$object=(array)$object;
	}
	if(is_array($object)){
		$new=array();
		foreach($object as $key => $val) {
			$key=preg_replace("/^\\0(.*)\\0/","",$key);
			$new[$key]=object_to_array($val);
		}
	}else{
		$new=$object;
	}
	return $new;
}
function from_google($query){
	$query=urlencode($query);
	$array=array();
	$url = "http://ajax.googleapis.com/ajax/services/search/web?v=1.0&q=".$query."&rsz=large";
	$data = file_get_contents($url);
	$json = json_decode($data);
	$array = object_to_array($json);
	return $array;
}
function decode_entities($text) {
	$text= html_entity_decode($text,ENT_QUOTES,"UTF-8");
	$text= preg_replace('/&#(\d+);/me',"chr(\\1)",$text);
	$text= preg_replace('/&#x([a-f0-9]+);/mei',"chr(0x\\1)",$text);
	return $text;
}
$google=from_google($params);
if(isset($google['responseData']['results'][0]['titleNoFormatting'])){
	privmsg($chan,"\002Google\002: ".decode_entities($google['responseData']['results'][0]['titleNoFormatting'])." => ".urldecode($google['responseData']['results'][0]['url']));
	privmsg($chan,"\002Google\002: ".decode_entities($google['responseData']['results'][1]['titleNoFormatting'])." => ".urldecode($google['responseData']['results'][1]['url']));
	privmsg($chan,"\002Google\002: ".decode_entities($google['responseData']['results'][2]['titleNoFormatting'])." => ".urldecode($google['responseData']['results'][2]['url']));
	privmsg($chan,"\002Google\002: ".decode_entities($google['responseData']['results'][3]['titleNoFormatting'])." => ".urldecode($google['responseData']['results'][3]['url']));
	privmsg($chan,"\002Google\002: ".decode_entities($google['responseData']['results'][4]['titleNoFormatting'])." => ".urldecode($google['responseData']['results'][4]['url']));
}else{
	privmsg($chan,"\002Google\002: Your search - ".$params." - did not match any documents. ");
}
function privmsg ($chan, $line) {
	echo("PRIVMSG ".$chan." :".$line."\n");
}
?>