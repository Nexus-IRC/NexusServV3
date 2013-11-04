/* cmd/update.cmd - NexusServV3
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
global $userinfo, $botnick, $god;
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
$ccchan = $cchan;
if ($cchan[0] != "#") {
	$ccchan = "";
}
$command = $GLOBALS['msg'];
if ($saxs >= 950) {
	if(is_dir(".git")){
		sendserv("NOTICE $nick :Update bot\n");
		$cmd = shell_exec("git pull");
		$pos = strpos($cmd, "nicht gefunden");
		$pos2 = strpos($cmd, "not found");
		if ($pos === false || $pos2 === false) {
			sendserv("NOTICE $nick :bot updated pls restart");
		} else {
			sendserv("NOTICE $nick :GIT not found on your server");
		}
	} else {
		sendserv("NOTICE $nick :you dont have clone NexusServ with git\n");
	}
	if($showdebug == true){
		sendserv("NOTICE $debugchannel :($ccchan) [$nick:$acc] $command $paramzz");
	}
} else {
	sendserv("NOTICE $nick :You lack sufficient staff access to use this command!");
}