/* modcmd.mod - NexusServV3
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
// cbase: version
// cbase: netinfo
// cbase: services
// cbase: codeteam
// cbase: bind
// cbase: unbind
// cbase: say
// cbase: emote
// cbase: modcmd
// cbase: staff
// cbase: god
// cbase: checkchans
// cbase: showcommands
// cbase: commands
// cbase: command
// cbase: botlist
if (strtolower($cbase) == "botlist") {
	sendserv("NOTICE $nick :Function under construction");
}
elseif (strtolower($cbase) == "checkchans") {
	global $userinfo; global $botnick; global $god; global $chans;
	$lbotnick = strtolower($botnick);
	$lnick = strtolower($nick);
	$acc = $userinfo["$lnick"]["auth"];
	$saxs = 0;
	$chansnoop = array();
	$chansnoton = array();
	$cpcount = 0;
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
		if ($god["$acc"] == "1") {
			foreach ($chans as $cname => $car) {
				if (str_replace("@","",$car["users"]["$lbotnick"]) == $car["users"]["$lbotnick"]) {
					if ($cname[0] == "#") {
						$ccn = $chans["$cname"]["name"];
						$chansnoop["$ccn"] = "1";
						$cpcount++;
					}
				}
			}
			$fop = fopen("users.conf","r+");
			while ($fr = fgets($fop)) {
				$fi = explode(" ",$fr);
				if ($fi[0] == "-" && $chans["$fi[1]"]["name"] == "") {
					$chansnoton["$fi[1]"] = "1";
					$cpcount++;
				}
			}
			sendserv("NOTICE $nick :\002Channel Check\002");
			sendserv("NOTICE $nick :\002Chans where i'm not opped:\002");
			foreach ($chansnoop as $cname => $carg) {
				sendserv("NOTICE $nick :$cname");
			}
			sendserv("NOTICE $nick :\002Chans where i'm not on:\002");
			foreach ($chansnoton as $cname => $carg) {
				sendserv("NOTICE $nick :- $cname");
			}
			sendserv("NOTICE $nick :---");
			sendserv("NOTICE $nick :Found a total amount of \002$cpcount\002 problems.");
		}
		else {
			sendserv("NOTICE $nick :You must enable security override (helping mode) to use this command.");
		}
	}
	else {
		sendserv("NOTICE $nick :You lack sufficient staff access to use this command.");
	}
}
elseif (strtolower($cbase) == "god") {
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
	$ccchan = $cchan;
	if ($cchan[0] != "#") {
		$ccchan = "";
	}
	$command = $GLOBALS['msg'];
	sendserv("NOTICE $debugchannel :($ccchan) [$nick:$acc] $command");
	if ($saxs >= 200) {
		if ($god["$acc"] != 1) {
			$god["$acc"] = 1;
			sendserv("NOTICE $nick :Security override has been enabled.");
		}
		else {
			$god["$acc"] = 0;
			sendserv("NOTICE $nick :Security override has been disabled.");
		}
	}
	else {
		sendserv("NOTICE $nick :You lack sufficient staff access to use this command.");
	}
}
elseif (strtolower($cbase) == "staff") {
	global $userinfo; global $botnick; global $god;
	$fop = fopen("staff.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		$ustaff["$frg[0]"] = $frg[2];
	}
	fclose($fop);
	foreach ($userinfo as $lnick => $uar) {
		$auth = $userinfo["$lnick"]["auth"];
		if ($ustaff["$auth"] != "" && $god[$auth] == "1") {
			$slevel = $ustaff["$auth"];
			$staffs["$slevel"] .= $userinfo["$lnick"]["nick"]." ";
		}
	}
	sendserv("NOTICE $nick :\002Developers\002");
	sendserv("NOTICE $nick :".$staffs["7"]); // Developers
	sendserv("NOTICE $nick :\002Hosters\002");
	sendserv("NOTICE $nick :".$staffs["8"]); // Hoster
	sendserv("NOTICE $nick :\002Admins\002");
	sendserv("NOTICE $nick :".$staffs["5"].$staffs["4"]); // Admin, Botadmin 
	sendserv("NOTICE $nick :\002Managers\002");
	sendserv("NOTICE $nick :".$staffs["3"]); // Manager
	sendserv("NOTICE $nick :\002Helpers\002");
	sendserv("NOTICE $nick :".$staffs["2"].$staffs["1"]); // Extended Helper
	sendserv("NOTICE $nick :\002Trials\002");
	sendserv("NOTICE $nick :".$staffs["0"]); // Trial
}
elseif (strtolower($cbase) == "modcmd") {
	sendserv("NOTICE $nick :The command modification engine currently isnt finished.");
}
elseif (strtolower($cbase) == "say") {
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
		sendserv("PRIVMSG $target :$params");
	}
	else {
		sendserv("NOTICE $nick :You lack sufficient staff access to use this command");
	}
}
elseif (strtolower($cbase) == "emote") {
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
		sendserv("PRIVMSG $target :\001ACTION $params\001");
	}
	else {
		sendserv("NOTICE $nick :You lack sufficient staff access to use this command");
	}
}
elseif (strtolower($cbase) == "version") {
	global $version; global $devline; global $secdevline;
	sendserv("NOTICE $nick :NexusServ ".$GLOBALS['bversion']." (".$GLOBALS['bcodename']."). Core ".$GLOBALS['core'].". Release ".$GLOBALS['brelease']);
}
elseif (strtolower($cbase) == "netinfo") {
	global $server; global $botnick; global $userinfo; global $stime;
	$chancount = 0;
	$fop = fopen("users.conf","r+");
	while ($fra = fgets($fop)) {
		if ($fra{0} == "-") {
			$chancount++;
		}
	}
	fclose($fop);
	$acccount = 0;
	$fop = fopen("accs.conf","r+");
	while ($fra = fgets($fop)) {
		$acccount++;
	}
	fclose($fop);
	sendserv("NOTICE $nick :\002Network information\002");
	sendserv("NOTICE $nick :\002Network            \002:     ".$GLOBALS['netdata']['NETWORK']);
	sendserv("NOTICE $nick :\002Bot Uptime         \002:     ".time2str(time() - $stime));
	sendserv("NOTICE $nick :\002Channels registered\002:     $chancount");
	sendserv("NOTICE $nick :\002Maximal channels   \002:     ".$GLOBALS['netdata']['MAXCHANNELS']);
	sendserv("NOTICE $nick :\002Accounts known     \002:     $acccount");
	sendserv("NOTICE $nick :\002Users visible      \002:     ".count($userinfo));
	$auc = 0;
	foreach ($userinfo as $uname => $user) {
		if ($userinfo[$uname]['auth'] != "") {
			$auc++;
		}
	}
	if ($userinfo[strtolower($botnick)]["auth"] != "") {
		sendserv("NOTICE $nick :\002Bot Account        \002:     ".$userinfo[strtolower($botnick)]["auth"]);
	}
	else {
		sendserv("NOTICE $nick :\002Bot Account        \002:     Not logged in");
	}
	sendserv("NOTICE $nick :\002Users authed       \002:     $auc");
	sendserv("NOTICE $nick :\002Maximal Memory Use \002:     ".round((memory_get_peak_usage()/1024/1024),2)."MBytes");
	sendserv("NOTICE $nick :\002         Right now \002:     ".round((memory_get_usage()/1024/1024),2)."MBytes");
	sendserv("NOTICE $nick :\002Incoming Traffic   \002:     ".round(($GLOBALS['glob']['dat_in']/1024/1024),2)."MBytes");
	sendserv("NOTICE $nick :\002Outgoing Traffic   \002:     ".round(($GLOBALS['glob']['dat_out']/1024/1024),2)."MBytes");
	sendserv("NOTICE $nick :\002Parser             \002:     php".phpversion());
	sendserv("NOTICE $nick :\002Version            \002:     ".$GLOBALS['bversion']." (".$GLOBALS['bcodename'].")");
	sendserv("NOTICE $nick :\002Core Version       \002:     ArcticServ v".$GLOBALS['core']);
	sendserv("NOTICE $nick :\002Reloads            \002:     ".($GLOBALS['rid']+0));
	sendserv("NOTICE $nick :---");
}
elseif (strtolower($cbase) == "codeteam") {
	global $botnick;
	sendserv("NOTICE $nick :\002$botnick\002 coding team");
	sendserv("NOTICE $nick :\002Main Coding\002");
	sendserv("NOTICE $nick :Calisto");
	sendserv("NOTICE $nick :\002Module Coding\002");
	sendserv("NOTICE $nick :Calisto Zer0n");
	sendserv("NOTICE $nick :\002Modifications/Bugfixes");
	sendserv("NOTICE $nick :Calisto Zer0n");
	sendserv("NOTICE $nick :\002SourceForge Public-Version Management");
	sendserv("NOTICE $nick :Calisto");
	sendserv("NOTICE $nick :---");
}
elseif (strtolower($cbase) == "services") {
	global $stime;
	sendserv("NOTICE $nick :\002Service status check\002");
	sendserv("NOTICE $nick :Service status: Bot online since ".time2str(time() - $stime).".");
}
elseif (strtolower($cbase) == "commands") {
	global $botnick;
	$cc = 0;
	$lsize = 0;
	sendserv("NOTICE $nick :\002$botnick\002 commands:");
	$fop = fopen("bind.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$fgr = explode(" ",$fra);
		if (strlen($fgr[0]) > $lsize) {
			$lsize = strlen($fgr[0]);
		}
		$cc++;
	}
	fclose($fop);
	$fad = 0;
	$fstr = "";
	$fop = fopen("bind.conf","r+");
	$bcount = 0;
	sendserv("NOTICE $nick :Binding".spaces("Binding",20)." Command");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$fgr = explode(" ",$fra);
		$cmdp = substr($fra,strlen($fgr[0]." ".$fgr[1]." ".$fgr[2]." ".$fgr[3]." "));
		sendserv("NOTICE $nick :$fgr[0]".spaces($fgr[0],20)." ".substr($fgr[2],0,(strlen($fgr[2])-4)).".$fgr[3] ".$cmdp);
		$bcount++;
	}
	sendserv("NOTICE $nick :There are \002$bcount\002 bindings for \002$botnick\002.");
}
elseif (strtolower($cbase) == "showcommands") {
	global $botnick;
	$cc = 0;
	$lsize = 0;
	sendserv("NOTICE $nick :\002$botnick\002 commands:");
	$fop = fopen("bind.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$fgr = explode(" ",$fra);
		if (strlen($fgr[0]) > $lsize) {
			$lsize = strlen($fgr[0]);
		}
		$cc++;
	}
	fclose($fop);
	$fad = 0;
	$fstr = "";
	$fop = fopen("bind.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$fgr = explode(" ",$fra);
		if ($fad < 4) {
			if ($fgr[1] != "mod_mod") {
				$fgr[0] == "\0034".$fgr[0]."\003";
			}
			$fstr .= "$fgr[0]".spaces("$fgr[0]",$lsize)." ";
		}
		else {
			sendserv("NOTICE $nick :$fstr");
			$fstr = "";
			$fad = 0;
			if ($fgr[1] != "mod_mod") {
				$fgr[0] == "\0034".$fgr[0]."\003";
			}
			$fstr .= "$fgr[0]".spaces("$fgr[0]",$lsize)." ";
		}
		$fad++;
	}
	fclose($fop);
	if ($fstr != "") {
		sendserv("NOTICE $nick :$fstr");
	}
	sendserv("NOTICE $nick :-- $cc commands found. --");
}
elseif (strtolower($cbase) == "command") {
	$params = $paramzz;
	$found = 0;
	$bip = explode(" ",$params);
	$fop = fopen("bind.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$fgr = explode(" ",$fra);
		if (strtolower($fgr[0]) == strtolower($bip[0])) {
			if (strtolower($fgr[1]) == "mod_mod") {
				$comothis = str_replace(".mod","",$fgr[2]).".".$fgr[3];
				$cmdthis = str_replace(".mod","",$fgr[2]).".".substr($fra,strlen($fgr[0]." ".$fgr[1]." ".$fgr[2]." "));
				sendserv("NOTICE $nick :\002$bip[0]\002 is a binding for: $cmdthis");
				if (is_file("./defs/def._".strtolower($comothis)."_.txt")) {
					sendserv("NOTICE $nick :\002".strtoupper($comothis)."\002");
					$xx = explode("\n",str_replace("\r","",file_get_contents("./defs/def._".strtolower($comothis)."_.txt")));
					foreach ($xx as $xy) {
						cmd_parser($nick,$ident,$host,"help",$target,$target,$xy);
					}
				}
				sendserv("NOTICE $nick :End of requirements for $bip[0].");
			}
			else {
				sendserv("NOTICE $nick :\002$bip[0]\002 is a binding for bot_internal.".substr($fra,strlen($fgr[0]." ")));
				sendserv("NOTICE $nick :End of requirements for $bip[0].");
			}
			$found = 1;
		}
	}
	fclose($fop);
	if ($found == 0) {
		sendserv("NOTICE $nick :\002$bip[0]\002 is an unknown command");
	}
}
elseif (strtolower($cbase) == "help") {
	$helpfile = "help.txt";
	$params = $paramzz;
	$para = explode(" ",$params);
	if (substr($para[0],0,2) == "::") {
		$helpfile = "help".substr($para[0],2).".txt";
		$params = substr($params,strlen($para[0]." "));
	}
	global $botnick; global $version;
	$fop = fopen($helpfile,"r+");
	if ($params == "") {
		$paramz = "Main";
	}
	else {
		$paramz = $params;
	}
	$fcont = "";
	$area = "";
	while ($fg = fgets($fop)) {
		$fra = str_replace("\r","",$fg);
		$fra = str_replace("\n","",$fra);
		if ($fra{0} == "[") {
			$area = $fra;
		}
		else {
			if (strtolower($area) == strtolower("[".$paramz."]")) {
				$fcont .= $fra."\r\n";
			}
		}
	}
	if ($fcont == "") {
		sendserv("NOTICE $nick :No help on that topic!");
		return(101);
	}
	$bla = explode("\r\n",$fcont);
	foreach ($bla as $blu) {
		sendserv("NOTICE $nick :".str_replace('$V',$version,str_replace('$B',$botnick,str_replace("[b]","\002",substr($blu,1)))));
	}
	fclose($fop);
}
elseif (strtolower($cbase) == "spamhelp") {
	$helpfile = "help.txt";
	$params = $paramzz;
	$para = explode(" ",$params);
	if (substr($para[0],0,2) == "::") {
		$helpfile = "spamhelp".substr($para[0],2).".txt";
		$params = substr($params,strlen($para[0]." "));
	}
	global $botnick; global $version;
	$fop = fopen($helpfile,"r+");
	if ($params == "") {
		$paramz = "Main";
	}
	else {
		$paramz = $params;
	}
	$fcont = "";
	$area = "";
	while ($fg = fgets($fop)) {
		$fra = str_replace("\r","",$fg);
		$fra = str_replace("\n","",$fra);
		if ($fra{0} == "[") {
			$area = $fra;
		}
		else {
			if (strtolower($area) == strtolower("[".$paramz."]")) {
				$fcont .= $fra."\r\n";
			}
		}
	}
	if ($fcont == "") {
		sendserv("NOTICE $nick :No help on that topic!");
		return(101);
	}
	$bla = explode("\r\n",$fcont);
	foreach ($bla as $blu) {
		sendserv("NOTICE $nick :".str_replace('$V',$version,str_replace('$B',$botnick,str_replace("[b]","\002",substr($blu,1)))));
	}
	fclose($fop);
}
elseif (strtolower($cbase) == "bind") {
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
	if ($saxs >= 800) {
		$fope = fopen("bind.conf","r+");
		$fcont = "";
		while ($frae = fgets($fope)) {
			$frae = str_replace("\r","",$frae);
			$frae = str_replace("\n","",$frae);
			$frge = explode(" ",$frae);
			if (strtolower($frge[0]) == strtolower($paz[0])) {
				sendserv("NOTICE $nick :There is already a command bound as \002$paz[0]\002.");
				return(0);
			}
			$fcont .= $frae."\n";
		}
		fclose($fope);
		$found = 0;
		$pazz = explode(".",$paz[1]);
		if (file_exists($pazz[0].".mod")) {
			$fope = fopen($pazz[0].".mod","r+");
			while ($frae = fgets($fope)) {
				$frae = str_replace("\r","",$frae);
				$frae = str_replace("\n","",$frae);
				$frge = explode(" ",$frae);
				if ($frae{0} == "/") {
					if (substr($params,strlen("$paz[0] $paz[1] ")) != "") {
						$mgs = substr($params,strlen("$paz[0] $paz[1] "))." ";
					}
					else {
						$mgs = "";
					}
					if (strtolower($frge[2]) == strtolower($pazz[1])) {
						$fcont .= $paz[0]." mod_mod ".$pazz[0].".mod ".$pazz[1]." ".$mgs;
						$found = 1;
					}
				}
			}
			fclose($fope);
			if ($found == 0) {
				sendserv("NOTICE $nick :\002".$pazz[1]."\002 is not a valid command in module ".$pazz[0].".");
			}
			else {
				$fope = fopen("bind.conf","w+");
				fwrite($fope,$fcont);
				fclose($fope);
				sendserv("NOTICE $nick :New command \002$paz[0]\002 bound to the bot.");
			}
		}
		else {
			if ($pazz[0] == "bot_internal") {
				if (is_callable("bot_".$pazz[1],false,$callable_name)) {
						if (substr($params,strlen("$paz[0] $paz[1] ")) != "") {
					$mgs = substr($params,strlen("$paz[0] $paz[1] "))." ";
					}
					else {
						$mgs = "";
					}
					$fcont .= $paz[0]." ".$pazz[1]." ".$mgs;
					$fope = fopen("bind.conf","w+");
					fwrite($fope,$fcont);
					fclose($fope);
					sendserv("NOTICE $nick :New command \002$paz[0]\002 bound to the bot.");     
				}
				else {
					sendserv("NOTICE $nick :Command not found bot-internally.");
				}
				return(1);
			}
			sendserv("NOTICE $nick :There is no module with name \002$pazz[0]\002.");
		}
	}
	else {
		sendserv("NOTICE $nick :You lack sufficient staff access to use this command.");
	}
}
elseif (strtolower($cbase) == "unbind") {
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
	if ($saxs >= 800) {
		$fope = fopen("bind.conf","r+");
		$found = 0;
		$fcont = "";
		while ($frae = fgets($fope)) {
			$frae = str_replace("\r","",$frae);
			$frae = str_replace("\n","",$frae);
			$frge = explode(" ",$frae);
			if (strtolower($frge[0]) == strtolower($paz[0])) {
				// ignore this command?
				$found = 1;
			}
			else {
				$fcont .= $frae."\n";
			}
		}
		fclose($fope);
		if ($found == 1) {
			$fope = fopen("bind.conf","w+");
			fwrite($fope,$fcont);
			fclose($fope);
			sendserv("NOTICE $nick :Command \002$paz[0]\002 unbound from the bot.");
		}
		else {
			sendserv("NOTICE $nick :Command \002$paz[0]\002 is unknown to me.");
		}
	}
	else {
		sendserv("NOTICE $nick :You lack sufficient staff access to use this command.");
	}
}
else {
	sendserv("NOTICE $nick :Module Error, please contact a staff member: $cbase command missing in module $modbase");
}
