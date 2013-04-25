/* cmd/rehash.cmd - NexusServV3
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
$ccchan = $cchan;
if ($cchan[0] != "#") {
	$ccchan = "";
}
$command = $GLOBALS['msg'];
sendserv("NOTICE $debugchannel :($ccchan) [$nick:$acc] $command");
if ($saxs >= 950) {
	$xlines = 0;
	$mcnt = 0;
	$mtime = microtime(true);
	$buffer .= "NOTICE $nick :Rehashing commands...\n";
	global $modules;
	$modules = array();
	foreach (glob("./cmd/*.cmd") as $filename) {
		$mcnt++;
		$cnt = 0; $lcnt = 0;
		$fop = fopen($filename,"r+");
		while ($fg = fgets($fop)) {
			$modules["$filename"] .= $fg;
			if ($fg{0} == "/") {
				$cnt++;
			}
			$lcnt++;
		}
		fclose($fop);
		$xlines = $xlines + $lcnt;
	}
	$buffer .= "NOTICE $nick :Done, rehashed everything ($mcnt commands, $xlines lines of code) in ".(microtime(true) - $mtime)." seconds.\n";
	$GLOBALS['rid']++;
	sendserv($buffer);
} else {
	sendserv("NOTICE $nick :You lack sufficient staff access to use this command!");
}