/* system.mod - NexusServV3
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
// cbase: bot
// cbase: debug
// cbase: raw
if (strtolower($cbase) == "bot") {
	$params = $paramzz;
	global $userinfo; global $botnick; global $god;
	$lnick = strtolower($nick);
	$acc = $userinfo["$lnick"]["auth"];
	$saxs = 0;
	$fop = fopen("./conf/staff.conf","r+");
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
	if ($saxs >= 950) {
		$paz = explode(" ",$params);
		if (strtolower($paz[0]) == "unloadmod") {
			global $modules;
			if ($modules["$paz[1].mod"] != "") {
				unset($modules["$paz[1].mod"]);
				sendserv("NOTICE $nick :Module unloaded.");
			}
			else {
				sendserv("NOTICE $nick :I don't know this module.");
			}
		}
		elseif (strtolower($paz[0]) == "rehash") {
			$xlines = 0;
			$mcnt = 0;
			$mtime = microtime(true);
			$buffer .= "NOTICE $nick :Rehashing modules...\n";
			global $modules;
			$modules = array();
			foreach (glob("modules/*.mod") as $filename) {
				/* $buffer .= "NOTICE $nick :Loading module $filename ...\n"; */
				$mcnt++;
				$cnt = 0; $lcnt = 0;
				$fop = fopen($filename,"r+");
				while ($fg = fgets($fop)) {
					$modules["$filename"] .= $fg;
					if ($fg{0} == "/") {
						$cnt++;
					}
					$lcnt++;
				}
				fclose($fop);
				/* $buffer .= "NOTICE $nick :Loaded module ".str_replace(".mod","",$filename)." ($filename) ; $cnt commands; $lcnt lines of code.\n"; */
				$xlines = $xlines + $lcnt;
			}
			/*
			$buffer .= "NOTICE $nick :Loading language pack...\n";
			if (!file_exists('languages.php')) {
				$buffer .= "NOTICE $nick :\0034WARNING:\003 Language pack not found. Using included English language.\n";
				$buffer .= "NOTICE $nick :\0033INFO:\003 Language packs are in just one file: \002languages.php\002 in the $botnick folder.\n";
			}
			else {
				include('languages.php');
			}
			*/
			$buffer .= "NOTICE $nick :Done, rehashed everything ($mcnt modules, $xlines lines of code) in ".(microtime(true) - $mtime)." seconds.\n";
			$GLOBALS['rid']++;
			sendserv($buffer);
		}
		elseif (strtolower($paz[0]) == "status") {
			global $modules;
			$amlc = 0;
			$amcc = 0;
			sendserv("NOTICE $nick :\002Loaded modules - status report:\002");
			foreach ($modules as $modname => $modcontent) {
				$mcc = 0; $mlc = 0;
				$modexp = explode("\n",$modules[$modname]);
				foreach ($modexp as $modexps) {
					$modexpsex = explode(' ',$modexps);
					if ($modexpsex[0] == '//' && $modexpsex[1] == 'cbase:') {
						$mcc++;
					}
					$mlc++;
				}
				sendserv("NOTICE $nick :".str_replace(".mod","",$modname)." ($modname), $mcc commands ($mlc lines)");
				$amcc = $amcc + $mcc;
				$amlc = $amlc + $mlc;
			}
			$mcode = file('nexusserv.php');
			$tcode = file('./inc/time_handler.php');
			$amlc = $amlc + count($mcode) + count($tcode);
			sendserv("NOTICE $nick :Main Code (Core) : ".round(filesize('nexusserv.php')/1024,0)."KBytes (".count($mcode)." Lines)");
			sendserv("NOTICE $nick :Time Handler Code: ".round(filesize('./inc/time_handler.php')/1024,0)."KBytes (".count($tcode)." Lines)");
			sendserv("NOTICE $nick :\002End of list.\002 $amcc Commands ($amlc Lines)");
		}
		else {
			sendserv("NOTICE $nick :Subcommands of modules: rehash status");
		}
	}
	else {
		sendserv("NOTICE $nick :You lack sufficient staff access to use this command!");
	}
}
if (strtolower($cbase) == "debug") {
	// Pre-defined variable functions
	$pr = "print_r";
	$par = "print_array";
	$af = "getArrayFromFile";
	$saf = "sendArrayToFile";
	// ----
	// Pre-defined global bot variables
	$ch = $GLOBALS['chans'];
	$ui = $GLOBALS['userinfo'];
	// ---
	$notc=false;
	$params = $paramzz;
	global $userinfo; global $botnick; global $god; $hand = new irc_handle;
	$chans = new IRC_Chan;
	$users = new IRC_User;
	$lnick = strtolower($nick);
	$acc = $userinfo["$lnick"]["auth"];
	$saxs = 0;
	$fop = fopen("./conf/staff.conf","r+");
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
	$command = $GLOBALS['command'];
	sendserv("NOTICE $debugchannel :($ccchan) [$nick:$acc] $command $paramzz");
	if ($saxs >= 1000) {
		if ($paramzz == "") {
			sendserv("NOTICE $nick :More parameters required:");
			sendserv("NOTICE $nick :Syntax: /msg $botnick ".$GLOBALS['command']." <debug commands>");
			sendserv("NOTICE $nick :Missing parameter(s): debug commands");
			return(0);
		}
		$public = false;
		$la = explode(" ",$params);
		$xy = microtime(true);
		ob_start();
		$dump = eval($params)."\n";
		$dump .= ob_get_contents();
		if ($dump != "") {
			$domp = explode("\n",$dump);
			foreach ($domp as $pomp) {
				if ($pomp != "") {
					if ($public == false) {
						sendserv("NOTICE $nick :$pomp");
					}
					else {
						sendserv("PRIVMSG $target :$pomp");
					}
				}
			}
		}
		ob_end_clean();
		if ($notc != false) {
			sendserv("NOTICE $nick :Successfully executed the command in ".(microtime(true) - $xy)."s:");
			sendserv("NOTICE $nick :$params");
		}
	}
	else {
		sendserv("NOTICE $nick :You lack sufficient staff access to use this command.");
	}
}
elseif (strtolower($cbase) == "raw") {
	$params = $paramzz;
	global $userinfo; global $botnick; global $god;
	$lnick = strtolower($nick);
	$acc = $userinfo["$lnick"]["auth"];
	$saxs = 0;
	$fop = fopen("./conf/staff.conf","r+");
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
	$command = $GLOBALS['command'];
	if($showdebug == true){
		sendserv("NOTICE $debugchannel :($ccchan) [$nick:$acc] $command $paramzz");
	}
	if ($saxs >= 1000) {
		sendserv($params);
	}
	else {
		sendserv("NOTICE $nick :You lack sufficient staff access to use this command.");
	}
}