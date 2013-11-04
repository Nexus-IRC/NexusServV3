/* cmd/debug.cmd - NexusServV3
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
// Pre-defined variable functions
$pr = "print_r";
$par = "print_array";
$af = "getArrayFromFile";
$saf = "sendArrayToFile";
// ----
// Pre-defined global bot variables
$ch = $GLOBALS['chans'];
$ui = $GLOBALS['userinfo'];
// ---
$notc=false;
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
$command = $GLOBALS['command'];
if ($saxs >= 1000) {
	if ($paramzz == "") {
		sendserv("NOTICE $nick :More parameters required:");
		sendserv("NOTICE $nick :Syntax: /msg $botnick ".$GLOBALS['command']." <debug commands>");
		sendserv("NOTICE $nick :Missing parameter(s): debug commands");
		return(0);
	}
	$public = false;
	$la = explode(" ",$params);
	$xy = microtime(true);
	ob_start();
	$dump = eval($params)."\n";
	$dump .= ob_get_contents();
	if ($dump != "") {
		$domp = explode("\n",$dump);
		foreach ($domp as $pomp) {
			if ($pomp != "") {
				if ($public == false) {
					sendserv("NOTICE $nick :$pomp");
				}
				else {
					sendserv("PRIVMSG $target :$pomp");
				}
			}
		}
	}
	ob_end_clean();
	if ($notc != false) {
		sendserv("NOTICE $nick :Successfully executed the command in ".(microtime(true) - $xy)."s:");
		sendserv("NOTICE $nick :$params");
	}
	if($showdebug == true){
		sendserv("NOTICE $debugchannel :($ccchan) [$nick:$acc] $command $paramzz");
	}
}
else {
	sendserv("NOTICE $nick :You lack sufficient staff access to use this command.");
}