// cbase: phpgod
// cbase: extscript
// cbase: timecmd
$phppath = 'php'; // Linux Path FOR EVERY FUNCTION IN THIS MODULE!
if (strtolower($cbase) == "phpgod") {
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
	if ($saxs >= 1000) {
		$dic = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890";
		if ($paramzz == "") {
			sendserv("NOTICE $nick :More parameters required:");
			sendserv("NOTICE $nick :Syntax: /MSG $botnick ".$GLOBALS['command']." <php code>");
			sendserv("NOTICE $nick :Missing parameter(s): php code");
			return(0);
		}
		$public = false;
		$la = explode(" ",$params);
		$xy = microtime(true);
		ob_start();
		// PHPGod Begin ------------------------------------------------
		if (substr($paramzz,0,strlen("http://pastebin.com/")) == "http://pastebin.com/") {
			$id = substr($paramzz,strlen("http://pastebin.com/"));
			$codecontent = file_get_contents("http://www.pastebin.com/download.php?i=$id");
			if ($codecontent == "") {
				echo("\0034ERROR\003: Unknown Paste ID.\n");
				$err_code = "yes";
			}
			else {
				echo("Running code from Paste \002ID#$id\002\n\n");
				$ID = "";
				for ($x = 0; $x < 33; $x++) {
					$ID .= $dic[rand(0,62)];
				}
				$fp = fopen("./codes/$ID","w+");
				fwrite($fp,file_get_contents("precode.php").$codecontent);
				fclose($fp);   
			}
		}
		elseif (substr($paramzz,0,strlen("http://pastebin.de/")) == "http://pastebin.de/") {
			$id = substr($paramzz,strlen("http://pastebin.de/"));
			$codecontent = file_get_contents("http://www.pastebin.de/download/?id=$id");
			if ($codecontent == "") {
				echo("\0034ERROR\003: Unknown Paste ID.\n");
				$err_code = "yes";
			}
			else {
				$uline = chr(31);
				echo("Running code from Paste \002ID#$id\002 (pastebin.{$uline}de{$uline})\n\n");
				$ID = "";
				for ($x = 0; $x < 33; $x++) {
					$ID .= $dic[rand(0,62)];
				}
				$fp = fopen("./codes/$ID","w+");
				fwrite($fp,file_get_contents("precode.php").$codecontent);
				fclose($fp);   
			}
		}
		else {
			$ID = "";
			for ($x = 0; $x < 33; $x++) {
				$ID .= $dic[rand(0,62)];
			}
			$fp = fopen("./codes/$ID","w+");
			fwrite($fp,file_get_contents("precode.php")."<?php ".$params." ?>");
			fclose($fp);
		}
		$la = shell_exec($phppath." ./codes/$ID");
		echo($la);
		if ($la == "" && $err_code != "yes") {
			echo("\0034ERROR:\003 Script returned \002nothing\002.");
		}
		// ---------------------------------------------------------------
		$dump .= ob_get_contents();
		if ($dump != "") {
			$domp = explode("\n",$dump);
			foreach ($domp as $pomp) {
				if ($cchan[0] != "#") {
					if ($pomp == "") {
						sendserv("NOTICE $nick : ");
					}
					else {
						sendserv("NOTICE $nick :$pomp");
					}
				}
				else {
					if ($pomp == "") {
						sendserv("PRIVMSG $cchan : ");
					}
					else {
						sendserv("PRIVMSG $cchan :$pomp");
					}
				}
			}
		}
		ob_end_clean();
	}
	else {
		sendserv("NOTICE $nick :You lack sufficient staff access to use this command.");
	}
}


if (strtolower($cbase) == "extscript") {
	$tchan = strtolower($cchan);
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
	$toyz = $tsets['toys'];

	$la = explode(" ",$paramzz);
	ob_start();
	$pe = substr($paramzz,strlen($la[0]." "));
	$fp = fopen("god_code.php","w+");
	$xn = '$nicklist = unserialize(file_get_contents("nicklist.af"));';
	$extnick = '<?php $nick = "'.addslashes($nick).'"; $params = \''.addslashes($pe).'\'; $chan = \''.addslashes($cchan).'\'; $toys = \''.$toyz.'\'; '.$xn.' ?>';
	global $chans; global $userinfo;
	$xx = fopen("nicklist.af","w+");
	$nicklist = array();
	foreach ($chans[strtolower($tchan)]['users'] as $nickname => $status) {
		$nicklist[$userinfo[$nickname]['nick']] = $status;
	}
	fwrite($xx,serialize($nicklist));
	fclose($xx);
	fwrite($fp,$extnick.file_get_contents($la[0]));
	// Relay the nick to the external script and - whuuush - start it!
	// We'll see how it goes.
	fclose($fp);
	$la = shell_exec($phppath." god_code.php");
	unlink("nicklist.af");
	echo($la);
	unlink("god_code.php");
	$dump .= ob_get_contents();

	if ($dump != "") {
		$domp = explode("\n",$dump);
		foreach ($domp as $pomp) {
			if ($cchan[0] == "#") {
				sendserv("$pomp");
			}
			else {
				sendserv("$pomp");
			}
		}
	}
	ob_end_clean();
}
if (strtolower($cbase) == "timecmd") {
	$xx = time();
	$pp = explode(" ",$paramzz);
	if ($pp[0] == "") {
		$xy = 0;
		sendserv("NOTICE $nick :Missing parameters: <command> [parameters]");
		$fop = fopen("bind.conf","r+");
		while ($fra = fgets($fop)) {
			$fra = str_replace("\r","",$fra);
			$fra = str_replace("\n","",$fra);
			$fgr = explode(" ",$fra);
			if ($xy == 6) {
				sendserv("NOTICE $nick :Subcommands of ".$GLOBALS['command'].": $xi");
				$xi = '';
				$xy = 0;
			}
			$xi .= " ".$fgr[0];
			$xy++;
		}
		if ($xi != "") {
			sendserv("NOTICE $nick :Subcommands of ".$GLOBALS['command'].": $xi");
		}
		fclose($fop);
		return(0);
	}
	if ($pp[1][0] != "#") {
		cmd_parser($nick,$ident,$host,"$pp[0]",$cchan,$target,substr($paramzz,strlen("$pp[0] ")));
	}
	else {
		cmd_parser($nick,$ident,$host,"$pp[0]",$cchan,$pp[1],substr($paramzz,strlen("$pp[0] $pp[1] ")));
	}
	$yy = time() - $xx;
	sendserv("NOTICE $nick :Command executed in ".time2str($yy));
}
