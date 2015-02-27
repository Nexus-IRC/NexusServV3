<?php
/* ext/movie.php - NexusServV3
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
$param = explode(" ",$params);
if ($param[0] == "") {
	echo("NOTICE $nick :\002".$command."\002 requires more parameters.");
	die();
}
$url = "http://www.omdbapi.com/?t=".urlencode($params)."&type=movie&plot=full&r=json";
$data = get_contents($url);
$data = json_decode($data);

$mresponse = $data->Response;

if (strtolower($mresponse) == "false") {
	$merror = $data->Error;
	$return = "\002Error:\002 ".$merror;
}
else {
	$mtitle = $data->Title;
	$myear = $data->Year;
	$mrated = $data->Rated;
	$mreleased = $data->Released;
	$mruntime = $data->Runtime;
	$mplot = $data->Plot;

	if (strlen($mplot) > 448) {
		$mplot = explode("\n", wordwrap($mplot, 448, "\n"));
	}

	$return[0] = "\002".$mtitle." (".$myear.")\002";
	$return[1] = $mrated." ".json_decode('"\u2022"')." ".$mreleased." ".json_decode('"\u2022"')." ".$mruntime;
	$return[2] = $mplot;
}

if ($chan[0] == "#") {
	if ($toys == "" || $toys == "0") {
		echo("NOTICE $nick :Toys are disabled in \002$chan\002.\n");
	}
	elseif ($toys == "1") {
		if (is_array($return)) {
			for ($i = 0; $i < count($return); $i += 1) {
				if ($i == 2 & is_array($return[$i])) {
					for ($j = 0; $j < count($return[$i]); $j += 1) {
						echo("NOTICE $nick :".$return[$i][$j]."\n");
			        }
				}
				else {
					echo("NOTICE $nick :".$return[$i]."\n");
				}
	        }
	    }
		else {
			echo("NOTICE $nick :".$return."\n");
		}
	}
	elseif ($toys == "2") {
		if (is_array($return)) {
			for ($i = 0; $i < count($return); $i += 1) {
				if ($i == 2 & is_array($return[$i])) {
					for ($j = 0; $j < count($return[$i]); $j += 1) {
						echo("PRIVMSG $chan :".$return[$i][$j]."\n");
			        }
				}
				else {
					echo("PRIVMSG $chan :".$return[$i]."\n");
				}
	        }
	    }
		else {
			echo("PRIVMSG $chan :".$return."\n");
		}
	}
}
else {
	if (is_array($return)) {
		for ($i = 0; $i < count($return); $i += 1) {
			if ($i == 2 & is_array($return[$i])) {
				for ($j = 0; $j < count($return[$i]); $j += 1) {
					echo("NOTICE $nick :".$return[$i][$j]."\n");
		        }
			}
			else {
				echo("NOTICE $nick :".$return[$i]."\n");
			}
	    }
	}
	else {
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