<?php
/* ext/book.php - NexusServV3
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
$apikey = "";		//register for the Books API here: https://code.google.com/apis/console#access

$param = explode(" ",$params);
if ($param[0] == "") {
	echo("NOTICE $nick :\002".$command."\002 requires more parameters.");
	die();
}
$url = "https://www.googleapis.com/books/v1/volumes?q=".urlencode($params)."&key=".$apikey;
$data = get_contents($url);
$data = json_decode($data);

$title = $data->items[0]->volumeInfo->title;
$desc = $data->items[0]->volumeInfo->description;
$isbn = $data->items[0]->volumeInfo->industryIdentifiers[0]->identifier;
$authors = "";
if (count($data->items[0]->volumeInfo->authors) == 1) {
	$authors = $data->items[0]->volumeInfo->authors[0];
}
else {
	for ($i = 0; $i < count($data->items[0]->volumeInfo->authors); $i += 1) {
		if ($i == count($data->items[0]->volumeInfo->authors)-1) {
			$authors .= $data->items[0]->volumeInfo->authors[$i];
		}
		else {
			$authors .= $data->items[0]->volumeInfo->authors[$i].", ";
		}
	}
}

if (strlen($desc) > 448) {
	$desc = explode("\n", wordwrap($desc, 448, "\n"));
}

$return[0] = "\002".$title."\002 by ".$authors." (ISBN: ".$isbn.")";
$return[1] = $desc;

if ($chan[0] == "#") {
	if ($toys == "" || $toys == "0") {
		echo("NOTICE $nick :Toys are disabled in \002$chan\002.\n");
	}
	elseif ($toys == "1") {
		for ($i = 0; $i < count($return); $i += 1) {
			if ($i == 1 & is_array($return[$i])) {
				for ($j = 0; $j < count($return[$i]); $j += 1) {
					echo("NOTICE $nick :".$return[$i][$j]."\n");
				}
			}
			else {
				echo("NOTICE $nick :".$return[$i]."\n");
			}
		}
	}
	elseif ($toys == "2") {
		for ($i = 0; $i < count($return); $i += 1) {
			if ($i == 1 & is_array($return[$i])) {
				for ($j = 0; $j < count($return[$i]); $j += 1) {
					echo("PRIVMSG $chan :".$return[$i][$j]."\n");
				}
			}
			else {
				echo("PRIVMSG $chan :".$return[$i]."\n");
			}
		}
	}
}
else {
	for ($i = 0; $i < count($return); $i += 1) {
		if ($i == 1 & is_array($return[$i])) {
			for ($j = 0; $j < count($return[$i]); $j += 1) {
				echo("NOTICE $nick :".$return[$i][$j]."\n");
			}
		}
		else {
			echo("NOTICE $nick :".$return[$i]."\n");
		}
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