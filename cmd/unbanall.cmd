/* cmd/unbanall.cmd - NexusServV3
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
$params = $paramzz;
$tchan = strtolower($target);
$lnick = strtolower($nick);
$area = "";
$axs = 0;
$cfound = 0;
$uaxs = array();
global $userinfo, $chans, $botnick, $god;
$acc = $userinfo["$lnick"]["auth"];
$fop = fopen("./conf/users.conf","r+t");
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
			$uaxs["$frg[0]"] = $frg[1];
			$cfound = 1;
		}
	}
}
fclose($fop);
$area = "";
$fop = fopen("./conf/settings.conf","r+t");
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
if ($cfound == 0) {
	sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
	return(0);
}
$cname = $chans["$tchan"]["name"];
if ($axs < 400) {
	sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
}
else {
sendserv("MODE $cname -b *");
sendserv("NOTICE $nick :Removed all channel bans from \002$cname\002.");
}