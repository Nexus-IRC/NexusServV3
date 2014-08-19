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
	$git = "NexusServV3";
} else {
	$git = $param[0];
}
$commits = file_get_contents("https://git.stricted.de/git_commits.php?git=".$git.".git");
if($commits == "404 Not Found - No such project") { echo $commits; die(); }
foreach (json_decode($commits) as $id => $commit) {
	echo("NOTICE ".$nick." :".$commit."\n");
}
?>