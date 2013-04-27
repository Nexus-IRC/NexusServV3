<?php
/* ext/iplocate.php - NexusServV3
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
$apikey = "";   //you can get your key here: http://ipinfodb.com/login.php after account activation you get your apikey
                //when you have add your key bind this script with this command =bind iplocate extscript iplocate.php
$param = explode(" ",$params);
if($param[0] == "") { echo("NOTICE $nick :\002iplocate\002 requires more parameters."); die(); }
$url = "http://api.ipinfodb.com/v3/ip-city/?key=".$apikey."&ip=".$param[0];
$data = file_get_contents($url);
$data = explode(";",$data);
if($data[0] != "OK") { echo("PRIVMSG $debugchan :!!!!!!!!!!!!IPLOCATE INTERNAL ERROR!!!!!\n"); die(); }
$return = "Country: ".$data[4]." (".$data[3].") State/Province: ".$data[5]." City: ".$data[6]."";
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