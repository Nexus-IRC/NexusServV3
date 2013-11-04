/* cmd/timeban.cmd - NexusServV3
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
global $userinfo, $chans, $botnick, $god, $botnick;
$lbotnick = strtolower($botnick);
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
$reason = breason(substr($params,strlen($pp[0]." ".$pp[1]." ")));
$targ = $pp[0];
if ($pp[1] == "p") {
	sendserv("NOTICE $nick :To ban someone permanently, please use \002addban\002.");
	return(0);
}
$btime = str2time($pp[1]);
if ($btime != "I") {
	$btime = time() + $btime;
}
else {
	sendserv("NOTICE $nick :\002$pp[1]\002 is an invalid time span.");
	return(0);
}
if (str_replace("@","",$targ) != $targ) {
	if (str_replace("!","",$targ) != $targ) {
		foreach($chans["$tchan"]["users"] as $unick => $ustat) {
			$userhost = $userinfo["$unick"]["nick"]."!".$userinfo["$unick"]["ident"]."@".$userinfo["$unick"]["host"];
			$uauth = $userinfo["$unick"]["auth"];
			if (fnmatch(bmask(strtolower($targ)),strtolower($userhost))) {
				if ($uaxs["$uauth"] < $axs or $uaxs["$uauth"] == "") {
					if ($unick != strtolower($botnick)) {
						sendserv("MODE $target -o $unick");
						sendserv("KICK $target $unick :($nick) $reason");
					}
				}
				else {
					if ($axs >= 500 or $acc = $userinfo["$lbotnick"]["auth"]) {
						if ($unick != strtolower($botnick)) {
							sendserv("MODE $target -o $unick");
							sendserv("KICK $target $unick :($nick) $reason");
						}
					}
					else {
						sendserv("NOTICE $nick :Ban cannot be set: User ".$userinfo["$unick"]["nick"]." ($uauth) ranks you off.");
						return(0);
					}
				}
			}
		}
	}
	else {
		sendserv("NOTICE $nick :\002$targ\002 is not a valid ban host.");
		return(0);
	}
}
elseif ($targ[0] == "*") {
	$targ = "*!*@".substr($targ,1).".*";
	if (str_replace("@","",$targ) != $targ) {
		if (str_replace("!","",$targ) != $targ) {
			foreach($chans["$tchan"]["users"] as $unick => $ustat) {
				$userhost = $userinfo["$unick"]["nick"]."!".$userinfo["$unick"]["ident"]."@".$userinfo["$unick"]["host"];
				$uauth = $userinfo["$unick"]["auth"];
				if (fnmatch(bmask(strtolower($targ)),strtolower($userhost))) {
					if ($uaxs["$uauth"] < $axs or $uaxs["$uauth"] == "") {
						if ($unick != strtolower($botnick)) {
							sendserv("MODE $target -o $unick");
							sendserv("KICK $target $unick :($nick) $reason");
						}
					}
					else {
						if ($axs >= 500 or $acc = $userinfo["$lbotnick"]["auth"]) {
							if ($unick != strtolower($botnick)) {
								sendserv("MODE $target -o $unick");
								sendserv("KICK $target $unick :($nick) $reason");
							}
						}
						else {
							sendserv("NOTICE $nick :Ban cannot be set: User ".$userinfo["$unick"]["nick"]." ($uauth) ranks you off.");
							return(0);
						}
					}
				}
			}
		}
		else {
			sendserv("NOTICE $nick :\002$targ\002 is not a valid ban host.");
			return(0);
		}
	}
}
else {
	$targ = $targ."!*@*";
	if (str_replace("@","",$targ) != $targ) {
		if (str_replace("!","",$targ) != $targ) {
			foreach($chans["$tchan"]["users"] as $unick => $ustat) {
				$userhost = $userinfo["$unick"]["nick"]."!".$userinfo["$unick"]["ident"]."@".$userinfo["$unick"]["host"];
				$uauth = $userinfo["$unick"]["auth"];
				if (fnmatch(bmask(strtolower($targ)),strtolower($userhost))) {
					if ($uaxs["$uauth"] < $axs or $uaxs["$uauth"] == "") {
						if ($unick != strtolower($botnick)) {
							sendserv("MODE $target -o $unick");
							sendserv("KICK $target $unick :($nick) $reason");
						}
					}
					else {
						if ($axs >= 500 or $acc = $userinfo["$lbotnick"]["auth"]) {
							if ($unick != strtolower($botnick)) {
								sendserv("MODE $target -o $unick");
								sendserv("KICK $target $unick :($nick) $reason");
							}
						}
						else {
							sendserv("NOTICE $nick :Ban cannot be set: User ".$userinfo["$unick"]["nick"]." ($uauth) ranks you off.");
							return(0);
						}
					}
				}
			}
		}
		else {
			sendserv("NOTICE $nick :\002$targ\002 is not a valid ban host.");
			return(0);
		}
	}
}
$modifyban = 0;
$bcfound = 0;
$xx = 0;
$fcont = "";
$fop = fopen("./conf/bans.conf","r+");
while ($fra = fgets($fop)) {
	$fra = str_replace("\r","",$fra);
	$fra = str_replace("\n","",$fra);
	$frg = explode(" ",$fra);
	if ($frg[0] == "-") {
		$area = $frg[1];
		$fcont .= "$fra\r\n";
		if ($area == $tchan) {
			$bcfound = 1;
			$fcont .= "$targ $acc $btime $reason\r\n";
		}
	}
	elseif ($fra == "") {
	}
	else {
		if ($area == $tchan) {
			if (fnmatch(bmask(strtolower($targ)),strtolower($frg[0]))) {
				$modifyban++;
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
	$fcont .= "$targ $acc $btime $reason\r\n";
}
$fop = fopen("./conf/bans.conf","w+");
fwrite($fop,$fcont);
fclose($fop);
sendserv("MODE $target +b $targ");
if ($modifyban != 0) {
	sendserv("NOTICE $nick :\002$modifyban\002 bans have been changed.");
}
sendserv("NOTICE $nick :\002$targ\002 has been banned from $cname for ".time2str($btime - time()).".");