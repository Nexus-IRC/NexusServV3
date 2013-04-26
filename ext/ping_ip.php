<?php
/* ext/ping_ip.php - NexusServV3
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
if($param[0] == "4") {
	$ping = shell_exec("ping -c4 ".$param[1]);
} elseif($param[0] == "6") {
	$ping = shell_exec("ping6 -c4 ".$param[1]);
}
if(isset($param[1])) {
	if(isset($ping)){
		$exp = explode("\n",$ping);
		foreach($exp as $rec){
			if($rec != "") {
				echo("PRIVMSG $chan :".$rec."\n");
			}
		}
	} else {
		echo("PRIVMSG $chan :ping: unknown host ".$param[1]);
	}
} else {
	echo("NOTICE $nick :\002ping_ip\002 requires more parameters.");
}
?>