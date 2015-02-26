/* cmd/deluser.cmd - NexusServV3
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
$tchan = $ctarg;
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
fclose($fop);
if ($tsets['changeusers'] == "") {
	$tsets['changeusers'] = "300";
}
if ($tsets['adduser'] == "") {
	$tsets['adduser'] = $tsets['changeusers'];
}
if ($tsets['deluser'] == "") {
	$tsets['deluser'] = $tsets['changeusers'];
}
if ($tsets['clvl'] == "") {
	$tsets['clvl'] = $tsets['changeusers'];
}	
$cname = $chans["$ctarg"]["name"];
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
if ($axs["$acc"] < $tsets['deluser'] && $god["$acc"] != "1") {
	sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
	return(0);
}
if (trim($params) == "") {
	sendserv("NOTICE $nick :More parameters required: <*account|nick>");
	return(0);
}
elseif ($params[0] == "*") {
	$pa = substr($pa,1);
	$pal = strtolower($pa);
	if ($accs["$pal"] == "") {
		sendserv("NOTICE $nick :This account (\002$pa\002) is unknown to me.");
		return(0);
	}
	else {
		$tacc = $accs["$pal"];
	}
	if ($axs["$tacc"] == "") {
		sendserv("NOTICE $nick :$tacc is not on the userlist for $cname.");
		return(0);
	}
	if ($acc == $tacc && $god["$acc"] != "1") {
		sendserv("NOTICE $nick :You can't delete yourself with \002deluser\002.");
		return(0);
	}
	if ($axs["$tacc"] >= $axs["$acc"] && $god["$acc"] != "1") {
		sendserv("NOTICE $nick :Command has no effect (User $tacc outranks you.)");
		return(0);
	}
	$area = "";
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
		elseif ($frg[0] == "") {
		}
		else {
			if ($area == $ctarg && $frg[0] == $tacc) {
				// Ignore him.
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
	sendserv("NOTICE $nick :$tacc has been removed from the $cname userlist (access ".$axs["$tacc"].")");
}
else {
	if ($userinfo["$pn"]["nick"] == "") {
		if ($userinfo["$pn"]["unknown"] != "1") {
			$wfc = count($waitfor["$pn"]) + 1;
			$waitfor["$pn"][$wfc] = "CMD deluser $nick $user $host $cchan $target $params";
			sendserv("WHOIS $pn");
			return(0);
		}
		else {
			sendserv("NOTICE $nick :User \002$pn\002 doesn't exist.");
			return(0);
		}
	}
	$pnnick = $userinfo["$pn"]["nick"];
	if ($userinfo["$pn"]["auth"] == "") {
		sendserv("NOTICE $nick :$pnnick is not authed with \002AuthServ\002.");
		return(0);
	}
	$pa = $userinfo["$pn"]["auth"];
	$pal = strtolower($pa);
	if ($accs["$pal"] == "") {
		$fop = fopen("./conf/accs.conf","a+");
		fwrite($fop,"\r\n$pa");
		fclose($fop);
		$tacc = $pa;
	}
	else {
		$tacc = $accs["$pal"];
	}
	if ($axs["$tacc"] == "") {
		sendserv("NOTICE $nick :$pnnick ($tacc) is not on the userlist for $cname.");
		return(0);
	}
	if ($acc == $tacc && $god["$acc"] != "1") {
		sendserv("NOTICE $nick :You can't delete yourself with \002deluser\002.");
		return(0);
	}
	if ($axs["$tacc"] >= $axs["$acc"] && $god["$acc"] != "1") {
		sendserv("NOTICE $nick :Command has no effect (User $pnnick ($tacc) outranks you.)");
		return(0);
	}
	$area = "";
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
		elseif ($frg[0] == "") {
		}
		else {
			if ($area == $ctarg && $frg[0] == $tacc) {
				// Ignore him.
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
	sendserv("NOTICE $nick :$pnnick ($tacc) has been removed from the $cname userlist (access ".$axs["$tacc"].")");
}