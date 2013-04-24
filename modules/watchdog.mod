/* watchdog.mod - NexusServV3
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
if (strtolower($cbase) == "watchdog") {
	global $userinfo; global $botnick; global $god; global $chans;
	$lbotnick = strtolower($botnick);
	$lnick = strtolower($nick);
	$acc = $userinfo["$lnick"]["auth"];
	$saxs = 0;
	$chansnoop = array();
	$chansnoton = array();
	$cpcount = 0;
	$fop = fopen("staff.conf","r+");
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
		$pp = explode(' ',$paramzz);
		if ($paramzz == "") {
			sendserv("NOTICE $nick :Subcommands of \002watchdog\002: add del list info set");
		}
		elseif ($pp[0] == 'set') {
			if ($pp[1] == "") {
				sendserv("NOTICE $nick :\002Watchdog Settings\002");
				sendserv("NOTICE $nick :\002DYNAMIC\002");
				sendserv("NOTICE $nick :REACTION            KICKBAN");
				sendserv("NOTICE $nick :RREASON             Watchdog: Illegal word/url found.");
				sendserv("NOTICE $nick :\002STATIC\002");
				sendserv("NOTICE $nick :SACCESS             800 (or higher)");
				sendserv("NOTICE $nick :LINKER              add del list info set");
				sendserv("NOTICE $nick :LISTFILE            watchdog.txt");
			}
			else {
				sendserv("NOTICE $nick :ERROR: Setting request/change for \002$pp[1]\002 failed.");
			}
		}
		elseif ($pp[0] == 'info') {
			sendserv("NOTICE $nick :NexusServ Watchdog Script v1.0-rv5");
		}
		elseif ($pp[0] == 'list') {
			sendserv("NOTICE $nick :\002Watchdog List\002");
			$fop = fopen('watchdog.txt','r+');
			while ($fr = fgets($fop)) {
				$fr = str_replace("\r","",$fr);
				$fr = str_replace("\n","",$fr);
				sendserv("NOTICE $nick :$fr");
			}
			fclose($fop);
			sendserv("NOTICE $nick :--- End of List ---");
		}
		elseif ($pp[0] == 'add') {
			$fop = fopen('watchdog.txt','r+');
			while ($fr = fgets($fop)) {
				$fr = str_replace("\r","",$fr);
				$fr = str_replace("\n","",$fr);
				$fg = explode(' ',$fr);
				if (fnmatch($pp[1],$fg[0])) {
					// ignore old match
				}
				else {
					$wac .= $fr."\n";
				}
				if (fnmatch($fg[0],$pp[1])) {
					sendserv("NOTICE $nick :There already is a match found for \002$pp[1]\002. (\002$fg[0]\002)");
					return(0);
				}
			}
			fclose($fop);

			$fop = fopen("watchdog.txt","w+");
			fwrite($fop,$wac.$pp[1]);
			fclose($fop);
			sendserv("NOTICE $nick :\002$pp[1]\002 was added to the Watchdog list.");
		}
		elseif ($pp[0] == "del") {

			$fop = fopen('watchdog.txt','r+');
			while ($fr = fgets($fop)) {
				$fr = str_replace("\r","",$fr);
				$fr = str_replace("\n","",$fr);
				$fg = explode(' ',$fr);
				if (fnmatch($pp[1],$fg[0])) {
					// ignore old match
				}
				else {
					$wac .= $fr."\n";
				}
			}
			fclose($fop);

			$fop = fopen("watchdog.txt","w+");
			fwrite($fop,$wac);
			fclose($fop);
			sendserv("NOTICE $nick :All matches for \002$pp[1]\002 were removed.");

		}
	}
	else {
		sendserv("NOTICE $nick :You lack sufficient staff access to use this command.");
	}
}