/* cmd/command.cmd - NexusServV3
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
$found = 0;
$bip = explode(" ",$paramzz);
if ($bip[0] != "") {
	$fop = fopen("./conf/bind.conf","r+t");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$fgr = explode(" ",$fra);
		if (strtolower($fgr[0]) == strtolower($bip[0])) {
			if (strtolower($fgr[1]) == "mod_mod") {
				$comothis = $fgr[2].".".$fgr[3];
				$cmdthis = $fgr[2]." ".substr($fra,strlen($fgr[0]." ".$fgr[1]." ".$fgr[2]." "));
				sendserv("NOTICE $nick :\002$bip[0]\002 is a binding for: $cmdthis");
				sendserv("NOTICE $nick :End of requirements for $bip[0].");
			}
			else {
				sendserv("NOTICE $nick :\002$bip[0]\002 is a unknown binding");
				sendserv("NOTICE $nick :End of requirements for $bip[0].");
			}
			$found = 1;
		}
	}
	fclose($fop);
	if ($found == 0) {
		sendserv("NOTICE $nick :\002$bip[0]\002 is an unknown command");
	}
} else {
	sendserv("NOTICE $nick :\002command\002 requires more parameters.");
}