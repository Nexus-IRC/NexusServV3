/* cmd/status.cmd - NexusServV3
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
$amlc = 0;
$amcc = 0;
$params = $paramzz;
global $userinfo, $botnick, $god, $modules;
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
$command = $GLOBALS['msg'];
if ($saxs >= 950) {
	sendserv("NOTICE $nick :\002Loaded modules - status report:\002");
	foreach ($modules as $modname => $modcontent) {
		$mlc = 0;
		$modexp = explode("\n",$modules[$modname]);
		foreach ($modexp as $modexps) {
			$mlc++;
		}
		sendserv("NOTICE $nick :".str_replace("./cmd/","",$modname).", 1 command ($mlc lines)");
		$amcc = $amcc + 1;
		$amlc = $amlc + $mlc;
	}
	$mcode = file('nexusserv.php');
	$tcode = file('./inc/time_handler.php');
	$amlc = $amlc + count($mcode) + count($tcode);
	sendserv("NOTICE $nick :Main Code (Core) : ".round(filesize('nexusserv.php')/1024,0)."KBytes (".count($mcode)." Lines)");
	sendserv("NOTICE $nick :Time Handler Code: ".round(filesize('./inc/time_handler.php')/1024,0)."KBytes (".count($tcode)." Lines)");
	sendserv("NOTICE $nick :\002End of list.\002 $amcc Commands ($amlc Lines)");
	if($showdebug == true){
		sendserv("NOTICE $debugchannel :($ccchan) [$nick:$acc] $command $paramzz");
	}
} else {
	sendserv("NOTICE $nick :You lack sufficient staff access to use this command!");
}