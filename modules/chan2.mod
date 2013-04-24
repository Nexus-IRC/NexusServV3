/* chan2.mod - NexusServV3
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
// cbase: op
// cbase: voice
// cbase: opall
// cbase: vall
if (strtolower($cbase) == "op") {
	$fail = 0;
	$params = $paramzz;
	$tchan = strtolower($target);
	$lnick = strtolower($nick);
	$area = "";
	$axs = 0;
	$cfound = 0;
	global $userinfo; global $chans; global $botnick; global $god;
	$acc = $userinfo["$lnick"]["auth"];
	$fop = fopen("users.conf","r+");
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
				$cfound = 1;
			}
		}
	}
	fclose($fop);
	$area = "";
	$fop = fopen("settings.conf","r+");
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
	$cname = $chans["$tchan"]["name"];
	if ($cfound != 0) {
		if ($axs >= 200 || $god[$acc] == 1) {
			$ps = explode(" ",$params);
			$xyxx = 0;
			while ($ps[$xyxx] != "") {
				sendserv("MODE $target +o ".$ps[$xyxx]);
				global $userinfo;
				if ($userinfo[strtolower($ps[$xyxx])]['nick'] == "") {
					$fail = 1;
				}
				$xyxx++;
			}
			if ($fail == 1) {
				global $botnick;
				sendserv("NOTICE $nick :\002$botnick\002 couldn't process with some nicks you provided.");
			}
			sendserv("NOTICE $nick :User(s) have been opped in $cname.");
		}
		else {
			sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
		}
	}
	else {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
	}
}
elseif (strtolower($cbase) == "voice") {
	$fail = 0;
	$params = $paramzz;
	$tchan = strtolower($target);
	$lnick = strtolower($nick);
	$area = "";
	$axs = 0;
	$cfound = 0;
	global $userinfo; global $chans; global $botnick; global $god;
	$acc = $userinfo["$lnick"]["auth"];
	$fop = fopen("users.conf","r+");
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
				$cfound = 1;
			}
		}
	}
	fclose($fop);
	$area = "";
	$fop = fopen("settings.conf","r+");
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
	$cname = $chans["$tchan"]["name"];
	if ($cfound != 0) {
		if ($axs >= 200 || $god[$acc] == 1) {
			$ps = explode(" ",$params);
			$xyxx = 0;
			while ($ps[$xyxx] != "") {
				sendserv("MODE $target +v ".$ps[$xyxx]);
				global $userinfo;
				if ($userinfo[strtolower($ps[$xyxx])]['nick'] == "") {
					$fail = 1;
				}
				$xyxx++;
			}
			if ($fail == 1) {
				global $botnick;
				sendserv("NOTICE $nick :\002$botnick\002 couldn't process with some nicks you provided.");
			}
			sendserv("NOTICE $nick :User(s) have been voiced in $cname.");
		}
		else {
			sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
		}
	}
	else {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
	}
}elseif (strtolower($cbase) == "opall") {
	global $userinfo; global $chans; global $god; global $waitfor; global $botnick;
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
	if($pp[0] == "FORCE"){
		$fop = fopen("users.conf","r+");
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
		$fop = fopen("settings.conf","r+");
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
		$fop = fopen("accs.conf","r+");
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
		$xuc = 0;
		$modes = "";
		$modeps = "";
		foreach ($chans["$ctarg"]["users"] as $unick => $ustat) {
			$authnick = $userinfo["$unick"]["auth"];
			$axss = $axs["$authnick"];
			if ($axss == "") {
				$axss = 0;
			}
			if (str_replace("@","",$chans["$ctarg"]["users"]["$unick"]) == $chans["$ctarg"]["users"]["$unick"]) {
				$xuc++;
				$modes .= "+o";
				$modeps .= " $unick";
			}
		}
		sendserv("MODE $target $modes $modeps");
		$modes = "";
		$modeps = "";
		$xuc = 0;
		sendserv("NOTICE $nick :Users in $cname have been synchronized with the userlist.");
	} else {
		sendserv("NOTICE $nick :WARNING: Opping all users on a channel is very insecure! If you still want to op all users on $cname use: '\002opall FORCE\002'");
	}
}elseif (strtolower($cbase) == "vall") {
	global $userinfo; global $chans; global $god; global $waitfor; global $botnick;
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
	if($pp[0] == "FORCE"){
		$fop = fopen("users.conf","r+");
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
		$fop = fopen("settings.conf","r+");
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
		$fop = fopen("accs.conf","r+");
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
		$xuc = 0;
		$modes = "";
		$modeps = "";
		foreach ($chans["$ctarg"]["users"] as $unick => $ustat) {
			$authnick = $userinfo["$unick"]["auth"];
			$axss = $axs["$authnick"];
			if ($axss == "") {
				$axss = 0;
			}
			if (str_replace("+","",$chans["$ctarg"]["users"]["$unick"]) == $chans["$ctarg"]["users"]["$unick"]) {
				$xuc++;
				$modes .= "+v";
				$modeps .= " $unick";
			}
		}
		sendserv("MODE $target $modes $modeps");
		$modes = "";
		$modeps = "";
		$xuc = 0;
		sendserv("NOTICE $nick :Users in $cname have been synchronized with the userlist.");
	} else {
		sendserv("NOTICE $nick :WARNING: Voicing all users on a channel is very insecure! If you still want to voice all users on $cname use: '\002vall FORCE\002'");
	}
}