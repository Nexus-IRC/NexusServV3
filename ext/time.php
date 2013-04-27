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
$param = explode(" ",$params);
if($param[0] == "") { echo("NOTICE $nick :\002time\002 requires more parameters."); die(); }
function getzone() {
	$zones = timezone_identifiers_list();
	$locations = array();
	foreach ($zones as $zone) {
		$zone = explode('/', $zone);
		if ($zone[0] == 'Africa' || $zone[0] == 'America' || $zone[0] == 'Antarctica' || $zone[0] == 'Arctic' || $zone[0] == 'Asia' || $zone[0] == 'Atlantic' || $zone[0] == 'Australia' || $zone[0] == 'Europe' || $zone[0] == 'Indian' || $zone[0] == 'Pacific') {  
			if (isset($zone[1]) != '') {
				$locations[strtolower($zone[1])] = $zone[0].'/'.str_replace('_', ' ', $zone[1]);
			}
		}
	}
	return $locations;
}
$zones = getzone();
$search = strtolower($param[0]);
if ($chan[0] == "#") {
	if ($toys == "" || $toys == "0") {
		echo("NOTICE ".$nick." :Toys are disabled in \002$chan\002.\n");
	}
	elseif ($toys == "1") {
		if(!isset($zones[$search])) { echo("NOTICE ".$nick." :cant find ".$param[0]); die(); }
		ini_set("date.timezone", $zones[$search]);
		echo("NOTICE ".$nick." :Time in ".$param[0]." ".date('d.m.y H:i:s'));
	}
	elseif ($toys == "2") {
		if(!isset($zones[$search])) { echo("PRIVMSG ".$chan." :cant find ".$param[0]); die(); }
		ini_set("date.timezone", $zones[$search]);
		echo("PRIVMSG ".$chan." :Time in ".$param[0]." ".date('d.m.y H:i:s'));
	}
}
else {
	if(!isset($zones[$search])) { echo("NOTICE ".$nick." :cant find ".$param[0]); die(); }
	ini_set("date.timezone", $zones[$search]);
	echo("NOTICE ".$nick." :Time in ".$param[0]." ".date('d.m.y H:i:s'));
}
?>