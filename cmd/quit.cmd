/* cmd/quit.cmd - NexusServV3
 * Copyright (C) 2014  #Nexus project
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
global $userinfo, $botnick, $god, $showdebug, $debugchannel;
$lnick = strtolower($nick);
$acc = $userinfo["$lnick"]["auth"];
$saxs = 0;
$fop = fopen("./conf/staff.conf","r+t");
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
$command = $GLOBALS['command'];
if ($saxs >= 1000) {
	if ($god["$acc"] != 1) {
		sendserv("NOTICE $nick :You must enable security override (helping mode) to use this command.");
	}
	else {
		if ((empty($paramzz)) || ($paramzz == " ")) {
			if ($showdebug == true){
				sendserv("PRIVMSG $debugchannel :($ccchan) [$nick:$acc] $command");
				quit_bot("Terminated",true);
			}
			else {
				quit_bot("Terminated",true);
			}
		}
		else {
			if ($showdebug == true){
				sendserv("PRIVMSG $debugchannel :($ccchan) [$nick:$acc] $command $paramzz");
				sleep(2);
				quit_bot(trim($params," "),true);
			}
			else {
				quit_bot(trim($params," "),true);
			}
		}
	}
}
else {
	sendserv("NOTICE $nick :You lack sufficient staff access to use this command.");
}