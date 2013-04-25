/* modules/timecmd.mod - NexusServV3
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
 if (strtolower($cbase) == "timecmd") {
	$xx = time();
	$pp = explode(" ",$paramzz);
	if ($pp[0] == "") {
		$xy = 0;
		sendserv("NOTICE $nick :Missing parameters: <command> [parameters]");
		$fop = fopen("./conf/bind.conf","r+");
		while ($fra = fgets($fop)) {
			$fra = str_replace("\r","",$fra);
			$fra = str_replace("\n","",$fra);
			$fgr = explode(" ",$fra);
			if ($xy == 6) {
				sendserv("NOTICE $nick :Subcommands of ".$GLOBALS['command'].": $xi");
				$xi = '';
				$xy = 0;
			}
			$xi .= " ".$fgr[0];
			$xy++;
		}
		if ($xi != "") {
			sendserv("NOTICE $nick :Subcommands of ".$GLOBALS['command'].": $xi");
		}
		fclose($fop);
		return(0);
	}
	if ($pp[1][0] != "#") {
		cmd_parser($nick,$ident,$host,"$pp[0]",$cchan,$target,substr($paramzz,strlen("$pp[0] ")));
	}
	else {
		cmd_parser($nick,$ident,$host,"$pp[0]",$cchan,$pp[1],substr($paramzz,strlen("$pp[0] $pp[1] ")));
	}
	$yy = time() - $xx;
	sendserv("NOTICE $nick :Command executed in ".time2str($yy));
}