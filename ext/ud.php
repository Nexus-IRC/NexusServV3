<?php
/* ext/ud.php - NexusServV3
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
$apikey = "";		//register for api key here: https://www.mashape.com/community/urban-dictionary

$param = explode(" ",$params);
if ($param[0] == "") {
	echo("NOTICE $nick :\002".$command."\002 requires more parameters.");
	die();
}
$url = "https://mashape-community-urban-dictionary.p.mashape.com/define?term=".urlencode($params);
$data = get_contents($url, $apikey);
$data = json_decode($data);

if ($data->result_type == "no_results") {
	echo("NOTICE $nick :No results found");
	die();
}

$word = $data->list[0]->word;
$def = $data->list[0]->definition;

$def = str_replace("\r\n\r\n", "\n", $def);
$def = str_replace("\r\n", "\n", $def);

if (strpos($def, "\n") !== false) {
	$def = explode("\n", $def);
}

if (is_array($def)) {
	for ($i = 0; $i < count($def); $i += 1) {
		if (strlen($def[$i]) > 448) {
			$def[$i] = explode("\n", wordwrap($def[$i], 448-strlen($word)-2, "\n"));
		}
	}
}
else if (strlen($def) > 448) {
	$def = explode("\n", wordwrap($def, 448-strlen($word)-2, "\n"));
}

if ($chan[0] == "#") {
	if ($toys == "" || $toys == "0") {
		echo("NOTICE $nick :Toys are disabled in \002$chan\002.\n");
	}
	elseif ($toys == "1") {
		if (is_array($def)) {
			for ($i = 0; $i < count($def); $i += 1) {
				if (is_array($def[$i])) {
					for ($j = 0; $j < count($def[$i]); $j += 1) {
						if ($i == 0 & $j == 0) {
							echo("NOTICE $nick :\002".$word.":\002 ".$def[$i][$j]."\n");
						}
						else {
							echo("NOTICE $nick :".$def[$i][$j]."\n");
						}
			        }
				}
				else {
					if ($i == 0) {
						echo("NOTICE $nick :\002".$word.":\002 ".$def[$i]."\n");
					}
					else {
						echo("NOTICE $nick :".$def[$i]."\n");
					}
				}
	        }
	    }
		else {
			echo("NOTICE $nick :\002".$word.":\002 ".$def."\n");
		}
	}
	elseif ($toys == "2") {
		if (is_array($def)) {
			for ($i = 0; $i < count($def); $i += 1) {
				if (is_array($def[$i])) {
					for ($j = 0; $j < count($def[$i]); $j += 1) {
						if ($i == 0 & $j == 0) {
							echo("PRIVMSG $chan :\002".$word.":\002 ".$def[$i][$j]."\n");
						}
						else {
							echo("PRIVMSG $chan :".$def[$i][$j]."\n");
						}
			        }
				}
				else {
					if ($i == 0) {
						echo("PRIVMSG $chan :\002".$word.":\002 ".$def[$i]."\n");
					}
					else {
						echo("PRIVMSG $chan :".$def[$i]."\n");
					}
				}
	        }
	    }
		else {
			echo("PRIVMSG $chan :\002".$word.":\002 ".$def."\n");
		}
	}
}
else {
	if (is_array($def)) {
		for ($i = 0; $i < count($def); $i += 1) {
			if (is_array($def[$i])) {
				for ($j = 0; $j < count($def[$i]); $j += 1) {
					if ($i == 0 & $j == 0) {
						echo("NOTICE $nick :\002".$word.":\002 ".$def[$i][$j]."\n");
					}
					else {
						echo("NOTICE $nick :".$def[$i][$j]."\n");
					}
		        }
			}
			else {
				if ($i == 0) {
					echo("NOTICE $nick :\002".$word.":\002 ".$def[$i]."\n");
				}
				else {
					echo("NOTICE $nick :".$def[$i]."\n");
				}
			}
        }
    }
	else {
		echo("NOTICE $nick :\002".$word.":\002 ".$def."\n");
	}
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