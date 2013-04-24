/* auth.mod - NexusServV3
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
// cbase: rename
// cbase: list
// cbase: trace
// cbase: set
if (strtolower($cbase) == "set") {
	global $command;
	global $userinfo;
	$lnick = strtolower($nick);
	$uauth = $userinfo[$lnick]['auth'];
	if ($uauth == "") {
		sendserv("NOTICE $nick :You are not authed with \002AuthServ\002.");
		return(0);
	}
	$paz = explode(" ",$paramzz);
	if ($paramzz == "") {
		$aset = getArrayFromFile("aset.conf");
		sendserv("NOTICE $nick :\002Account settings for $uauth:\002");
		sendserv("NOTICE $nick :\002PrivMsg         \002 ".binsetting($aset[strtolower($uauth)]['privmsg']));
		sendserv("NOTICE $nick :\002Language        \002 ".strsetting("English (en)"));
		sendserv("NOTICE $nick :\002Info            \002 ".strsetting($aset[strtolower($uauth)]['info']));
		sendserv("NOTICE $nick :---");
	}
	elseif (strtolower($paz[0]) == "privmsg") {
		if ($paz[1] == "") {
			$aset = getArrayFromFile("aset.conf");
			sendserv("NOTICE $nick :\002PrivMsg         \002 ".binsetting($aset[strtolower($uauth)]['privmsg']));
		}
		elseif ($paz[1] == "1" || strtolower($paz[1]) == "on") {
			$aset = getArrayFromFile("aset.conf");
			$aset[strtolower($uauth)]['privmsg'] = 1;
			sendArrayToFile("aset.conf",$aset);
			sendserv("NOTICE $nick :\002PrivMsg         \002 ".binsetting($aset[strtolower($uauth)]['privmsg']));
		}
		elseif ($paz[1] == "0" || strtolower($paz[1]) == "off") {
			$aset = getArrayFromFile("aset.conf");
			unset($aset[strtolower($uauth)]['privmsg']);
			sendArrayToFile("aset.conf",$aset);
			sendserv("NOTICE $nick :\002PrivMsg         \002 ".binsetting($aset[strtolower($uauth)]['privmsg']));
		}
		else {
			sendserv("NOTICE $nick :\002$paz[1]\002 is not a valid binary value.");
		}
	}
	elseif (strtolower($paz[0]) == "language") {
		sendserv("NOTICE $nick :You currently can't use the \002Language\002 account setting.");
	}
	elseif (strtolower($paz[0]) == "info") {
		if ($paz[1] == "") {
			sendserv("NOTICE $nick :\002Info            \002 ".strsetting($aset[strtolower($uauth)]['info']));
		}
		else {
			if (substr($paramzz,strlen($paz[0]." ")) == "*") {
				$aset = getArrayFromFile("aset.conf");
				unset($aset[strtolower($uauth)]['info']);
				sendArrayToFile("aset.conf",$aset);
				sendserv("NOTICE $nick :\002Info            \002 ".strsetting($aset[strtolower($uauth)]['info']));
			}
			else {
				$aset = getArrayFromFile("aset.conf");
				$aset[strtolower($uauth)]['info'] = substr($paramzz,strlen($paz[0]." "));
				sendArrayToFile("aset.conf",$aset);
				sendserv("NOTICE $nick :\002Info            \002 ".strsetting($aset[strtolower($uauth)]['info']));
			}
		}
	}
	else {
	sendserv("NOTICE $nick :ERROR: Unknown syntax or unknown setting.");
	}
}
elseif (strtolower($cbase) == "trace") {
	$params = $paramzz;
	$paz = explode(" ",$params);
	if (strtoupper($paz[0]) == "PRINT") {
		// nothing, continue.
	}
	elseif (strtoupper($paz[0]) == "COUNT") {
		// nothing, continue.
	}
	else {
		sendserv("NOTICE $nick :\002$paz[0]\002 is an invalid AuthTrace action.");
		return("ERROR: Invalid ATRACE");
	}
	global $userinfo; global $botnick; global $god;
	$lnick = strtolower($nick);
	$acc = $userinfo["$lnick"]["auth"];
	$saxs = 0;
	$fop = fopen("staff.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if (strtolower($frg[0]) == strtolower($acc)) {
			$saxs = $frg[1];
		}
	}
	fclose($fop);
	if ($saxs >= 200) {
		$cnt = 0;
		$fope = fopen("accs.conf","r+");
		while ($frae = fgets($fope)) {
			$frae = str_replace("\r","",$frae);
			$frae = str_replace("\n","",$frae);
			if (strtoupper($paz[0]) == "PRINT" && fnmatch(strtolower($paz[1]),strtolower($frae))) {
				sendserv("NOTICE $nick :$frae");
			}
			if (fnmatch(strtolower($paz[1]),strtolower($frae))) {
				$cnt++;
			}
		}
		sendserv("NOTICE $nick :\002$cnt\002");
		fclose($fope);
	}
}
elseif (strtolower($cbase) == "list") {
	$params = $paramzz;
	$paz = explode(" ",$params);
	global $userinfo; global $botnick; global $god;
	$lnick = strtolower($nick);
	$acc = $userinfo["$lnick"]["auth"];
	$saxs = 0;
	$fop = fopen("staff.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if (strtolower($frg[0]) == strtolower($acc)) {
			$saxs = $frg[1];
		}
	}
	fclose($fop);
	if ($saxs >= 200) {
		$cnt = 0;
		$fope = fopen("accs.conf","r+");
		sendserv("NOTICE $nick :\002Auth List\002");
		while ($frae = fgets($fope)) {
			$frae = str_replace("\r","",$frae);
			$frae = str_replace("\n","",$frae);
			sendserv("NOTICE $nick :$frae");
			$cnt++;
		}
		sendserv("NOTICE $nick :---");
		sendserv("NOTICE $nick :Found \002$cnt\002 auths");
		sendserv("NOTICE $nick :---");
		fclose($fope);
	}
}
elseif (strtolower($cbase) == "rename") {
	$params = $paramzz;
	$paz = explode(" ",$params);
	global $userinfo; global $botnick; global $god;
	$lnick = strtolower($nick);
	$acc = $userinfo["$lnick"]["auth"];
	$saxs = 0;
	$fop = fopen("staff.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if (strtolower($frg[0]) == strtolower($acc)) {
			$saxs = $frg[1];
		}
	}
	fclose($fop);
	if ($saxs >= 200) {
		$fcont = "";
		$found = "";
		$fope = fopen("accs.conf","r+");
		while ($frae = fgets($fope)) {
			$frae = str_replace("\r","",$frae);
			$frae = str_replace("\n","",$frae);
			if (strtolower($frae) == strtolower($paz[0])) {
				$fcont .= $paz[1]."\n";
				$found = $frae;
			}
			else {
				$fcont .= $frae."\n";
			}
		}
		fclose($fope);
		$ffcont = "";
		$fope = fopen("users.conf","r+");
		while ($frae = fgets($fope)) {
			$frae = str_replace("\r","",$frae);
			$frae = str_replace("\n","",$frae);
			$frge = explode(" ",$frae);
			if (strtolower($frge[0]) == strtolower($paz[0])) {
				$ffcont .= $paz[1]." ".substr($frae,strlen($frge[0]." "))."\n";
			}
			else {
				$ffcont .= $frae."\n";
			}
		}
		fclose($fope);
		$fffcont = "";
		$fope = fopen("staff.conf","r+");
		while ($frae = fgets($fope)) {
			$frae = str_replace("\r","",$frae);
			$frae = str_replace("\n","",$frae);
			$frge = explode(" ",$frae);
			if (strtolower($frge[0]) == strtolower($paz[0])) {
				$fffcont .= $paz[1]." ".substr($frae,strlen($frge[0]." "))."\n";
			}
			else {
				$fffcont .= $frae."\n";
			}
		}
		fclose($fope);
		if ($found != "") {
			sendserv("NOTICE $nick :The account $found has been renamed to $paz[1].");
			if($showdebug == true){
				sendserv("PRIVMSG $debugchannel :$nick renamed account $found to $paz[1].");
			}
			$fope = fopen("accs.conf","w+");
			fwrite($fope,$fcont);
			fclose($fope);
			$fope = fopen("users.conf","w+");
			fwrite($fope,$ffcont);
			fclose($fope);
			$fope = fopen("staff.conf","w+");
			fwrite($fope,$fffcont);
			fclose($fope);
		}
		else {
			sendserv("NOTICE $nick :The account \002$paz[0]\002 is unknown to me.");
		}
	}
}