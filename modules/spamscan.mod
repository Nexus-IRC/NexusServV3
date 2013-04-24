/* spamscan.mod - NexusServV3
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
// cbase: spamscan
if (strtolower($cbase) == "spamscan") {
	if ($paramzz[0] != "§") {
		sendserv("NOTICE $nick :SpamScan isnt a real command. This is just for scanning.");
		return(0);
	}
	$params = $paramzz;
	$tchan = strtolower($target);
	$lnick = strtolower($nick);
	$area = "";
	$axs = 0;
	$cfound = 0;
	global $userinfo; global $chans; global $botnick; global $god;
	$acc = $userinfo["$lnick"]["auth"];
	$fop = fopen("users.conf","r+");
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
	$fop = fopen("settings.conf","r+");
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
	if ($tsets["setters"] == "") {
		$tsets["setters"] = "400";
	}
	if ($tsets["spam.spamreaction"] == "") {
		$tsets["spam.spamreaction"] = "KICK";
	}
	if ($tsets["spam.floodreaction"] == "") {
		$tsets["spam.floodreaction"] = "KICK";
	}
	if ($tsets["spam.badwordreaction"] == "") {
		$tsets["spam.badwordreaction"] = "KICK";
	}
	if ($tsets["spam.botnetreaction"] == "") {
		$tsets["spam.botnetreaction"] = "KICK";
	}
	if ($tsets["spam.advreaction"] == "") {
		$tsets["spam.advreaction"] = "KICK";
	}
	if ($tsets["spam.capsreaction"] == "") {
		$tsets["spam.capsreaction"] = "KICK";
	}
	if ($tsets["spam.exceptlevel"] == "") {
		$tsets["spam.exceptlevel"] = "200";
	}
	if ($tsets["spam.floodsensibility"] == "") {
		$tsets["spam.floodsensibility"] = "1:2";
	}
	if ($axs == '') {
		$axs = '0';
	}
	if ($tsets['spam.spamscan'] == '1' && $axs < $tsets['spam.exceptlevel']) {
		$said = substr($paramzz,1);
		global $whatsaid; global $whatspammed;
		if ($whatsaid[$target][$nick] == $said) {
			if ($whatspammed[$target][$nick] == 2) {
				sendserv("MODE $target -o+b $nick $nick");
				sendserv("KICK $target $nick :Spamming is against the network rules.");
				$whatspammed[$target][$nick] = 0;
			}
			else {
				sendserv("NOTICE $nick :Spamming is against the channel rules.");
				$whatspammed[$target][$nick] = $whatspammed[$target][$nick] + 1;
			}
		}
		else {
			$whatsaid[$target][$nick] = $said;
		}
	}
}