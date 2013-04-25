/* cmd/delban.cmd - NexusServV3
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
$tchan = strtolower($target);
$lnick = strtolower($nick);
$area = "";
$axs = 0;
$cfound = 0;
$uaxs = array();
global $userinfo; global $chans; global $botnick; global $god;
$acc = $userinfo["$lnick"]["auth"];
$fop = fopen("./conf/users.conf","r+");
while ($fra = fgets($fop)) {
	$fra = str_replace("\r","",$fra);
	$fra = str_replace("\n","",$fra);
	$frg = explode(" ",$fra);
	if ($frg[0] == "-") {
		$area = $frg[1];
	}
	else {
		if ($area == $tchan) {
			if ($frg[0] == $userinfo["$lnick"]["auth"]) {
				$axs = $frg[1];
			}
			$uaxs["$frg[0]"] = $frg[1];
			$cfound = 1;
		}
	}
}
fclose($fop);
$area = "";
$fop = fopen("./conf/settings.conf","r+");
while ($fra = fgets($fop)) {
	$fra = str_replace("\r","",$fra);
	$fra = str_replace("\n","",$fra);
	$frg = explode(" ",$fra);
	if ($frg[0] == "-") {
		$area = $frg[1];
	}
	else {
		if ($area == $tchan) {
		$tsets["$frg[0]"] = substr($fra,strlen($frg[0]." "));
			}
	}
}
fclose($fop);
if ($cfound == 0) {
	sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
	return(0);
}
$cname = $chans["$tchan"]["name"];
if ($axs < 400 && $god["$acc"] != "1") {
	sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
	return(0);
}
$pp = explode(" ",$params);
$reason = breason(substr($params,strlen($pp[0]." ")));
$targ = $pp[0];
if (str_replace("@","",$targ) != $targ) {
	if (str_replace("!","",$targ) != $targ) {
		// Nothing
	}
	else {
		sendserv("NOTICE $nick :\002$targ\002 is not a valid ban host.");
		return(0);
	}
}
elseif ($targ[0] == "*") {
	$targ = "*!*@".substr($targ,1).".*";
}
else {
	$targ = $targ."!*@*";
}
$bcfound = 0;
$xx = 0;
$fcont = "";
$fop = fopen("./conf/bans.conf","r+");
$ccnt = 0;
$cmodes = "";
$cparms = "";
while ($fra = fgets($fop)) {
	$fra = str_replace("\r","",$fra);
	$fra = str_replace("\n","",$fra);
	$frg = explode(" ",$fra);
	if ($frg[0] == "-") {
	$area = $frg[1];
	$fcont .= "$fra\r\n";
	if ($area == $tchan) {
	$bcfound = 1;
	}
	}
	elseif ($fra == "") {
	}
	else {
		if ($area == $tchan) {
			if (fnmatch(bmask(strtolower($targ)),strtolower($frg[0]))) {
				$ccnt++;
				$cmodes .= "-b";
				$cparms .= " $frg[0]";
				if ($ccnt == 6) {
					sendserv("MODE $target $cmodes $cparms");
					$ccnt = 0;
					$cmodes = "";
					$cparms = "";
				}
			}
			else {
				$fcont .= "$fra\r\n";
			}
		}
		else {
			$fcont .= "$fra\r\n";
		}
	}
}
fclose($fop);
if ($bcfound == 0) {
	$fcont .= "- $tchan\r\n";
	$fcont .= "$targ $acc p $reason\r\n";
}
$fop = fopen("./conf/bans.conf","w+");
fwrite($fop,$fcont);
fclose($fop);
if ($cmodes != "") {
	sendserv("MODE $target $cmodes $cparms");
}
sendserv("NOTICE $nick :All bans matching \002$targ\002 have been removed.");