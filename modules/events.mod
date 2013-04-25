/* modules/events.mod - NexusServV3
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
if (strtolower($cbase) == "events") {
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
	if ($cfound == 0) {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
		return(0);
	}
	if ($params == "") {
		$paramz = "10m";
	}
	else {
		$paramz = $params;
	}
	if ($paramz != "*") {
		$tdur = str2time($paramz);
		if ($tdur == "I") {
			sendserv("NOTICE $nick :\002$params\002 is an invalid time span.");
		}
		sendserv("NOTICE $nick :Events from ".$chans["$tchan"]["name"]." from the last ".time2str(str2time("$tdur")).":");
	}
	else {
		sendserv("NOTICE $nick :Events from ".$chans["$tchan"]["name"]." (\002all, since registration\002)");
	}
	$evcnt = 0;
	if ($axs >= 200) {
		$fop = fopen("./inc/events.log","r+");
		while ($fra = fgets($fop)) {
			$fra = str_replace("\r","",$fra);
			$fra = str_replace("\n","",$fra);
			$frg = explode(" ",$fra);
			$fm = explode("?",$frg[2]);
			if ($fm[1] != "") {
				$fres = $fm[0].":".$fm[1];
			}
			else {
				$fres = $fm[0];
			}
			if ($frg[0] == $tchan && $frg[1] >= (time() - str2time("$tdur")) or $frg[0] == $tchan && $params == "*") {
				$evcnt++;
				sendserv("NOTICE $nick :(".date("H:i:s d/m/y","$frg[1]").") [".$fres."] ".substr($fra,strlen("$frg[0] $frg[1] $frg[2] ")));
			}
		}
		fclose($fop);
		sendserv("NOTICE $nick :Found \002$evcnt\002 events in ".$chans["$tchan"]["name"].".");
	}
}