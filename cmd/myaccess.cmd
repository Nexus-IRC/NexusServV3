/* cmd/myaccess.cmd - NexusServV3
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
$cname = array();
$cfound = 0;
$cc = 0;
global $userinfo, $chans, $botnick, $god;
if ($params == "") {
	if ($userinfo["$lnick"]["auth"] == "") {
		sendserv("NOTICE $nick :$nick is not authed with \002AuthServ\002.");
		return(0);
	}
	$fop = fopen("./conf/settings.conf","r+t");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
			$area = $frg[1];
		}
		else {
			$tsets["$area"]["$frg[0]"] = substr($fra,strlen($frg[0]." "));
		}
	}
	fclose($fop);
	$owncnt = 0;
	sendserv("NOTICE $nick :Showing all channel entries for \002".$userinfo["$lnick"]["auth"]."\002:");
	$fop = fopen("./conf/users.conf","r+t");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
		$area = $frg[1];
		if ($chans["$area"]["name"] != "") {
		$cname["$area"] = $chans["$area"]["name"];
		}
		else {
		$cname["$area"] = "\00304$area\003";
		}
		}
		else {
			if ($frg[0] == $userinfo["$lnick"]["auth"]) {
				$mlayer = "";
				$elayer = "";
				$axs = $frg[1];
				$autoinvite = $frg[2];
				$noamodes = $frg[3];
				$infos = unserialize(substr($fra,strlen("$frg[0] $frg[1] $frg[2] $frg[3] ")));
				if ($axs >= $tsets["$area"]["giveops"]) {
					$mlayer .= "o";
				}
				elseif ($axs >= $tsets["$area"]["givevoice"]) {
					$mlayer .= "v";
				}
				if (binsetting($autoinvite) == "On") {
					$mlayer .= "i";
				}
				if ($infos['info'] != "") {
					$elayer = ": ".$infos['info'];
				}
				if ($mlayer != "") {
					$mlayer = ",$mlayer";
				}
				sendserv("NOTICE $nick :[".$cname["$area"]." ($axs".$mlayer.")]".$elayer);
				if ($axs == "500") {
					$owncnt++;
				}
				$cc++;
			}
			$cfound = 1;
		}
	}
	if ($owncnt != 0) {
		$owntxt = " and has owner access on \002$owncnt\002 channel(s)";
	}
	fclose($fop);
	sendserv("NOTICE $nick :\002".$userinfo["$lnick"]["auth"]."\002 has access to \002$cc\002 channel(s)".$owntxt.".");
}
else {
	$uauth = $userinfo["$lnick"]["auth"];
	if ($god[$uauth] != 1) {
		sendserv("NOTICE $nick :You might just see access and infolines for yourself using this command without parameters.");
	}
	else {
		if ($paramzz[0] == "*") {
			$fop = fopen("./conf/accs.conf","r+t");
			// TODO: Add accountcheck
			fclose($fop);
		}

		$owncnt = 0;
		sendserv("NOTICE $nick :Showing all channel entries for \002".$paramzz."\002:");
		$fop = fopen("./conf/users.conf","r+t");
		while ($fra = fgets($fop)) {
			$fra = str_replace("\r","",$fra);
			$fra = str_replace("\n","",$fra);
			$frg = explode(" ",$fra);
			if ($frg[0] == "-") {
				$area = $frg[1];
				if ($chans["$area"]["name"] != "") {
					$cname["$area"] = $chans["$area"]["name"];
				}
				else {
					$cname["$area"] = "\00304$area\003";
				}
			}
			else {
				if ($frg[0] == $paramzz) {
					$mlayer = "";
					$elayer = "";
					$axs = $frg[1];
					$autoinvite = $frg[2];
					$noamodes = $frg[3];
					$setinfo = substr($fra,strlen("$frg[0] $frg[1] $frg[2] $frg[3] "));
					if ($axs >= $tsets["$area"]["giveops"]) {
						$mlayer .= "o";
					}
					elseif ($axs >= $tsets["$area"]["givevoice"]) {
						$mlayer .= "v";
					}
					if (binsetting($autoinvite) == "On") {
						$mlayer .= "i";
					}
					if ($setinfo != "") {
						$elayer = ": $setinfo";
					}
					if ($mlayer != "") {
					$mlayer = ",$mlayer";
						}
					sendserv("NOTICE $nick :[".$cname["$area"]." ($axs".$mlayer.")]".$elayer);
					if ($axs == "500") {
						$owncnt++;
					}
					$cc++;
				}
				$cfound = 1;
			}
		}
		if ($owncnt != 0) {
			$owntxt = " and has owner access on \002$owncnt\002 channel(s)";
		}
		fclose($fop);
		sendserv("NOTICE $nick :\002".$paramzz."\002 has access to \002$cc\002 channel(s)".$owntxt.".");
	}
}