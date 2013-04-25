/* modules/readchan.mod - NexusServV3
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
if (strtolower($cbase) == "readchan") {
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
	if ($tsets['changeusers'] == "") {
		$tsets['changeusers'] = "300";
	}
	if ($tsets['adduser'] == "") {
		$tsets['adduser'] = $tsets['changeusers'];
	}
	if ($tsets['deluser'] == "") {
		$tsets['deluser'] = $tsets['changeusers'];
	}
	if ($tsets['clvl'] == "") {
		$tsets['clvl'] = $tsets['changeusers']; 
	}
	$cname = $chans["$ctarg"]["name"];
	if ($cfound == 0) {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
	}
	else {
		if ($axs < "500" && $god[$acc] != "1") {
			sendserv("NOTICE $nick :You lack sufficient access to ".$chans["$tchan"]["name"]." to use this command.");
			return(0);
		}
	}

	$uc = 0;
	$ufound = "";
	global $botnick;
	global $chans;
	foreach ($chans[strtolower($target)]['users'] as $uname => $uaccs) {
		if ($userinfo[$uname]['auth'] != "") {
			if (str_replace("@","",$uaccs) != $uaccs) {
				if (addChanUser(strtolower($target),$userinfo[$uname]['auth'],200) == "Ok") {
					$ua = $userinfo[$uname]['auth'];
					$uc++;
					sendserv("NOTICE $nick :Added \002$uname\002 ($ua) with access \002200\002");
				}
			}
			if (str_replace("+","",$uaccs) != $uaccs) {
				if (addChanUser(strtolower($target),$userinfo[$uname]['auth'],100) == "Ok") {
					$ua = $userinfo[$uname]['auth'];
					$uc++;
					sendserv("NOTICE $nick :Added \002$uname\002 ($ua) with access \002100\002");
				}
			}
		}
	}
	sendserv("NOTICE $nick :\002$uc\002 users were added.");
}