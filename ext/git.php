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
if ($param[0] == "") {
	$git = "NexusServV3";
}
else {
	$git = $param[0];
}
$commits = get_contents("http://git.stricted.de/git_commits.php?git=".$git.".git");
if ($commits == "404 Not Found - No such project") {
	echo("NOTICE ".$nick." :".$commits);
	die();
}
else {
	foreach (json_decode($commits) as $id => $commit) {
		$commit = str_replace("\n\n"," ",$commit);
		echo("NOTICE ".$nick." :".$commit."\n");
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