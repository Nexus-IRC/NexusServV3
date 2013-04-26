/* cmd/users.cmd - NexusServV3
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
$cp = 0;
$lsize = strlen("Account");
$paz = explode(" ",$paramzz);
if ($paz[1] == "") {
	$paz[1] = "1";
	$cp = 1;
}
if ($paz[2] == "") {
	$paz[2] = "500";
	$cp = 1;
}
$params = $paz[0];
$sul = 6;
global $chans; global $god;
$ctarg = strtolower($target);
$mc = 0;
if ($params != "") {
	if ($paz[3] != "") {
		$matchstr = " matching $paz[3]";
		$pat = str_replace("[","\[",$paz[3]);
		$pat = str_replace("]","\]",$pat);
	}
	else {
		if ($cp == 1) {
			$matchstr = " matching $params";
		}
		$pat = str_replace("[","\[",$params);
		$pat = str_replace("]","\]",$pat);
	}
}
else {
	$pat = "*";
}

$fop = fopen("./conf/users.conf","r+");
while ($fra = fgets($fop)) {
	$fra = str_replace("\r","",$fra);
	$fra = str_replace("\n","",$fra);
	$fgr = explode(" ",$fra);
	if ($fgr[0] == "-") {
		$area = $fgr[1];
	}
	elseif ($fra == "") {
	}
	else {
		if ($area == $ctarg) {
			$uc++;
			$ualvl = str_replace("-","",$fgr[1]);
			if (str_replace("-","",$fgr[1]) != $fgr[1]) {
				$ustat[strtolower($fgr[0])] = "Suspended";
				$sul = 9;
			}
			$userz["$ualvl"][strtolower("$fgr[0]")] = array("1");
			if ($god["$fgr[0]"] == 1) {
				if (staffstat($fgr[0]) != "Bot") {
					$sul = 17;
				}
			}
			$xun[strtolower("$fgr[0]")] = $fgr[0];
			if (strlen($fgr[0]) > $lsize) {
				$lsize = strlen($fgr[0]);
			}
			$found = 1;
		}
	}
}
if (vaccess($paz[1],500) != "yes") {
	sendserv("NOTICE $nick :\002$paz[1]\002 is not a valid access level!");
	return(0);
}
if (vaccess($paz[2],500) != "yes") {
	sendserv("NOTICE $nick :\002$paz[2]\002 is not a valid access level!");
	return(0);
}
sendserv("NOTICE $nick :".@(isset($chans["$ctarg"]["name"]) ? $chans["$ctarg"]["name"] : $ctarg)." users from level $paz[1] to $paz[2]".$matchstr.":");
sendserv("NOTICE $nick :Access".spaces("Access",6)." Account".spaces("Account",$lsize)." Status".spaces("Status",$sul)." Last Seen");
krsort($userz);
foreach ($userz as $uaxs => $unam) {
	ksort($unam);
	foreach ($unam as $unme => $unmear) {
		if (fnmatch(strtolower($pat),$unme)) {
			$stat = "Normal";
			if ($god[$xun["$unme"]] == 1) {
				$stat = "Security Override";
			}
			if ($ustat[$unme] != "") {
				$stat = $ustat[$unme];
			}
			if (staffstat($xun["$unme"]) == "Bot") {
				$stat = "Bot";
			}
			if ($uaxs >= $paz[1] && $uaxs <= $paz[2]) {
				sendserv("NOTICE $nick :$uaxs".spaces("$uaxs",6)." ".$xun[$unme].spaces($xun[$unme],$lsize)." ".$stat.spaces($stat,$sul)." ".lseen($unme,$ctarg)); 
				$mc++;
			}
		}
	}
}
sendserv("NOTICE $nick :There are \002$uc\002 users in ".$chans["$ctarg"]["name"].".\n");
if ($params != "") {
	sendserv("NOTICE $nick :There are \002$mc\002 users in ".$chans["$ctarg"]["name"]." matching your request.\n");
}