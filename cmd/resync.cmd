/* cmd/resync.cmd - NexusServV3
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
global $userinfo, $chans, $god, $waitfor, $botnick;
$lnick = strtolower($nick);
$acc = $userinfo["$lnick"]["auth"];
$pp = explode(" ",$params);
$pa = $pp[0];
$pn = strtolower($pa);
$pe = $pp[1];
$cfound = 0;
$ppe = $pp[1];
$accs = array();
$ctarg = strtolower($target);
$cname = $chans["$ctarg"]["name"];
$tsets = array();
$axs = array();
$fop = fopen("./conf/users.conf","r+t");
while ($fra = fgets($fop)) {
	$fra = str_replace("\r","",$fra);
	$fra = str_replace("\n","",$fra);
	$frg = explode(" ",$fra);
	if ($frg[0] == "-") {
		$area = $frg[1];
	}
	else {
		if ($area == $ctarg) {
			$axs["$frg[0]"] = $frg[1];
			$cfound = 1;
		}
	}
}
fclose($fop);
$fop = fopen("./conf/settings.conf","r+t");
while ($fra = fgets($fop)) {
	$fra = str_replace("\r","",$fra);
	$fra = str_replace("\n","",$fra);
	$frg = explode(" ",$fra);
	if ($frg[0] == "-") {
		$area = $frg[1];
	}
	else {
		if ($area == $ctarg) {
			$tsets["$frg[0]"] = substr($fra,strlen($frg[0]." "));
		}
	}
}
fclose($fop);
$fop = fopen("./conf/accs.conf","r+t");
while ($fra = fgets($fop)) {
	$fra = str_replace("\r","",$fra);
	$fra = str_replace("\n","",$fra);
	$frg = explode(" ",$fra);
	$frgl = strtolower($frg[0]);
	$accs["$frgl"] = $frg[0];
}
fclose($fop);
if ($cfound == 0) {
	sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
}
if ($acc == "") {
	sendserv("NOTICE $nick :$nick is not authed with \002AuthServ\002.");
	return(0);
}
if ($axs["$acc"] < 200 && $god["$acc"] != "1") {
	sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
	return(0);
}
if ($tsets["giveops"] == "") {
	$tsets["giveops"] = "200";
}
if ($tsets["givevoice"] == "") {
	$tsets["givevoice"] = "100";
}
$xuc = 0;
$modes = "";
$modeps = "";
foreach ($chans["$ctarg"]["users"] as $unick => $ustat) {
	$authnick = $userinfo["$unick"]["auth"];
	$axss = $axs["$authnick"];
	if ($axss == "") {
		$axss = 0;
	}
	if ($axss >= $tsets["giveops"]) {
		if (str_replace("@","",$chans["$ctarg"]["users"]["$unick"]) == $chans["$ctarg"]["users"]["$unick"]) {
			$xuc++;
			$modes .= "+o";
			$modeps .= " $unick";
		}
	}
	elseif ($axss >= $tsets["givevoice"]) {
		if (str_replace("+","",$chans["$ctarg"]["users"]["$unick"]) == $chans["$ctarg"]["users"]["$unick"]) {
			$xuc++;
			$modes .= "+v";
			$modeps .= " $unick";
		}
	}
	if ($xuc == 6) {
		sendserv("MODE $target $modes $modeps");
		$modes = "";
		$modeps = "";
		$xuc = 0;
	}
	if ($axss < $tsets["giveops"]) {
		if (str_replace("@","",$chans["$ctarg"]["users"]["$unick"]) != $chans["$ctarg"]["users"]["$unick"]) {
			if ($unick != strtolower($botnick)) {
				$xuc++;
				$modes .= "-o";
				$modeps .= " $unick";
			}
		}
	}
	if ($xuc == 6) {
		sendserv("MODE $target $modes $modeps");
		$modes = "";
		$modeps = "";
		$xuc = 0;
	}
	if ($axss < $tsets["givevoice"]) {
		if (str_replace("+","",$chans["$ctarg"]["users"]["$unick"]) != $chans["$ctarg"]["users"]["$unick"]) {
			$xuc++;
			$modes .= "-v";
			$modeps .= " $unick";
		}
	}
	if ($xuc == 6) {
		sendserv("MODE $target $modes $modeps");
		$modes = "";
		$modeps = "";
		$xuc = 0;
	}
}
sendserv("MODE $target $modes $modeps");
$modes = "";
$modeps = "";
$xuc = 0;
sendserv ("NOTICE $nick :Users in $cname have been synchronised with the userlist.");