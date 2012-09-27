/* chan5.mod - NexusServV3
 * Copyright (C) 2012  #Nexus project
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
// cbase: takelist
// cbase: readchan
// cbase: users
// cbase: topic
// cbase: atopic
// cbase: etopics
if (strtolower($cbase) == "readchan") {
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
	if ($cfound == 0) {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
	}
	else {
		if ($axs < "500" && $god[$acc] != "1") {
			sendserv("NOTICE $nick :You lack sufficient access to ".$chans["$tchan"]["name"]." to use this command.");
			return(0);
		}
	}

	$uc = 0;
	$ufound = "";
	global $botnick;
	global $chans;
	foreach ($chans[strtolower($target)]['users'] as $uname => $uaccs) {
		if ($userinfo[$uname]['auth'] != "") {
			if (str_replace("@","",$uaccs) != $uaccs) {
				if (addChanUser(strtolower($target),$userinfo[$uname]['auth'],200) == "Ok") {
					$ua = $userinfo[$uname]['auth'];
					$uc++;
					sendserv("NOTICE $nick :Added \002$uname\002 ($ua) with access \002200\002");
				}
			}
			if (str_replace("+","",$uaccs) != $uaccs) {
				if (addChanUser(strtolower($target),$userinfo[$uname]['auth'],100) == "Ok") {
					$ua = $userinfo[$uname]['auth'];
					$uc++;
					sendserv("NOTICE $nick :Added \002$uname\002 ($ua) with access \002100\002");
				}
			}
		}
	}
	sendserv("NOTICE $nick :\002$uc\002 users were added.");
}
if (strtolower($cbase) == "takelist") {
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
	if ($cfound == 0) {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
	}
	else {
		if ($axs < "500" && $god[$acc] != "1") {
			sendserv("NOTICE $nick :You lack sufficient access to ".$chans["$tchan"]["name"]." to use this command.");
			return(0);
		}
	}


	$ufound = "";
	global $botnick;
	if ($paramzz == "") {
		$paramzz = "chanserv";
	}
	$paz = explode(" ",$paramzz);
	foreach ($GLOBALS['chans'][strtolower($target)]['users'] as $unick => $u) {
		if ($unick == strtolower($paz[0])) {
			$ufound = $GLOBALS['userinfo'][$unick]['nick'];
		}
	}
	if ($ufound == "") {
		sendserv("NOTICE $nick :\002$paz[0]\002 was not found on \002$target\002.");
		return(0);
	}
	if ($paz[1] != "!".substr(md5($ufound),0,8)."!" && $god[$acc] != "1") {
		sendserv("NOTICE $nick :To really try synchronizing \002$botnick\002s userlist with \002$ufound\002, use \002".$GLOBALS['command']." $ufound !".substr(md5($ufound),0,8)."!\002");
		return(0);
	}
	if ($ufound == $botnick) {
		sendserv("NOTICE $nick :You can't synchronize \002$botnick\002 with itself.");
		return(0);
	}
	if ($GLOBALS['takelistchan'] != "") {
		sendserv("NOTICE $nick :Interupting erroneous synchronisation of \002".$GLOBALS['tln']."\002...");  
	}

	sendserv("NOTICE $nick :Synchronizing the userlist of ".$chans["$tchan"]["name"]." with \002$ufound\002...");
	$GLOBALS["takelista"] = "false";
	$GLOBALS["takelist"] = $ufound;
	$GLOBALS["takelistnick"] = $nick;
	$GLOBALS["tln"] = $ufound;
	$GLOBALS["takelistchan"] = $chans["$tchan"]["name"];
	sendserv("PRIVMSG $ufound :users ".$chans["$tchan"]["name"]);
	sendserv("PRIVMSG $ufound :a ".$chans["$tchan"]["name"]);
}
elseif (strtolower($cbase) == "users") {
	$cp = 0;
	$lsize = strlen("Account");
	$paz = explode(" ",$paramzz);
	if ($paz[1] == "") {
		$paz[1] = "1";
		$cp = 1;
	}
	if ($paz[2] == "") {
		$paz[2] = "500";
		$cp = 1;
	}
	$params = $paz[0];
	$sul = 6;
	global $chans; global $god;
	$ctarg = strtolower($target);
	$mc = 0;
	if ($params != "") {
		if ($paz[3] != "") {
			$matchstr = " matching $paz[3]";
			$pat = str_replace("[","\[",$paz[3]);
			$pat = str_replace("]","\]",$pat);
		}
		else {
			if ($cp == 1) {
				$matchstr = " matching $params";
			}
			$pat = str_replace("[","\[",$params);
			$pat = str_replace("]","\]",$pat);
		}
	}
	else {
		$pat = "*";
	}

	$fop = fopen("users.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$fgr = explode(" ",$fra);
		if ($fgr[0] == "-") {
			$area = $fgr[1];
		}
		elseif ($fra == "") {
		}
		else {
			if ($area == $ctarg) {
				$uc++;
				$ualvl = str_replace("-","",$fgr[1]);
				if (str_replace("-","",$fgr[1]) != $fgr[1]) {
					$ustat[strtolower($fgr[0])] = "Suspended";
					$sul = 9;
				}
				$userz["$ualvl"][strtolower("$fgr[0]")] = array("1");
				if ($god["$fgr[0]"] == 1) {
					if (staffstat($fgr[0]) != "Bot") {
						$sul = 17;
					}
				}
				$xun[strtolower("$fgr[0]")] = $fgr[0];
				if (strlen($fgr[0]) > $lsize) {
					$lsize = strlen($fgr[0]);
				}
				$found = 1;
			}
		}
	}
	if (vaccess($paz[1],500) != "yes") {
		sendserv("NOTICE $nick :\002$paz[1]\002 is not a valid access level!");
		return(0);
	}
	if (vaccess($paz[2],500) != "yes") {
		sendserv("NOTICE $nick :\002$paz[2]\002 is not a valid access level!");
		return(0);
	}
	sendserv("NOTICE $nick :".$chans["$ctarg"]["name"]." users from level $paz[1] to $paz[2]".$matchstr.":");
	sendserv("NOTICE $nick :Access".spaces("Access",6)." Account".spaces("Account",$lsize)." Status".spaces("Status",$sul)." Last Seen");
	krsort($userz);
	foreach ($userz as $uaxs => $unam) {
		ksort($unam);
		foreach ($unam as $unme => $unmear) {
			if (fnmatch(strtolower($pat),$unme)) {
				$stat = "Normal";
				if ($god[$xun["$unme"]] == 1) {
					$stat = "Security Override";
				}
				if ($ustat[$unme] != "") {
					$stat = $ustat[$unme];
				}
				if (staffstat($xun["$unme"]) == "Bot") {
					$stat = "Bot";
				}
				if ($uaxs >= $paz[1] && $uaxs <= $paz[2]) {
					sendserv("NOTICE $nick :$uaxs".spaces("$uaxs",6)." ".$xun[$unme].spaces($xun[$unme],$lsize)." ".$stat.spaces($stat,$sul)." ".lseen($unme,$ctarg)); 
					$mc++;
				}
			}
		}
	}
	sendserv("NOTICE $nick :There are \002$uc\002 users in ".$chans["$ctarg"]["name"].".\n");
	if ($params != "") {
		sendserv("NOTICE $nick :There are \002$mc\002 users in ".$chans["$ctarg"]["name"]." matching your request.\n");
	}
}
elseif (strtolower($cbase) == "etopics") {
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
	if ($cfound == 0) {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
	}
	else {
	if ($tsets["changetopic"] == "") {
		$tsets["changetopic"] = "200";
	}
	if ($tsets["enftopic"] == "") {
		$tsets["enftopic"] = "400";
	}
	if ($axs < $tsets["changetopic"]) {
		sendserv("NOTICE $nick :You lack sufficient access to ".$chans["$tchan"]["name"]." to use this command.");
	}
	if (binsetting($tsets['enhancedtopic']) == 'Off') {
		sendserv("NOTICE $nick :\002EnhancedTopic\002 is disabled in \002".$chans["$tchan"]["name"]."\002.");
		return(0);
	}
	sendserv("NOTICE $nick :\002EnhancedTopic values for ".chr(31).$chans["$tchan"]["name"].chr(31).":");
	$etopics = getArrayFromFile("etopics.conf");
	sendserv("NOTICE $nick :1         = ".$etopics[$tchan][1]);
	sendserv("NOTICE $nick :2         = ".$etopics[$tchan][2]);
	sendserv("NOTICE $nick :3         = ".$etopics[$tchan][3]);
	sendserv("NOTICE $nick :4         = ".$etopics[$tchan][4]);
	sendserv("NOTICE $nick :5         = ".$etopics[$tchan][5]);
	sendserv("NOTICE $nick :6         = ".$etopics[$tchan][6]);
	sendserv("NOTICE $nick :7         = ".$etopics[$tchan][7]);
	sendserv("NOTICE $nick :8         = ".$etopics[$tchan][8]);
	sendserv("NOTICE $nick :9         = ".$etopics[$tchan][9]);
	sendserv("NOTICE $nick :10        = ".$etopics[$tchan][10]);
	sendserv("NOTICE $nick :11        = ".$etopics[$tchan][11]);
	sendserv("NOTICE $nick :12        = ".$etopics[$tchan][12]);
	sendserv("NOTICE $nick :13        = ".$etopics[$tchan][13]);
	sendserv("NOTICE $nick :14        = ".$etopics[$tchan][14]);
	sendserv("NOTICE $nick :15        = ".$etopics[$tchan][15]);
	sendserv("NOTICE $nick ---");
	sendArrayToFile("etopics.conf",$etopics);
	}
}
elseif (strtolower($cbase) == "topic") {
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
	if ($cfound == 0) {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
	}
	else {
		if ($tsets["changetopic"] == "") {
			$tsets["changetopic"] = "200";
		}
		if ($tsets["enftopic"] == "") {
		$tsets["enftopic"] = "400";
		}
		if ($axs < $tsets["changetopic"]) {
		sendserv("NOTICE $nick :You lack sufficient access to ".$chans["$tchan"]["name"]." to use this command.");
		}
		else {
			if ($params != "") {
				if ($axs < $tsets["enftopic"]) {
					if (binsetting($tsets["enhancedtopic"]) == "Off") {
						$topicchange = str_replace("*",$params,$tsets["topicmask"]);
						sendserv("TOPIC $target :$topicchange");
						sendserv("NOTICE $nick :Topic should now be:");
						sendserv("NOTICE $nick :$topicchange");
					}
					else {
						$xploder = explode(" ",$paramzz);
						$allowed[1] = 1;
						$allowed[2] = 1;
						$allowed[3] = 1;
						$allowed[4] = 1;
						$allowed[5] = 1;
						$allowed[6] = 1;
						$allowed[7] = 1;
						$allowed[8] = 1;
						$allowed[9] = 1;
						$allowed[10] = 1;
						$allowed[11] = 1;
						$allowed[12] = 1;
						$allowed[13] = 1;
						$allowed[14] = 1;
						$allowed[15] = 1;
						if ($allowed[$xploder[0]] != 1) {
							sendserv("NOTICE $nick :\002$xploder[0]\002 is an invalid \002EnhancedTopic\002-ID");
							return(0);
						}
						$etopics = getArrayFromFile("etopics.conf");
						if (substr($paramzz,strlen($xploder[0]." ")) != "*") {
							$etopics[$tchan][$xploder[0]] = substr($paramzz,strlen($xploder[0]." "));
							sendArrayToFile("etopics.conf",$etopics);
						}
						else {
							unset($etopics[$tchan][$xploder[0]]);
							sendArrayToFile("etopics.conf",$etopics);
						}
						$bla[1] = "";
						$bla[2] = "";
						$bla[3] = "";
						$bla[4] = "";
						$bla[5] = "";
						$bla[6] = "";
						$bla[7] = "";
						$bla[8] = "";
						$bla[9] = "";
						$bla[10] = "";
						$bla[11] = "";
						$bla[12] = "";
						$bla[13] = "";
						$bla[14] = "";
						$bla[15] = "";
						foreach ($bla as $tnr => $tval) {
							if ($etopics[$tchan][$tnr] != "") {
								$bla[$tnr] = $etopics[$tchan][$tnr];
							}
						}
						$topicchange = $tsets["topicmask"];
						$topicchange = vsprintf($topicchange,$bla);
						sendserv("TOPIC $target :$topicchange");
						sendserv("NOTICE $nick :Topic should now be:");
						sendserv("NOTICE $nick :$topicchange");
					}
				}
				else {
					$topicchange = $params;
					sendserv("TOPIC $target :$topicchange");
					sendserv("NOTICE $nick :Topic should now be:");
					sendserv("NOTICE $nick :$topicchange");
				}
			}
			else {
				$topicchange = $tsets["defaulttopic"];
				sendserv("TOPIC $target :$topicchange");
				sendserv("NOTICE $nick :Topic should now be:");
				sendserv("NOTICE $nick :$topicchange");
			}
		}
	}
}
elseif (strtolower($cbase) == "atopic") {
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
	if ($cfound == 0) {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
	}
	else {
		if ($tsets["changetopic"] == "") {
			$tsets["changetopic"] = "200";
		}
		if ($tsets["enftopic"] == "") {
			$tsets["enftopic"] = "400";
		}
		if ($axs < $tsets["changetopic"]) {
			sendserv("NOTICE $nick :You lack sufficient access to ".$chans["$tchan"]["name"]." to use this command.");
		}
		else {
			if ($params != "") {
				if ($axs < $tsets["enftopic"]) {
					if (binsetting($tsets["enhancedtopic"]) == "Off") {
						$topicchange = str_replace("*",$params,$tsets["alttopicmask"]);
						sendserv("TOPIC $target :$topicchange");
						sendserv("NOTICE $nick :Topic should now be:");
						sendserv("NOTICE $nick :$topicchange");
					}
					else {
						$xploder = explode(" ",$paramzz);
						$allowed[1] = 1;
						$allowed[2] = 1;
						$allowed[3] = 1;
						$allowed[4] = 1;
						$allowed[5] = 1;
						$allowed[6] = 1;
						$allowed[7] = 1;
						$allowed[8] = 1;
						$allowed[9] = 1;
						$allowed[10] = 1;
						$allowed[11] = 1;
						$allowed[12] = 1;
						$allowed[13] = 1;
						$allowed[14] = 1;
						$allowed[15] = 1;
						if ($allowed[$xploder[0]] != 1) {
							sendserv("NOTICE $nick :\002$xploder[0]\002 is an invalid \002EnhancedTopic\002-ID");
							return(0);
						}
						$etopics = getArrayFromFile("etopics.conf");
						if (substr($paramzz,strlen($xploder[0]." ")) != "*") {
							$etopics[$tchan][$xploder[0]] = substr($paramzz,strlen($xploder[0]." "));
							sendArrayToFile("etopics.conf",$etopics);
						}
						else {
							unset($etopics[$tchan][$xploder[0]]);
							sendArrayToFile("etopics.conf",$etopics);
						}
						$bla[1] = "";
						$bla[2] = "";
						$bla[3] = "";
						$bla[4] = "";
						$bla[5] = "";
						$bla[6] = "";
						$bla[7] = "";
						$bla[8] = "";
						$bla[9] = "";
						$bla[10] = "";
						$bla[11] = "";
						$bla[12] = "";
						$bla[13] = "";
						$bla[14] = "";
						$bla[15] = "";
						foreach ($bla as $tnr => $tval) {
							if ($etopics[$tchan][$tnr] != "") {
								$bla[$tnr] = $etopics[$tchan][$tnr];
							}
						}
						$topicchange = $tsets["alttopicmask"];
						$topicchange = vsprintf($topicchange,$bla);
						sendserv("TOPIC $target :$topicchange");
						sendserv("NOTICE $nick :Topic should now be:");
						sendserv("NOTICE $nick :$topicchange");
					}
				}
				else {
					$topicchange = $params;
					sendserv("TOPIC $target :$topicchange");
					sendserv("NOTICE $nick :Topic should now be:");
					sendserv("NOTICE $nick :$topicchange");
				}
			}
			else {
				$topicchange = $tsets["alttopic"];
				sendserv("TOPIC $target :$topicchange");
				sendserv("NOTICE $nick :Topic should now be:");
				sendserv("NOTICE $nick :$topicchange");
			}
		}
	}
}