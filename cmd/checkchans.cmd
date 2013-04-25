/* cmd/checkchans.cmd - NexusServV3
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
global $userinfo; global $botnick; global $god; global $chans;
$lbotnick = strtolower($botnick);
$lnick = strtolower($nick);
$acc = $userinfo["$lnick"]["auth"];
$saxs = 0;
$chansnoop = array();
$chansnoton = array();
$cpcount = 0;
$fop = fopen("./conf/staff.conf","r+");
while ($fra = fgets($fop)) {
	$fra = str_replace("\r","",$fra);
	$fra = str_replace("\n","",$fra);
	$frg = explode(" ",$fra);
	if (strtolower($frg[0]) == strtolower($acc)) {
		$saxs = $frg[1];
	}
}
fclose($fop);
if ($saxs >= 200) {
	if ($god["$acc"] == "1") {
		foreach ($chans as $cname => $car) {
			if (str_replace("@","",$car["users"]["$lbotnick"]) == $car["users"]["$lbotnick"]) {
				if ($cname[0] == "#") {
					$ccn = $chans["$cname"]["name"];
					$chansnoop["$ccn"] = "1";
					$cpcount++;
				}
			}
		}
		$fop = fopen("./conf/users.conf","r+");
		while ($fr = fgets($fop)) {
			$fi = explode(" ",$fr);
			if ($fi[0] == "-" && $chans["$fi[1]"]["name"] == "") {
				$chansnoton["$fi[1]"] = "1";
				$cpcount++;
			}
		}
		sendserv("NOTICE $nick :\002Channel Check\002");
		sendserv("NOTICE $nick :\002Chans where I'm not opped:\002");
		foreach ($chansnoop as $cname => $carg) {
			sendserv("NOTICE $nick :$cname");
		}
		sendserv("NOTICE $nick :\002Chans where I'm not on:\002");
		foreach ($chansnoton as $cname => $carg) {
			sendserv("NOTICE $nick :- $cname");
		}
		sendserv("NOTICE $nick :---");
		sendserv("NOTICE $nick :Found a total amount of \002$cpcount\002 problems.");
	}
	else {
		sendserv("NOTICE $nick :You must enable security override (helping mode) to use this command.");
	}
}
else {
	sendserv("NOTICE $nick :You lack sufficient staff access to use this command.");
}