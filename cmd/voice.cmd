/* cmd/voice.cmd - NexusServV3
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
$fail = 0;
$params = $paramzz;
$tchan = strtolower($target);
$lnick = strtolower($nick);
$area = "";
$axs = 0;
$cfound = 0;
global $userinfo; global $chans; global $botnick; global $god;
$acc = $userinfo["$lnick"]["auth"];
$fop = fopen("./conf/users.conf","r+");
while ($fra = fgets($fop)) {
	$fra = str_replace("\r","",$fra);
	$fra = str_replace("\n","",$fra);
	$frg = explode(" ",$fra);
	if ($frg[0] == "-") {
		$area = $frg[1];
	}
	else {
		if ($area == $tchan) {
			if ($frg[0] == $userinfo["$lnick"]["auth"]) {
				$axs = $frg[1];
			}
			$cfound = 1;
		}
	}
}
fclose($fop);
$area = "";
$fop = fopen("./conf/settings.conf","r+");
while ($fra = fgets($fop)) {
	$fra = str_replace("\r","",$fra);
	$fra = str_replace("\n","",$fra);
	$frg = explode(" ",$fra);
	if ($frg[0] == "-") {
		$area = $frg[1];
	}
	else {
		if ($area == $tchan) {
			$tsets["$frg[0]"] = substr($fra,strlen($frg[0]." "));
		}
	}
}
fclose($fop);
$cname = $chans["$tchan"]["name"];
if ($cfound != 0) {
	if ($axs >= 200 || $god[$acc] == 1) {
		$ps = explode(" ",$params);
		$xyxx = 0;
		while ($ps[$xyxx] != "") {
			sendserv("MODE $target +v ".$ps[$xyxx]);
			global $userinfo;
			if ($userinfo[strtolower($ps[$xyxx])]['nick'] == "") {
				$fail = 1;
			}
			$xyxx++;
		}
		if ($fail == 1) {
			global $botnick;
			sendserv("NOTICE $nick :\002$botnick\002 couldn't process with some nicks you provided.");
		}
		sendserv("NOTICE $nick :User(s) have been voiced in $cname.");
	}
	else {
		sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
	}
}
else {
	sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
}