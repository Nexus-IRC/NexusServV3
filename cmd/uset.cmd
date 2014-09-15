/* cmd/uset.cmd - NexusServV3
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
$autoinvite = "0";
$nomodes = "0";
$info = "";
global $userinfo, $chans, $botnick, $god;
$acc = $userinfo["$lnick"]["auth"];
$fop = fopen("./conf/users.conf","r+t");
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
				$autoinvite = $frg[2];
				$nomodes = $frg[3];
				$infos = unserialize(substr($fra,strlen("$frg[0] $frg[1] $frg[2] $frg[3] ")));
			}
			$cfound = 1;
		}
	}
}
fclose($fop);
$area = "";
$fop = fopen("./conf/settings.conf","r+t");
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
if ($cfound == 0) {
	sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
	return(0);
}
$cname = $chans["$tchan"]["name"];
if ($tsets['uset'] == '') {
	$tsets['uset'] = '0';
}
if ($tsets['giveops'] == '') {
	$tsets['giveops'] = '200';
}
if ($tsets['givevoice'] == '') {
	$tsets['givevoice'] = '100';
}
if ($axs == 0 || $axs < $tsets['uset']) {
	sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
	return(0);  
}
$pp = explode(" ",$params);
$pa = strtolower($pp[0]);
$pb = strtolower($pp[1]);
$pc = substr($params,strlen("$pa "));
if ($pa == "") {
	sendserv("NOTICE $nick :$cname user settings for \002$acc\002:");
	if ($axs > $tsets['giveops']) {
		sendserv("NOTICE $nick :\002NoAutoOp             \002 ".binsetting($nomodes));
	}
	elseif ($axs > $tsets['givevoice']) {
		sendserv("NOTICE $nick :\002NoAutoVoice          \002 ".binsetting($nomodes));
	}
	sendserv("NOTICE $nick :\002AutoInvite           \002 ".binsetting($autoinvite));
	sendserv("NOTICE $nick :\002Info                 \002 ".strsetting($infos['info']));
	sendserv("NOTICE $nick :\002PartInfo             \002 ".strsetting($infos['pinfo']));
	sendserv("NOTICE $nick :\002QuitInfo             \002 ".strsetting($infos['qinfo']));
	sendserv("NOTICE $nick :\002NoInvite             \002 ".binsetting($infos['noinvite']));
}
elseif ($pa == "noautovoice" && $pb == "" && $axs > $tsets['givevoice'] && $axs < $tsets['giveops']) {
	sendserv("NOTICE $nick :\002NoAutoVoice          \002 ".binsetting($nomodes));
}
elseif ($pa == "noautoop" && $pb == "" && $axs > $tsets['giveops']) {
	sendserv("NOTICE $nick :\002NoAutoOp             \002 ".binsetting($nomodes));
}
elseif ($pa == "autoinvite" && $pb == "") {
	sendserv("NOTICE $nick :\002AutoInvite           \002 ".binsetting($autoinvite));
}
elseif ($pa == "noinvite" && $pb == "") {
	sendserv("NOTICE $nick :\002NoInvite             \002 ".binsetting($infos['noinvite']));
}
elseif ($pa == "info" && $pc == "") {
	sendserv("NOTICE $nick :\002Info                 \002 ".strsetting($infos['info']));
}
elseif ($pa == "partinfo" && $pc == "") {
	sendserv("NOTICE $nick :\002PartInfo             \002 ".strsetting($infos['pinfo']));
}
elseif ($pa == "quitinfo" && $pc == "") {
	sendserv("NOTICE $nick :\002QuitInfo             \002 ".strsetting($infos['qinfo']));
}
elseif ($pa == "noautoop" && $pb != "" && $axs > $tsets['giveops']) {
	if ($pb == "on" or $pb == "1") {
		$setchange = "1";
	}
	elseif ($pb = "off" or $pb == "0") {
		$setchange = "0";
	}
	else {
		sendserv("NOTICE $nick :\002$pb\002 is not a valid binary value.");
	}
	$fcont = "";
	$fop = fopen("./conf/users.conf","r+t");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
			$area = $frg[1];
			$fcont .= $fra."\r\n";
		}
		else {
			if ($area == $tchan) {
				if ($frg[0] == $userinfo["$lnick"]["auth"]) {
					$axs = $frg[1];
					$autoinvite = $frg[2];
					$nomodes = $frg[3];
					$info = substr($fra,strlen("$frg[0] $frg[1] $frg[2] $frg[3] "));
					$nomodes = $setchange;
					$fcont .= "$acc $axs $autoinvite $nomodes $info\r\n";
				}
				else {
					$fcont .= $fra."\r\n";
				}
			$cfound = 1;
			}
			else {
				$fcont .= $fra."\r\n";
			}
		}
	}
	fclose($fop);
	$fop = fopen("./conf/users.conf","w+t");
	fwrite($fop,$fcont);
	fclose($fop);
	sendserv("NOTICE $nick :\002NoAutoOp             \002 ".binsetting($nomodes));
}
elseif ($pa == "noautovoice" && $pb != "" && $axs > $tsets['givevoice'] && $axs < $tsets['giveops']) {
	if ($pb == "on" or $pb == "1") {
	$setchange = "1";
	}
	elseif ($pb = "off" or $pb == "0") {
	$setchange = "0";
	}
	else {
	sendserv("NOTICE $nick :\002$pb\002 is not a valid binary value.");
	}
	$fcont = "";
	$fop = fopen("./conf/users.conf","r+t");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
			$area = $frg[1];
			$fcont .= $fra."\r\n";
		}
		else {
			if ($area == $tchan) {
				if ($frg[0] == $userinfo["$lnick"]["auth"]) {
					$axs = $frg[1];
					$autoinvite = $frg[2];
					$nomodes = $frg[3];
					$info = substr($fra,strlen("$frg[0] $frg[1] $frg[2] $frg[3] "));
					$nomodes = $setchange;
					$fcont .= "$acc $axs $autoinvite $nomodes $info\r\n";
				}
				else {
					$fcont .= $fra."\r\n";
				}
				$cfound = 1;
			}
			else {
				$fcont .= $fra."\r\n";
			}
		}
	}
	fclose($fop);
	$fop = fopen("./conf/users.conf","w+t");
	fwrite($fop,$fcont);
	fclose($fop);
	sendserv("NOTICE $nick :\002NoAutoVoice          \002 ".binsetting($nomodes));
}
elseif ($pa == "autoinvite" && $pb != "") {
	if ($pb == "on" or $pb == "1") {
		$setchange = "1";
	}
	elseif ($pb = "off" or $pb == "0") {
		$setchange = "0";
	}
	else {
		sendserv("NOTICE $nick :\002$pb\002 is not a valid binary value.");
	}
	$fcont = "";
	$fop = fopen("./conf/users.conf","r+t");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
			$area = $frg[1];
			$fcont .= $fra."\r\n";
		}
		else {
			if ($area == $tchan) {
				if ($frg[0] == $userinfo["$lnick"]["auth"]) {
					$axs = $frg[1];
					$autoinvite = $frg[2];
					$nomodes = $frg[3];
					$info = substr($fra,strlen("$frg[0] $frg[1] $frg[2] $frg[3] "));
					$autoinvite = $setchange;
					$fcont .= "$acc $axs $autoinvite $nomodes $info\r\n";
				}
				else {
					$fcont .= $fra."\r\n";
				}
				$cfound = 1;
			}
			else {
				$fcont .= $fra."\r\n";
			}
		}
	}
	fclose($fop);
	$fop = fopen("./conf/users.conf","w+t");
	fwrite($fop,$fcont);
	fclose($fop);
	sendserv("NOTICE $nick :\002AutoInvite           \002 ".binsetting($autoinvite));
}
elseif ($pa == "info" && $pc != "") {
	if ($pc == "*") {
	$pc = "";
	}
	$setchange = $pc;
	$fcont = "";
	$fop = fopen("./conf/users.conf","r+t");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
			$area = $frg[1];
			$fcont .= $fra."\r\n";
		}
		else {
			if ($area == $tchan) {
				if ($frg[0] == $userinfo["$lnick"]["auth"]) {
					$axs = $frg[1];
					$autoinvite = $frg[2];
					$nomodes = $frg[3];
					$infos = unserialize(substr($fra,strlen("$frg[0] $frg[1] $frg[2] $frg[3] ")));
					$infos['info'] = $setchange;
					$fcont .= "$acc $axs $autoinvite $nomodes ".serialize($infos)."\r\n";
				}
				else {
					$fcont .= $fra."\r\n";
				}
				$cfound = 1;
			}
			else {
				$fcont .= $fra."\r\n";
			}
		}
	}
	fclose($fop);
	$fop = fopen("./conf/users.conf","w+t");
	fwrite($fop,$fcont);
	fclose($fop);
	sendserv("NOTICE $nick :\002Info                 \002 ".strsetting($infos['info']));
}
elseif ($pa == "partinfo" && $pc != "") {
	if ($pc == "*") {
		$pc = "";
	}
	$setchange = $pc;
	$fcont = "";
	$fop = fopen("./conf/users.conf","r+t");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
			$area = $frg[1];
			$fcont .= $fra."\r\n";
		}
		else {
			if ($area == $tchan) {
				if ($frg[0] == $userinfo["$lnick"]["auth"]) {
					$axs = $frg[1];
					$autoinvite = $frg[2];
					$nomodes = $frg[3];
					$infos = unserialize(substr($fra,strlen("$frg[0] $frg[1] $frg[2] $frg[3] ")));
					$infos['pinfo'] = $setchange;
					$fcont .= "$acc $axs $autoinvite $nomodes ".serialize($infos)."\r\n";
				}
				else {
					$fcont .= $fra."\r\n";
				}
				$cfound = 1;
			}
			else {
				$fcont .= $fra."\r\n";
			}
		}
	}
	fclose($fop);
	$fop = fopen("./conf/users.conf","w+t");
	fwrite($fop,$fcont);
	fclose($fop);
	sendserv("NOTICE $nick :\002PartInfo             \002 ".strsetting($infos['pinfo']));
}
elseif ($pa == "quitinfo" && $pc != "") {
	if ($pc == "*") {
		$pc = "";
	}
	$setchange = $pc;
	$fcont = "";
	$fop = fopen("./conf/users.conf","r+t");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
			$area = $frg[1];
			$fcont .= $fra."\r\n";
		}
		else {
			if ($area == $tchan) {
				if ($frg[0] == $userinfo["$lnick"]["auth"]) {
					$axs = $frg[1];
					$autoinvite = $frg[2];
					$nomodes = $frg[3];
					$infos = unserialize(substr($fra,strlen("$frg[0] $frg[1] $frg[2] $frg[3] ")));
					$infos['qinfo'] = $setchange;
					$fcont .= "$acc $axs $autoinvite $nomodes ".serialize($infos)."\r\n";
				}
				else {
					$fcont .= $fra."\r\n";
				}
				$cfound = 1;
			}
			else {
				$fcont .= $fra."\r\n";
			}
		}
	}
	fclose($fop);
	$fop = fopen("./conf/users.conf","w+t");
	fwrite($fop,$fcont);
	fclose($fop);
	sendserv("NOTICE $nick :\002QuitInfo             \002 ".strsetting($infos['qinfo']));
}
else {
sendserv("NOTICE $nick :\002$pa\002 is an invalid user setting");
}