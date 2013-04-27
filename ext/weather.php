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
$param = explode(" ",$params);
if($param[0] == "") { echo("NOTICE $nick :\002weather\002 requires more parameters."); die(); }
$url = "http://api.wunderground.com/auto/wui/geo/WXCurrentObXML/index.xml?query=".urlencode($params);
$data = file_get_contents($url);
$exp = explode("<display_location>",$data);
$exp = explode("</display_location>",$exp[1]);
$exp = explode("<full>",$exp[0]);
$exp = explode("</full>",$exp[1]);
$exp = $exp[0];
$expa = explode("<weather>",$data);
$expa = explode("</weather>",$expa[1]);
$expa = $expa[0];
$expb = explode("<temp_f>",$data);
$expb = explode("</temp_f>",$expb[1]);
$expb = $expb[0];
$expc = explode("<temp_c>",$data);
$expc = explode("</temp_c>",$expc[1]);
$expc = $expc[0];
$return = $exp.": ".$expa." and ".$expb."°F/".$expc."°C";
if ($chan[0] == "#") {
	if ($toys == "" || $toys == "0") {
		echo("NOTICE $nick :Toys are disabled in \002$chan\002.\n");
	}
	elseif ($toys == "1") {
		if($exp == ", ") {
			echo("notice $nick :Unable to find a match.");
		} else {
			echo("NOTICE $nick :".$return."\n");
		}
	}
	elseif ($toys == "2") {
		if($exp == ", ") {
			echo("PRIVMSG $chan :Unable to find a match.");
		} else {
			echo("PRIVMSG $chan :".$return."\n");
		}
	}
}
else {
	if($exp == ", ") {
		echo("notice $nick :Unable to find a match.");
	} else {
		echo("NOTICE $nick :".$return."\n");
	}
}
?>