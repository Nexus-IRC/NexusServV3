 <?php
/* ext/git.php - NexusServV3
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
if($param[0] == "") {
	$a=str_replace('\r', '',str_replace('\n', '', file_get_contents("http://git.nexus-irc.de/git_v.php?git=NexusServV3.git")));
	$b=explode("<br>",$a);
	notice($nick,$b[0]);
	notice($nick,$b[1]);
	notice($nick,$b[2]);
	notice($nick,$b[3]);
	notice($nick,$b[4]);
}
else {
	$repo = $param[0];
	$a=str_replace('\r', '',str_replace('\n', '', file_get_contents("http://git.nexus-irc.de/git_v.php?git=".$repo.".git")));
	$b=explode("<br>",$a);
	notice($nick,$b[0]);
	notice($nick,$b[1]);
	notice($nick,$b[2]);
	notice($nick,$b[3]);
	notice($nick,$b[4]);
}
function notice ($nick, $line) {
	echo("NOTICE ".$nick." :".$line."\n");
}
?>