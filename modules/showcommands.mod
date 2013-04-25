/* modules/showcommands.mod - NexusServV3
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
if (strtolower($cbase) == "showcommands") {
	global $botnick;
	$cc = 0;
	$lsize = 0;
	sendserv("NOTICE $nick :\002$botnick\002 commands:");
	$fop = fopen("./conf/bind.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$fgr = explode(" ",$fra);
		if (strlen($fgr[0]) > $lsize) {
			$lsize = strlen($fgr[0]);
		}
		$cc++;
	}
	fclose($fop);
	$fad = 0;
	$fstr = "";
	$fop = fopen("./conf/bind.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$fgr = explode(" ",$fra);
		if ($fad < 4) {
			if ($fgr[1] != "mod_mod") {
				$fgr[0] == "\0034".$fgr[0]."\003";
			}
			$fstr .= "$fgr[0]".spaces("$fgr[0]",$lsize)." ";
		}
		else {
			sendserv("NOTICE $nick :$fstr");
			$fstr = "";
			$fad = 0;
			if ($fgr[1] != "mod_mod") {
				$fgr[0] == "\0034".$fgr[0]."\003";
			}
			$fstr .= "$fgr[0]".spaces("$fgr[0]",$lsize)." ";
		}
		$fad++;
	}
	fclose($fop);
	if ($fstr != "") {
		sendserv("NOTICE $nick :$fstr");
	}
	sendserv("NOTICE $nick :-- $cc commands found. --");
}