/* modules/unbind.mod - NexusServV3
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
 if (strtolower($cbase) == "unbind") {
	$params = $paramzz;
	$paz = explode(" ",$params);
	global $userinfo; global $botnick; global $god;
	$lnick = strtolower($nick);
	$acc = $userinfo["$lnick"]["auth"];
	$saxs = 0;
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
	if ($saxs >= 800) {
		$fope = fopen("./conf/bind.conf","r+");
		$found = 0;
		$fcont = "";
		while ($frae = fgets($fope)) {
			$frae = str_replace("\r","",$frae);
			$frae = str_replace("\n","",$frae);
			$frge = explode(" ",$frae);
			if (strtolower($frge[0]) == strtolower($paz[0])) {
				// ignore this command?
				$found = 1;
			}
			else {
				$fcont .= $frae."\n";
			}
		}
		fclose($fope);
		if ($found == 1) {
			$fope = fopen("./conf/bind.conf","w+");
			fwrite($fope,$fcont);
			fclose($fope);
			sendserv("NOTICE $nick :Command \002$paz[0]\002 unbound from the bot.");
		}
		else {
			sendserv("NOTICE $nick :Command \002$paz[0]\002 is unknown to me.");
		}
	}
	else {
		sendserv("NOTICE $nick :You lack sufficient staff access to use this command.");
	}
}