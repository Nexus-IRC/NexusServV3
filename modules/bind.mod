/* modules/bind.mod - NexusServV3
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
 if (strtolower($cbase) == "bind") {
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
		$fcont = "";
		while ($frae = fgets($fope)) {
			$frae = str_replace("\r","",$frae);
			$frae = str_replace("\n","",$frae);
			$frge = explode(" ",$frae);
			if (strtolower($frge[0]) == strtolower($paz[0])) {
				sendserv("NOTICE $nick :There is already a command bound as \002$paz[0]\002.");
				return(0);
			}
			$fcont .= $frae."\n";
		}
		fclose($fope);
		$found = 0;
		$pazz = explode(".",$paz[1]);
		if (file_exists($pazz[0].".mod")) {
			$fope = fopen($pazz[0].".mod","r+");
			while ($frae = fgets($fope)) {
				$frae = str_replace("\r","",$frae);
				$frae = str_replace("\n","",$frae);
				$frge = explode(" ",$frae);
				if ($frae{0} == "/") {
					if (substr($params,strlen("$paz[0] $paz[1] ")) != "") {
						$mgs = substr($params,strlen("$paz[0] $paz[1] "))." ";
					}
					else {
						$mgs = "";
					}
					if (strtolower($frge[2]) == strtolower($pazz[1])) {
						$fcont .= $paz[0]." mod_mod ".$pazz[0].".mod ".$pazz[1]." ".$mgs;
						$found = 1;
					}
				}
			}
			fclose($fope);
			if ($found == 0) {
				sendserv("NOTICE $nick :\002".$pazz[1]."\002 is not a valid command in module ".$pazz[0].".");
			}
			else {
				$fope = fopen("./conf/bind.conf","w+");
				fwrite($fope,$fcont);
				fclose($fope);
				sendserv("NOTICE $nick :New command \002$paz[0]\002 bound to the bot.");
			}
		}
		else {
			if ($pazz[0] == "bot_internal") {
				if (is_callable("bot_".$pazz[1],false,$callable_name)) {
						if (substr($params,strlen("$paz[0] $paz[1] ")) != "") {
					$mgs = substr($params,strlen("$paz[0] $paz[1] "))." ";
					}
					else {
						$mgs = "";
					}
					$fcont .= $paz[0]." ".$pazz[1]." ".$mgs;
					$fope = fopen("./conf/bind.conf","w+");
					fwrite($fope,$fcont);
					fclose($fope);
					sendserv("NOTICE $nick :New command \002$paz[0]\002 bound to the bot.");     
				}
				else {
					sendserv("NOTICE $nick :Command not found bot-internally.");
				}
				return(1);
			}
			sendserv("NOTICE $nick :There is no module with name \002$pazz[0]\002.");
		}
	}
	else {
		sendserv("NOTICE $nick :You lack sufficient staff access to use this command.");
	}
}